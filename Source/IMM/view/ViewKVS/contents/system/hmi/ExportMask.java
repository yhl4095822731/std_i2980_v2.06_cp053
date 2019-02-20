/* --------------------------------------------------------------------------------
 *                               (c) 2018 by KEBA AG
 *                                   Linz/AUSTRIA
 *                               All rights reserved
 * --------------------------------------------------------------------------------
 *    Project  : KePlast.HMI.KVS
 *    Author   : mhf
 *    Date     : 28.03.2018
 * --------------------------------------------------------------------------------
 */
package system.hmi;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FilenameFilter;
import java.util.Locale;
import java.util.StringTokenizer;

import com.ibm.log4j.Category;
import com.keba.kemro.kv.dialog.KvDialogInfoInterface;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.dialog.KvProgressMonitor;
import com.keba.kemro.kv.widgets.std.KvCheckBoxStd;
import com.keba.kemro.kv.widgets.std.KvNumFieldStd;
import com.keba.kemro.kvs.keplast.general.util.KPResourceBundle;
import com.keba.kemro.kvs.keplast.recipe.util.FileUtils;
import com.keba.keplast.utils.SystemInfo;
import com.keba.keplast.widgets.KUsbSelectList;
import com.keba.util.Worker;

public class ExportMask extends ExportMask_generated {

   protected static Category CAT = Category.getInstance(ExportMask.class.getName());
   private KPResourceBundle textBundle = KPResourceBundle.getBundle("system.hmi.text.exportTexts");
   private static final long serialVersionUID = 1L;

   private KUsbSelectList comboBoxUsb;
   private Worker worker;

   private ExportJob[] exportJobs;

   public static class ExtFileNameFilter implements FilenameFilter {

      private String exts;
      private String excludedFiles;

      public ExtFileNameFilter(String exts, String excludedFiles) {

         this.exts = exts.toLowerCase(Locale.ENGLISH);
         if (excludedFiles != null) {
            this.excludedFiles = excludedFiles.toLowerCase(Locale.ENGLISH);
         }
      }

      public boolean accept(File dir, String name) {

         StringTokenizer tokens;
         String ext;

         // included extensions
         boolean included = false;
         if (exts != null) {
            tokens = new StringTokenizer(exts, ";");
            while (tokens.hasMoreElements() && !included) {
               ext = tokens.nextToken();
               included = name.toLowerCase(Locale.ENGLISH).endsWith(ext);
            }
         }

         // excluded files
         String excludedFile;
         boolean excluded = false;
         if (excludedFiles != null && included) {
            tokens = new StringTokenizer(excludedFiles, ";");
            while (tokens.hasMoreElements() && !excluded) {
               excludedFile = tokens.nextToken();
               excluded = name.toLowerCase(Locale.ENGLISH).endsWith(excludedFile);
            }
         }

         return included && !excluded;
      }

   }

   private class ExportJob {

      private String root;
      private String relDir;
      private String extensions;
      private String excludedFiles;
      private KvCheckBoxStd checkBoxExport;
      private KvCheckBoxStd checkBoxDelete;
      private KvNumFieldStd numFieldCount;
      private boolean deleteAllFiles;

      public ExportJob(
            String root,
            String relDir,
            String extensions,
            KvCheckBoxStd cbExport,
            KvCheckBoxStd cbDelete,
            KvNumFieldStd numFieldCount) {

         this.root = root;
         this.relDir = relDir;
         this.extensions = extensions;
         this.checkBoxExport = cbExport;
         this.checkBoxDelete = cbDelete;
         this.numFieldCount = numFieldCount;
      }

      public ExportJob(
            String root,
            String relDir,
            String extension,
            KvCheckBoxStd cbExport,
            KvCheckBoxStd cbDelete,
            KvNumFieldStd numFieldCount,
            boolean deleteAllFiles) {

         this(root, relDir, extension, cbExport, cbDelete, numFieldCount);
         this.deleteAllFiles = deleteAllFiles;
      }

