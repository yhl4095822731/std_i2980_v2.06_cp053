package composite.ServiceNetOrTigBitmap;

import java.awt.Color;
import java.awt.Container;

import com.ibm.log4j.Category;
import com.keba.kemro.kvs.keplast.tig.TIG;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;

import ServiceNet.hmi.service.IServiceNetListener;
import ServiceNet.hmi.service.KPServiceNetService;

public class ServiceNetOrTigBitmap extends ServiceNetOrTigBitmap_generated implements IServiceNetListener {
   private static final long serialVersionUID = 1L;
   private final String VAR_PATH_SERVICE_NET_IS_CONNECTED = "ServiceNet.sv_ConnectionStatus";
   private final String VAR_PATH_EASYNET_IS_AVAILABLE = "EasyNet.sv_bENAvailable";
   private final String VAR_PATH_EASYNET_IS_CONNECTED = "EasyNet.sv_ENHmi.bIsConnected";
   private final String VAR_PATH_GENERICCONTROLCENTER_IS_AVAILABLE = "HostCommunication.sv_bHostAvailable";
   private final String VAR_PATH_GENERICCONTROLCENTER_IS_CONNECTED = "HostCommunication.sv_HostHmi.bIsConnected";
   private final int STATE_CONNECTED = KPServiceNetService.CONNECTION_STATE_SERVICE_ACTIVE;
   private Category CAT;

   // Vars for control centers (TIG, EasyNet,...)
   private boolean m_isAnyCtrlCenterAvailable;
   private boolean m_isAnyCtrlCenterConnected;
   private KVariable kVarTIGConnected;
   private KVariable kVarENConnected;
   private KVariable kVarGenericConnected;

   // ServiceNet flags
   private boolean m_isServiceNetConnected;
   private boolean m_isVncClientConnected;
   private MyUpdateThread m_updateThread;

