package system.hmi;

import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import com.keba.kemro.kvs.keplast.widgets.simple.KPlausNumField;
import com.keba.kemro.kvs.widgets.KvsTextField;
import com.keba.kemro.kvs.widgets.KvsTextSelectList;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KBoolean;
import com.keba.kemro.plc.variable.KNumber;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.PlastConstants;

import Dialogs.hmi.ProgressMonitorDialog;

public class DrvPIDSettingsMask extends DrvPIDSettingsMask_generated {
   private static final long serialVersionUID = 1L;

   private final String SV_SINGLE_PARAMETER_TRANSFER_DATATYPE_M = "ServoDrives1.sv_SingleParamTransferHMIMaster.Datatype";
   private final String SV_SINGLE_PARAMETER_TRANSFER_DATATYPE_S1 = "ServoDrives1.sv_SingleParamTransferHMISlave1.Datatype";
   private final String SV_SINGLE_PARAMETER_TRANSFER_DATATYPE_S2 = "ServoDrives1.sv_SingleParamTransferHMISlave2.Datatype";

   private final String SV_PROCESS_WORKING_M = "ServoDrives1.sv_bProcessWorkingMaster";
   private final String SV_PROCESS_PROGRESS_PERCENTAGE_M = "ServoDrives1.sv_iAnimatedBarPercentageMaster";
   private final String SV_PROCESS_WORKING_S1 = "ServoDrives1.sv_bProcessWorkingSlave1";
   private final String SV_PROCESS_PROGRESS_PERCENTAGE_S1 = "ServoDrives1.sv_iAnimatedBarPercentageSlave1";
   private final String SV_PROCESS_WORKING_S2 = "ServoDrives1.sv_bProcessWorkingSlave2";
   private final String SV_PROCESS_PROGRESS_PERCENTAGE_S2 = "ServoDrives1.sv_iAnimatedBarPercentageSlave2";
   private static final String sRESOURCE_BUNDLE_PROG_MON = "system.hmi.text.DrvPIDSettingsProgMon";
   private boolean[] initDone = { false, false, false };

   private final String DATATYPE_BOOL = "BOOL";
   private final String DATATYPE_USINT = "USINT";
   private final String DATATYPE_UINT = "UINT";
   private final String DATATYPE_UDINT = "UDINT";
   private final String DATATYPE_SINT = "SINT";
   private final String DATATYPE_INT = "INT";
   private final String DATATYPE_DINT = "DINT";
   private final String DATATYPE_LINT = "LINT";
   private final String DATATYPE_REAL = "REAL";
   private final String DATATYPE_STRING = "STRING";

   private ProgressMonitorDialog progressMonitor;
   private ResourceBundle textBundleProgMon = ResourceBundle.getBundle(sRESOURCE_BUNDLE_PROG_MON, locale);

   public DrvPIDSettingsMask() throws Exception {
      super();

      // Master
      KVariable variableM = hmiService.getVariable(SV_SINGLE_PARAMETER_TRANSFER_DATATYPE_M);
      HmiVariableService.registerVariable(variableM, null, new DataTypeChangedListener(f_BOOL_M, f_DINT_M, f_UDINT_M, f_REAL_M, f_LINT_M,
            f_STRING_M), KNumber.class);
      addProgressMonitorHandler("paramTransferDialogTitleM", SV_PROCESS_WORKING_M, SV_PROCESS_PROGRESS_PERCENTAGE_M, 0);

      // Slave1
      if (MachineEquipment.hasSpeedPumpAndOneSlave()) {
         KVariable variableS1 = hmiService.getVariable(SV_SINGLE_PARAMETER_TRANSFER_DATATYPE_S1);
         HmiVariableService.registerVariable(variableS1, null, new DataTypeChangedListener(f_BOOL_S1, f_DINT_S1, f_UDINT_S1, f_REAL_S1,
               f_LINT_S1, f_STRING_S1), KNumber.class);
         addProgressMonitorHandler("paramTransferDialogTitleS1", SV_PROCESS_WORKING_S1, SV_PROCESS_PROGRESS_PERCENTAGE_S1, 1);
      }

      // Slave2
      if (MachineEquipment.hasSpeedPumpAndTwoSlaves()) {
         KVariable variableS2 = hmiService.getVariable(SV_SINGLE_PARAMETER_TRANSFER_DATATYPE_S2);
         HmiVariableService.registerVariable(variableS2, null, new DataTypeChangedListener(f_BOOL_S2, f_DINT_S2, f_UDINT_S2, f_REAL_S2,
               f_LINT_S2, f_STRING_S2), KNumber.class);
         addProgressMonitorHandler("paramTransferDialogTitleS2", SV_PROCESS_WORKING_S2, SV_PROCESS_PROGRESS_PERCENTAGE_S2, 2);
      }

      // vpl3
      if (PlastConstants.isVPL3()) {
         this.setBackground(PlastConstants.COL_BG_PANEL);
      }
   }