      public ExportJob(
            String root,
            String relDir,
            String extension,
            KvCheckBoxStd cbExport,
            KvCheckBoxStd cbDelete,
            KvNumFieldStd numFieldCount,
            String excludedFiles,
            boolean deleteAllFiles) {

         this(root, relDir, extension, cbExport, cbDelete, numFieldCount, deleteAllFiles);
         this.excludedFiles = excludedFiles;
      }

      private String getExportDirectory(String root) {
         return root + relDir;
      }

      public boolean isExportSelected() {
         return checkBoxExport != null ? checkBoxExport.isSelected() : false;
      }

      public boolean isDeleteSelected() {
         return checkBoxDelete != null ? checkBoxDelete.isSelected() : false;
      }

      public void unselectAll() {
         if (checkBoxDelete != null)
            checkBoxDelete.setState(false);
         if (checkBoxExport != null)
            checkBoxExport.setState(false);
      }

      public void updateNumberOfFiles() {
         if (numFieldCount == null) {
            return;
         }

         try {
            if (FileUtils.dirExists(getExportDirectory(root))) {
               File[] files = FileUtils.getChildren(getExportDirectory(root), new ExtFileNameFilter(extensions, excludedFiles));
               numFieldCount.setValue(files.length);
            }
         } catch (Exception e) {
            numFieldCount.setValue(0);
            CAT.error("Could not obtain number of files in directory " + getExportDirectory(root), e);
         }
      }

      public boolean export(String usbTarget) {
         if (checkBoxExport == null) {
            return true;
         }

         if (!checkBoxExport.isSelected()) {
            return true;
         }

         try {
            if (!existsUsbPath(usbTarget)) {
               comboBoxUsb.setSelectedIndex(-1);
               CAT.error("USB was removed before export was finished");
               return false;
            }

            boolean success = true;

            if (FileUtils.dirExists(getExportDirectory(root))) {
               String usbTargetAbs = getExportDirectory(usbTarget);
               File usbTargetAbsDir = new File(usbTargetAbs);
               usbTargetAbsDir.mkdirs();

               File[] files = FileUtils.getChildren(getExportDirectory(root), new ExtFileNameFilter(extensions, excludedFiles));
               for (int i = 0; i < files.length; i++) {
                  File file = files[i];
                  try {
                     FileUtils.copyFile(file.getParent(), file.getName(), usbTargetAbs, file.getName());
                  } catch (Exception ex) {
                     CAT.error("Could not export file " + file.getAbsolutePath(), ex);
                     success = false;
                  }
               }
            } else {
               success = false;
            }

            return success;

         } catch (Exception e) {
            CAT.error("Could not export files from directory " + getExportDirectory(root), e);
            return false;
         }
      }

      public boolean delete() {
         if (checkBoxDelete == null) {
            return true;
         }

         if (!checkBoxDelete.isSelected()) {
            return true;
         }

         boolean success = true;
         try {

            if (FileUtils.dirExists(getExportDirectory(root))) {
               // we dont consider the excluded files here -> delete whole folder content!
               // reason: the starep files (lastStarepId.txt, ...) have to be deleted as well
               try {
                  // TODO Workaround CR 268361: ChangeRequest KeView.Style/Trend:
                  // Symlinks are not recognized on remote file system
                  // delete this symlink before everything else
                  if (getExportDirectory(root).toLowerCase(Locale.ENGLISH).indexOf("statusreport") > 0) {
                     FileUtils.deleteFile(getExportDirectory(root), "starep_latest.tgz");
                  }
               } catch (Exception ex) {
                  // ignore
               }

               File[] files = FileUtils.getChildren(getExportDirectory(root),
                     deleteAllFiles ? null : new ExtFileNameFilter(extensions, null));
               for (int i = 0; i < files.length; i++) {
                  File file = files[i];
                  try {
                     // currently do not check for return code here - since deleting symlinks always
                     // returns false on delete(), fix with CR 268361
                     file.delete();
                  } catch (Exception ex) {
                     CAT.error("Could not delete file " + file.getAbsolutePath(), ex);
                     success = false;
                  }
               }
            } else {
               success = false;
            }

         } catch (Exception e) {
            CAT.error("Could not delete files in directory " + getExportDirectory(root), e);
            success = false;
         }
         return success;
      }

   }

