/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_redesign
 *    Datum     : 14.04.2009
 *    Archive   : system.hmi
 *------------------------------------------------------------------------*/

package system.hmi;

import java.util.Vector;

import com.keba.kemro.kv.control.KvFrame;
import com.keba.kemro.kv.control.KvMask;
import com.keba.kemro.kv.widgets.KvButton;
import com.keba.kemro.kvs.keplast.cycletime.CycleTimeMask;
import com.keba.kemro.kvs.keplast.drive.DriveParamMask;
import com.keba.kemro.kvs.keplast.general.BaseMachineEquipment;
import com.keba.kemro.kvs.keplast.tig.TIG;
import com.keba.kemro.kvs.util.KvsConfig;
import com.keba.kemro.kvs.widgets.KvsMaskChangeButton;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KBoolean;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.PlastConstants;
import com.keba.keplast.odc.EditorButtonEditMode;
import com.keba.keplast.odc.EditorButtonMonitorMode;
import com.keba.keplast.odc.IODCEditorImages;
import com.keba.keplast.odc.ODCFlowEditorMaskProvider;
import com.keba.keplast.odc.safetyeditor.ISafetyEditorMask;
import com.keba.keplast.odc.safetyeditor.SEButton;
import com.keba.keplast.odc.safetyeditor.SafetyEditorMask;
import com.keba.keplast.widgets.menu.MainMenuBar;

import Drive.hmi.DriveParamOperation;

/**
 */
public class MainMenuCustomizer {

   public static final int ID_OVERVIEW = 0;
   public static final int ID_MOLD = 1;
   public static final int ID_EJECTOR = 2;
   public static final int ID_CORE = 3;
   public static final int ID_INJECT = 4;
   public static final int ID_PLAST = 5;
   public static final int ID_NOZZLE = 6;
   public static final int ID_HEATING = 7;
   public static final int ID_OPERATION = 8;
   public static final int ID_ALARM = 9;

   public static final String sPOPUP_SETUP = "system.hmi.PopupMaskSetup";
   public static final String sPOPUP_SERVICE = "system.hmi.PopupMaskService";
   public static final String sPOPUP_ROBOT = "system.hmi.PopupMaskRobot";

   static String sOverviewMask;
   private static String sMoldMask;
   private static String sEjectorMask;
   private static String sCoreMask;
   private static String sInjectMask;
   private static String sPlastMask;
   private static String sNozzleMask;
   private static String sHeatingMask;
   private static String sOperationMask;
   private static String sAlarmMask;

   /**
    * Customize the main menu buttons.
    * 
    * @param mainMenu
    */
   protected static void customizeMainButtons(MainMenuBar mainMenu) {

      // Ejector
      if (BaseMachineEquipment.doesVariableExist("Ejector1.ai_Position") || BaseMachineEquipment.isDeviceElectric("Ejector1")) {
         // profile ejector mask
         mainMenu.setMainButtonMask(ID_EJECTOR, sEjectorMask);
      } else {
         mainMenu.setMainButtonMask(ID_EJECTOR, "Ejector1.hmi.EjectorMaskLimitSwitch1");
      }
      customizeCoreMasks(mainMenu, ID_CORE);

      if (BaseMachineEquipment.doesDeviceExist("Euromap")) {
         KvsConfig.writeProperty("AlarmTab7", "7");
         mainMenu.setMainButtonMask(ID_ALARM, sAlarmMask);
         KvsConfig.removeProperty("AlarmTab7");
      }
   }

