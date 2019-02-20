package ServiceNet.hmi.service;

import java.util.ResourceBundle;
import java.util.Vector;

import com.ibm.log4j.Category;
import com.keba.kemro.kv.control.VncServerControl;
import com.keba.kemro.kv.control.VncServerControl.VncEvent;
import com.keba.kemro.kv.dialog.KvDialogInfoInterface;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.util.KvTouchUI;
import com.keba.kemro.kv.widgets.KvPopupMenu;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiSystemService;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.util.KChangeEvent;
import com.keba.util.KChangeListener;

public class KPServiceNetService {
   private static KPServiceNetService m_instance;
   private final String RESOURCE_BUNDLE = "ServiceNet.hmi.text.message";
   private final String VAR_PATH_CONNECTION_STATE = "ServiceNet.sv_ConnectionStatus";
   private final String VAR_PATH_HMI_RESPONSE = "ServiceNet.sv_HMIResponse";
   public static final int CONNECTION_STATE_DISCONNECTED = 0;
   public static final int CONNECTION_STATE_CONNECTING = 1;
   public static final int CONNECTION_STATE_REQUEST_PENDING = 2;
   public static final int CONNECTION_STATE_SERVICE_ACCEPTED = 3;
   public static final int CONNECTION_STATE_SERVICE_ACCESS_REQUEST = 4;
   public static final int CONNECTION_STATE_SERVICE_ACTIVE = 5;

   private final Integer DIALOG_OPTION_OK = new Integer(1);
   private final Integer DIALOG_OPTION_NO = new Integer(2);
   private Category CAT;
   private Integer m_varGroupId;
   private Vector m_listener;
   private VncListener m_vncListener;
   private int defaultVarServiceTaskPrio = -1;
   private static final int TMP_VAR_SVC_TASK_PRIO_DURING_VNC_ACTIVE = 1;
   private boolean m_VncServerStarted = false;

   private KPServiceNetService() {
      CAT = Category.getInstance(getClass().getName());
      try {
         m_listener = new Vector();
         m_vncListener = new VncListener();
         initVariables();
      } catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   public static KPServiceNetService getInstance() {
      if (m_instance == null) {
         m_instance = new KPServiceNetService();
      }
      return m_instance;
   }

   public void startService() {
      if (m_varGroupId != null) {
         HmiVariableService.getService().activateGroup(m_varGroupId);
      }
   }

   public void stopService() {
      if (m_varGroupId != null) {
         HmiVariableService.getService().deactivateGroup(m_varGroupId);
      }
   }

   public void addServiceNetListener(IServiceNetListener listener) {
      m_listener.addElement(listener);
   }

   public void removeServiceNetListener(IServiceNetListener listener) {
      m_listener.removeElement(listener);
   }

   private void initVariables() {
      KVariable var;
      Vector v;

      try {
         v = new Vector();
         var = HmiVariableService.registerVariable(VAR_PATH_CONNECTION_STATE, new ValueChangedListener() {
            public void valueChanged(ValueChangedEvent event) {
               if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
                  // React on real value changes only, because VncServer must not be started if it
                  // is already running
                  return;
               }

               try {
                  connectionStateChanged(event.getVariable().getIntValue());
               } catch (Exception ex) {
                  CAT.error("valueChanged (connection state): ", ex);
               }
            }
         });
         v.addElement(var);
         m_varGroupId = HmiVariableService.getService().addGroup("KPServiceNetServiceVarGroup", v);
      } catch (Exception ex) {
         CAT.error("initVariables: ", ex);
      }
   }

   private void connectionStateChanged(int connectionState) {
      String message, title;
      ResourceBundle bundle;

      if ((connectionState == CONNECTION_STATE_SERVICE_ACCESS_REQUEST) && (HmiSystemService.getService().isLocalStation() == true)) {
         try {
            bundle = ResourceBundle.getBundle(RESOURCE_BUNDLE);
            title = bundle.getString("dlg_allow_remote_access_title");
            message = bundle.getString("dlg_allow_remote_access_message");
         } catch (Exception ex) {
            CAT.error("connectionStateChanged (bundle): ", ex);
            title = "Remote access";
            message = "Allow remote access?";
         }
         KvMessageDialog.showQuestionMessage(message, title, true, new RemoteAccessInfo());
      } else if (connectionState == CONNECTION_STATE_SERVICE_ACTIVE) {
         boolean success;

         success = VncServerControl.startServer(22, "", m_vncListener);
         Thread varUpdateThread = HmiVariableService.getService().getUpdateThread();
         defaultVarServiceTaskPrio = varUpdateThread.getPriority();
         varUpdateThread.setPriority(TMP_VAR_SVC_TASK_PRIO_DURING_VNC_ACTIVE);

         if (success == false) {
            KvMessageDialog.showErrorMessage("Could not start VNC-Server!", "VNC-Server", true, null);
         } else {
            m_VncServerStarted = true;
            // Read extended popup delay time and set it globally for all popup menus
            KvPopupMenu.setGlobalCloseTimeAll(KvTouchUI.getIntProperty("popup.disappear.delay.during.vnc.in.ms", 20000));

         }
      } else if (connectionState == CONNECTION_STATE_DISCONNECTED) {
         if (m_VncServerStarted) {
            VncServerControl.stopServer();
            m_VncServerStarted = false;
            // Reset global popup close time
            KvPopupMenu.setGlobalCloseTimeAll(0);

            if (defaultVarServiceTaskPrio >= 0) {
               HmiVariableService.getService().getUpdateThread().setPriority(defaultVarServiceTaskPrio);
            }
         }
      }
   }

   private class RemoteAccessInfo implements KvDialogInfoInterface {
      private KVariable var;

      RemoteAccessInfo() {
         try {
            var = HmiVariableService.getService().getVariable(VAR_PATH_HMI_RESPONSE);
         } catch (Exception ex) {
            CAT.error("RemoteAccess: ", ex);
         }
      }

      public boolean getPressedOption(int option) {
         try {
            if (option == KvDialogInfoInterface.OK) {
               HmiVariableService.getService().writeValue(var, DIALOG_OPTION_OK, false);
            } else {
               HmiVariableService.getService().writeValue(var, DIALOG_OPTION_NO, false);
            }
         } catch (Exception ex) {
            CAT.error("getPressedOption: ", ex);
         }
         return true;
      }

   }

   private class VncListener implements KChangeListener {

      public void stateChanged(KChangeEvent e) {
         if (e instanceof VncEvent) {
            VncEvent vncEv;
            IServiceNetListener l;

            vncEv = (VncEvent) e;
            CAT.info("VNC connection state changed: connected = " + vncEv.isAdded() + "; client-Ip = " + vncEv.getSource());
            if (vncEv.isAdded() == true) {
               for (int i = 0; i < m_listener.size(); i++) {
                  l = (IServiceNetListener) m_listener.elementAt(i);
                  l.vncClientConnected((String) vncEv.getSource());
               }
            } else {
               for (int i = 0; i < m_listener.size(); i++) {
                  l = (IServiceNetListener) m_listener.elementAt(i);
                  l.vncClientDisconnected((String) vncEv.getSource());
               }
            }
         }
      }
   }
}
