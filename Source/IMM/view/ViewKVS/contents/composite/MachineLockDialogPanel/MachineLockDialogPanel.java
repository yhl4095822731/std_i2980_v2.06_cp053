package composite.MachineLockDialogPanel;

import java.util.Vector;

import com.keba.kemro.kv.dialog.KvDialog;
import com.keba.kemro.kv.dialog.KvDialogInfoInterface;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.utils.UncheckedException;
import com.keba.util.LanguageChangedEvent;
import com.keba.util.LanguageChangedListener;
import com.keba.util.LanguageManager;

public class MachineLockDialogPanel extends MachineLockDialogPanel_generated {
   private static final long serialVersionUID = 1L;
   private Vector mVariables;
   private KVariable mVarResult;
   private KVariable mVarOpenState;
   private KVariable mVarIsPreLockKey;
   private KVariable mVarNewPreLockState;

   protected KvDialogInfoInterface mDialogInfoInterface = null;
   private KvDialog mDialog;
   protected static MachineLockDialogPanel mPanel;

   protected MachineLockDialogPanel() throws Exception {
      super();
      init();
   }

   private void init() throws Exception {
      remove(lblCaption);

      LanguageManager.sharedInstance().addLanguageChangedListener(new LanguageChangedListener() {
         public void languageChanged(LanguageChangedEvent event) {
            changeLocale(event.getLocale());
         }
      });

      mDialogInfoInterface = new KvDialogInfoInterface() {
         public boolean getPressedOption(int option) {
            writeStatus(option == KvDialogInfoInterface.YES);
            mDialog = null;
            return true;
         }
      };

      mVarResult = HmiVariableService.getService().getVariable("system.sv_MachineLockDlg.bResult");
      mVarOpenState = HmiVariableService.getService().getVariable("system.sv_MachineLockDlg.bOpenState");
      mVarIsPreLockKey = HmiVariableService.getService().getVariable("system.sv_MachineLockDlg.bIsPreLockKey");
      mVarNewPreLockState = HmiVariableService.getService().getVariable("system.sv_MachineLockDlg.bNewPreLockState");

   }

   protected void writeStatus(boolean doUpdate) {
      try {
         HmiVariableService.getService().writeValue(mVarResult, new Boolean(doUpdate));
         HmiVariableService.getService().writeValue(mVarOpenState, new Boolean(false));
      } catch (Exception e) {

      }
   }

   private void readVariables() throws Exception {
      HmiVariableService.getService().readValues(mVariables);
   }

   private void setDialogElementVisibility() throws Exception {
      KVariable kVarLockActive = HmiVariableService.getService().getVariable(markLockActive.getVariable());
      KVariable kVarLockActiveNew = HmiVariableService.getService().getVariable(markLockActiveNew.getVariable());
      KVariable kVarExpireDateNew = fExpireDateNew.getKVariable();
      KVariable kVarMachineFileLockNrAct = fMachineFileLockNrAct.getKVariable();
      KVariable kVarMachineFileLockNrAll = fMachineFileLockNrAll.getKVariable();
      KVariable kVarMachineFileLockNrActNew = fMachineFileLockNrActNew.getKVariable();
      KVariable kVarMachineFileLockNrAllNew = fMachineFileLockNrAllNew.getKVariable();

      pExpireDate.setVisible(kVarLockActive.getBooleanValue());
      pExpireDateNew.setVisible(kVarLockActiveNew.getBooleanValue());
      pStateNew.setVisible(kVarExpireDateNew.getDateValue().getTime() > 0);

      lblLockFileCnt.setVisible(kVarMachineFileLockNrAct.getIntValue() > 0);
      fMachineFileLockNrAct.setVisible(kVarMachineFileLockNrAct.getIntValue() > 0);
      lbl.setVisible(kVarMachineFileLockNrAll.getIntValue() > 0);
      fMachineFileLockNrAll.setVisible(kVarMachineFileLockNrAll.getIntValue() > 0);
      pLockFileCnt.setVisible(kVarMachineFileLockNrAct.getIntValue() > 0);

      lblLockFileCntNew.setVisible(kVarMachineFileLockNrActNew.getIntValue() > 0);
      fMachineFileLockNrActNew.setVisible(kVarMachineFileLockNrActNew.getIntValue() > 0);
      lblNew.setVisible(kVarMachineFileLockNrAllNew.getIntValue() > 0);
      fMachineFileLockNrAllNew.setVisible(kVarMachineFileLockNrAllNew.getIntValue() > 0);
      pLockFileCntNew.setVisible(kVarMachineFileLockNrActNew.getIntValue() > 0);

      pPreLockKeyClear.setVisible(mVarIsPreLockKey.getBooleanValue() && (!mVarNewPreLockState.getBooleanValue()));
      pPreLockKeySet.setVisible(mVarIsPreLockKey.getBooleanValue() && (mVarNewPreLockState.getBooleanValue()));

   }

   private void setVariables(Vector v) {
      mVariables = v;
      // add variables which are not registered on mask
      mVariables.addElement(mVarIsPreLockKey);
      mVariables.addElement(mVarNewPreLockState);
   }

   public void show() {
      if (mDialog != null)
         return;

      try {
         readVariables();
         setDialogElementVisibility();
         mDialog = new KvDialog(KvDialog.YES_NO, lblCaption.getText(), false);
         mDialog.setDialogInfoInterface(mDialogInfoInterface);
         mDialog.getContent().add(this);
         mDialog.pack();
         mDialog.showDialog();
      } catch (Exception e) {
         throw new UncheckedException("", e);
      }
   }

   public void close() {
      if (mDialog == null)
         return;
      mDialog.close();
      mDialog = null;
   };

   public static void register() {

      try {
         KVariable v = HmiVariableService.registerVariable("system.sv_MachineLockDlg.bOpenState", new ValueChangedListener() {

            public void valueChanged(ValueChangedEvent event) {
               try {
                  if (event.getReason() != ValueChangedEvent.VALUE_CHANGED)
                     return;
                  boolean val = event.getVariable().getBooleanValue();

                  if (mPanel == null)
                     mPanel = MachineLockDialogPanel.create();

                  if (val)

                     mPanel.show();
                  else
                     mPanel.close();
               } catch (VartypeException e) {
                  throw new UncheckedException("", e);
               }

            }
         });
         HmiVariableService.getService().startRefresh(new KVariable[] { v });

      } catch (Exception e) {
         throw new UncheckedException("", e);
      }
   }

   private static MachineLockDialogPanel create() {
      try {
         Vector v = KVariable.popVariablesInMaskTable();

         if (v != null)
            throw new IllegalStateException("not allowed during mask construction");

         KVariable.pushVariablesInMaskTable();
         MachineLockDialogPanel p = new MachineLockDialogPanel();

         v = KVariable.popVariablesInMaskTable();

         p.setVariables(v);
         return p;
      } catch (Exception e) {
         throw new UncheckedException("", e);
      }
   }
}