   /**
    * Add functionality for showing parameter transfer progress in a modal dialog
    * 
    * @param txtKeyDialogTitle
    *           Text key for the title of the dialog
    * @param varProcessWorking
    *           Boolean variable for triggering open/close of dialog
    * @param varProgressPercentage
    *           Variable signalizing the actual progress in %
    * @param initDoneIdx
    *           Index for initDone flag
    * @throws Exception
    */
   private void addProgressMonitorHandler(final String txtKeyDialogTitle, final String varProcessWorking,
         final String varProgressPercentage, final int initDoneIdx)
         throws Exception {
      KVariable varProcWork = hmiService.getVariable(varProcessWorking);
      HmiVariableService.registerVariable(varProcWork, null, new ValueChangedListener() {
         public void valueChanged(ValueChangedEvent event) {
            // Prevent opening/closing dialog if value didn't change
            // or if it is called during registration of variable (initDone == false)
            if ((event.getReason() != ValueChangedEvent.VALUE_CHANGED) || !initDone[initDoneIdx]) {
               return;
            }

            try {
               boolean processWorking = event.getVariable().getBooleanValue();
               if (processWorking) {
                  if (progressMonitor != null) {
                     progressMonitor.close();
                  }

                  try {
                     progressMonitor = new ProgressMonitorDialog(textBundleProgMon
                           .getString(txtKeyDialogTitle), textBundleProgMon.getString("paramTransferDialogMessage"));
                     progressMonitor.showDialog();
                  } catch (MissingResourceException e) {
                     e.printStackTrace();
                  }

                  progressMonitor.setVariable(varProgressPercentage);
               } else {
                  if (progressMonitor != null) {
                     progressMonitor.close();
                  }
               }
            } catch (VartypeException e) {
               e.printStackTrace();
            }

         }
      }, KBoolean.class);

      initDone[initDoneIdx] = true;
   }

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);
      textBundleProgMon = ResourceBundle.getBundle(sRESOURCE_BUNDLE_PROG_MON, locale);
   }

   /**
    * The data type changed listener is responsible for showing only fields of the correct dataType.
    * Incompatible fields are hidden.
    * 
    * @author steg
    * 
    */
   private class DataTypeChangedListener implements ValueChangedListener {

      KvsTextSelectList f_BOOL;
      KPlausNumField f_DINT;
      KPlausNumField f_UDINT;
      KPlausNumField f_REAL;
      KPlausNumField f_LINT;
      KvsTextField f_STRING;

      DataTypeChangedListener(KvsTextSelectList f_BOOL, KPlausNumField f_DINT, KPlausNumField f_UDINT, KPlausNumField f_REAL,
            KPlausNumField f_LINT, KvsTextField f_STRING) {
         this.f_BOOL = f_BOOL;
         this.f_DINT = f_DINT;
         this.f_UDINT = f_UDINT;
         this.f_REAL = f_REAL;
         this.f_LINT = f_LINT;
         this.f_STRING = f_STRING;
      }

      public void valueChanged(ValueChangedEvent event) {
         String dataType = event.getVariable().getStringValue();

         this.f_BOOL.setVisible(false);
         this.f_DINT.setVisible(false);
         this.f_UDINT.setVisible(false);
         this.f_REAL.setVisible(false);
         this.f_LINT.setVisible(false);
         this.f_STRING.setVisible(false);

         invalidate();
         if (dataType.equals(DATATYPE_BOOL)) {
            this.f_BOOL.setVisible(true);
         }
         else if ((dataType.equals(DATATYPE_USINT)) || (dataType.equals(DATATYPE_UINT)) || (dataType.equals(DATATYPE_UDINT))) {
            this.f_UDINT.setVisible(true);
         }
         else if ((dataType.equals(DATATYPE_SINT)) || (dataType.equals(DATATYPE_INT)) || (dataType.equals(DATATYPE_DINT))) {
            this.f_DINT.setVisible(true);
         }
         else if (dataType.equals(DATATYPE_LINT)) {
            this.f_LINT.setVisible(true);
         }
         else if (dataType.equals(DATATYPE_REAL)) {
            this.f_REAL.setVisible(true);
         }
         else if (dataType.equals(DATATYPE_STRING)) {
            this.f_STRING.setVisible(true);
         }
      }
   }

}