   public ServiceNetOrTigBitmap() throws Exception {
      super();
      CAT = Category.getInstance(getClass().getName());
      try {
         m_isAnyCtrlCenterConnected = false;
         m_isServiceNetConnected = false;
         m_isVncClientConnected = false;
         KPServiceNetService.getInstance().addServiceNetListener(this);
         initVariables();
      } catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   private void initVariables() {
      try {
         // ########## Control centers ##########
         // Check availability
         m_isAnyCtrlCenterAvailable = TIG.getInstance().isTIGExisting();
         if (!m_isAnyCtrlCenterAvailable) {
            try {
               // EasyNet check only necessary if TIG is not available
               KVariable kVarEnAvailable = HmiVariableService.getService().getTempVariable(VAR_PATH_EASYNET_IS_AVAILABLE, false);
               HmiVariableService.getService().readValue(kVarEnAvailable);
               m_isAnyCtrlCenterAvailable = kVarEnAvailable.getBooleanValue();
            } catch (Exception ex) {
               CAT.error("Cannot read EasyNet-Available flag!", ex);
            }
         }
         try {
            if (HmiVariableService.getService().getTempVariable(VAR_PATH_GENERICCONTROLCENTER_IS_AVAILABLE, false).getBooleanValue())
               m_isAnyCtrlCenterAvailable = true;
         } catch (Exception ex) {
         }
         // Register connection listeners
         CtrlCenterConnectionChangedListener ctrlCenterConnectionChangedListener = new CtrlCenterConnectionChangedListener();
         kVarTIGConnected = HmiVariableService.registerVariable(TIG.KVAR_CONNECT, ctrlCenterConnectionChangedListener);
         kVarENConnected = HmiVariableService.registerVariable(VAR_PATH_EASYNET_IS_CONNECTED, ctrlCenterConnectionChangedListener);
         kVarGenericConnected = HmiVariableService.registerVariable(VAR_PATH_GENERICCONTROLCENTER_IS_CONNECTED,
               ctrlCenterConnectionChangedListener);
         // ########## ServiceNet ##########
         HmiVariableService.registerVariable(VAR_PATH_SERVICE_NET_IS_CONNECTED, new ValueChangedListener() {
            public void valueChanged(ValueChangedEvent event) {
               try {
                  if (event.getVariable().getIntValue() == STATE_CONNECTED) {
                     m_isServiceNetConnected = true;
                  } else {
                     m_isServiceNetConnected = false;
                  }
                  updateBitmap();
               } catch (Exception ex) {
                  CAT.error("valueChanged (ServiceNet): ", ex);
               }
            }
         });
      } catch (Exception ex) {
         CAT.error("initVariables: ", ex);
      }
   }

   private void updateBitmap() {
      String iconPath;
      if (m_isVncClientConnected) {
         // Vncviewer open
         iconPath = "ServiceNet.hmi.images.ServiceNet_active.gif";
      } else if (m_isServiceNetConnected) {
         // ServiceNet connected
         iconPath = "composite/ServiceNetOrTigBitmap/images/movNoMove.gif";
      } else if (m_isAnyCtrlCenterAvailable) { // Any control center available?
         if (m_isAnyCtrlCenterConnected) { // Any control center connected?
            // Control center connected
            iconPath = "TIG.hmi.images.lan_ok.gif";
         } else {
            // Control center disconnected
            iconPath = "TIG.hmi.images.lan_nok.gif";
         }
      } else {
         // ServiceNet not connected, VncClient not open, no control center available -> no icon
         iconPath = "composite/ServiceNetOrTigBitmap/images/movNoMove.gif";
      }
      // set icon
      bmpState.setIconName(iconPath);
      bmpState.repaint();
   }

   public void vncClientConnected(String clientIp) {
      m_isVncClientConnected = true;
      updateBitmap();
      startUpdateThread();
   }

   public void vncClientDisconnected(String clientIp) {
      m_isVncClientConnected = false;
      updateBitmap();
      stopUpdateThread();
   }

   private void startUpdateThread() {
      checkLineColor();
      if (m_updateThread != null) {
         // Thread is still running
         return;
      }
      m_updateThread = new MyUpdateThread();
      m_updateThread.start();
   }

   private void stopUpdateThread() {
      if (m_updateThread != null) {
         m_updateThread.stopMe();
         m_updateThread = null;
      }
   }

   private void checkLineColor() {
      Color bgCol = null;
      Container parent;
      parent = this;
      while ((parent != null) && (parent.getBackground() == null)) {
         parent = parent.getParent();
      }
      if (parent != null) {
         bgCol = parent.getBackground();
      }
      int b = bgCol.getBlue();
      if (b > 100) {
         b = b - 10;
      } else {
         b = b + 10;
      }
      bgCol = new Color(bgCol.getRed(), bgCol.getGreen(), b);
      line1.setForeground(bgCol);
      line1.setVisible(true);
      line1.invalidate();
      this.validate();
   }

   private class MyUpdateThread extends Thread {
      /**
       * This thread is used to check a disconnect from the vnc-client. If the client doesn't
       * respond to a repaint, then the server recognized, that the client has disconnected. If the
       * visu has no repaints, so no telegram is sent to the client and the server has no
       * opportunity to check if the client is still responsing. So this thread shows and hides a
       * line, just to do some repaints.
       */
      private boolean m_isRunning;

      public void run() {
         m_isRunning = true;
         try {
            while (m_isRunning == true) {
               changePointColor();
               sleep(2000);
            }
            line1.setVisible(false);
            line1.repaint();
         } catch (Exception ex) {
            CAT.error("MyUpdateThread.run: ", ex);
         }
      }

      public void stopMe() {
         m_isRunning = false;
      }

      private void changePointColor() {
         line1.setVisible(!line1.isVisible());
         // line1.repaint(); // don't call here repaint, otherwise the paint is called twice
      }
   }

   /**
    * Helper class for updating bitmap depending on control center states.
    * 
    * @author steg
    * 
    */
   private class CtrlCenterConnectionChangedListener implements ValueChangedListener {
      public void valueChanged(ValueChangedEvent event) {
         try {
            m_isAnyCtrlCenterConnected = event.getVariable().getBooleanValue()
                  || (kVarTIGConnected != null && kVarTIGConnected.getBooleanValue())
                  || (kVarENConnected != null && kVarENConnected.getBooleanValue())
                  || (kVarGenericConnected != null && kVarGenericConnected.getBooleanValue());
            // Control center should signalize "available" if control center gets connected the
            // first time
            m_isAnyCtrlCenterAvailable = m_isAnyCtrlCenterAvailable || m_isAnyCtrlCenterConnected;
            updateBitmap();
         } catch (Exception ex) {
            CAT.error("ctrlStationConnectionChanged: ", ex);
         }
      }
   }
}
