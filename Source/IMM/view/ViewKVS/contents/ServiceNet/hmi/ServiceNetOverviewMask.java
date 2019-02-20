package ServiceNet.hmi;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.io.IOException;
import java.util.Locale;

import com.ibm.log4j.Category;
import com.keba.espresso.awt.border.KvEmptyBorder;
import com.keba.espresso.awt.config.rtk.KvTextFieldBackgroundRendererInterface;
import com.keba.kemro.jni.NativeNetConfig;
import com.keba.kemro.jni.SystemInfo;
import com.keba.kemro.kv.util.KvToolkit;
import com.keba.kemro.kvs.keplast.general.util.VersionInfoReader;
import com.keba.kemro.plc.catalog.KCatStringObj;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiIOService;
import com.keba.kemro.plc.service.HmiSystemService;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.PlastConstants;

import espial.awt.Border;

public class ServiceNetOverviewMask extends ServiceNetOverviewMask_generated implements ItemListener {
   private static final long serialVersionUID = 1L;

   // The default ServiceNet IP to connect to the service modem.
   ////////////////////////////////////////////////////////////
   private final String DEFAULT_SWITCH_IP = "192.168.0.1";
   private final String DEFAULT_SWITCH_SUBNET = "255.255.255.0";
   private final String DEFAULT_SWITCH_GATEWAY = "192.168.0.100";
   //////////////////////////////////////////////////////////////

   private final String VAR_PATH_CONNECT_CMD = "ServiceNet.sv_bConnect";
   private final String VAR_PATH_NETCONFIG = "ServiceNet.sv_SNNetworkConfig";
   private final String VAR_PATH_NETCONFIG_IP = VAR_PATH_NETCONFIG + ".sIP";
   private final String VAR_PATH_NETCONFIG_SUBNET = VAR_PATH_NETCONFIG + ".sSubnetMask";
   private final String VAR_PATH_NETCONFIG_GATEWAY = VAR_PATH_NETCONFIG + ".sGateway";

   // Remote maintenance software unit specific variables
   private final String VAR_PATH_REMOTESERVICE_AVAIL = "ServiceNet.sv_bRemoteMaintAvailable";
   private final String VAR_PATH_REMOTESERVICE_ACTIVATE = "ServiceNet.sv_bRemoteMaintActivate";
   private final String VAR_PATH_REMOTESERVICE_SITEMAN_CONNECTED = "ServiceNet.sv_SiteManager.bConnected";

   private final String ACTION_CMD_REQUEST = "doRequest";
   private final String ACTION_CMD_DISCONNECT = "doDisconnect";

   private final String ACTION_CMD_ACTIVATE = "doActivate";
   private final String ACTION_CMD_DEACTIVATE = "doDeactivate";

   private KVariable m_varNetConfigIP;
   private KVariable m_varNetConfigSubnet;
   private KVariable m_varNetConfigGateway;
   private KVariable m_varConnect;

   private KVariable m_varRemoteServiceAvail;
   private KVariable m_varRemoteServiceActivate;
   private KVariable m_varRemoteServiceSiteManConnected;

   private Category CAT;

