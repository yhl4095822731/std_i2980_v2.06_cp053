package ServiceNet.hmi;

import java.awt.Cursor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.StringTokenizer;
import java.util.Vector;

import org.w3c.dom.Element;

import com.ibm.log4j.Category;
import com.keba.espresso.awt.border.KvEmptyBorder;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.util.KvToolkit;
import com.keba.kemro.kvs.recipe.data.AbsKPVarGroupStorage;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.general.PlastConstants;
import com.keba.util.Config;

import system.hmi.PathConfigUtils;

public class ServiceNetSettingsMask extends ServiceNetSettingsMask_generated {
   private static final long serialVersionUID = 1L;
   private final String FILENAME_SERVICE_NET_CONTACTS = "serviceNetContacts.xml";
   private final String VAR_GROUP_NAME = "VG_ServiceNetContactData";
   private USBInfo m_usbList[];
   private Category CAT;

   public ServiceNetSettingsMask() throws Exception {
      super();
      CAT = Category.getInstance(this.getClass().getName());
      try {
         initComponents();
      } catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   public void onShow() {
      super.onShow();
      btnRefreshClicked();
   }

   private void initComponents() {
      btnRefresh.removeActionListener(this);
      btnRefresh.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            btnRefreshClicked();
         }
      });

      comboUsbList.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            comboUsbListClicked();
         }
      });

      btnExportUSB.removeActionListener(this);
      btnExportUSB.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            btnExportUsbClicked();
         }
      });

      btnImportUSB.removeActionListener(this);
      btnImportUSB.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            btnImportUsbClicked();
         }
      });

      // vpl3
      if (PlastConstants.isVPL3()) {
         containerButtons.setBorder(new KvEmptyBorder(10, 0, 0, 0));
      }
   }

   private void btnRefreshClicked() {
      String usbNames;

      KvToolkit.setCursor(Cursor.WAIT_CURSOR);
      m_usbList = getValidUsbDir();
      usbNames = "";
      for (int i = 0; i < m_usbList.length; i++) {
         usbNames = usbNames + m_usbList[i].displayName;
         if (i < m_usbList.length - 1) {
            usbNames += ";";
         }
      }
      comboUsbList.setListTexts(usbNames);
      comboUsbList.setSelectedIndex(-1);
      comboUsbList.repaint();
      KvToolkit.setCursor(Cursor.DEFAULT_CURSOR);
   }

   private void comboUsbListClicked() {
      int selectedIndex;
      boolean enabled;

      selectedIndex = comboUsbList.getSelectedIndex();
      CAT.info("comboUsbListClicked: new index = " + selectedIndex);
      enabled = true;
      if (selectedIndex == -1) {
         enabled = false;
      }
      btnExportUSB.setEnabled(enabled);
      btnImportUSB.setEnabled(enabled);
      btnExportUSB.repaint();
      btnImportUSB.repaint();
   }

   private void btnExportUsbClicked() {
      String path;
      ServiceNetSettingsDataVarGroupStorage varGroupStorage;

      path = m_usbList[comboUsbList.getSelectedIndex()].usbPath;

      varGroupStorage = new ServiceNetSettingsDataVarGroupStorage();
      try {
         varGroupStorage.save(path, FILENAME_SERVICE_NET_CONTACTS, VAR_GROUP_NAME);
         KvMessageDialog.showInfoMessage("Export successfully finished", "Export contactdata", true, null);
      } catch (Exception ex) {
         CAT.error("btnExportUsbClicked: ", ex);
         KvMessageDialog.showErrorMessage(ex.getMessage(), "Export failed", true, null);
      }
   }

   private void btnImportUsbClicked() {
      String path;
      ServiceNetSettingsDataVarGroupStorage varGroupStorage;

      path = m_usbList[comboUsbList.getSelectedIndex()].usbPath;

      varGroupStorage = new ServiceNetSettingsDataVarGroupStorage();
      try {
         varGroupStorage.load(path, FILENAME_SERVICE_NET_CONTACTS);
         KvMessageDialog.showInfoMessage("Import successfully finished", "Import contactdata", true, null);
      } catch (Exception ex) {
         CAT.error("btnImportUsbClicked: ", ex);
         KvMessageDialog.showErrorMessage(ex.getMessage(), "Import failed", true, null);
      }
   }

   /**
    * Returns all currently valid paths for the usb-stick.
    * 
    * @return String
    */
   private USBInfo[] getValidUsbDir() {
      String directoryList;
      StringTokenizer tokens;
      String pathEntry;
      USBInfo usbInfos[];
      USBInfo singleInfo;
      Vector entries;
      File f;
      int idxSeparator;

      entries = new Vector();
      directoryList = Config.getStringProperty("UsbDirectoryList", PathConfigUtils.createUSBPath(0, false));
      tokens = new StringTokenizer(directoryList, ";");
      while (tokens.hasMoreElements()) {
         pathEntry = tokens.nextToken();
         idxSeparator = pathEntry.indexOf("|");
         singleInfo = new USBInfo();
         singleInfo.usbPath = pathEntry.substring(0, idxSeparator);
         singleInfo.displayName = pathEntry.substring(idxSeparator + 1);
         f = new File(singleInfo.usbPath);
         if (f.exists() && f.isDirectory()) {
            entries.addElement(singleInfo);
         }
      }
      usbInfos = new USBInfo[entries.size()];
      for (int i = 0; i < entries.size(); i++) {
         usbInfos[i] = (USBInfo) entries.elementAt(i);
      }
      return usbInfos;
   }

   private class USBInfo {
      String usbPath;
      String displayName;
   }

   private class ServiceNetSettingsDataVarGroupStorage extends AbsKPVarGroupStorage {
      public Vector[] getAdditionalVarGroups() {
         return null;
      }

      public KVariable[] getAdditionalVars() {
         return null;
      }

      protected void loadAdditionalFromDoc() throws Exception {
         // nothing to do
      }

      protected void saveAdditionalToNode(Element arg0) throws Exception {
         // nothing to do
      }
   }
}
