/* --------------------------------------------------------------------------------
 *                               (c) 2017 by KEBA AG
 *                                   Linz/AUSTRIA
 *                               All rights reserved
 * --------------------------------------------------------------------------------
 *    Project  : KePlast HMI
 *    Author   : azb
 *    Date     : 26 Sep 2017
 * --------------------------------------------------------------------------------
 */
package system.hmi;

import java.io.File;

import com.ibm.log4j.Category;
import com.keba.kemro.kv.dialog.KvProgressMonitor;
import com.keba.kemro.kvs.keplast.general.util.KPResourceBundle;
import com.keba.kemro.kvs.keplast.recipe.manager.KePlastRecipeManager;
import com.keba.kemro.kvs.keplast.recipe.util.DataStateManager;
import com.keba.kemro.kvs.util.KvsConfig;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.IOperationModes;
import com.keba.keplast.general.OperationModeAdmin;
import com.keba.keplast.general.util.OperationModeChangedEvent;
import com.keba.keplast.general.util.OperationModeChangedListener;
import com.keba.keplast.utils.UncheckedException;
import com.keba.util.LanguageManager;
import com.keba.util.Worker;

/**
 * This class listen to molddata load and save commands on a systemvariable of type tsHostDataSetHmi
 * and performs the requested load or save action.
 */
public class MoldDataSetCommand {

   protected static Category CAT = Category.getInstance(MoldDataSetCommand.class.getName());

   private String commandVariableName;
   private KVariable kVarTrigger;
   private KVariable kVarCommand;
   private KVariable kVarFileName;
   private KVariable kVarError;
   private KVariable kVarMoldDataName;
   protected int iOperationMode;

   private final static int ERR_INVALID_CMD = 2;
   private static final int ERR_NOTALLOWED = 3;
   private static final int ERR_FILENOTEXISTS = 4;
   private static final int ERR_UNKNOWN = 0xff;

   /**
    * worker class for loading and saving mold data in a worker thread
    */
   private class MoldDataWorker extends Worker {

      private KvProgressMonitor mon;
      private File dataFile;
      private int action;
      private String msgTitle = null;
      private String msgText = null;

      public MoldDataWorker(File dataFile, int action) {
         this.dataFile = dataFile;
         this.action = action;
         if ((action != DataStateManager.DS_MOLDDATA_READ) && (action != DataStateManager.DS_MOLDDATA_WRITE))
            throw new IllegalArgumentException("illegal argument action=" + action);
      }

      public void setMessageData(String title, String text) {
         this.msgTitle = title;
         this.msgText = text;
      }

      public Object construct() {
         KePlastRecipeManager recipeMgr;
         int ret = 0;
         DataStateManager dsm = null;
         try {
            dsm = new DataStateManager();

            if (msgTitle != null) {
               mon = new KvProgressMonitor(msgTitle, msgText);
               mon.hideCancelButton();
               mon.setModal(true);
               mon.setProgress(1);
            }
            recipeMgr = new KePlastRecipeManager("IEC_" + commandVariableName, false);

            recipeMgr.setRecipeVargroup("VG_MoldData");

            dsm.writeState(action);

            if (action == DataStateManager.DS_MOLDDATA_READ) {
               recipeMgr.setLoadPath(dataFile.getParent(), false);
               String fileName = dataFile.getName();
               recipeMgr.load(fileName);
               if (fileName.endsWith(".xml"))
                  fileName = fileName.substring(0, fileName.length() - 4);
               writeVariableValue(kVarMoldDataName, fileName);
            } else if (action == DataStateManager.DS_MOLDDATA_WRITE) {
               recipeMgr.setSavePath(dataFile.getParent());
               recipeMgr.setRecipeName(dataFile.getName(), false);
               recipeMgr.save();
            }

         } catch (IllegalStateException ex) {
            ret = ERR_NOTALLOWED;
         } catch (Exception ex) {
            CAT.error("exception when loading", ex);
            ret = ERR_UNKNOWN;
         } finally {
            if (dsm != null)
               dsm.writeState(DataStateManager.DS_READY);
            cmdDone(ret);
         }
         return null;
      }

      public void finished() {
         if (mon != null)
            mon.close();
      }
   }

   public MoldDataSetCommand(String commandVariableName) {
      try {
         this.commandVariableName = commandVariableName;
         initOpModeListener();
         initVariables();
         writeAvailableFlag();
      } catch (Exception ex) {
         String msg = "Exception in constructor of MoldDataSetCommand(" + commandVariableName + ")";
         CAT.error(msg, ex);
         throw new UncheckedException(msg, ex);
      }
   }

   private void initOpModeListener() {
      OperationModeAdmin.getInstance().addListener(new OperationModeChangedListener() {
         public void operationModeChanged(OperationModeChangedEvent e) {
            iOperationMode = e.getMode();
         }
      });
   }

