/*-------------------------------------------------------------------------
 *                   (c) 2015 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project  : KePlast.HMI.KVS
 *    Author   : mhf
 *    Date     : 12.05.2015
 *--------------------------------------------------------------------------  *
 */

package system.hmi;

import java.io.IOException;
import java.util.ResourceBundle;

import com.ibm.log4j.Category;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.dialog.KvProgressMonitor;
import com.keba.kemro.kvs.keplast.general.util.KPResourceBundle;
import com.keba.kemro.kvs.keplast.recipe.manager.KePlastRecipeManager;
import com.keba.kemro.kvs.keplast.recipe.util.DataStateManager;
import com.keba.kemro.kvs.keplast.recipe.util.FileUtils;
import com.keba.kemro.plc.network.NetworkException;
import com.keba.kemro.plc.service.HmiSystemService;
import com.keba.keplast.utils.SystemInfo;
import com.keba.util.Worker;

/***
 * load initial system data (either mold/machine data) from file
 * 
 * @author mhf
 * 
 */
public class StartupAutoLoad {

   protected static Category CAT = Category.getInstance(StartupAutoLoad.class.getName());
   private KePlastRecipeManager recipeMgr;
   private String autoLoadPath;

   private final String RELPATH_MACHINEDATA = "machinedata/";
   private final String RELPATH_MOLDDATA = "molddata/";
   private final String AUTOLOAD_FILENAME = "autoLoad.xml";

   public StartupAutoLoad() {
      autoLoadPath = HmiSystemService.getService().getPersitencePath() + "autoload/";
      if (!SystemInfo.getInstance().isLocalStation()) {
         autoLoadPath = FileUtils.SERVER_PATH_PREFIX + autoLoadPath;
      }
   }

   public void autoLoad() {

      try {
         if (!FileUtils.dirExists(autoLoadPath)) {
            return;
         }
      } catch (NetworkException e) {
         CAT.error("Could not check if " + autoLoadPath + " exists", e);
      } catch (IOException e) {
         CAT.error("Could not check if " + autoLoadPath + " exists", e);
      }

      Worker w = new Worker() {

         private KvProgressMonitor mon;

         public Object construct() {
            recipeMgr = new KePlastRecipeManager("autoLoad", false);

            String title = "";
            try {
               ResourceBundle bundle = ResourceBundle.getBundle("system.hmi.text.startupautoload");
               title = bundle.getString("MsgAutoLoadData");
            } catch (Exception ex) {
               CAT.warn("text not found for autoload", ex);
               title = "Auto. loading system data";
            }
            mon = new KvProgressMonitor(title);
            mon.hideCancelButton();
            mon.setModal(true);
            mon.setProgress(1);
            DataStateManager dsm = null;
            try {
               dsm = new DataStateManager();
               // Machinedata auto load
               String tmpPath = autoLoadPath + RELPATH_MACHINEDATA;
               if (FileUtils.fileExists(tmpPath, AUTOLOAD_FILENAME)) {
                  dsm.writeState(DataStateManager.DS_MACHINEDATA_READ);
                  recipeMgr.setLoadPath(tmpPath, false);
                  recipeMgr.load(AUTOLOAD_FILENAME);
                  dsm.writeState(DataStateManager.DS_READY);
               }

               // Molddata auto load
               tmpPath = autoLoadPath + RELPATH_MOLDDATA;
               if (FileUtils.fileExists(tmpPath, AUTOLOAD_FILENAME)) {
                  dsm.writeState(DataStateManager.DS_MOLDDATA_READ);
                  recipeMgr.setLoadPath(tmpPath, false);
                  recipeMgr.load(AUTOLOAD_FILENAME);
                  dsm.writeState(DataStateManager.DS_READY);
               }

            } catch (Exception ex) {
               CAT.warn(null, ex);
               return new Boolean(false);
            } finally {
               if (dsm != null)
                  dsm.writeState(DataStateManager.DS_READY);
            }
            return new Boolean(true);
         }

         public void finished() {
            if (Boolean.TRUE.equals(getValue())) {
               deleteFiles();
               mon.close();
            } else {
               mon.close();
               KPResourceBundle textBundle = KPResourceBundle.getBundle("com.keba.kemro.kvs.keplast.recipe.text.RecipeMask_texts");
               KvMessageDialog.showErrorMessage(textBundle.getString("load_nok"), textBundle.getString("this.setTitle"), true, null);
            }
         }
      };
      w.start();
   }

   protected void deleteFiles() {
      if (autoLoadPath.endsWith("/")) {
         autoLoadPath = autoLoadPath.substring(0, autoLoadPath.length() - 1);
      }
      String renamedPath = autoLoadPath + "_used";

      try {
         FileUtils.deleteDir(renamedPath);
         FileUtils.renameDir(autoLoadPath, renamedPath);
      } catch (Exception e) {
         CAT.error("Could not rename " + autoLoadPath + " to " + renamedPath);
      }
   }
}
