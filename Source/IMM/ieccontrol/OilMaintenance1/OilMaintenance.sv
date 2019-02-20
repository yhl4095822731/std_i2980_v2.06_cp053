(*
/*-------------------------------------------------------------------------
 *                         (c) 2003 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : moldmachine - demoapplication
 *    First Author : roe
 *    Date         : 24.04.2003
 *    $Author: Ltr $
 *    $Revision: 5 $
 *    $Modtime: 5.01.07 9:36 $
 *    $Archive: /ApplicationFrames/KePlast/APPL/ApplMoldMachineKeplast_i4030/keplast/ieccontrol/OilMaintenance1/OilMaintenance.sv $
 *--------------------------------------------------------------------------*/
*)

%IMPORT_OVER_LISTFILE_SOURCE
 Temperature
, fmt30
, VG_MachineData
, RisingFalling
, Time
, fmt31
, TempSensorType

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tnRisingFalling
, KHW_TempSensor
, nRisingEdge
, KHW_TempSensor_NiCrNi
, cLevelServiceEngineer
, cLevelStartupTechnican
, cLevelProcessOperator
, KHW_TempSensor_FeCuNiDIN
, KHW_TempSensor_FeCuNiIEC

END_IMPORT

%SYSTEMVAR_DECL
  sv_rTempStartCooling : REAL := 50.0
 %PLAUSIBILITY %FU.sv_rTempStopCooling..999.99    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT Temperature 
// Start cooling Start oil cooling
;
 sv_rTempStopCooling : REAL := 45.0
 %PLAUSIBILITY 0.0..%FU.sv_rTempStartCooling    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT Temperature 
// Stop cooling Stop oil cooling
;
 sv_rAlarmTemp : REAL := 60.0 (* alarm temperature oil temp high *)
 %PLAUSIBILITY %FU.sv_rWarnTempTooHigh..99.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT Temperature 
// Alarm temp. high Alarm temp. high
;
 sv_rAlarmTempTooLow : REAL := 15.0 (* alarm temperature oil temp low *)
 %PLAUSIBILITY 0.0..%FU.sv_rWarnTempTooLow    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT Temperature 
// Alarm temp. low Alarm temp. low
;
 sv_rWarnTempTooHigh : REAL := 55.0 (* warning temperature oil temp high *)
 %PLAUSIBILITY %FU.sv_rWarnTempTooLow..%FU.sv_rAlarmTemp    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT Temperature 
// Warning temp. high Warn temperature oil high
;
 sv_rWarnTempTooLow : REAL := 20.0 (* warning temperature oil temp low *)
 %PLAUSIBILITY %FU.sv_rAlarmTempTooLow..%FU.sv_rWarnTempTooHigh    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT Temperature 
// Warning temp. low Warn temperature oil low
;
 sv_FilterMode : tnRisingFalling := nRisingEdge
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT RisingFalling 
// Oil filter error mode Oil filter error mode
;
 sv_dFilterAlarmTime : TIME := t#10s
 %PLAUSIBILITY T#100ms..T#99s900ms    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Oil filter monitor time Oil filter monitor time oil filter
