%IMPORT_OVER_LISTFILE_SOURCE
 VG_Production
, VG_SPC_POST
, OperationModeDisplay
, Pressure
, NoRelative
, fmt40
, VG_MachineData
, Percent
, fmt30
, InjectBackpressureABS
, Time
, fmt31
, VG_MoldData
, ShotCount
, fmt100
, PieceCount
, fmt60
, fmt50
, UseNoUse
, TimeHoursFromSec
, fmt61
, Stroke
, VG_SequenceData
, MotorDisplay
, PartQuality
, BadPartReason
, TimeMinutes
, OnOff
, InjectBackpressure
, fmt10
, fmtUser

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tnDataState
, tsDataActionsEnable
, tyNumberOfDevices
, tsTraceLevel
, tsTraceFilter
, tyMovementRegisterList
, tDeviceMovementList
, tnOperationMode
, tnBadPartReason
, tsProduction
, tyPumpData
, tsPumpConnectionList
, tsLockOperationModeAuto
, tsResourceLock
, cCompAll
, cAllDevIndex
, nManual
, cLevelSuperUser
, cLevelStartupTechnican
, cLevelProduction
, cLevelProcessOperator
, FPlausMaxInjectPressure
, ALARM_EVENT
, tevDeviceRegister
, tevMovementRegister
, tevLockUnlock
, tevLockUnlockGroup
, tevStartedStopped
, tevMovementState
, tevCheckLocklist
, tevStart
, tevStop
, tevStartRequest
, tevStopRequest
, tevOutputRequest
, tevOutputResponse
, tevAnaDevCmd
, tevAnaDevResponse
, tevAlarmConfirm
, tevCycleStart
, tevCoreTypeChanged
, tevSafetyGate
, tevRedoEvent
, tevProtect
, tevInterCondChanged
, tevPartCheck
, tevEmergencyStop
, tevRedoIdentEvent
, tevRedoIdentSpeedEvent
, tevLockGroupEnableDisable
, KPUSB_Event
, tevSequenceInterrupt
, tevHoldScrap
, tevReleaseSinglePump
, tevInterruptActivePump
, tevRequestSinglePump
, tevModifyCycleStartCondition

END_IMPORT

%SYSTEMVAR_DECL
  sv_dShotTimeAct : DATE_AND_TIME (* RTC Time of actual shot *)
     %VARIABLE_GROUP VG_Production,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Shot time Shot time
;
 sv_bInitStart : BOOL (* Device registration finished - custom IEC initialisation can be started *)
     %INPUT_LEVEL 16

// Init start Initialisation start
;
 sv_bInitDone : BOOL (* IEC initialisation is finished (after movement registration) *)
     %INPUT_LEVEL 16

// Init done Initialisation done
;
 sv_DataState : tnDataState (* State of machine / mold data read *)
     %INPUT_LEVEL 16

// Data state Data state
;
 sv_DataActionsEnable : tsDataActionsEnable := (bMoldDataLoad:=TRUE,bMoldDataSave:=TRUE,bMachineDataLoad:=TRUE,bMachineDataSave:=TRUE,bSequenceDataLoad:=TRUE,bSequenceDataSave:=TRUE) (* set enabled state of actions load/save mold/machinedata *)
     %INPUT_LEVEL 16

// enable data actions enable data actions

%ELEMENT sv_DataActionsEnable.bMachineDataLoad
    
// enable machine data load enable machine data load

%ELEMENT sv_DataActionsEnable.bMachineDataSave
    
// enable machine data save enable machine data save

%ELEMENT sv_DataActionsEnable.bMoldDataLoad
    
// enable mold data load enable mold data load

%ELEMENT sv_DataActionsEnable.bMoldDataSave
    
// enable mold data save enable mold data save
;
 sv_iDevicesToRegister : DINT (* Number of devices to register *)
     %INPUT_LEVEL 16

// Devices to register Devices to register
;
 sv_iMovementsToRegister : DINT (* Number of Movements to register *)
     %INPUT_LEVEL 16

// Movements to register Movements to register
;
 sv_iRegistrationCounter : DINT (* Registrationcounter for delaytime generation *)
     %INPUT_LEVEL 16

// Registration counter Registrated devices counter
;
 sv_NumberOfDevices : tyNumberOfDevices
     %INPUT_LEVEL 16

// Number of devices Number of devices
;
 sv_TraceLevel : tsTraceLevel := (bDebugCalibration:=TRUE)
   RETAIN  %INPUT_LEVEL 5

// Trace level Trace level
;
 sv_TraceFilter : tsTraceFilter := (DeviceFilter:=4((CompId:=cCompAll,IndexId:=cAllDevIndex)))
   RETAIN  %INPUT_LEVEL 5

// Trace filter Trace filter
;
 sv_bTRUE : BOOL := TRUE (* always true, used to set a reference true *)
     %INPUT_LEVEL 16

// True True
;
 sv_bFALSE : BOOL := FALSE (* always false, used to set a reference false *)
     %INPUT_LEVEL 16

// False False
;
 sv_MovementsAvailable : tyMovementRegisterList
    ;
 sv_DeviceMovements : tDeviceMovementList
    ;
 sv_OperationMode : tnOperationMode := nManual
     %FORMAT OperationModeDisplay 
// Operation mode Operation mode
;
 sv_rMaximumPressure : REAL := 210.0
 %PLAUSIBILITY 0.0..999.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT Pressure  %ABSREL NoRelative 
// Max. system pressure pump 1 Max. system pressure pump 1
;
 sv_rMaximumVelocity : REAL := 100.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent 
// Max. velocity Maximum velocity
;
 sv_rMaxBackPressure : REAL := 210.0
 %PLAUSIBILITY FPlausMaxInjectPressure    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT InjectBackpressureABS  %ABSREL NoRelative 
