/*-------------------------------------------------------------------------
 *                   (c) 2015 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project  : KePlast.HMI.KVS
 *    Author   : azb
 *    Date     : 20.06.2015
 *--------------------------------------------------------------------------  *
 */

package system.hmi;

import java.io.File;
import java.util.ResourceBundle;

import com.ibm.log4j.Category;
import com.keba.kemro.kv.dialog.KvDialogInfoInterface;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.help.KvHelpViewer;
import com.keba.kemro.kv.help.KvHelpViewerListener;
import com.keba.keplast.utils.SystemInfo;

/***
 * if available a special startup information is displayed using the help viewer
 * 
 * @author azb
 * 
 */
public class StartupInfo {

   protected static Category CAT = Category.getInstance(StartupInfo.class.getName());
   private File startupInfoJar;

   public StartupInfo() {
      startupInfoJar = new File(SystemInfo.getInstance().getApplPath() + "workspace/startupinfo/startupinfo.jar");
   }

   public void showIfAvailable() {
      if (!startupInfoJar.exists())
         return;

      KvHelpViewer v = new KvHelpViewer(startupInfoJar.getAbsolutePath());
      v.setTOC(null);
      v.addKvHelpViewerListener(new KvHelpViewerListener() {
         public void helpViewerClosed() {
            try {
               onCloseHelp();
            } catch (Exception e) {
               CAT.error("", e);
            }
         }

         public void helpNotFound(String html) {
         }
      });

      v.showHelp("startupinfo.htm");
   }

   protected void onCloseHelp() {
      String text = getMessageText();
      KvMessageDialog.showQuestionMessage(text, "", false, new KvDialogInfoInterface() {
         public boolean getPressedOption(int option) {
            if (option == KvDialogInfoInterface.OK) {
               try {
                  deleteFiles();
               } catch (Exception e) {
                  CAT.error("could not delete files", e);
               }
            }
            return true;
         }
      });
   }

   private String getMessageText() {
      try {
         ResourceBundle bundle = ResourceBundle.getBundle("system.hmi.text.startupinfo");
         return bundle.getString("MsgDeleteStartupInfo");
      } catch (Exception e) {
         CAT.error("text not found", e);
         return "???";
      }
   }

   protected void deleteFiles() {
      File renameFile = new File(startupInfoJar.getAbsolutePath() + "_used");
      renameFile.delete();
      startupInfoJar.renameTo(renameFile);
   }

}