;
 sv_OilLevelMode : tnRisingFalling (* TRUE = error if DI on >> *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT RisingFalling 
// Oil level error mode Oil level error mode
;
 sv_dOilLevelTime : TIME := t#10s
 %PLAUSIBILITY T#100ms..T#99s900ms    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Oil level monitor time Oil level monitor time
;
 sv_OilTempSensorType : KHW_TempSensor := KHW_TempSensor_NiCrNi
 %PLAUSIBILITY KHW_TempSensor_FeCuNiIEC,KHW_TempSensor_NiCrNi,KHW_TempSensor_FeCuNiDIN    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT TempSensorType 
// Sensor type Sensor type
;
 sv_bUseReturnLineFilter : BOOL
   RETAIN  %VARIABLE_GROUP VG_MachineData 
// Use return line oil filter Use return line oil filter
;
 sv_dReturnLineFilterAlarmTime : TIME
 %PLAUSIBILITY T#0s..T#100s    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Monitor time Monitor time return line oil filter
;
%END

%SYSTEM_ALARM
  erOilLevelLow
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// Oil level low{#]Oil level is low.{#]When the oil level low signal rises this alarm is raised and the motor is stopped immediately. \u000aUsually the oil needs to be filled. In rare cases the sensor feedback, wiring or \u000aterminal can be the problem.{#]Check the oil level and if necessary fill the oil.<br>\u000aIf the oil level is ok check the wiring and terminal as well as the \u000asensor feedback in the IO monitor masks.
 ;
  erOilFilterNotOk
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop,system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Oilfilter clogged up{#]Oilfilter is clogged up.{#]When the oil filter clogged up signal rises this alarm is raised. If the machine is \u000acurrently in production, the current autocycle is finished and the machine stops \u000aafterwards. Usually the oil filter needs to be cleaned/replaced before operation\u000acan be continued.<br>\u000aIn rare cases also the feedback, wiring or terminal might be the problem.{#]Check the oil filter and clean/replace it.<br>\u000aIf the oil filter is ok check the wiring and terminal as well as the \u000asensor feedback in the IO monitor masks.
 ;
  erOilTempHigh
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmLampBlink,system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset,system.evAlarmMotorRelease 
// Oil Temperature too high!{#]Oil temperature is too high for further \u000amovements.{#]If the oil temperature exceeds the alarm temperature setting the motor is locked \u000aand no further movement is possible.{#]Wait for the oil temperature to get back within limits. If cooling is \u000aavailable make sure it operates properly.<br><br>\u000aIs the oil temperature within allowable operation temperature range \u000awhen the alarm is raised the {OilMaintenance1.sv_rAlarmTemp} can be adjusted to \u000afit the machine and process requirements.
 ;
  erOilTempLow
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Oil Temperature too low!{#]Oil temperature is too low for autocycle.{#]The oil temperature is too low to operate the machine in autocycle. Movements in manual mode or in setup mode are possible.{#]Start oil-preheating to increase the oil temperature.<br>\u000aIf the oil temperature is within set point tolerance range the \u000a{OilMaintenance1.sv_rAlarmTempTooLow} limit setting can be adjusted accordingly.
 ;
  erOilTempHighWarning
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Oil Temperature high!{#]Oil temperature is close to exceed alarm \u000alimits.{#]This is just a message. Although normal operation is possible at this point it is \u000astrongly recommended to apply all necessary steps to bring the oil temperature \u000adown to operate within allowable limits.{#]This is just a message, but an action is indicated.<br>\u000aIf cooling is available make sure it operates properly. If the oil \u000atemperature is actually not exceeding warning limits while this alarm \u000ais raised the {OilMaintenance1.sv_rWarnTempTooHigh} setting can be adjusted to fit \u000athe machine and process requirements.
 ;
  erOilTempLowWarning
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Oil Temperature low!{#]Oil temperature is low for operation.{#]This is just a message. Although normal operation is possible at this point it is \u000arecommended to try the provided solution suggestions.{#]Start oil-preheating before trying to perform hydraulic movements.<br>\u000aIf the oil temperature is within set point tolerance range the \u000a{OilMaintenance1.sv_rWarnTempTooLow} limit setting can be adjusted accordingly.
 ;
  erOilSensorProblem
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Problem with oil temp. sensor, check terminal and wiring %1s{#]An error occurred on the oil temperature input hardware endpoint.{#]The status flag of the TI temperature input for oil temperature signals an error state. The problem can be at the specific hardware, wiring, terminal or the \u000ainvolved IO board of the controller.{#]Check the hardware endpoint information and state in the IO monitor. \u000aExamine the wiring, terminal and hardware connected to the output. If controller external causes can be ruled out further help is required.<br>\u000aPlease contact the machine manufacturer.
 ;
  erReturnLineOilFilterNotOk
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop,system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Problem with the Return line Oil Filter{#]Return line oil filter is clogged up.{#]When the return line oil filter clogged up signal rises this alarm is raised. If the machine is currently in production the current autocycle is finished and the machine stops afterwards. Usually the return line oil filter needs to be cleaned/replaced before operation can be continued.<br>\u000aIn rare cases also the feedback, wiring or terminal might be the problem.{#]Check the return line oil filter and clean/replace it.<br>\u000aIf the return line oil filter is ok check the wiring and terminal as well as the sensor feedback in the IO monitor masks.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 113 @Sve 25 
@@@BEG_Comment@@@
/*-------------------------------------------------------------------------
 *                         (c) 2003 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : moldmachine - demoapplication
 *    First Author : roe
 *    Date         : 24.04.2003
 *    $Author: Ltr $
 *    $Revision: 5 $
 *    $Modtime: 5.01.07 9:36 $
 *    $Archive: /ApplicationFrames/KePlast/APPL/ApplMoldMachineKeplast_i4030/keplast/ieccontrol/OilMaintenance1/OilMaintenance.sv $
 *--------------------------------------------------------------------------*/
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
13 
@SysVar @RT(20)sv_rTempStartCooling @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(31)%FU.sv_rTempStopCooling..999.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Start cooling @RT(17)Start oil cooling @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rTempStartCooling @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(31)%FU.sv_rTempStopCooling..999.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Start cooling @RT(17)Start oil cooling @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rTempStopCooling @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)45.0 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(29)0.0..%FU.sv_rTempStartCooling @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Stop cooling @RT(16)Stop oil cooling @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rTempStopCooling @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(29)0.0..%FU.sv_rTempStartCooling @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Stop cooling @RT(16)Stop oil cooling @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_rAlarmTemp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)60.0 @RT(31)alarm temperature oil temp high 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(29)%FU.sv_rWarnTempTooHigh..99.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Alarm temp. high @RT(16)Alarm temp. high @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_rAlarmTemp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(29)%FU.sv_rWarnTempTooHigh..99.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Alarm temp. high @RT(16)Alarm temp. high @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rAlarmTempTooLow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)15.0 @RT(30)alarm temperature oil temp low 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rWarnTempTooLow @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Alarm temp. low @RT(15)Alarm temp. low @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rAlarmTempTooLow @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rWarnTempTooLow @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Alarm temp. low @RT(15)Alarm temp. low @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rWarnTempTooHigh @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)55.0 @RT(33)warning temperature oil temp high 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(41)%FU.sv_rWarnTempTooLow..%FU.sv_rAlarmTemp @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Warning temp. high @RT(25)Warn temperature oil high @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rWarnTempTooHigh @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(41)%FU.sv_rWarnTempTooLow..%FU.sv_rAlarmTemp @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Warning temp. high @RT(25)Warn temperature oil high @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rWarnTempTooLow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)20.0 @RT(32)warning temperature oil temp low 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(48)%FU.sv_rAlarmTempTooLow..%FU.sv_rWarnTempTooHigh @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Warning temp. low @RT(24)Warn temperature oil low @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rWarnTempTooLow @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(48)%FU.sv_rAlarmTempTooLow..%FU.sv_rWarnTempTooHigh @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Warning temp. low @RT(24)Warn temperature oil low @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_FilterMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnRisingFalling @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(11)nRisingEdge @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(13)RisingFalling @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Oil filter error mode @RT(21)Oil filter error mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_FilterMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(13)RisingFalling @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Oil filter error mode @RT(21)Oil filter error mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_dFilterAlarmTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#10s @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(19)T#100ms..T#99s900ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Oil filter monitor time @RT(34)Oil filter monitor time oil filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dFilterAlarmTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(19)T#100ms..T#99s900ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Oil filter monitor time @RT(34)Oil filter monitor time oil filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_OilLevelMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnRisingFalling @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)TRUE = error if DI on >> 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(13)RisingFalling @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Oil level error mode @RT(20)Oil level error mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_OilLevelMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)TRUE = error if DI on >> 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(13)RisingFalling @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Oil level error mode @RT(20)Oil level error mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_dOilLevelTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#10s @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(19)T#100ms..T#99s900ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Oil level monitor time @RT(22)Oil level monitor time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_dOilLevelTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(19)T#100ms..T#99s900ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Oil level monitor time @RT(22)Oil level monitor time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_OilTempSensorType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)KHW_TempSensor_NiCrNi @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(71)KHW_TempSensor_FeCuNiIEC,KHW_TempSensor_NiCrNi,KHW_TempSensor_FeCuNiDIN @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_OilTempSensorType @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(71)KHW_TempSensor_FeCuNiIEC,KHW_TempSensor_NiCrNi,KHW_TempSensor_FeCuNiDIN @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bUseReturnLineFilter @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Use return line oil filter @RT(26)Use return line oil filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bUseReturnLineFilter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Use return line oil filter @RT(26)Use return line oil filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_dReturnLineFilterAlarmTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#100s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Monitor time @RT(35)Monitor time return line oil filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_dReturnLineFilterAlarmTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#100s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Monitor time @RT(35)Monitor time return line oil filter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
8 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erOilLevelLow @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(20)User and Application @RT(429)Oil level low{#]Oil level is low.{#]When the oil level low signal rises this alarm is raised and the motor is stopped immediately. \u000aUsually the oil needs to be filled. In rare cases the sensor feedback, wiring or \u000aterminal can be the problem.{#]Check the oil level and if necessary fill the oil.<br>\u000aIf the oil level is ok check the wiring and terminal as well as the \u000asensor feedback in the IO monitor masks. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erOilFilterNotOk @RT(1)2 @RT(1)y @RT(56)system.evAlarmFinishCycleAndStop,system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(583)Oilfilter clogged up{#]Oilfilter is clogged up.{#]When the oil filter clogged up signal rises this alarm is raised. If the machine is \u000acurrently in production, the current autocycle is finished and the machine stops \u000aafterwards. Usually the oil filter needs to be cleaned/replaced before operation\u000acan be continued.<br>\u000aIn rare cases also the feedback, wiring or terminal might be the problem.{#]Check the oil filter and clean/replace it.<br>\u000aIf the oil filter is ok check the wiring and terminal as well as the \u000asensor feedback in the IO monitor masks. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erOilTempHigh @RT(1)2 @RT(1)y @RT(72)system.evAlarmAutoManual,system.evAlarmLampBlink,system.evAlarmMotorLock @RT(50)system.evAlarmLampReset,system.evAlarmMotorRelease @RT(20)User and Application @RT(545)Oil Temperature too high!{#]Oil temperature is too high for further \u000amovements.{#]If the oil temperature exceeds the alarm temperature setting the motor is locked \u000aand no further movement is possible.{#]Wait for the oil temperature to get back within limits. If cooling is \u000aavailable make sure it operates properly.<br><br>\u000aIs the oil temperature within allowable operation temperature range \u000awhen the alarm is raised the {OilMaintenance1.sv_rAlarmTemp} can be adjusted to \u000afit the machine and process requirements. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erOilTempLow @RT(1)2 @RT(1)y @RT(49)system.evAlarmAutoManual, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(409)Oil Temperature too low!{#]Oil temperature is too low for autocycle.{#]The oil temperature is too low to operate the machine in autocycle. Movements in manual mode or in setup mode are possible.{#]Start oil-preheating to increase the oil temperature.<br>\u000aIf the oil temperature is within set point tolerance range the \u000a{OilMaintenance1.sv_rAlarmTempTooLow} limit setting can be adjusted accordingly. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erOilTempHighWarning @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(633)Oil Temperature high!{#]Oil temperature is close to exceed alarm \u000alimits.{#]This is just a message. Although normal operation is possible at this point it is \u000astrongly recommended to apply all necessary steps to bring the oil temperature \u000adown to operate within allowable limits.{#]This is just a message, but an action is indicated.<br>\u000aIf cooling is available make sure it operates properly. If the oil \u000atemperature is actually not exceeding warning limits while this alarm \u000ais raised the {OilMaintenance1.sv_rWarnTempTooHigh} setting can be adjusted to fit \u000athe machine and process requirements. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erOilTempLowWarning @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(431)Oil Temperature low!{#]Oil temperature is low for operation.{#]This is just a message. Although normal operation is possible at this point it is \u000arecommended to try the provided solution suggestions.{#]Start oil-preheating before trying to perform hydraulic movements.<br>\u000aIf the oil temperature is within set point tolerance range the \u000a{OilMaintenance1.sv_rWarnTempTooLow} limit setting can be adjusted accordingly. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erOilSensorProblem @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(597)Problem with oil temp. sensor, check terminal and wiring %1s{#]An error occurred on the oil temperature input hardware endpoint.{#]The status flag of the TI temperature input for oil temperature signals an error state. The problem can be at the specific hardware, wiring, terminal or the \u000ainvolved IO board of the controller.{#]Check the hardware endpoint information and state in the IO monitor. \u000aExamine the wiring, terminal and hardware connected to the output. If controller external causes can be ruled out further help is required.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erReturnLineOilFilterNotOk @RT(1)2 @RT(1)y @RT(56)system.evAlarmFinishCycleAndStop,system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(639)Problem with the Return line Oil Filter{#]Return line oil filter is clogged up.{#]When the return line oil filter clogged up signal rises this alarm is raised. If the machine is currently in production the current autocycle is finished and the machine stops afterwards. Usually the return line oil filter needs to be cleaned/replaced before operation can be continued.<br>\u000aIn rare cases also the feedback, wiring or terminal might be the problem.{#]Check the return line oil filter and clean/replace it.<br>\u000aIf the return line oil filter is ok check the wiring and terminal as well as the sensor feedback in the IO monitor masks. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