   public ExportMask() throws Exception {
      super();

      exportJobs = new ExportJob[] {
            // state reports
            new ExportJob(FileUtils.SERVER_PATH_PREFIX + com.keba.keplast.utils.SystemInfo.getInstance().getRootPath(),
                  PathConfigUtils.getDefaultStarepPathRel(), ".tgz",
                  checkBoxExportStarep, checkBoxDeleteStarep, numFieldStarep, "starep_latest.tgz", true),
            // screenshots
            new ExportJob(com.keba.keplast.utils.SystemInfo.getInstance().getApplPath(),
                  PathConfigUtils.getDefaultScreenShotPathRel(), ".png;.ps;.pdf",
                  checkBoxExportScreenShot, checkBoxDeleteScreenShot, numFieldScreenShot, false),
            // PDP protocol
            new ExportJob(com.keba.keplast.utils.SystemInfo.getInstance().getApplPath(),
                  PathConfigUtils.getDefaultPdpPathRel(), ".txt",
                  checkBoxExportPDP, checkBoxDeletePDP, numFieldPDP, false),
            // machine data
            new ExportJob(FileUtils.SERVER_PATH_PREFIX + com.keba.keplast.utils.SystemInfo.getInstance().getWorkPath(),
                  PathConfigUtils.getDefaultMachineDataPathRel(), ".xml",
                  checkBoxExportMachineData, null, numFieldMachineData, false),
            // mold data
            new ExportJob(FileUtils.SERVER_PATH_PREFIX + com.keba.keplast.utils.SystemInfo.getInstance().getWorkPath(),
                  PathConfigUtils.getDefaultMoldDataPathRel(), ".xml",
                  checkBoxExportMoldData, null, numFieldMoldData, false),
            // crash reports
            new ExportJob(FileUtils.SERVER_PATH_PREFIX + com.keba.keplast.utils.SystemInfo.getInstance().getRootPath(),
                  PathConfigUtils.getDefaultCrashReportPathRel(), ".preport",
                  checkBoxExportCrashReports, checkBoxDeleteCrashReports, numFieldCrashReports, false)
      };

      initComponents();

   }

   /**
    * Refreshes the number of files in the num fields for each job
    */
   private void updateNumberOfFiles() {
      for (int i = 0; i < exportJobs.length; i++) {
         exportJobs[i].updateNumberOfFiles();
      }
   }

   /**
    * Performs the export or delete operation on the selected jobs
    * 
    * @param delete
    *           true, if the files should be deleted. false if the files should be copied to the USB
    */
   private void doAction(final boolean delete) {

      worker = new Worker() {

         private KvProgressMonitor mon;
         private KPResourceBundle textBundle = KPResourceBundle.getBundle("system.hmi.text.exportTexts");

         public Object construct() {

            String title = textBundle.getString(delete ? "DeleteInProgress" : "ExportInProgress");
            mon = new KvProgressMonitor(title);
            mon.hideCancelButton();
            mon.setModal(true);
            mon.setProgress(1);
            boolean success = true;
            try {
               String usbPath = comboBoxUsb.getSelectedUsbPath();

               for (int i = 0; i < exportJobs.length; i++) {
                  ExportJob job = exportJobs[i];
                  if (delete) {
                     success &= job.delete();
                  } else {
                     success &= job.export(usbPath);
                  }
               }

            } catch (Exception ex) {
               CAT.warn(null, ex);
               return new Boolean(false);
            }
            return new Boolean(success);
         }

         public void finished() {

            unselectAll();
            updateNumberOfFiles();
            if (Boolean.TRUE.equals(getValue())) {
               KvMessageDialog.showInfoMessage(textBundle.getString(delete ? "DeleteSuccess" : "ExportSuccess"),
                     textBundle.getString("ExportSuccessTitle"), true, null);
            } else {
               KvMessageDialog.showErrorMessage(textBundle.getString(delete ? "DeleteFailed" : "ExportFailed"),
                     textBundle.getString("ExportFailedTitle"), true, null);
            }

            mon.close();
         }
      };
      worker.start();

   }