// Max. backpressure Maximum backpressure
;
 sv_dCycleTime : TIME (* act. cylce time *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Cycle time Cycle time
 %UPDATE_CYCLE "Fast";
 sv_dCycleTimeMachine : TIME (* act. cycle time machine *)
     %VARIABLE_GROUP VG_Production,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt31  %UNIT Time 
// Cycle time machine Cycle time machine
;
 sv_dMaxCycleTime : TIME := T#60s
 %PLAUSIBILITY T#0s..T#999s    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Max. cycle time Maximum cycle time
;
 sv_dCalculatedCycleTime : TIME (* calculated cycle time (written by machine sequencer) *)
     %DISPLAY_LEVEL cLevelSuperUser  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_iShotCounterAct : DINT
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt100  %UNIT ShotCount 
// Shotcounter Shotcounter
;
 sv_iProdCounterAct : DINT
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt60  %UNIT PieceCount 
// Prod.counter Productionounter
;
 sv_iShotCounterSet : DINT (* shot limit *)
 %PLAUSIBILITY 1..99999    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt50  %UNIT ShotCount 
// Shotcounter Shotcounter limit
;
 sv_iProdCounterSet : DINT := 1 (* shot limit *)
 %PLAUSIBILITY 1..999999    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt60  %UNIT PieceCount 
// Prod.counter limit Productioncounter limit
;
 sv_bUseProdCounter : BOOL (* use shot counter *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Use production counter Use production counter
;
 sv_iShotCounterRetain : UDINT (* shot counter retain (used for lubrication) *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt50 
// Total shotcounter Total shotcounter
;
 sv_bResetShotCounter : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Reset production counter Reset production counter
;
 sv_dCycleDelaySet : TIME
 %PLAUSIBILITY t#0s..t#100s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Cycle delay time Cycle delay time
;
 sv_dCycleDelayAct : TIME
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. Cycle delay time Act. Cycle delay time
;
 sv_iPowerOnTime : LINT (* total power on time in seconds *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt61  %UNIT TimeHoursFromSec 
// Power on time Power on time
;
 sv_iFullAutoTime : LINT (* full-automatic mode time in seconds *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt61  %UNIT TimeHoursFromSec 
// Full auto time Full auto time
;
 sv_dTransducerCalibTime : TIME := t#2s
 %PLAUSIBILITY T#0s..T#100s    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Calibration time Calibration time
;
 sv_rMaxCalibDifference : REAL := 0.05
 %PLAUSIBILITY 0.0..99.99    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Max. calib difference Maximum calibration difference
;
 sv_sSequenceData : STRING(99) := '---'
   RETAIN  %VARIABLE_GROUP VG_SequenceData  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Sequence data Sequence data name
;
 sv_sMoldData : STRING(99) := '---'
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Mold data Mold data name
;
 sv_sMachineData : STRING(99) := '---'
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Machine data Machine data name
;
 sv_sMaterialData : STRING(99) := '---'
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Material data Material data name
;
 sv_bFirstCycle : BOOL := TRUE
     %INPUT_LEVEL 16

// First cycle First cycle is active
;
 sv_bAutoCycleRunning : BOOL
     %INPUT_LEVEL 16

// Autocycle running Autocycle is running
;
 sv_bAllMotorsRunning : BOOL (* all motors are running *)
     %DISPLAY_LEVEL 1  %FORMAT MotorDisplay 
 // All motors running
;
 sv_bReadConfigDone : BOOL (* reading of machine config from catalog done *)
     %INPUT_LEVEL 16

// Read cfg done Read cfg done
;
 sv_bDeviceRegisterDone : BOOL (* device registration finished *)
     %INPUT_LEVEL 16

// Device reg. done Device registration done
;
 sv_dLastCycleTime : TIME (* act. cylce time *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Cycle time Cycle time
;
 sv_dRefCycleTime : TIME (* act. cylce time *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt31  %UNIT Time 
// Cycle time Cycle time
;
 sv_bMoveRegisterDone : BOOL (* movement registration finished *)
     %INPUT_LEVEL 16

// Move reg. Done Movement registration done
;
 sv_iCavities : DINT := 1
 %PLAUSIBILITY 1..999    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30 
// Cavity Cavity
;
 sv_bODCFilesChanged : BOOL (* TRUE if ODC sequence should be reinitialized because the files on disk changed *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_bProgramSwitchChanged : BOOL (* TRUE if ODC sequence should be reinitialized because a program switch changed *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_bActivationChanged : BOOL (* TRUE if ODC sequence safety should be recalculated because a program switch was deactivated *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_bOverrideCoreSafety : BOOL (* overrides safety settings for core movements in setup mode *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Override core safety Override core safety
;
 sv_bOverrideEjectorSafety : BOOL (* overrides safety settings for ejector movements in setup mode *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Override ejector safety Override ejector safety
;
 sv_bCalcMaxValuesFromCylData : BOOL := TRUE (* TRUE: calculate max speed and max pressure values by using cylinder data;  FALSE: max values must be entered manually *)
    ;
 sv_rMaxPercentRamp : REAL := 120.0
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Percent ;
 sv_rMinPercentRamp : REAL := 0.1
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Percent ;
 sv_dDummyTime : TIME := t#2s
 %PLAUSIBILITY t#0s..t#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %UNIT Time 
// Time Time
;
 sv_rNull : REAL := 0.0
    ;
 sv_bReadAddDeviceInfoDone : BOOL (* reading of additional device information done (by ODC1) *)
     %INPUT_LEVEL 16

// Read device info done Read additional device info done
;
 sv_iEditorPropertiesChanged : DINT (* must be increased if properties, that are relevant for ODC editor, changed *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Properties changed ODC editor properties changed
;
 sv_bBadPart : BOOL
     %DISPLAY_LEVEL 1  %FORMAT PartQuality 
// Actual Part Quality Actual Part Quality
;
 sv_BadPartReason : tnBadPartReason
     %DISPLAY_LEVEL 1  %FORMAT BadPartReason 
// Bad part reason Bad part reason
;
 sv_Production : tsProduction := (iRejectTimeSpan:=5,iGoodPartsPerReject:=2147483647)
     %DISPLAY_LEVEL 1 
%ELEMENT sv_Production.iGoodPartsPerReject
     %FORMAT fmt60  %UNIT PieceCount 
// Good parts per reject Good parts per reject

%ELEMENT sv_Production.iRejectCounter
     %FORMAT fmt60  %UNIT PieceCount 
// Reject counter Reject counter

%ELEMENT sv_Production.iRejectTimeSpan
 %PLAUSIBILITY 1..999    RETAIN  %VARIABLE_GROUP VG_MoldData  %FORMAT fmt30  %UNIT TimeMinutes 
// Timespan for reject Timespan for reject

%ELEMENT sv_Production.iRejectsInSeries
     %FORMAT fmt60  %UNIT PieceCount 
// Rejects in series Rejects in series

%ELEMENT sv_Production.iRejectsPerTime
     %FORMAT fmt30  %UNIT PieceCount 
// Rejects per time Rejects per time
;
 sv_bEmergencyStop : BOOL (* Common emergency stop signal. true if any emergency stop button is pressed *)
     %INPUT_LEVEL 16

// Emg Stop Emergency Stop
;
 sv_bUseProgramSwitches : BOOL := TRUE (* TRUE: create sequence by using program switches; FALSE: use sequence from ODC editor *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData  %VISI_CLASS system.hmi.UseProgramSwitchController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Disable cycle designer Disable cycle designer
;
 sv_bSimplifyProfileVis : BOOL := TRUE
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Simplify profile Simplify profile table
;
 sv_sPathMasterdisk : STRING(255) := '\0'
    ;
 sv_sPathWorkspace : STRING(255) := '\0'
    ;
 sv_sPathAppldisk : STRING(255) := '\0'
    ;
 sv_bIOParamInitDone : BOOL
    ;
 sv_bCoresParallelToMold : BOOL (* cores should move parallel to mold  *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Cores parallel to mold Cores parallel to mold
;
 sv_bParallelCoreMovement : BOOL (* cores with the same mode (for example before close) should move parallel  *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Parallel core movement Parallel core movement
;
 sv_bAutoCalibRunning : BOOL (* auto calibration active *)
    ;
 sv_rUnitPlaceHolderBackpressure : REAL (* variable for HMI to get InjectBackpressure Unit *)
     %UNIT InjectBackpressure ;
 sv_iDurationUpdateInTolerance : DINT (* counter is increased by ODC if duration is updated although it was in tolerance *)
    ;
 sv_dAllowedCycleDeviation : TIME := t#200ms
   RETAIN  %FORMAT fmt31  %UNIT Time ;
 sv_bODCCombinedMoveActive : BOOL (* TRUE: combined movement (for example closing sequence) is active (only in manual mode!) *)
    ;
 sv_iActMoldProtectRetry : DINT
    ;
 sv_iSetMoldProtectRetry : DINT
 %PLAUSIBILITY 0..9    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt10 
// Mold protect retry count Mold protect retry count
;
 sv_bSkipCycleStartCond : BOOL
    ;
 sv_bPresMoldHeightAdjustActive : BOOL (* TRUE: mold adjust in mode nPressureOpenLoop is active *)
    ;
 sv_bTwoButtonOperation : BOOL (* TRUE: two startbuttons are linked; SV is set in OperationMode - FU *)
    ;
 sv_bStartButtonsPressed : BOOL (* TRUE: both start buttons are pressed; SV is set in OperationMode - FU *)
    ;
 sv_bEvenCycle : BOOL (* TRUE: even cycle, FALSE: odd cycle *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Even cycle Even cycle
;
 sv_iLoopCounter : DINT
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Loop counter Loop counter
;
 sv_UserLevel : DINT := 1 (* actual userlevel *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmtUser 
// Userlevel Userlevel
;
 sv_bSequenceInterruption : BOOL (* TRUE: sequence is interrupted *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Sequence interruption Sequence interruption
;
 sv_bStepBwdActive : BOOL (* TRUE: stepping bwd is active *)
    ;
 sv_bReferenceClear : BOOL
    ;
 sv_iCpuId : LINT := 0 (* cpu id (serial number) *)
     %DISPLAY_LEVEL 1  %FORMAT fmt100 
// CPU serial number CPU serial number
;
 sv_PumpData : tyPumpData
    ;
 sv_iPumpFlowChanged : DINT (* must be increased by every pump if sv_rAbsFlow is changed *)
    ;
 sv_iPumpPressureChanged : DINT (* must be increased by every pump if sv_rMaxPressure is changed *)
    ;
 sv_PumpConnectionList : tsPumpConnectionList
    ;
 sv_bProfileEditorActive : BOOL (* "profile dirty" flag (will be set / reset by HMI)  *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Profile editor active Profile editor active
;
 sv_bRecalcPendingOrActive : BOOL (* The ODC wants to recalc the sequence or a recalc is currently active. Any evStartRequest sent at this time can potentially be ignored if recalculation is already active. *)
    ;
 sv_LockOperationModeAuto : tsLockOperationModeAuto
    ;
 sv_LockDataState : tsResourceLock
    ;
 sv_iReadMachineDataCount : UDINT (* counter which is increased after every loading of machine data  *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iReadMoldDataCount : UDINT (* counter which is increased after every loading of mold data  *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
%END

%SYSTEMEVENT_DECL
  evAlarmLampBlink : ALARM_EVENT
;
 evAlarmLampReset : ALARM_EVENT
;
 evAlarmFinishCycleAndStop : ALARM_EVENT (* finish cycle and then switch to manual mode *)
;
 evAlarmAutoManual : ALARM_EVENT (* stop cycle and switch to manual mode immediatly *)
;
 evAlarmAutoHalf : ALARM_EVENT (* finish cycle switch to half auto mode immediatly *)
;
 evAlarmMotorLock : ALARM_EVENT (* stop motor and don´t allow switching on *)
;
 evAlarmMotorRelease : ALARM_EVENT (* release motor (switching on is possible again) *)
;
 evDeviceRegister : tevDeviceRegister
;
 evMovementRegister : tevMovementRegister
;
 evLockUnlock : tevLockUnlock
;
 evLockUnlockGroup : tevLockUnlockGroup
;
 evStartedStopped : tevStartedStopped
;
 evMovementState : tevMovementState
;
 evCheckLocklist : tevCheckLocklist (* check the locklist of a movement and set alarms(if the movement is locked) *)
;
 evStart : tevStart
;
 evStop : tevStop
;
 evStartRequest : tevStartRequest
;
 evStopRequest : tevStopRequest
;
 evOutputRequest : tevOutputRequest
;
 evOutputResponse : tevOutputResponse
;
 evAnaDevCmd : tevAnaDevCmd
;
 evAnaDevResponse : tevAnaDevResponse
;
 evAlarmConfirm : tevAlarmConfirm
;
 evCycleStart : tevCycleStart
;
 evNewCycleStarted : tevCycleStart (* New machine cycle has been started *)
;
 evCoreTypeChanged : tevCoreTypeChanged
;
 evSafetyGate : tevSafetyGate
;
 evRedoStart : tevRedoEvent
;
 evProtect : tevProtect
;
 evInterCondChanged : tevInterCondChanged (* sent when intermediate condition changes (for example: new core in position) *)
;
 evPartCheck : tevPartCheck (* sent by a quality check FU to mark a part as good or bad *)
;
 evEmergencyStop : tevEmergencyStop (* sent by any emergencystop handler (eg. Robot interface) when the emergencystop is pressed. Received by OperationMode1 *)
;
 evAlarmWatchdog : ALARM_EVENT (* watchdog opend by execptioninterpration *)
;
 evRedoIdentStart : tevRedoIdentEvent
;
 evRedoIdentMaxSpeedStart : tevRedoIdentSpeedEvent
;
 evRedoIdentMinSpeedStart : tevRedoIdentSpeedEvent
;
 evLockGroupEnableDisable : tevLockGroupEnableDisable
;
 evUsbEvent : KPUSB_Event (* USB attach/detach notification event *)
;
 evSequenceInterrupt : tevSequenceInterrupt
;
 evHoldScrap : tevHoldScrap
;
 evReleaseSinglePump : tevReleaseSinglePump
;
 evInterruptActivePump : tevInterruptActivePump
;
 evRequestSinglePump : tevRequestSinglePump
;
 evModifyCycleStartCondition : tevModifyCycleStartCondition (* event can be sent for modification of cycle start conditions *)
;
%END

%SYSTEM_ALARM
  erDeviceReg
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// Device registration error{#]An Error within the initial device registration \u000aprevents any further machine operation.{#]All devices will register themselves within the control application. In this case a problem occurred during the registration procedure.{#]Please contact the machine manufacturer.
 ;
  erMultipleDeviceReg
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// Multiple device registration: %1t%2n{#]A device tried to register multiple times.{#]Each device can only register once. In this case a device tried to register \u000amultiple times which should not happen.{#]Please contact the machine manufacturer.
 ;
  erMaxDeviceIndexExeeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// Too much devices of component %1t registered. (max: %2n){#]The maximum number of devices per \u000acomponent that can be registered within \u000athe application is exceeded.{#]For each machine component a number of such devices can be registered \u000awithin the control application. This number is exceeded for a certain \u000acomponent type.{#]Please contact the machine manufacturer.
 ;
  erMaxCompIdExeeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// Too much components registered. (max: %1n){#]The maximum number of components that \u000acan be registered within the application \u000ais exceeded.{#]Each device type carries a component ID. For example each core carries the \u000acomponent ID for cores overall. There is a maximum component ID \u000awhich must not be exceeded, which is the case if this alarm is raised.{#]Please contact the machine manufacturer.
 ;
  erMaxMovementsExeeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Too much movements in device %1t%2n registered. (max: %3n){#]The maximum number of movements per \u000adevice that can be registered within \u000athe application is exceeded.{#]Each device can contain several movements. The maximum number of \u000asuch movements is limited and exceeded in this case.{#]Please contact the machine manufacturer.
 ;
  erMaxMoveRegisteredExeeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Too much movements registered. (max: %1n){#]The maximum number of movements that \u000acan be registered within the application \u000ais exceeded.{#]The overall number of movements that can register within the control application \u000ais limited. This limit is exceeded by the current application software setup.{#]Please contact the machine manufacturer.
 ;
  erNoSvDeviceId
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// Device registration error: "sv_DeviceId" missing of FU %1s{#]A basic device variable is missing.{#]Registration of a device is only possible with the application internal \u000asv_DeviceId variable. This alarm is raised if the variable is missing.{#]Please contact the machine manufacturer.
 ;
  erLockListSizeExeeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual 
// ABLockList: Locklist-size exceeded. (max : %1n){#]A movement should be locked, but the \u000alocklist storing all lock events is full.{#]Movements are locked by other movements. All such locks are stored within the \u000aso called locklist. If the maximum size of the locklist is exceeded the alarm is raised.{#]Try to operate the machine in a way that produces less problematic \u000alock situations.<br>\u000aIf this alarm is frequently raised without intention, please contact the \u000amachine manufacturer.
 ;
  erNoSvMove
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Movement initialisation error in device %1t: "sv_MoveXxx" missing{#]A basic device variable is missing.{#]Registration of a device is only possible with the application internal \u000asv_MoveXxx variable. This alarm is raised if the variable is missing.{#]Please contact the machine manufacturer.
 ;
  erNoSvDeviceReady
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Movement initialisation error in device %1t: "sv_bDeviceReady" missing{#]A basic device variable is missing.{#]Registration of a device is only possible with the application internal \u000asv_bDeviceReady variable. This alarm is raised if the variable is missing.{#]Please contact the machine manufacturer.
 ;
  erDeviceActive
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual 
// Device %1t%2n already active!{#]A movement cannot be started because \u000athe device is already active.{#]A movement of a certain device should be started while the same or another \u000amovement of this device is already active. One device can only perform one \u000amovement at a time.{#]Wait for the device to become inactive before retrying the desired \u000aoperation.<br>\u000aIf this alarm is frequently raised without a recognizable reason, \u000aplease contact the machine manufacturer.
 ;
  erInitNotReady
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n: Initialisation active{#]Initialization of the control application is \u000astill active. No movements possible during \u000athis stage of bootup.{#]After the controller finished booting the control application itself is starting. The \u000ainitialization is one of the first stages of this process. During initialization no \u000amovements are possible.{#]Wait for initialization to finish before retrying the desired operation.
 ;
  erMovementRegistrationTimeout
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// Timeout during movement registration!{#]Not all expected movements registered \u000awithin the preset timeout.{#]At this point the application is waiting for further expected movements to register. \u000aWithin a given timeout the registration doesn't happen, thus the alarm is raised.{#]Try to reboot the controller.<br>\u000aIf the alarm still appears, please contact the machine manufacturer.
 ;
  erSwitchToManual
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Switch to manual - mode{#]The required action is not possible because the machine is not in manual mode.{#]Some actions are only possible if the machine is in manual mode.{#]Change the operation mode to manual mode.
 ;
  erProdLimitReached
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmFinishCycleAndStop 
// Number of pieces to produce reached{#]The set number of parts to produce is \u000areached.{#]This is just a message and does not indicate a problem.<br>\u000aAccording to the cavities setting and the production counter the number \u000aof produced parts is calculated. This counter is then compared to the \u000aproduction limit setting in order to generate this message.{#]This is just a message, no action required.<br>\u000aA new production process can be started, a new {system.sv_iProdCounterSet:l} \u000acan be set.
 ;
  erCycleTimeExceeded
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual,%FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Cycle time exceeded{#]The current cycle time exceeds the maximum cycle time.{#]The current cycle execution time is limited by the user setting of maximum \u000acycle time. If this maximum time is exceeded the alarm is given.{#]Increase the {system.sv_dMaxCycleTime} setting.<br>\u000aIf this is not allowed try to find component movements which can be \u000aoptimized in order to run the cycle within maximum limitations.
 ;
  erListOverflow
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmLampBlink, %FU.evAlarmMotorLock  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// %1t%2n: List overflow in "%1s" !{#]An application internal list ran into an \u000aoverflow.{#]Several features of the control application use lists. If an element is added to \u000asuch a list, which is already full, this overflow alarm is raised. This problem \u000aneeds to be solved by an application engineer.{#]Please contact the machine manufacturer.
 ;
  erAnalogInput
 %CLASS 1 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual 
// Sensor error in: %1t%2n Endpoint: %1s, check terminal and wiring %2s{#]An analog sensor input signals an invalid \u000ainput value.{#]The status flag of an analog input signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.\u000aWithout a working sensor feedback the according measurement is stopped, \u000aprobably also causing a lock on other movements.{#]Check the feedback of the sensor in the IO monitor.\u000aThen check the according hardware including the terminal and its wiring.
 ;
  erMovementNotAvailable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual 
// Movement not available: Device: %1t%2n, MoveId: %3n, MoveDir: %4n{#]A movement should be started which \u000adoesn't exist.{#]According to the knowledge of the registration lists of the control application \u000athe movement that should be started is unknown.{#]After confirmation of the alarm further operation is possible.<br><br>\u000aBecause of the application internal character of the alarm cause, \u000aplease contact the machine manufacturer.
 ;
  erCalibrationNotEnoughValues
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Not enough values captured for parameter detection of PID controller{#]During screw movement at autocalibration for inject and hold PID-identification to less numbers of actual pressure values are measured.{#]During autocalibration reference pressure profiles with different steps are used to calculate PID-values of the pressure controllers. The step response of the actual pressure is analyzed.<br>Inject-PID: If screw velocity is very high and screw stroke is low to less measure points are recorded.<br>Hold-PID: Reference pressure steps are to short.{#]Please contact the machine manufacturer.
 ;
  erCalibrationDataFailure
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// No meaningful data during calibration.{#]Calculation of PID-values for pressure controller precutoff and hold can't be calculated.{#]During autocalibration reference pressure profiles with different steps are used to calculate PID-values of the pressure controllers.<br>The step response of the actual pressure is analyzed. If the actual pressure can't follow the reference the calculation of the PID-values fails.{#]Start calibration of pressure controller for inject or hold again.
 ;
  erUserLevelLow
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Userlevel %1i required!{#]The current user level is too low to \u000aperform the desired operation.{#]Certain functionalities are only available to higher user levels. If such a \u000afunctionality is used with a lower user level this alarm is raised.{#]Log in with a user level equal or higher than the required level.
 ;
  erSetupModeRequired
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Setup mode required{#]Certain movements are only possible in \u000aoperation mode 'setup'.{#]A number of movements, including all autocalibration movements, require the \u000aoperation mode 'setup' to be active. Otherwise the according movements are \u000anot allowed.{#]Change to operation mode 'setup' before retrying the desired \u000aoperation.
 ;
  erSetupModeRequiredForCalib
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Calibration not possible, setup mode required{#]Autocalibration feature is only available in operation mode 'setup'.{#]Any calibration movement requires the operation mode 'setup' to be active. Otherwise the according movements are not allowed.{#]Change to operation mode 'setup' before retrying the desired \u000aoperation.
 ;
  erSetupModeRequiredForAdjust
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t movement not possible, setup mode required{#]Adjustment movements are only possible in operation mode 'setup'.{#]Adjustment functionalities, for example mold height adjustment, require the \u000aoperation mode 'setup' to be active. Otherwise the according movements are \u000anot allowed.{#]Change to operation mode 'setup' before retrying the desired \u000aoperation.
 ;
  erTransducerCalibNoMovement
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n: no movement detected during transducer calibration, check movement in setup mode{#]Too little reaction came from a device \u000aduring transducer calibration.{#]The calibration feature is moving a device for example forward and backward \u000ain order to measure the voltage values corresponding to zero position and \u000afull stroke. If the two voltages are (almost) equal the application can assume \u000ano movement actually happened. It is also possible that the transducer feedback \u000ais corrupt because of wiring, terminal or malfunctioning transducer hardware.{#]Check the problematic movement manually in setup mode. Is the \u000adevice moving, but the input voltage does not change, check the \u000awiring, terminal and transducer hardware.<br>\u000aIf the device is not moving try to increase the problematic movements \u000asetup mode output settings and possibly check the according pump calibration by moving other devices in setup mode.
 ;
  erRPMCalibNoMovement
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// No movement detected during RPM calibration, check impulse sensor and plast movement in setup mode{#]Too little RPM reaction for calibration.{#]During calibration the application cannot find enough RPM change while \u000atrying to rotate the screw.<br>\u000aMost likely there is a problem with the impulse sensor feedback.{#]Try a plasticizing movement in operation mode setup to find possible \u000aproblems. Check the {Injection1.di_ImpulseInput} feedback value in the \u000aIO monitor.<br>\u000aIf there is no feedback check the terminal, wiring and possibly the \u000asensor itself before retrying a calibration.
 ;
  erAssert
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Assert!{#]An internal error regarding movement \u000ahandling is active.{#]Serious control application problems regarding movement handling are covered \u000aby this alarm. The detailed cause must be analyzed by an according \u000aapplication engineer.{#]Please contact the machine manufacturer.
 ;
  erPumpPresCalibNoValueChange
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// No pressure change detected during pump pressure calibration, check pressure sensor and lintab{#]Too little pressure reaction for calibration.{#]During calibration the application cannot find any pressure change while \u000agiving an output pressure.<br>\u000aMost likely the reason is a bad linearization table setting for pressure sensor \u000areading. It is also possible that there is a problem at the terminal or the wiring\u000aof the sensor, or even the sensor itself.{#]Check the IO monitor for pressure output voltage given. Also check \u000athe voltage measured by the pressure sensor.<br>\u000aIf these two are ok, check the linearization table setting of the \u000aaccording pressure sensor.<br>\u000aOtherwise check the pressure sensor itself for problems before\u000a retrying a calibration.
 ;
  erPumpVelCalibNoValueChange
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// No position change detected during pump velocity calibration, check transducer and lintab and inject movement in setup mode{#]Too little velocity reaction for calibration.{#]During calibration the application cannot find enough velocity change while \u000atrying to move the selected calibration axis.<br>\u000aMost likely the reason is a bad linearization table setting for the according axis\u000atransducer. There could also be a hardware problem.{#]Try a movement of the according axis in operation mode setup to find\u000apossible problems.<br>\u000aCheck the IO monitor for velocity output voltage given.<br>\u000aIf this is ok, check the linearization table setting of the \u000aaccording axis transducer.<br>\u000aOtherwise check the hardware for problems before\u000a retrying a calibration.
 ;
  erCalibrationFailure
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at calibration.{#]Transducer calibration can't be finished.{#]During transducer calibration no movement is possible.{#]Check output to actuators (all required valves are opened, torque and reference speed to drive).
 ;
  erCalibrationWarning
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Warning: Calibration successful, but result might be problematic.{#]The calculation of the pressure PID-parameters is done successfully. A little change of the values would cause invalid values for the PID-parameters.{#]The PID-parameters are calculated from analyzed measure data.<br>The calculation can still be done but if a measured quantity has different values the calculation would not be possible.{#]Start calibration again.
 ;
  erCalibrationRPMNotStable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at calibration because measured screw rpm not stable, send statusreport to manufacturer{#]The measured actual revolution of the screw is not stable during observation time.{#]During RPM-calibration the output to the actuator is increased step-by-step.<br>At each step the actual revolution must be stable after short reaction time.{#]Please contact the machine manufacturer.
 ;
  erCalibrationPressureNotStable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at calibration because measured pressure not stable, send statusreport to manufacturer{#]During calibration of the pump pressure the actual pressure is not stable enough.{#]At pressure calibration the pressure valve is opened using constant control value. As result the actual pressure has to be stable after short reaction time.<br>If the pressure doesn't get stable measurement has to be stopped.{#]Please contact the machine manufacturer.
 ;
  erCalibrationVelocityNotStable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at calibration because measured velocity not stable, send statusreport to manufacturer{#]During calibration of the pump velocity the actual screw velocity is not stable enough.{#]At velocity calibration the flow valve is opened using constant control value. As result the actual screw velocity has to be stable after short reaction time.<br>If the velocity doesn't get stable measurement has to be stopped.{#]Please contact the machine manufacturer.
 ;
  erPIDCalcVelocityNotStable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at inject closed loop parameter detection because measured velocity not stable, send statusreport to manufacturer{#]During calibration of the screw velocity controller the actual screw velocity is not stable enough.{#]At velocity calibration the flow valve is opened using constant control value. As result the actual screw velocity has to be stable after short reaction time.{#]Please contact the machine manufacturer.
 ;
  erPIDCalcPressureNotStable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at hold closed loop parameter detection because measured pressure not stable, send statusreport to manufacturer{#]Measured pressure at hold pressure calibration is not stable.{#]At pressure calibration the pressure valve is opened using constant control value. As result the actual pressure has to be stable after short reaction time.{#]Please contact the machine manufacturer.
 ;
  erPIDParamDetectionError
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at closed loop parameter detection, send statusreport to manufacturer{#]Failure at velocity calibration.{#]There are some failures during velocity calibration possible:<br>- no constant movement possible<br>- parametrization of filter<br>- parametrization of differentiator{#]Please contact the machine manufacturer.
 ;
  erCalibrationStopped
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Calibration stopped because of pending alarm(s){#]There are alarms pending or one of the \u000acalibration movements is locked, \u000apreventing any autocalibration.{#]To allow execution of the autocalibration the number of active alarms must be 0. \u000aAlso autocalibration is only executed if all involved movements are free to \u000aoperate and not locked by any other movement or function. Both cases will \u000aresult in an immediate stop of the calibration with this alarm.{#]Solve problems for all pending alarms. Make sure the movements \u000ainvolved in the desired calibration are not locked. For this it might \u000abe necessary to move other components into appropriate \u000aendpositions. After this retry the desired calibration.
 ;
  erCalibrationSpeedStopped
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Calibration stopped because of pending alarm(s) (%1i){#]There are alarms pending or one of the \u000acalibration movements is locked, \u000apreventing any autocalibration.{#]To allow execution of the autocalibration the number of active alarms must be 0. \u000aAlso autocalibration is only executed if all involved movements are free to \u000aoperate and not locked by any other movement or function. Both cases will \u000aresult in an immediate stop of the calibration with this alarm.{#]Solve problems for all pending alarms. Make sure the movements \u000ainvolved in the desired calibration are not locked. For this it might \u000abe necessary to move other components into appropriate \u000aendpositions. After this retry the desired calibration.
 ;
  erCalibrationCycleMissmatch
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Automatic calibration sequence is not done in correct order. Missing step: %1n.{#]Automatic calibration needs to be done in \u000aa specific order, which is not the case.{#]Basically the autocalibration must be done in a fixed sequence to get correct results. This alarm is displayed if a single calibration is started manually without executing the previous calibration steps. The autocalibration feature shows the required order of this steps.\u000aOnce the complete autocalibration is successfully finished, any \u000apart can be solitary executed. Because all steps which are previous steps for \u000aanother calibration are done.{#]Perform all automatic calibrations down to the desired calibration \u000abefore retrying.<br>\u000aAs an alternative the complete autocalibration can be run \u000abefore retrying.
 ;
  erCalibrationNotActivated
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n: Calibration not started. Movement not activated.{#]The movement which should be started for \u000acalibratin of a transducer is switched off.{#]It was tried to calibrate a machine device that is deactivated.{#]Activate the device on the according HMI mask.
 ;
  erVariableNotFound
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Device %1t%2n: variable %1s missing{#]The application requires a variable which \u000ais missing.{#]For various application parts variables are dynamically accessed during runtime. \u000aIf a required variable cannot be accessed this alarm is raised. In this case \u000aapplication software changes are indicated.{#]Please contact the machine manufacturer.
 ;
  erEndPosChangedWithoutMove
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// %1t%2n: Endposition changed without starting movement{#]The endposition state of a device changed \u000awithout starting the movement.{#]At all times the position and endposition of devices providing such sensor \u000afeedback is monitored. If the position changes without a deliberate command \u000afrom the control application this alarm is raised.\u000aThe underlying reason is most likely a hydraulic/mechanical problem. It is also \u000apossible that the output device (pump or drive) is not calibrated properly, giving \u000aan unintended movement output where the output should be zero.{#]Check the pump (or drive) output. In case the zero-output has a \u000aproblematic offset recalibrate the device.<br><br>\u000aIf all outputs are ok check the according hydraulic valves to locate \u000athe problem before retrying the desired operation.
 ;
  erVariableNotLinked
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink, %FU.evAlarmMotorLock  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Device %1t%2n: variable %1s not linked{#]A hardware endpoint system variable \u000aneeds to be configured for the IO board, \u000abut it is not.{#]Hardware endpoints are system variables used within the control application. \u000aThese variables also need to appear in the IO configuration to be 'linked'. If \u000asuch a variable is not linked, the application cannot operate properly. In this \u000acase an IO configuration or control application change is indicated.{#]Please contact the machine manufacturer.
 ;
  erStartCycleAfterProtectFailed
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Starting mold close after protect failed!{#]Retrying mold close after mold protect \u000afailed.{#]If mold protect is triggered and the user setting for {Mold1.sv_bOpenAfterProtect} is set to \u000aTRUE the mold will open after meeting a protect timeout. If the {system.sv_iSetMoldProtect} is set &gt; 0 the application will try to close the mold an according \u000anumber of times. In order to retry the cycle the operation mode will be brought \u000aback to full- or semi-automatic mode, depending on the active mode when \u000amold protect was triggered.<br>\u000aAt this point there could be problematic machine states signaled by alarms, \u000awhich can prevent the operation mode to be switched to semi- or full-automatic. \u000aIn this latter case this alarm will be raised.{#]Find the cause preventing the operation mode from switching \u000ato semi- or full-automatic mode. Check the endpositions of \u000amold, ejector and possibly cores. Check all active alarms in \u000aorder to find and solve the problems before retrying the desired \u000aoperation.
 ;
  erMaxMoveDevicesExceeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Too much movement devices registered (max: %1n), adapt limit in application{#]The maximum number of devices that \u000acan be registered within the application \u000ais exceeded.{#]The overall number of devices that can register within the control application \u000ais limited. This limit is exceeded by the current application software setup.{#]Please contact the machine manufacturer.
 ;
  erTooManyPumpsRegistered
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmLampBlink, %FU.evAlarmMotorLock, %FU.evAlarmWatchdog 
// Too many pumps registered. Adapt application!{#]The maximum number of pumps that \u000acan be registered within the application \u000ais exceeded.{#]The overall number of pumps that can register within the control application \u000ais limited. This limit is exceeded by the current application software setup.{#]Please contact the machine manufacturer.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
101 
@SysVar @RT(15)sv_dShotTimeAct @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)RTC Time of actual shot 
@RT(1)1 @RT(15)cLevelSuperUser @RT(25)VG_Production,VG_SPC_POST @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Shot time @RT(9)Shot time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_dShotTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)RTC Time of actual shot 
@RT(1)1 @RT(15)cLevelSuperUser @RT(25)VG_Production,VG_SPC_POST @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Shot time @RT(9)Shot time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bInitStart @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)Device registration finished - custom IEC initialisation can be started 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Init start @RT(20)Initialisation start @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bInitStart @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)Device registration finished - custom IEC initialisation can be started 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Init start @RT(20)Initialisation start @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_bInitDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)IEC initialisation is finished (after movement registration) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Init done @RT(19)Initialisation done @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_bInitDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)IEC initialisation is finished (after movement registration) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Init done @RT(19)Initialisation done @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_DataState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tnDataState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)State of machine / mold data read 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Data state @RT(10)Data state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_DataState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)State of machine / mold data read 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Data state @RT(10)Data state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_DataActionsEnable @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsDataActionsEnable @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(135)(bMoldDataLoad:=TRUE,bMoldDataSave:=TRUE,bMachineDataLoad:=TRUE,bMachineDataSave:=TRUE,bSequenceDataLoad:=TRUE,bSequenceDataSave:=TRUE) @RT(55)set enabled state of actions load/save mold/machinedata 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)enable data actions @RT(19)enable data actions @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(20)sv_DataActionsEnable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)State of machine / mold data read 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)enable data actions @RT(19)enable data actions @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_DataActionsEnable.bMachineDataLoad @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)enable machine data load @RT(24)enable machine data load @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_DataActionsEnable.bMachineDataSave @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)enable machine data save @RT(24)enable machine data save @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_DataActionsEnable.bMoldDataLoad @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)enable mold data load @RT(21)enable mold data load @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_DataActionsEnable.bMoldDataSave @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)enable mold data save @RT(21)enable mold data save @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_iDevicesToRegister @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)Number of devices to register 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Devices to register @RT(19)Devices to register @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_iDevicesToRegister @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)Number of devices to register 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Devices to register @RT(19)Devices to register @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_iMovementsToRegister @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)Number of Movements to register 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Movements to register @RT(21)Movements to register @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_iMovementsToRegister @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)Number of Movements to register 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Movements to register @RT(21)Movements to register @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_iRegistrationCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)Registrationcounter for delaytime generation 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Registration counter @RT(27)Registrated devices counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_iRegistrationCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)Registrationcounter for delaytime generation 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Registration counter @RT(27)Registrated devices counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_NumberOfDevices @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyNumberOfDevices @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Number of devices @RT(17)Number of devices @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_NumberOfDevices @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Number of devices @RT(17)Number of devices @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_TraceLevel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsTraceLevel @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(25)(bDebugCalibration:=TRUE) @RT(0) 
@RT(0) @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Trace level @RT(11)Trace level @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_TraceLevel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Trace level @RT(11)Trace level @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_TraceFilter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsTraceFilter @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(59)(DeviceFilter:=4((CompId:=cCompAll,IndexId:=cAllDevIndex))) @RT(0) 
@RT(0) @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Trace filter @RT(12)Trace filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_TraceFilter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Trace filter @RT(12)Trace filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_bTRUE @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(41)always true, used to set a reference true 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)True @RT(4)True @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(8)sv_bTRUE @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(41)always true, used to set a reference true 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)True @RT(4)True @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_bFALSE @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(43)always false, used to set a reference false 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)False @RT(5)False @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_bFALSE @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(43)always false, used to set a reference false 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)False @RT(5)False @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MovementsAvailable @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tyMovementRegisterList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_DeviceMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tDeviceMovementList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_OperationMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnOperationMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)nManual @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(20)OperationModeDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Operation mode @RT(14)Operation mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_OperationMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)enManual @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(20)OperationModeDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Operation mode @RT(14)Operation mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaximumPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)210.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Max. system pressure pump 1 @RT(27)Max. system pressure pump 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaximumPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(0) 
@RT(1)1 @RT(1)1 @RT(14)VG_MachineData @RT(5)fmt40 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Max. system pressure pump 1 @RT(27)Max. system pressure pump 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaximumVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. velocity @RT(16)Maximum velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaximumVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. velocity @RT(16)Maximum velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaxBackPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)210.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(21)InjectBackpressureABS @RT(10)NoRelative @RT(0) 
@RT(23)FPlausMaxInjectPressure @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. backpressure @RT(20)Maximum backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxBackPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(21)InjectBackpressureABS @RT(10)NoRelative @RT(0) 
@RT(23)FPlausMaxInjectPressure @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. backpressure @RT(20)Maximum backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_dCycleTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_dCycleTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_dCycleTimeMachine @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)act. cycle time machine 
@RT(1)1 @RT(2)16 @RT(25)VG_Production,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Cycle time machine @RT(18)Cycle time machine @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_dCycleTimeMachine @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(2)16 @RT(25)VG_Production,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Cycle time machine @RT(18)Cycle time machine @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_dMaxCycleTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#60s @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. cycle time @RT(18)Maximum cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_dMaxCycleTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#60s @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. cycle time @RT(18)Maximum cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dCalculatedCycleTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)calculated cycle time (written by machine sequencer) 
@RT(15)cLevelSuperUser @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dCalculatedCycleTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(15)cLevelSuperUser @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iShotCounterAct @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(6)fmt100 @RT(9)ShotCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Shotcounter @RT(11)Shotcounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iShotCounterAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(6)fmt100 @RT(9)ShotCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Shotcounter @RT(11)Shotcounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iProdCounterAct @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Prod.counter @RT(16)Productionounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iProdCounterAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Prod.counter @RT(16)Productionounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iShotCounterSet @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(10)shot limit 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt50 @RT(9)ShotCount @RT(0) @RT(0) 
@RT(8)1..99999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Shotcounter @RT(17)Shotcounter limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iShotCounterSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(10)shot limit 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt50 @RT(9)ShotCount @RT(0) @RT(0) 
@RT(8)1..99999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Shotcounter @RT(17)Shotcounter limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iProdCounterSet @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(10)shot limit 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(9)1..999999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Prod.counter limit @RT(23)Productioncounter limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iProdCounterSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(10)shot limit 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(9)1..999999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Prod.counter limit @RT(23)Productioncounter limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bUseProdCounter @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)use shot counter 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Use production counter @RT(22)Use production counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bUseProdCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)use shot counter 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Use production counter @RT(22)Use production counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_iShotCounterRetain @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)shot counter retain (used for lubrication) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt50 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Total shotcounter @RT(17)Total shotcounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_iShotCounterRetain @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)shot counter retain (used for lubrication) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt50 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Total shotcounter @RT(17)Total shotcounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bResetShotCounter @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Reset production counter @RT(24)Reset production counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_bResetShotCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Reset production counter @RT(24)Reset production counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_dCycleDelaySet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#0s..t#100s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cycle delay time @RT(16)Cycle delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_dCycleDelaySet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#0s..t#100s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cycle delay time @RT(16)Cycle delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_dCycleDelayAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Act. Cycle delay time @RT(21)Act. Cycle delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_dCycleDelayAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Act. Cycle delay time @RT(21)Act. Cycle delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_iPowerOnTime @RT(0) @T @F @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)total power on time in seconds 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt61 @RT(16)TimeHoursFromSec @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Power on time @RT(13)Power on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_iPowerOnTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt61 @RT(16)TimeHoursFromSec @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Power on time @RT(13)Power on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iFullAutoTime @RT(0) @T @F @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)full-automatic mode time in seconds 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt61 @RT(16)TimeHoursFromSec @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Full auto time @RT(14)Full auto time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iFullAutoTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt61 @RT(16)TimeHoursFromSec @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Full auto time @RT(14)Full auto time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dTransducerCalibTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#2s @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#100s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Calibration time @RT(16)Calibration time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dTransducerCalibTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#2s @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#100s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Calibration time @RT(16)Calibration time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCalibDifference @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)0.05 @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..99.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. calib difference @RT(30)Maximum calibration difference @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCalibDifference @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)0.05 @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..99.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. calib difference @RT(30)Maximum calibration difference @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_sSequenceData @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)'---' @RT(0) 
@RT(1)1 @RT(1)1 @RT(15)VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Sequence data @RT(18)Sequence data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_sSequenceData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(15)VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Sequence data @RT(18)Sequence data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_sMoldData @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)'---' @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Mold data @RT(14)Mold data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_sMoldData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Mold data @RT(14)Mold data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_sMachineData @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)'---' @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Machine data @RT(17)Machine data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_sMachineData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Machine data @RT(17)Machine data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_sMaterialData @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)'---' @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Material data @RT(18)Material data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_sMaterialData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Material data @RT(18)Material data name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bFirstCycle @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)First cycle @RT(21)First cycle is active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bFirstCycle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)First cycle @RT(21)First cycle is active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bAutoCycleRunning @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Autocycle running @RT(20)Autocycle is running @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_bAutoCycleRunning @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Autocycle running @RT(20)Autocycle is running @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bAllMotorsRunning @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)all motors are running 
@RT(1)1 @RT(0) @RT(0) @RT(12)MotorDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(18)All motors running @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_bAllMotorsRunning @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)all motors are running 
@RT(1)1 @RT(0) @RT(0) @RT(12)MotorDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(18)All motors running @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bReadConfigDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)reading of machine config from catalog done 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Read cfg done @RT(13)Read cfg done @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bReadConfigDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)reading of machine config from catalog done 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Read cfg done @RT(13)Read cfg done @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bDeviceRegisterDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)device registration finished 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Device reg. done @RT(24)Device registration done @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bDeviceRegisterDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)device registration finished 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Device reg. done @RT(24)Device registration done @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_dLastCycleTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_dLastCycleTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_dRefCycleTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_dRefCycleTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bMoveRegisterDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)movement registration finished 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Move reg. Done @RT(26)Movement registration done @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_bMoveRegisterDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)movement registration finished 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Move reg. Done @RT(26)Movement registration done @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_iCavities @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Cavity @RT(6)Cavity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_iCavities @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Cavity @RT(6)Cavity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bODCFilesChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(78)TRUE if ODC sequence should be reinitialized because the files on disk changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bODCFilesChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(77)TRUE if ODC sequence should be reinitialized because a program switch changed 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bProgramSwitchChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(77)TRUE if ODC sequence should be reinitialized because a program switch changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bProgramSwitchChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(77)TRUE if ODC sequence should be reinitialized because a program switch changed 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bActivationChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(91)TRUE if ODC sequence safety should be recalculated because a program switch was deactivated 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bActivationChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(77)TRUE if ODC sequence should be reinitialized because a program switch changed 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bOverrideCoreSafety @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(58)overrides safety settings for core movements in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Override core safety @RT(20)Override core safety @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bOverrideCoreSafety @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(58)overrides safety settings for core movements in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Override core safety @RT(20)Override core safety @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_bOverrideEjectorSafety @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(61)overrides safety settings for ejector movements in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Override ejector safety @RT(23)Override ejector safety @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_bOverrideEjectorSafety @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(58)overrides safety settings for core movements in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Override ejector safety @RT(23)Override ejector safety @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_bCalcMaxValuesFromCylData @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(117)TRUE: calculate max speed and max pressure values by using cylinder data;  FALSE: max values must be entered manually 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_rMaxPercentRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)120.0 @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPercentRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)120.0 @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMinPercentRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.1 @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMinPercentRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)120.0 @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_dDummyTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#2s @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_dDummyTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#2s @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_rNull @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(25)sv_bReadAddDeviceInfoDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)reading of additional device information done (by ODC1) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Read device info done @RT(32)Read additional device info done @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_bReadAddDeviceInfoDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)reading of machine config from catalog done 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Read device info done @RT(32)Read additional device info done @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_iEditorPropertiesChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)must be increased if properties, that are relevant for ODC editor, changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Properties changed @RT(29)ODC editor properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_iEditorPropertiesChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)properties that are relevant for ODC editor changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Properties changed @RT(29)ODC editor properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_bBadPart @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(11)PartQuality @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Actual Part Quality @RT(19)Actual Part Quality @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_bBadPart @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(11)PartQuality @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Actual Part Quality @RT(19)Actual Part Quality @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_BadPartReason @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnBadPartReason @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(13)BadPartReason @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Bad part reason @RT(15)Bad part reason @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_BadPartReason @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(13)BadPartReason @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Bad part reason @RT(15)Bad part reason @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_Production @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsProduction @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(52)(iRejectTimeSpan:=5,iGoodPartsPerReject:=2147483647) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(13)sv_Production @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_Production.iGoodPartsPerReject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)count parts until bad part 
@RT(0) @RT(0) @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Good parts per reject @RT(21)Good parts per reject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_Production.iRejectCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)number of bad parts 
@RT(0) @RT(0) @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Reject counter @RT(14)Reject counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_Production.iRejectTimeSpan @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)TimeMinutes @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Timespan for reject @RT(19)Timespan for reject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Production.iRejectsInSeries @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(49)increase if bad part, reset if to 0 if good part. 
@RT(0) @RT(0) @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Rejects in series @RT(17)Rejects in series @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_Production.iRejectsPerTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(64)actual number of rejected  parts per timespan (see next element) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Rejects per time @RT(16)Rejects per time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_bEmergencyStop @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)Common emergency stop signal. true if any emergency stop button is pressed 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Emg Stop @RT(14)Emergency Stop @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_bEmergencyStop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)Common emergency stop signal. true if any emergency stop button is pressed 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Emg Stop @RT(14)Emergency Stop @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bUseProgramSwitches @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(84)TRUE: create sequence by using program switches; FALSE: use sequence from ODC editor 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(27)VG_MoldData,VG_SequenceData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(37)system.hmi.UseProgramSwitchController 
@RT(22)Disable cycle designer @RT(22)Disable cycle designer @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bUseProgramSwitches @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(84)TRUE: create sequence by using program switches; FALSE: use sequence from ODC editor 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(27)VG_MoldData,VG_SequenceData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(37)system.hmi.UseProgramSwitchController 
@RT(22)Disable cycle designer @RT(22)Disable cycle designer @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bSimplifyProfileVis @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Simplify profile @RT(22)Simplify profile table @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bSimplifyProfileVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Simplify profile @RT(22)Simplify profile table @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_sPathMasterdisk @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)'\0' @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_sPathWorkspace @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)'\0' @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_sPathAppldisk @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)'\0' @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)sv_bIOParamInitDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_bCoresParallelToMold @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)cores should move parallel to mold  
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Cores parallel to mold @RT(22)Cores parallel to mold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bCoresParallelToMold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)cores should move parallel to mold  
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Cores parallel to mold @RT(22)Cores parallel to mold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bParallelCoreMovement @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(73)cores with the same mode (for example before close) should move parallel  
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Parallel core movement @RT(22)Parallel core movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bParallelCoreMovement @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)cores should move parallel to mold  
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Parallel core movement @RT(22)Parallel core movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bAutoCalibRunning @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)auto calibration active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(31)sv_rUnitPlaceHolderBackpressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)variable for HMI to get InjectBackpressure Unit 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(18)InjectBackpressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_rUnitPlaceHolderBackpressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)variable for HMI to get InjectBackpressure Unit 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(18)InjectBackpressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_iDurationUpdateInTolerance @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(79)counter is increased by ODC if duration is updated although it was in tolerance 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(25)sv_dAllowedCycleDeviation @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)t#200ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dAllowedCycleDeviation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_bODCCombinedMoveActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(87)TRUE: combined movement (for example closing sequence) is active (only in manual mode!) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_iActMoldProtectRetry @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_iSetMoldProtectRetry @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)0..9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Mold protect retry count @RT(24)Mold protect retry count @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_iSetMoldProtectRetry @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)0..9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Mold protect retry count @RT(24)Mold protect retry count @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bSkipCycleStartCond @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(30)sv_bPresMoldHeightAdjustActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)TRUE: mold adjust in mode nPressureOpenLoop is active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(22)sv_bTwoButtonOperation @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)TRUE: two startbuttons are linked; SV is set in OperationMode - FU 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_bStartButtonsPressed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(69)TRUE: both start buttons are pressed; SV is set in OperationMode - FU 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(13)sv_bEvenCycle @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)TRUE: even cycle, FALSE: odd cycle 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Even cycle @RT(10)Even cycle @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bEvenCycle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)TRUE: even cycle, FALSE: odd cycle 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Even cycle @RT(10)Even cycle @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_iLoopCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Loop counter @RT(12)Loop counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_iLoopCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Loop counter @RT(12)Loop counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_UserLevel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(16)actual userlevel 
@RT(1)1 @RT(2)16 @RT(0) @RT(7)fmtUser @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Userlevel @RT(9)Userlevel @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_UserLevel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)actual userlevel 
@RT(1)1 @RT(2)16 @RT(0) @RT(7)fmtUser @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Userlevel @RT(9)Userlevel @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bSequenceInterruption @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)TRUE: sequence is interrupted 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Sequence interruption @RT(21)Sequence interruption @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bSequenceInterruption @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Sequence interruption @RT(21)Sequence interruption @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_bStepBwdActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)TRUE: stepping bwd is active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_bReferenceClear @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(9)sv_iCpuId @RT(0) @T @F @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)0 @RT(22)cpu id (serial number) 
@RT(1)1 @RT(0) @RT(0) @RT(6)fmt100 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)CPU serial number @RT(17)CPU serial number @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_iCpuId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)0 @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(6)fmt100 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)CPU serial number @RT(17)CPU serial number @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_PumpData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tyPumpData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)sv_iPumpFlowChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)must be increased by every pump if sv_rAbsFlow is changed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_iPumpPressureChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(61)must be increased by every pump if sv_rMaxPressure is changed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(21)sv_PumpConnectionList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tsPumpConnectionList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_bProfileEditorActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)"profile dirty" flag (will be set / reset by HMI)  
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Profile editor active @RT(21)Profile editor active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bProfileEditorActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)"profile dirty" flage (will be set / reset by HMI) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Profile editor active @RT(21)Profile editor active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_bRecalcPendingOrActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(169)The ODC wants to recalc the sequence or a recalc is currently active. Any evStartRequest sent at this time can potentially be ignored if recalculation is already active. 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(24)sv_LockOperationModeAuto @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tsLockOperationModeAuto @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_LockDataState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsResourceLock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(24)sv_iReadMachineDataCount @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(63)counter which is increased after every loading of machine data  
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_iReadMachineDataCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(63)counter which is increased after every loading of machine data  
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_iReadMoldDataCount @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)counter which is increased after every loading of mold data  
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_iReadMoldDataCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)counter which is increased after every loading of mold data  
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
44 
@SysEvent @RT(16)evAlarmLampBlink @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(16)evAlarmLampReset @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(25)evAlarmFinishCycleAndStop @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(43)finish cycle and then switch to manual mode 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)evAlarmFinishCycleAndStop @RT(0) @F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(43)finish cycle and then switch to manual mode 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 