   public ServiceNetOverviewMask() throws Exception {
      super();
      CAT = Category.getInstance("ServiceNetOverviewMask");
      try {
         initComponents();
         initVariables();

      } catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   private void initComponents() {
      VersionInfoReader versions = VersionInfoReader.getInstance();

      lblActCustVersion.setText(versions.getVersionInfoCustomer());
      lblActSystem.setText(versions.getSystemName());
      lblActHMIVersion.setText(versions.getVersionInfoKePlastHMI());
      lblActIECVersion.setText(versions.getVersionInfoIEC());
      if (lblActFirmware != null) {
         lblActFirmware.setText(getFirmwareVersion());
      }
      containerStateShadow.setBorder(new StateBorder());

      if (lblActIPAddress != null) {
         lblActIPAddress.setText("Unknown");
         cbSwitch.addItemListener(this);
      }

      btnRequest.removeActionListener(this);
      btnRequest.addActionListener(new ActionListener() {

         public void actionPerformed(ActionEvent e) {
            btnRequestClicked();
         }
      });

      if (btnActivate != null) {
         btnActivate.removeActionListener(this);
         btnActivate.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
               btnActivateClicked();
            }
         });
      }

      // vpl3
      if (PlastConstants.isVPL3()) {
         containerButtons.setBorder(new KvEmptyBorder(10, 0, 0, 0));
      }
   }

   private void initVariables() {

      try {

         m_varNetConfigIP = HmiVariableService.getService().getVariable(VAR_PATH_NETCONFIG_IP);
         m_varNetConfigSubnet = HmiVariableService.getService().getVariable(VAR_PATH_NETCONFIG_SUBNET);
         m_varNetConfigGateway = HmiVariableService.getService().getVariable(VAR_PATH_NETCONFIG_GATEWAY);

         m_varConnect = HmiVariableService.registerVariable(VAR_PATH_CONNECT_CMD, new ValueChangedListener() {
            public void valueChanged(ValueChangedEvent event) {
               try {
                  updateConnectButton(event.getVariable().getBooleanValue());
               } catch (Exception ex) {
                  CAT.error("valueChanged (m_varConnect): ", ex);
               }
            }
         });

      } catch (Exception ex) {
         CAT.error("initVariables: ", ex);
      }

      try {
         m_varRemoteServiceAvail = HmiVariableService.getService().getVariable(VAR_PATH_REMOTESERVICE_AVAIL);
         HmiVariableService.getService().readValue(m_varRemoteServiceAvail);
         if (m_varRemoteServiceAvail.getBooleanValue()) {

            m_varRemoteServiceActivate = HmiVariableService.registerVariable(VAR_PATH_REMOTESERVICE_ACTIVATE, new ValueChangedListener() {
               public void valueChanged(ValueChangedEvent event) {
                  try {
                     updateActivateButton(event.getVariable().getBooleanValue());
                  } catch (Exception ex) {
                     CAT.error("valueChanged (m_varRemoteServiceActivate): ", ex);
                  }
               }
            });

            m_varRemoteServiceSiteManConnected = HmiVariableService.registerVariable(VAR_PATH_REMOTESERVICE_SITEMAN_CONNECTED,
                  new ValueChangedListener() {

                     public void valueChanged(ValueChangedEvent event) {
                        try {
                           boolean activated = event.getVariable().getBooleanValue();
                           btnRequest.setEnabled(activated);
                           if (!activated) {
                              serviceNetDisconnect();
                              updateConnectButton(false);
                           }

                        } catch (Exception ex) {
                           CAT.error("valueChanged (m_varRemoteServiceSiteManConnected): ", ex);
                        }
                     }
                  });
         }
      } catch (Exception ex) {
         CAT.error("initVariables/remote maintenance: ", ex);
      }
   }

   private String getFirmwareVersion() {
      try {
         KCatStringObj obj = (KCatStringObj) HmiIOService.getService().getIOItem(0, "System.firmwareVersion");
         String firmware = obj.getValue();
         return firmware;
      } catch (Exception e) {
         return "not detected";
      }
   }

   private String getControlIP() {
      try {
         NativeNetConfig.readConfiguration();
      } catch (IOException e) {
      }

      return SystemInfo.getLocalAddress(HmiSystemService.getService().getSocket());
   }

   public void onShow() {
      super.onShow();
      if (lblActIPAddress != null) {
         String ip = getControlIP();
         lblActIPAddress.setText(ip);
      }
   }

   private void btnRequestClicked() {
      String currentActionCommand;

      currentActionCommand = btnRequest.getActionCommand();
      if (currentActionCommand.equalsIgnoreCase(ACTION_CMD_REQUEST) == true) {
         serviceNetConnect();
         updateConnectButton(true);
      } else {
         serviceNetDisconnect();
         updateConnectButton(false);
      }
   }

   private void updateConnectButton(boolean connectedCmd) {
      if (connectedCmd) {
         btnRequest.setActionCommand(ACTION_CMD_DISCONNECT);
         btnRequest.setText(labDisconnect.getText());
      } else {
         btnRequest.setActionCommand(ACTION_CMD_REQUEST);
         btnRequest.setText(labConnect.getText());
      }
      btnRequest.repaint();
   }

   private void serviceNetConnect() {
      try {
         if (m_varConnect != null) {
            HmiVariableService.getService().writeValue(m_varConnect, Boolean.TRUE, false);
         }
      } catch (Exception ex) {
         CAT.error("serviceNetConnect: ", ex);
      }
   }

   private void serviceNetDisconnect() {
      try {
         if (m_varConnect != null) {
            HmiVariableService.getService().writeValue(m_varConnect, Boolean.FALSE, false);
         }
      } catch (Exception ex) {
         CAT.error("serviceNetDisconnect: ", ex);
      }
   }

   private void btnActivateClicked() {
      String currentActionCommand;

      currentActionCommand = btnActivate.getActionCommand();
      if (currentActionCommand.equalsIgnoreCase(ACTION_CMD_ACTIVATE) == true) {
         gatewayActivate();
         updateActivateButton(true);
      } else {
         serviceNetDisconnect();
         gatewayDeactivate();
         btnRequest.setEnabled(false);
         updateActivateButton(false);
      }
   }

   private void updateActivateButton(boolean activatedCmd) {
      if (btnActivate == null) {
         return;
      }
      if (activatedCmd) {
         btnActivate.setActionCommand(ACTION_CMD_DEACTIVATE);
         btnActivate.setText(labDeactivate.getText());
      } else {
         btnActivate.setActionCommand(ACTION_CMD_ACTIVATE);
         btnActivate.setText(labActivate.getText());
      }
      btnActivate.repaint();
   }

   private void gatewayActivate() {
      try {
         if (m_varRemoteServiceActivate != null) {
            HmiVariableService.getService().writeValue(m_varRemoteServiceActivate, Boolean.TRUE, false);
         }
      } catch (Exception ex) {
         CAT.error("remoteServiceActivate: ", ex);
      }
   }

   private void gatewayDeactivate() {
      try {
         if (m_varRemoteServiceActivate != null) {
            HmiVariableService.getService().writeValue(m_varRemoteServiceActivate, Boolean.FALSE, false);
         }
      } catch (Exception ex) {
         CAT.error("remoteServiceDeactivate: ", ex);
      }

   }

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);

      // Correct text for request button depending on current connection
      if (m_varConnect != null) {
         try {
            updateConnectButton(m_varConnect.getBooleanValue());

         } catch (VartypeException ex) {
            CAT.error("changeLocale (m_varConnect): ", ex);
         }
      }

      if (m_varRemoteServiceActivate != null) {
         try {
            updateActivateButton(m_varRemoteServiceActivate.getBooleanValue());
         } catch (VartypeException ex) {
            CAT.error("changeLocale (m_varRemoteServiceActivate): ", ex);
         }
      }

   }

   public void itemStateChanged(ItemEvent e) {
      if (e.getSource().equals(cbSwitch)) {
         // an empty IP indicates that the IP should not be switched
         String ip = "";
         if (cbSwitch.getState()) {
            ip = DEFAULT_SWITCH_IP;
            CAT.debug("Switching IP address to '" + ip + "'");
         }

         try {
            if (m_varNetConfigIP != null) {
               hmiService.writeValue(m_varNetConfigIP, ip);
            }
            // we write the subnet + gateway just in case
            if (m_varNetConfigSubnet != null) {
               hmiService.writeValue(m_varNetConfigSubnet, DEFAULT_SWITCH_SUBNET);
            }
            if (m_varNetConfigGateway != null) {
               hmiService.writeValue(m_varNetConfigGateway, DEFAULT_SWITCH_GATEWAY);
            }
         } catch (Exception ex) {
            CAT.error("Could not switch IP to '" + ip + "'", ex);
         }
      }
   }

   private class StateBorder implements Border {

      public void paint(Component c, Graphics g) {
         KvTextFieldBackgroundRendererInterface renderer;

         renderer = KvToolkit.getRenderingToolkit().getTextFieldBackgoundRenderer();

         renderer.drawFieldBackground(c, g, TEXT_FIELD_NOT_EDITABLE_BG);
         renderer.drawFieldBorder(c, g, COL_WIDGET_BORDER_DISABLED);
      }

      public Insets getInsets(Component arg0) {
         return new Insets(0, 4, 1, 4);
      }
   }

}