   /**
    * Customize the sub menu buttons.
    * 
    * @param mainMenu
    */
   protected static void customizeSubMenuButtons(MainMenuBar mainMenu) {

      if (BaseMachineEquipment.hasMachineSequenzer()) {
         mainMenu.addSubMask(ID_OVERVIEW, "com.keba.keplast.odc.EditorMask");
         mainMenu.addEmptyContext("com.keba.keplast.odc.EditorMask");

         mainMenu.addSubMask(ID_OVERVIEW, "com.keba.keplast.odc.FlowEditorMask");

         KvButton button = new EditorButtonMonitorMode(ODCFlowEditorMaskProvider.getInstance());
         button.setIconName(IODCEditorImages.FLOW_MONITOR_ICON);
         mainMenu.addContextButton("com.keba.keplast.odc.FlowEditorMask", button);

         button = new EditorButtonEditMode(ODCFlowEditorMaskProvider.getInstance());
         button.setIconName(IODCEditorImages.FLOW_EDITOR_ICON);
         mainMenu.addContextButton("com.keba.keplast.odc.FlowEditorMask", button);

         if (SafetyEditorMask.isAvailable()) {
            mainMenu.addContextButton("com.keba.keplast.odc.EditorMask", new SEButton(ISafetyEditorMask.MODE_MONITOR));
            mainMenu.addContextButton("com.keba.keplast.odc.EditorMask", new SEButton(ISafetyEditorMask.MODE_EDIT));
         }
      }
      mainMenu.addSubMask(ID_OVERVIEW, sPOPUP_SETUP);
      mainMenu.addSubMask(ID_OVERVIEW, sPOPUP_SERVICE);
   }