   private boolean anyDeleteSelected() {
      boolean selected = false;
      for (int i = 0; i < exportJobs.length; i++) {
         selected = selected || exportJobs[i].isDeleteSelected();
      }
      return selected;
   }

   private boolean anyExportSelected() {
      boolean selected = false;
      for (int i = 0; i < exportJobs.length; i++) {
         selected = selected || exportJobs[i].isExportSelected();
      }
      return selected;
   }

   private void unselectAll() {
      for (int i = 0; i < exportJobs.length; i++) {
         exportJobs[i].unselectAll();
      }
   }

   private void initComponents() {

      if (!SystemInfo.getInstance().getOSName().toLowerCase(Locale.ENGLISH).equals("linux")) {
         panelCopyCrashRep.setVisible(false);
         panelDeleteCrashRep.setVisible(false);
      }

      // create USB selector programmatically
      comboBoxUsb = new KUsbSelectList();
      comboBoxUsb.setInputLevel(3);
      comboBoxUsb.setPreferredSize(new Dimension(140, 28));
      panelExportEast.add(comboBoxUsb, BorderLayout.CENTER);

      comboBoxUsb.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            comboBoxUsbClicked();
         }
      });

      btnExportUSB.setEnabled(false);
      btnExportUSB.removeActionListener(this);
      btnExportUSB.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {

            if (!anyExportSelected()) {
               KvMessageDialog.showInfoMessage(textBundle.getString("SelectExport"),
                     "", true, null);
               return;
            }

            String usbPath = comboBoxUsb.getSelectedUsbPath();
            if (!existsUsbPath(usbPath)) {
               comboBoxUsb.setSelectedIndex(-1);
               KvMessageDialog.showErrorMessage(textBundle.getString("UsbNotFound"),
                     "", true, null);

               return;
            }
            doAction(false);
         }
      });

      btnDeleteFromFlash.removeActionListener(this);
      btnDeleteFromFlash.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            if (!anyDeleteSelected()) {
               KvMessageDialog.showInfoMessage(textBundle.getString("SelectDelete"),
                     "", true, null);
               return;

            }

            KvMessageDialog.showQuestionMessage(textBundle.getString("DeleteQuestion"), "",
                  false, new KvDialogInfoInterface() {
                     public boolean getPressedOption(int option) {
                        if (option == KvDialogInfoInterface.OK) {
                           try {
                              doAction(true);
                           } catch (Exception e) {
                              CAT.error("could not delete files", e);
                           }
                        }
                        return true;
                     }
                  });

         }
      });
   }

   /**
    * Checks if the given USB path exists.
    * 
    * @param usbPath
    *           the path to the USB drive
    * @return true, if usbPath exists
    */
   private boolean existsUsbPath(String usbPath) {
      boolean exists = true;
      try {
         exists = usbPath != null;
         if (exists) {
            exists = FileUtils.dirExists(usbPath);
         }
      } catch (Exception ex) {
         exists = false;
         CAT.error("Could not check USB path " + usbPath, ex);
         ex.printStackTrace();
      }
      return exists;
   }

   private void comboBoxUsbClicked() {
      int selectedIndex;
      boolean enabled;
      selectedIndex = comboBoxUsb.getSelectedIndex();
      enabled = true;
      if (selectedIndex == -1) {
         enabled = false;
      }
      btnExportUSB.setEnabled(enabled);
   }

   /**
    * Called on showing of the mask
    */
   public void onShow() {
      super.onShow();
      updateNumberOfFiles();
   }

   /**
    * Called on hiding of the mask
    */
   public void onHide() {
      super.onHide();
      unselectAll();
   }

}