@SysEvent @RT(17)evAlarmAutoManual @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(47)stop cycle and switch to manual mode immediatly 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)evAlarmAutoManual @RT(0) @F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(47)stop cycle and switch to manual mode immediatly 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 


@SysEvent @RT(15)evAlarmAutoHalf @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(48)finish cycle switch to half auto mode immediatly 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)evAlarmAutoHalf @RT(0) @F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(47)stop cycle and switch to manual mode immediatly 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 


@SysEvent @RT(16)evAlarmMotorLock @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(39)stop motor and don´t allow switching on 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)evAlarmMotorLock @RT(0) @F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(39)stop motor and don´t allow switching on 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 


@SysEvent @RT(19)evAlarmMotorRelease @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(46)release motor (switching on is possible again) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)evAlarmMotorRelease @RT(0) @F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(46)release motor (switching on is possible again) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 


@SysEvent @RT(16)evDeviceRegister @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tevDeviceRegister @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(18)evMovementRegister @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tevMovementRegister @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(12)evLockUnlock @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tevLockUnlock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(17)evLockUnlockGroup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tevLockUnlockGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(16)evStartedStopped @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tevStartedStopped @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(15)evMovementState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tevMovementState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(15)evCheckLocklist @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tevCheckLocklist @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(74)check the locklist of a movement and set alarms(if the movement is locked) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(7)evStart @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tevStart @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(6)evStop @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tevStop @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(14)evStartRequest @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tevStartRequest @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(13)evStopRequest @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tevStopRequest @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(15)evOutputRequest @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tevOutputRequest @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(16)evOutputResponse @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tevOutputResponse @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(11)evAnaDevCmd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tevAnaDevCmd @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(16)evAnaDevResponse @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tevAnaDevResponse @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(14)evAlarmConfirm @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tevAlarmConfirm @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(12)evCycleStart @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tevCycleStart @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(17)evNewCycleStarted @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tevCycleStart @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(34)New machine cycle has been started 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(17)evCoreTypeChanged @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tevCoreTypeChanged @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(12)evSafetyGate @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tevSafetyGate @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(11)evRedoStart @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tevRedoEvent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(9)evProtect @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tevProtect @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(18)evInterCondChanged @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tevInterCondChanged @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(76)sent when intermediate condition changes (for example: new core in position) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(11)evPartCheck @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tevPartCheck @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(56)sent by a quality check FU to mark a part as good or bad 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(15)evEmergencyStop @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tevEmergencyStop @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(117)sent by any emergencystop handler (eg. Robot interface) when the emergencystop is pressed. Received by OperationMode1 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(15)evAlarmWatchdog @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(39)watchdog opend by execptioninterpration 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(16)evRedoIdentStart @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tevRedoIdentEvent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(24)evRedoIdentMaxSpeedStart @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tevRedoIdentSpeedEvent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(24)evRedoIdentMinSpeedStart @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tevRedoIdentSpeedEvent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(24)evLockGroupEnableDisable @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tevLockGroupEnableDisable @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(10)evUsbEvent @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)KPUSB_Event @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(36)USB attach/detach notification event 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(19)evSequenceInterrupt @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tevSequenceInterrupt @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(11)evHoldScrap @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tevHoldScrap @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(19)evReleaseSinglePump @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tevReleaseSinglePump @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(21)evInterruptActivePump @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tevInterruptActivePump @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(19)evRequestSinglePump @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tevRequestSinglePump @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(27)evModifyCycleStartCondition @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(28)tevModifyCycleStartCondition @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(60)event can be sent for modification of cycle start conditions 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
48 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(11)erDeviceReg @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(302)Device registration error{#]An Error within the initial device registration \u000aprevents any further machine operation.{#]All devices will register themselves within the control application. In this case a problem occurred during the registration procedure.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erMultipleDeviceReg @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(248)Multiple device registration: %1t%2n{#]A device tried to register multiple times.{#]Each device can only register once. In this case a device tried to register \u000amultiple times which should not happen.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erMaxDeviceIndexExeeded @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(386)Too much devices of component %1t registered. (max: %2n){#]The maximum number of devices per \u000acomponent that can be registered within \u000athe application is exceeded.{#]For each machine component a number of such devices can be registered \u000awithin the control application. This number is exceeded for a certain \u000acomponent type.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erMaxCompIdExeeded @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(415)Too much components registered. (max: %1n){#]The maximum number of components that \u000acan be registered within the application \u000ais exceeded.{#]Each device type carries a component ID. For example each core carries the \u000acomponent ID for cores overall. There is a maximum component ID \u000awhich must not be exceeded, which is the case if this alarm is raised.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erMaxMovementsExeeded @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(343)Too much movements in device %1t%2n registered. (max: %3n){#]The maximum number of movements per \u000adevice that can be registered within \u000athe application is exceeded.{#]Each device can contain several movements. The maximum number of \u000asuch movements is limited and exceeded in this case.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erMaxMoveRegisteredExeeded @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(356)Too much movements registered. (max: %1n){#]The maximum number of movements that \u000acan be registered within the application \u000ais exceeded.{#]The overall number of movements that can register within the control application \u000ais limited. This limit is exceeded by the current application software setup.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erNoSvDeviceId @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(290)Device registration error: "sv_DeviceId" missing of FU %1s{#]A basic device variable is missing.{#]Registration of a device is only possible with the application internal \u000asv_DeviceId variable. This alarm is raised if the variable is missing.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erLockListSizeExeeded @RT(1)1 @RT(1)y @RT(21)%FU.evAlarmAutoManual @RT(0) @RT(11)Application @RT(511)ABLockList: Locklist-size exceeded. (max : %1n){#]A movement should be locked, but the \u000alocklist storing all lock events is full.{#]Movements are locked by other movements. All such locks are stored within the \u000aso called locklist. If the maximum size of the locklist is exceeded the alarm is raised.{#]Try to operate the machine in a way that produces less problematic \u000alock situations.<br>\u000aIf this alarm is frequently raised without intention, please contact the \u000amachine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(10)erNoSvMove @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(296)Movement initialisation error in device %1t: "sv_MoveXxx" missing{#]A basic device variable is missing.{#]Registration of a device is only possible with the application internal \u000asv_MoveXxx variable. This alarm is raised if the variable is missing.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erNoSvDeviceReady @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(306)Movement initialisation error in device %1t: "sv_bDeviceReady" missing{#]A basic device variable is missing.{#]Registration of a device is only possible with the application internal \u000asv_bDeviceReady variable. This alarm is raised if the variable is missing.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erDeviceActive @RT(1)3 @RT(1)y @RT(21)%FU.evAlarmAutoManual @RT(0) @RT(4)User @RT(496)Device %1t%2n already active!{#]A movement cannot be started because \u000athe device is already active.{#]A movement of a certain device should be started while the same or another \u000amovement of this device is already active. One device can only perform one \u000amovement at a time.{#]Wait for the device to become inactive before retrying the desired \u000aoperation.<br>\u000aIf this alarm is frequently raised without a recognizable reason, \u000aplease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erInitNotReady @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(436)%1t%2n: Initialisation active{#]Initialization of the control application is \u000astill active. No movements possible during \u000athis stage of bootup.{#]After the controller finished booting the control application itself is starting. The \u000ainitialization is one of the first stages of this process. During initialization no \u000amovements are possible.{#]Wait for initialization to finish before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erMovementRegistrationTimeout @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(395)Timeout during movement registration!{#]Not all expected movements registered \u000awithin the preset timeout.{#]At this point the application is waiting for further expected movements to register. \u000aWithin a given timeout the registration doesn't happen, thus the alarm is raised.{#]Try to reboot the controller.<br>\u000aIf the alarm still appears, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erSwitchToManual @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(215)Switch to manual - mode{#]The required action is not possible because the machine is not in manual mode.{#]Some actions are only possible if the machine is in manual mode.{#]Change the operation mode to manual mode. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erProdLimitReached @RT(1)3 @RT(1)y @RT(29)%FU.evAlarmFinishCycleAndStop @RT(0) @RT(4)User @RT(521)Number of pieces to produce reached{#]The set number of parts to produce is \u000areached.{#]This is just a message and does not indicate a problem.<br>\u000aAccording to the cavities setting and the production counter the number \u000aof produced parts is calculated. This counter is then compared to the \u000aproduction limit setting in order to generate this message.{#]This is just a message, no action required.<br>\u000aA new production process can be started, a new {system.sv_iProdCounterSet:l} \u000acan be set. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erCycleTimeExceeded @RT(1)3 @RT(1)y @RT(42)%FU.evAlarmAutoManual,%FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(421)Cycle time exceeded{#]The current cycle time exceeds the maximum cycle time.{#]The current cycle execution time is limited by the user setting of maximum \u000acycle time. If this maximum time is exceeded the alarm is given.{#]Increase the {system.sv_dMaxCycleTime} setting.<br>\u000aIf this is not allowed try to find component movements which can be \u000aoptimized in order to run the cycle within maximum limitations. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erListOverflow @RT(1)1 @RT(1)y @RT(42)%FU.evAlarmLampBlink, %FU.evAlarmMotorLock @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(356)%1t%2n: List overflow in "%1s" !{#]An application internal list ran into an \u000aoverflow.{#]Several features of the control application use lists. If an element is added to \u000asuch a list, which is already full, this overflow alarm is raised. This problem \u000aneeds to be solved by an application engineer.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erAnalogInput @RT(1)1 @RT(1)y @RT(21)%FU.evAlarmAutoManual @RT(0) @RT(20)User and Application @RT(586)Sensor error in: %1t%2n Endpoint: %1s, check terminal and wiring %2s{#]An analog sensor input signals an invalid \u000ainput value.{#]The status flag of an analog input signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.\u000aWithout a working sensor feedback the according measurement is stopped, \u000aprobably also causing a lock on other movements.{#]Check the feedback of the sensor in the IO monitor.\u000aThen check the according hardware including the terminal and its wiring. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erMovementNotAvailable @RT(1)3 @RT(1)y @RT(21)%FU.evAlarmAutoManual @RT(0) @RT(4)User @RT(450)Movement not available: Device: %1t%2n, MoveId: %3n, MoveDir: %4n{#]A movement should be started which \u000adoesn't exist.{#]According to the knowledge of the registration lists of the control application \u000athe movement that should be started is unknown.{#]After confirmation of the alarm further operation is possible.<br><br>\u000aBecause of the application internal character of the alarm cause, \u000aplease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erCalibrationNotEnoughValues @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(598)Not enough values captured for parameter detection of PID controller{#]During screw movement at autocalibration for inject and hold PID-identification to less numbers of actual pressure values are measured.{#]During autocalibration reference pressure profiles with different steps are used to calculate PID-values of the pressure controllers. The step response of the actual pressure is analyzed.<br>Inject-PID: If screw velocity is very high and screw stroke is low to less measure points are recorded.<br>Hold-PID: Reference pressure steps are to short.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erCalibrationDataFailure @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(483)No meaningful data during calibration.{#]Calculation of PID-values for pressure controller precutoff and hold can't be calculated.{#]During autocalibration reference pressure profiles with different steps are used to calculate PID-values of the pressure controllers.<br>The step response of the actual pressure is analyzed. If the actual pressure can't follow the reference the calculation of the PID-values fails.{#]Start calibration of pressure controller for inject or hold again. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erUserLevelLow @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(319)Userlevel %1i required!{#]The current user level is too low to \u000aperform the desired operation.{#]Certain functionalities are only available to higher user levels. If such a \u000afunctionality is used with a lower user level this alarm is raised.{#]Log in with a user level equal or higher than the required level. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erSetupModeRequired @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(348)Setup mode required{#]Certain movements are only possible in \u000aoperation mode 'setup'.{#]A number of movements, including all autocalibration movements, require the \u000aoperation mode 'setup' to be active. Otherwise the according movements are \u000anot allowed.{#]Change to operation mode 'setup' before retrying the desired \u000aoperation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erSetupModeRequiredForCalib @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(324)Calibration not possible, setup mode required{#]Autocalibration feature is only available in operation mode 'setup'.{#]Any calibration movement requires the operation mode 'setup' to be active. Otherwise the according movements are not allowed.{#]Change to operation mode 'setup' before retrying the desired \u000aoperation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erSetupModeRequiredForAdjust @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(372)%1t movement not possible, setup mode required{#]Adjustment movements are only possible in operation mode 'setup'.{#]Adjustment functionalities, for example mold height adjustment, require the \u000aoperation mode 'setup' to be active. Otherwise the according movements are \u000anot allowed.{#]Change to operation mode 'setup' before retrying the desired \u000aoperation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erTransducerCalibNoMovement @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(962)%1t%2n: no movement detected during transducer calibration, check movement in setup mode{#]Too little reaction came from a device \u000aduring transducer calibration.{#]The calibration feature is moving a device for example forward and backward \u000ain order to measure the voltage values corresponding to zero position and \u000afull stroke. If the two voltages are (almost) equal the application can assume \u000ano movement actually happened. It is also possible that the transducer feedback \u000ais corrupt because of wiring, terminal or malfunctioning transducer hardware.{#]Check the problematic movement manually in setup mode. Is the \u000adevice moving, but the input voltage does not change, check the \u000awiring, terminal and transducer hardware.<br>\u000aIf the device is not moving try to increase the problematic movements \u000asetup mode output settings and possibly check the according pump calibration by moving other devices in setup mode. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erRPMCalibNoMovement @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(616)No movement detected during RPM calibration, check impulse sensor and plast movement in setup mode{#]Too little RPM reaction for calibration.{#]During calibration the application cannot find enough RPM change while \u000atrying to rotate the screw.<br>\u000aMost likely there is a problem with the impulse sensor feedback.{#]Try a plasticizing movement in operation mode setup to find possible \u000aproblems. Check the {Injection1.di_ImpulseInput} feedback value in the \u000aIO monitor.<br>\u000aIf there is no feedback check the terminal, wiring and possibly the \u000asensor itself before retrying a calibration. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(8)erAssert @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(295)Assert!{#]An internal error regarding movement \u000ahandling is active.{#]Serious control application problems regarding movement handling are covered \u000aby this alarm. The detailed cause must be analyzed by an according \u000aapplication engineer.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erPumpPresCalibNoValueChange @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(805)No pressure change detected during pump pressure calibration, check pressure sensor and lintab{#]Too little pressure reaction for calibration.{#]During calibration the application cannot find any pressure change while \u000agiving an output pressure.<br>\u000aMost likely the reason is a bad linearization table setting for pressure sensor \u000areading. It is also possible that there is a problem at the terminal or the wiring\u000aof the sensor, or even the sensor itself.{#]Check the IO monitor for pressure output voltage given. Also check \u000athe voltage measured by the pressure sensor.<br>\u000aIf these two are ok, check the linearization table setting of the \u000aaccording pressure sensor.<br>\u000aOtherwise check the pressure sensor itself for problems before\u000a retrying a calibration. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erPumpVelCalibNoValueChange @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(800)No position change detected during pump velocity calibration, check transducer and lintab and inject movement in setup mode{#]Too little velocity reaction for calibration.{#]During calibration the application cannot find enough velocity change while \u000atrying to move the selected calibration axis.<br>\u000aMost likely the reason is a bad linearization table setting for the according axis\u000atransducer. There could also be a hardware problem.{#]Try a movement of the according axis in operation mode setup to find\u000apossible problems.<br>\u000aCheck the IO monitor for velocity output voltage given.<br>\u000aIf this is ok, check the linearization table setting of the \u000aaccording axis transducer.<br>\u000aOtherwise check the hardware for problems before\u000a retrying a calibration. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erCalibrationFailure @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(223)Failure at calibration.{#]Transducer calibration can't be finished.{#]During transducer calibration no movement is possible.{#]Check output to actuators (all required valves are opened, torque and reference speed to drive). 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erCalibrationWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(432)Warning: Calibration successful, but result might be problematic.{#]The calculation of the pressure PID-parameters is done successfully. A little change of the values would cause invalid values for the PID-parameters.{#]The PID-parameters are calculated from analyzed measure data.<br>The calculation can still be done but if a measured quantity has different values the calculation would not be possible.{#]Start calibration again. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erCalibrationRPMNotStable @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(382)Failure at calibration because measured screw rpm not stable, send statusreport to manufacturer{#]The measured actual revolution of the screw is not stable during observation time.{#]During RPM-calibration the output to the actuator is increased step-by-step.<br>At each step the actual revolution must be stable after short reaction time.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erCalibrationPressureNotStable @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(449)Failure at calibration because measured pressure not stable, send statusreport to manufacturer{#]During calibration of the pump pressure the actual pressure is not stable enough.{#]At pressure calibration the pressure valve is opened using constant control value. As result the actual pressure has to be stable after short reaction time.<br>If the pressure doesn't get stable measurement has to be stopped.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erCalibrationVelocityNotStable @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(457)Failure at calibration because measured velocity not stable, send statusreport to manufacturer{#]During calibration of the pump velocity the actual screw velocity is not stable enough.{#]At velocity calibration the flow valve is opened using constant control value. As result the actual screw velocity has to be stable after short reaction time.<br>If the velocity doesn't get stable measurement has to be stopped.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erPIDCalcVelocityNotStable @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(427)Failure at inject closed loop parameter detection because measured velocity not stable, send statusreport to manufacturer{#]During calibration of the screw velocity controller the actual screw velocity is not stable enough.{#]At velocity calibration the flow valve is opened using constant control value. As result the actual screw velocity has to be stable after short reaction time.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erPIDCalcPressureNotStable @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(385)Failure at hold closed loop parameter detection because measured pressure not stable, send statusreport to manufacturer{#]Measured pressure at hold pressure calibration is not stable.{#]At pressure calibration the pressure valve is opened using constant control value. As result the actual pressure has to be stable after short reaction time.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erPIDParamDetectionError @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(324)Failure at closed loop parameter detection, send statusreport to manufacturer{#]Failure at velocity calibration.{#]There are some failures during velocity calibration possible:<br>- no constant movement possible<br>- parametrization of filter<br>- parametrization of differentiator{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erCalibrationStopped @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(744)Calibration stopped because of pending alarm(s){#]There are alarms pending or one of the \u000acalibration movements is locked, \u000apreventing any autocalibration.{#]To allow execution of the autocalibration the number of active alarms must be 0. \u000aAlso autocalibration is only executed if all involved movements are free to \u000aoperate and not locked by any other movement or function. Both cases will \u000aresult in an immediate stop of the calibration with this alarm.{#]Solve problems for all pending alarms. Make sure the movements \u000ainvolved in the desired calibration are not locked. For this it might \u000abe necessary to move other components into appropriate \u000aendpositions. After this retry the desired calibration. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erCalibrationSpeedStopped @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(750)Calibration stopped because of pending alarm(s) (%1i){#]There are alarms pending or one of the \u000acalibration movements is locked, \u000apreventing any autocalibration.{#]To allow execution of the autocalibration the number of active alarms must be 0. \u000aAlso autocalibration is only executed if all involved movements are free to \u000aoperate and not locked by any other movement or function. Both cases will \u000aresult in an immediate stop of the calibration with this alarm.{#]Solve problems for all pending alarms. Make sure the movements \u000ainvolved in the desired calibration are not locked. For this it might \u000abe necessary to move other components into appropriate \u000aendpositions. After this retry the desired calibration. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erCalibrationCycleMissmatch @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(816)Automatic calibration sequence is not done in correct order. Missing step: %1n.{#]Automatic calibration needs to be done in \u000aa specific order, which is not the case.{#]Basically the autocalibration must be done in a fixed sequence to get correct results. This alarm is displayed if a single calibration is started manually without executing the previous calibration steps. The autocalibration feature shows the required order of this steps.\u000aOnce the complete autocalibration is successfully finished, any \u000apart can be solitary executed. Because all steps which are previous steps for \u000aanother calibration are done.{#]Perform all automatic calibrations down to the desired calibration \u000abefore retrying.<br>\u000aAs an alternative the complete autocalibration can be run \u000abefore retrying. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erCalibrationNotActivated @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(264)%1t%2n: Calibration not started. Movement not activated.{#]The movement which should be started for \u000acalibratin of a transducer is switched off.{#]It was tried to calibrate a machine device that is deactivated.{#]Activate the device on the according HMI mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erVariableNotFound @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(356)Device %1t%2n: variable %1s missing{#]The application requires a variable which \u000ais missing.{#]For various application parts variables are dynamically accessed during runtime. \u000aIf a required variable cannot be accessed this alarm is raised. In this case \u000aapplication software changes are indicated.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erEndPosChangedWithoutMove @RT(1)3 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(847)%1t%2n: Endposition changed without starting movement{#]The endposition state of a device changed \u000awithout starting the movement.{#]At all times the position and endposition of devices providing such sensor \u000afeedback is monitored. If the position changes without a deliberate command \u000afrom the control application this alarm is raised.\u000aThe underlying reason is most likely a hydraulic/mechanical problem. It is also \u000apossible that the output device (pump or drive) is not calibrated properly, giving \u000aan unintended movement output where the output should be zero.{#]Check the pump (or drive) output. In case the zero-output has a \u000aproblematic offset recalibrate the device.<br><br>\u000aIf all outputs are ok check the according hydraulic valves to locate \u000athe problem before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erVariableNotLinked @RT(1)1 @RT(1)y @RT(65)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink, %FU.evAlarmMotorLock @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(512)Device %1t%2n: variable %1s not linked{#]A hardware endpoint system variable \u000aneeds to be configured for the IO board, \u000abut it is not.{#]Hardware endpoints are system variables used within the control application. \u000aThese variables also need to appear in the IO configuration to be 'linked'. If \u000asuch a variable is not linked, the application cannot operate properly. In this \u000acase an IO configuration or control application change is indicated.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erStartCycleAfterProtectFailed @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(1063)Starting mold close after protect failed!{#]Retrying mold close after mold protect \u000afailed.{#]If mold protect is triggered and the user setting for {Mold1.sv_bOpenAfterProtect} is set to \u000aTRUE the mold will open after meeting a protect timeout. If the {system.sv_iSetMoldProtect} is set &gt; 0 the application will try to close the mold an according \u000anumber of times. In order to retry the cycle the operation mode will be brought \u000aback to full- or semi-automatic mode, depending on the active mode when \u000amold protect was triggered.<br>\u000aAt this point there could be problematic machine states signaled by alarms, \u000awhich can prevent the operation mode to be switched to semi- or full-automatic. \u000aIn this latter case this alarm will be raised.{#]Find the cause preventing the operation mode from switching \u000ato semi- or full-automatic mode. Check the endpositions of \u000amold, ejector and possibly cores. Check all active alarms in \u000aorder to find and solve the problems before retrying the desired \u000aoperation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erMaxMoveDevicesExceeded @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(386)Too much movement devices registered (max: %1n), adapt limit in application{#]The maximum number of devices that \u000acan be registered within the application \u000ais exceeded.{#]The overall number of devices that can register within the control application \u000ais limited. This limit is exceeded by the current application software setup.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erTooManyPumpsRegistered @RT(1)1 @RT(1)y @RT(63)%FU.evAlarmLampBlink, %FU.evAlarmMotorLock, %FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(352)Too many pumps registered. Adapt application!{#]The maximum number of pumps that \u000acan be registered within the application \u000ais exceeded.{#]The overall number of pumps that can register within the control application \u000ais limited. This limit is exceeded by the current application software setup.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