   /**
    * Customize the context menu buttons.
    * 
    * @param mainMenu
    */
   protected static void customizeContextButtons(final MainMenuBar mainMenu) {

      // main masks
      mainMenu.addContextMask(sOverviewMask, "com.keba.kemro.kvs.keplast.recipe.RecipeMask");
      mainMenu.addContextMask(sOverviewMask, "com.keba.kemro.kvs.keplast.spc.SpcMask");
      mainMenu.addContextMask(sOverviewMask, "com.keba.kemro.kvs.notepad.NotepadMask");

      mainMenu.addContextMask(sMoldMask, "Mold1.hmi.MoldParameterMask1");

      if (BaseMachineEquipment.doesVariableExist("Mold1.ao_Valve")) {
         mainMenu.addSubMask("Mold1.hmi.MoldParameterMask1", "Mold1.hmi.MoldControlMask1");
      }

      if (MachineEquipment.hasOption("Mold1", MachineEquipment.SUB_OPTION_MOLD_TWO_PLATEN)) {
         mainMenu.addContextMask(sMoldMask, "Mold1.hmi.MoldTwoPlatenParamMask1");
         mainMenu.addContextMask(sMoldMask, "Mold1.hmi.MoldTwoPlatenOverviewMask1");
      }

      if (MachineEquipment.hasOption("Mold1", MachineEquipment.SUB_OPTION_MOLD_TWO_PLATEN)) {
         mainMenu.addContextMask(sMoldMask, "MoldHeightAdjust1.hmi.MoldAdjustMask2Platen1");
      } else if (MachineEquipment.hasOption("Mold1", MachineEquipment.SUB_OPTION_MOLD_DIRECTLOCK)) {
         mainMenu.addContextMask(sMoldMask, "MoldHeightAdjust1.hmi.MoldAdjustMaskDirectLock1");
      } else {
         mainMenu.addContextMask(sMoldMask, "MoldHeightAdjust1.hmi.MoldAdjustMask1");
      }

      if (MachineEquipment.isDeviceElectric("Mold1")) {
         mainMenu.addContextMask(sMoldMask, "Mold1.hmi.MoldDriveMask1");
      }

      if (BaseMachineEquipment.doesDeviceExist("SafetyGateAuto1")) {
         mainMenu.addContextMask(sMoldMask, "SafetyGateAuto1.hmi.SafetyGateAutoMask1");
      }

      if (BaseMachineEquipment.doesDeviceExist("RotaryTable1")) {
         mainMenu.addContextMask(sMoldMask, "RotarySlideTable.hmi.RotarySlideTableMask");
      }
      if (BaseMachineEquipment.doesDeviceExist("SlideTable1")) {
         mainMenu.addContextMask(sMoldMask, "SlideTable.hmi.SlideTableMask");
      }

      if (BaseMachineEquipment.doesVariableExist("Mold1.sv_ICMMode")) {
         mainMenu.addContextMask(sMoldMask, "Mold1.hmi.ICMMask");
      }

      if (BaseMachineEquipment.doesVariableExist("Ejector1.ai_Position") || BaseMachineEquipment.isDeviceElectric("Ejector1")) {
         mainMenu.addContextMask(sEjectorMask, "Ejector1.hmi.EjectorParameterMask1");
         mainMenu.addContextMask(sEjectorMask, "AirValve1.hmi.AirValveMask");
         if (MachineEquipment.isDeviceElectric("Ejector1")) {
            mainMenu.addContextMask(sEjectorMask, "Ejector1.hmi.EjectorDriveMask1");
         }
      } else {
         mainMenu.addContextMask("Ejector1.hmi.EjectorMaskLimitSwitch1", "Ejector1.hmi.EjectorParameterMask1");
         mainMenu.addContextMask("Ejector1.hmi.EjectorMaskLimitSwitch1", "AirValve1.hmi.AirValveMask");
      }

      mainMenu.addContextMask(sInjectMask, "Injection1.hmi.InjectParameterMask1");
      mainMenu.addContextMask(sInjectMask, "Injection1.hmi.InjectHoldMask1");
      mainMenu.addContextMask(sInjectMask, "com.keba.kemro.kvs.inject.InjectionMask", PlastConstants.LEVEL_QUALITY,
            PlastConstants.LEVEL_QUALITY);

      if (MachineEquipment.isDeviceElectric("Injection1")) {
         mainMenu.addContextMask(sInjectMask, "Injection1.hmi.InjectDriveMask1");
      }
      if (MachineEquipment.doesDeviceExist("ValveGate1")) {
         mainMenu.addContextMask(sInjectMask, "ValveGate1.hmi.ValveGateMask1");
      }

      mainMenu.addContextMask(sPlastMask, "Injection1.hmi.PlasticizeParameterMask1");

      if (MachineEquipment.isDeviceElectric("Injection1")) {
         mainMenu.addContextMask(sPlastMask, "Injection1.hmi.PlasticizeDriveMask1");
      }

      // Nozzle
      if (MachineEquipment.isDeviceElectric("Nozzle1")) {
         mainMenu.setMainButtonMask(ID_NOZZLE, sNozzleMask);
         mainMenu.addContextMask(sNozzleMask, "Nozzle1.hmi.NozzleParameterMask1");
         mainMenu.addContextMask(sNozzleMask, "Nozzle1.hmi.AutoPurgeMask1");
         mainMenu.addContextMask(sNozzleMask, "Nozzle1.hmi.NozzleDriveMask1");

         if (MachineEquipment.doesDeviceExist("ShutOffNozzle1")) {
            mainMenu.addContextMask(sNozzleMask, "ShutOffNozzle1.hmi.ShutOffNozzleMask1");
         }
      } else if (MachineEquipment.hasOption("Nozzle1", MachineEquipment.MAIN_OPTION_NOZZLE_ASM)) {
         mainMenu.setMainButtonMask(ID_NOZZLE, "Nozzle1.hmi.NozzleMaskASM1");
         mainMenu.addContextMask("Nozzle1.hmi.NozzleMaskASM1", "Nozzle1.hmi.AutoPurgeMask1");
         if (MachineEquipment.doesDeviceExist("ShutOffNozzle1")) {
            mainMenu.addContextMask("Nozzle1.hmi.NozzleMaskASM1", "ShutOffNozzle1.hmi.ShutOffNozzleMask1");
         }
      }

      mainMenu.addContextMask(sHeatingMask, "HeatingNozzle1.hmi.HeatingNozzleParameterMask1");

      // check for hopper option
      if (MachineEquipment.doesVariableExist("HeatingNozzle1.do_HopperCooler")) {
         mainMenu.addContextMask(sHeatingMask, "HeatingNozzle1.hmi.HeatingNozzleParameterMask2");
      }
      if (MachineEquipment.doesDeviceExist("HeatingMold1")) {
         mainMenu.addContextMask(sHeatingMask, "com.keba.keplast.heating.mold.HeatingMoldParameterMask1");
         mainMenu.addContextMask(sHeatingMask, "HeatingMold1.hmi.HeatingMoldGeneralSettingsMask1");
         mainMenu.addContextMask(sHeatingMask, "HeatingMold1.hmi.HeatingMoldModeSettingsMask1");
      }

      mainMenu.addContextMask(sPOPUP_SETUP, "system.hmi.MachineParameterMask");
      mainMenu.addContextMask(sPOPUP_SETUP, "system.hmi.ProfileSettingsMask");
      mainMenu.addContextMask(sPOPUP_SETUP, "com.keba.kemro.kvs.keplast.calibration.AutoCalibMask");
      mainMenu.addContextMask(sPOPUP_SETUP, "com.keba.kemro.kvs.keplast.mask.SetupMaskVersionInfo");

      mainMenu.addContextMask(sPOPUP_SERVICE, "com.keba.kemro.kvs.diag.iomon.IOMon", 0, PlastConstants.LEVEL_STARTUP);
      mainMenu.addContextMask(sPOPUP_SERVICE, "com.keba.kemro.kvs.swoszi.SwOsziMask", PlastConstants.LEVEL_SERVICE,
            PlastConstants.LEVEL_SERVICE);

      // OverviewMask for ServiceNet
      mainMenu.addContextMask(sPOPUP_SERVICE, "ServiceNet.hmi.ServiceNetOverviewMask");
      // SimpleScope mask
      mainMenu.addContextMask(sPOPUP_SERVICE, "system.hmi.Scope");

      // Context masks for ServiceNet
      mainMenu.addContextMask("ServiceNet.hmi.ServiceNetOverviewMask", "com.keba.kemro.kvs.diag.iomon.IOMon");
      mainMenu.addContextMask("ServiceNet.hmi.ServiceNetOverviewMask", "com.keba.kemro.kvs.swoszi.SwOsziMask");
      mainMenu.addContextMask("ServiceNet.hmi.ServiceNetOverviewMask", "ServiceNet.hmi.ServiceNetOverviewMask");

      mainMenu.addSubMask("com.keba.kemro.kvs.diag.iomon.IOMon", "com.keba.kemro.kvs.diag.varmon.VarMon", PlastConstants.LEVEL_STARTUP,
            PlastConstants.LEVEL_STARTUP);
      mainMenu.addSubMask("com.keba.kemro.kvs.diag.iomon.IOMon", "com.keba.kemro.kvs.infolog.InfologMask");
      mainMenu.addSubMask("com.keba.kemro.kvs.diag.iomon.IOMon", "com.keba.keplast.io.iochange.IOChangeMask", PlastConstants.LEVEL_SERVICE,
            PlastConstants.LEVEL_SERVICE);

      if (BaseMachineEquipment.hasServoDrives() && !BaseMachineEquipment.hasSpeedPump()) {
         final String driveParamMaskName = "com.keba.kemro.kvs.keplast.drive.DriveParamMask";
         mainMenu.addSubMask("com.keba.kemro.kvs.diag.iomon.IOMon", driveParamMaskName);

         // Set custom drive parameter operations ("Drive -> PLC", "PLC -> Drive" and "Save/Reset")
         // for drive parameter mask
         DriveParamMask driveParamMask = (DriveParamMask) KvFrame.getInstance().getMaskInstance(driveParamMaskName);
         driveParamMask.setDriveParamOperation(new DriveParamOperation());
      }

      mainMenu.addSubMask("system.hmi.MachineParameterMask", "system.hmi.MachineEquipmentMask");

      mainMenu.addSubMask("system.hmi.ProfileSettingsMask", "system.hmi.CoreSettingsMask");
      mainMenu.addSubMask("system.hmi.ProfileSettingsMask", "system.hmi.PIDSettingsMask");
      mainMenu.addSubMask("system.hmi.ProfileSettingsMask", "system.hmi.TimeSettingsMask");

      /*
       * Position control settings mask visible for any of following options Mold - has a
       * proportional valve or - has a servo valve or - is electric Inject - has a servo valve - is
       * electric Ejector - is electric Nozzle - is electric
       */
      if (MachineEquipment.doesVariableExist("Mold1.ao_Valve") || MachineEquipment.isDeviceElectric("Mold1")
            || MachineEquipment.doesDeviceExist("ValveServoInj1") || MachineEquipment.isDeviceElectric("Inject1")
            || MachineEquipment.isDeviceElectric("Ejector1") || MachineEquipment.isDeviceElectric("Nozzle1")) {
         mainMenu.addSubMask("system.hmi.ProfileSettingsMask", "system.hmi.PositionControlSettingsMask");
      }

      if (!(MachineEquipment.hasOption("Mold1", MachineEquipment.SUB_OPTION_MOLD_DIRECTLOCK)
            || MachineEquipment.hasOption("Mold1", MachineEquipment.SUB_OPTION_MOLD_TWO_PLATEN))) {
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.calibration.AutoCalibMask", "com.keba.kemro.kvs.keplast.recipe.LintabLoaderMask");
      }
      if ((!MachineEquipment.hasSpeedPump() && MachineEquipment.hasAnyPump())
            || MachineEquipment.doesVariableExist("ValveBackPres1.ao_Pressure")) {
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.calibration.AutoCalibMask",
               "system.hmi.AutoCalibLimitsMask");
      }
      if (MachineEquipment.hasAnyPump()) {
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.calibration.AutoCalibMask",
               "com.keba.kemro.kvs.keplast.calibration.AutoIdentRampMask");
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.calibration.AutoCalibMask",
               "system.hmi.AutoCalibSpeedMask");
      }

      // mold data mask
      mainMenu.addSubMask("com.keba.kemro.kvs.keplast.recipe.RecipeMask", "com.keba.kemro.kvs.keplast.recipe.MachineDataMask");
      // spc (since V01.36)
      mainMenu.addSubMask("com.keba.kemro.kvs.keplast.spc.SpcMask", "com.keba.kemro.kvs.pdp.graphic.GraphicMask",
            PlastConstants.LEVEL_QUALITY, PlastConstants.LEVEL_QUALITY);

      // Use keplast specific histogram mask (since V01.36)
      mainMenu.addSubMask("com.keba.kemro.kvs.keplast.spc.SpcMask", "com.keba.kemro.kvs.keplast.histogram.HistogramMask");

      if (MachineEquipment.doesVariableExist("CycleTime.sv_dTimeLimit")) {
         CycleTimeMask cycleTimeMask = (CycleTimeMask) KvFrame.getInstance()
               .getMaskInstance("com.keba.kemro.kvs.keplast.cycletime.CycleTimeMask");
         // Possibility to set input level for "setup command" of CycleTimeMask
         // cycleTimeMask.setInputLevelSetupCmd(IPlastUserLevels.LEVEL_STARTUP);
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.spc.SpcMask", cycleTimeMask.getID());
      }

      mainMenu.addEmptyContext(sOperationMask);

      // operation options mask
      if (BaseMachineEquipment.hasEasyMold()) {
         mainMenu.addContextMask(sOperationMask, "com.keba.kemro.kvs.keplast.easymold.EasyMoldWizard");
      }

      if (BaseMachineEquipment.doesVariableExist("IOParam.sv_bIOParamAvailable")) {
         // Flex IOs
         mainMenu.addContextMask(sOperationMask, "com.keba.keplast.io.ioparam.IOParamMask");
      }

      mainMenu.addEmptyContext(sAlarmMask);
      if (BaseMachineEquipment.doesVariableExist("system.sv_bMachineLockAvailable")) {
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.mask.SetupMaskVersionInfo", "system.hmi.MachineLockMask");
      }

      if (BaseMachineEquipment.doesVariableExist("Service1.sv_Options")) {
         mainMenu.addSubMask("com.keba.kemro.kvs.keplast.mask.SetupMaskVersionInfo", "com.keba.keplast.service.ServiceMask");
      }

      // Energy masks
      if (BaseMachineEquipment.hasServoDrives() || BaseMachineEquipment.doesDeviceExist("EnergyMeter1")) {
         mainMenu.addContextMask(sOperationMask, "Energy.hmi.EnergyMask");
         if (!BaseMachineEquipment.doesVariableExist("KVB.sv_MaskID")) {
            // Energy with shot
            mainMenu.addSubMask("Energy.hmi.EnergyMask", "Energy.hmi.EnergyShotChart");

            if (BaseMachineEquipment.hasServoDrives()) {
               // Energy by time
               mainMenu.addSubMask("Energy.hmi.EnergyMask", "Energy.hmi.EnergyCycleChart");
            }
         }
      }

      // Export mask
      mainMenu.addContextMask(sOperationMask, "system.hmi.ExportMask");

      // Speedpump
      // Add basic masks for a SpeedPump
      if (BaseMachineEquipment.hasSpeedPump()) {
         mainMenu.addContextMask(sPOPUP_SETUP, "Drive.hmi.DriveStatusMask");
         mainMenu.addSubMask("Drive.hmi.DriveStatusMask", "system.hmi.DrvPIDSettingsMask");

         if (!BaseMachineEquipment.doesVariableExist("KVB.sv_MaskID")) {
            // Drive chart masks
            mainMenu.addSubMask("Drive.hmi.DriveStatusMask", "Drive.hmi.PQChart");
            mainMenu.addSubMask("Drive.hmi.DriveStatusMask", "Drive.hmi.DriveTempChart");
         }
      }

      if (TIG.getInstance().isTIGExisting()) {
         // TIG
         mainMenu.addContextMask(sOperationMask, "com.keba.kemro.kvs.keplast.tig.TIGMainMask");
      }

      addContextMaskConditional(mainMenu, sAlarmMask, "EasyNet.hmi.StandstillReasonMask", "EasyNet.sv_bENAvailable");

      mainMenu.addEmptyContext(sAlarmMask);
      mainMenu.addEmptyContext(sPOPUP_ROBOT);
      mainMenu.addEmptyContext(sPOPUP_SETUP);
      mainMenu.addEmptyContext(sPOPUP_SERVICE);

   }

   private static void addContextMaskConditional(final MainMenuBar mainMenu, final String ownerMask, final String contextMask,
         final String variableName) {
      try {
         final KBoolean var = (KBoolean) HmiVariableService.getService().getVariable(variableName);
         HmiVariableService.registerVariable(var, null, new ValueChangedListener() {

            public void valueChanged(ValueChangedEvent event) {
               try {
                  if (event.getVariable().getBooleanValue()) {

                     // unregister
                     HmiVariableService.registerVariable((KVariable) null, (KVariable) var, this, null);

                     // add context mask
                     mainMenu.addContextMask(ownerMask, contextMask);
                  }

               } catch (VartypeException e) {
                  // cannot happen because of variable has been type checked
               }
            }
         }, null);
      } catch (Exception e) {
         // variable not existing or wrong type, do not add context mask
      }

   }

   private static void customizeCoreMasks(MainMenuBar mainMenu, int buttonID) {

      boolean bAnyCoreFound = false;

      if (MachineEquipment.doesDeviceExist("Core1") || MachineEquipment.doesDeviceExist("Core2")) {
         mainMenu.setMainButtonMask(buttonID, sCoreMask);
         mainMenu.addContextMask(sCoreMask, "Core.hmi.CoreParameterMask");
         bAnyCoreFound = true;
      }
      if (MachineEquipment.doesDeviceExist("Core7") || MachineEquipment.doesDeviceExist("Core8")) {
         if (bAnyCoreFound) {
            mainMenu.addSubMask(buttonID, "Core7.hmi.CoreMask78");
         } else {
            mainMenu.setMainButtonMask(buttonID, "Core7.hmi.CoreMask78");
         }
         mainMenu.addContextMask("Core7.hmi.CoreMask78", "Core.hmi.CoreParameterMask");
         bAnyCoreFound = true;
      }
      if (MachineEquipment.doesDeviceExist("Core5") || MachineEquipment.doesDeviceExist("Core6")) {
         if (bAnyCoreFound) {
            mainMenu.addSubMask(buttonID, "Core5.hmi.CoreMask56");
         } else {
            mainMenu.setMainButtonMask(buttonID, "Core5.hmi.CoreMask56");
         }
         mainMenu.addContextMask("Core5.hmi.CoreMask56", "Core.hmi.CoreParameterMask");
         bAnyCoreFound = true;
      }
      if (MachineEquipment.doesDeviceExist("Core3") || MachineEquipment.doesDeviceExist("Core4")) {
         if (bAnyCoreFound) {
            mainMenu.addSubMask(buttonID, "Core3.hmi.CoreMask34");
         } else {
            mainMenu.setMainButtonMask(buttonID, "Core3.hmi.CoreMask34");
         }
         mainMenu.addContextMask("Core3.hmi.CoreMask34", "Core.hmi.CoreParameterMask");
         bAnyCoreFound = true;
      }
      if (!bAnyCoreFound) {
         KvsMaskChangeButton buttonCore = mainMenu.getMaskChangeButton(buttonID);
         buttonCore.setMask(null);
         buttonCore.setDisabledImageName("Core.hmi.images.iconCoreNo_disabled.gif");
         buttonCore.setEnabled(false);
      }

   }

   private static void registerDynamicMaskSwitch(final MainMenuBar mainMenu) {
      // register nozzle mask dynamic
      Vector vVariables = new Vector();
      if (!MachineEquipment.isDeviceElectric("Nozzle1")
            && !MachineEquipment.hasOption("Nozzle1", MachineEquipment.MAIN_OPTION_NOZZLE_ASM)) {
         // register dynamic mask to button only on not electrical nozzle
         try {
            KVariable knumberNozzleMode = HmiVariableService.getService().getVariable("Nozzle1.sv_MovementMode");
            vVariables.addElement(knumberNozzleMode);
            knumberNozzleMode.addListener(new ValueChangedListener() {
               public void valueChanged(ValueChangedEvent event) {
                  if (event.getReason() == ValueChangedEvent.VALUE_CHANGED) {
                     try {
                        int mode = event.getVariable().getIntValue();

                        KvsMaskChangeButton button = mainMenu.getMaskChangeButton(ID_NOZZLE);
                        KvMask maskOld = button.getMaskInstance();
                        KvMask maskNew = null;
                        // mode:
                        // 0 = position
                        // 1 = limit
                        // 2 = time
                        if (mode == 0) { // 0 = position
                           maskNew = KvFrame.getInstance().getMaskInstance(sNozzleMask);
                        } else {
                           maskNew = KvFrame.getInstance().getMaskInstance("Nozzle1.hmi.NozzleMask1");
                        }
                        // check for real mask change and remove old mask in
                        // case of.
                        if (maskOld != null && !maskOld.equals(maskNew)) {
                           mainMenu.changeMainButtonMask(button, maskNew);
                        }
                        mainMenu.addContextMask(maskNew.getID(), "Nozzle1.hmi.NozzleParameterMask1");
                        mainMenu.addContextMask(maskNew.getID(), "Nozzle1.hmi.AutoPurgeMask1");
                        if (MachineEquipment.doesDeviceExist("ShutOffNozzle1")) {
                           mainMenu.addContextMask(maskNew.getID(), "ShutOffNozzle1.hmi.ShutOffNozzleMask1");
                        }
                     } catch (VartypeException e) {
                     }
                  }
               }
            });

         } catch (Exception ex) {
            System.err.println("Could not change nozzle mask depending on nozzle movement mode");
         }
      }
      // register variables to global variable group
      if (!vVariables.isEmpty()) {
         try {
            HmiVariableService.getService().startRefresh(vVariables);
         } catch (Exception e) {
            System.err.println("Could not register variables in MainMenuCustomizer!");
         }
      }
   }

   /**
    * Customize the main menu.
    * 
    * @param mainMenu
    */
   public static void customizeMenu(MainMenuBar mainMenu) {

      // Collect MaskNames
      sOverviewMask = mainMenu.getMaskChangeButton(ID_OVERVIEW).getMask();

      if (MachineEquipment.hasOption("Mold1", MachineEquipment.SUB_OPTION_MOLD_TWO_PLATEN)) {
         mainMenu.getMaskChangeButton(ID_MOLD).setMask("Mold1.hmi.MoldTwoPlatenMask1");
      }
      sMoldMask = mainMenu.getMaskChangeButton(ID_MOLD).getMask();
      sEjectorMask = mainMenu.getMaskChangeButton(ID_EJECTOR).getMask();
      sCoreMask = mainMenu.getMaskChangeButton(ID_CORE).getMask();
      sInjectMask = mainMenu.getMaskChangeButton(ID_INJECT).getMask();
      sPlastMask = mainMenu.getMaskChangeButton(ID_PLAST).getMask();
      sNozzleMask = mainMenu.getMaskChangeButton(ID_NOZZLE).getMask();
      sHeatingMask = mainMenu.getMaskChangeButton(ID_HEATING).getMask();
      sOperationMask = mainMenu.getMaskChangeButton(ID_OPERATION).getMask();
      sAlarmMask = mainMenu.getMaskChangeButton(ID_ALARM).getMask();

      // main buttons
      customizeMainButtons(mainMenu);
      // sub masks
      customizeSubMenuButtons(mainMenu);
      // context masks
      customizeContextButtons(mainMenu);
      // register dynamic masks
      registerDynamicMaskSwitch(mainMenu);
   }
}