   private void writeAvailableFlag() {
      KVariable kVar = getCommandVariable("bAvailable");
      writeVariableValue(kVar, new Boolean(true));
   }

   private void writeVariableValue(KVariable kVar, Object value) {
      try {
         HmiVariableService.getService().writeValue(kVar, value, false);
      } catch (Exception e) {
         throw new UncheckedException("cannot write variable " + kVar.getName(), e);
      }
   }

   private KVariable getCommandVariable(String name) {
      return getVariable(commandVariableName + "." + name);
   }

   private KVariable getVariable(String name) {
      try {
         return HmiVariableService.getService().getVariable(name);
      } catch (Exception e) {
         throw new UncheckedException("cannot get variable " + name, e);
      }
   }

   private void initVariables() {
      kVarMoldDataName = getVariable(KvsConfig.getStringProperty("MoldDataName", "system.sv_sMoldData"));
      kVarTrigger = getCommandVariable("iTrigger");
      kVarCommand = getCommandVariable("iCommand");
      kVarFileName = getCommandVariable("sFile");
      kVarError = getCommandVariable("iError");

      readIntVar(kVarTrigger);
      readIntVar(kVarCommand);
      readStringVar(kVarFileName);
      readIntVar(kVarError);

      kVarTrigger.addListener(new ValueChangedListener() {
         public void valueChanged(ValueChangedEvent ev) {
            if (ev.getReason() != ValueChangedEvent.VALUE_CHANGED)
               return;
            triggerChanged();
         }
      });
      try {
         HmiVariableService.getService().startRefresh(new KVariable[] { kVarTrigger });
      } catch (Exception e) {
         throw new UncheckedException("", e);
      }
   }

   private String readStringVar(KVariable var) {
      try {
         HmiVariableService.getService().readValue(var);
         return var.getStringValue();
      } catch (Exception ex) {
         throw new UncheckedException("cannot read string variable " + var.getName(), ex);
      }
   }

   private int readIntVar(KVariable var) {
      try {
         HmiVariableService.getService().readValue(var);
         return var.getIntValue();
      } catch (Exception ex) {
         throw new UncheckedException("cannot read int variable " + var.getName(), ex);
      }
   }

   protected void triggerChanged() {
      int ret = 0;
      try {
         int trigger = kVarTrigger.getIntValue();
         if (trigger % 2 == 0)
            return;
         int cmd = readIntVar(kVarCommand);

         switch (cmd) {
         case 0: // load mold
            ret = load();
            break;
         case 2: // save mold
            save();
            break;
         default:
            ret = ERR_INVALID_CMD;
         }
      } catch (Exception e) {
         ret = ERR_UNKNOWN;
         CAT.error("error MoldDataSetCommand action", e);
      } finally {
         if (ret > 0)
            cmdDone(ret);
      }

   }

   private void cmdDone(int ret) {
      try {
         writeError(ret);
         int trigger = kVarTrigger.getIntValue();
         writeVariableValue(kVarTrigger, new Integer(trigger + 1));
      } catch (VartypeException e) {
         throw new UncheckedException("", e);
      }

   }

   private void writeError(int err) {
      writeVariableValue(kVarError, new Integer(err));
   }

   private int load() {
      File file = new File(readStringVar(kVarFileName));
      if (!file.exists()) {
         return ERR_FILENOTEXISTS;
      }
      if (iOperationMode >= IOperationModes.OP_MODE_HALF_AUTO) {
         return ERR_NOTALLOWED;
      }

      MoldDataWorker w = new MoldDataWorker(file, DataStateManager.DS_MOLDDATA_READ);

      KPResourceBundle bundle = KPResourceBundle.getBundle("com.keba.kemro.kvs.keplast.recipe.text.RecipeMask_texts",
            LanguageManager.sharedInstance().getLanguage().getLocale());

      w.setMessageData(bundle.getString("progMonAutoLoad.title"),
            bundle.getString("progMonAutoLoad.note", file.getName().substring(0, file.getName().length() - 4), null));
      w.start();

      return 0;
   }

   private void save() {
      File file = new File(readStringVar(kVarFileName));
      String dirName = file.getParent();
      if (dirName != null) // create directories
         new File(dirName).mkdirs();
      MoldDataWorker w = new MoldDataWorker(file, DataStateManager.DS_MOLDDATA_WRITE);

      KPResourceBundle bundle = KPResourceBundle.getBundle("com.keba.kemro.kvs.keplast.recipe.text.RecipeMask_texts",
            LanguageManager.sharedInstance().getLanguage().getLocale());

      w.setMessageData(bundle.getString("progMonAutoSave.title"),
            bundle.getString("progMonAutoSave.note", file.getName().substring(0, file.getName().length() - 4), null));
      w.start();
   }
}
