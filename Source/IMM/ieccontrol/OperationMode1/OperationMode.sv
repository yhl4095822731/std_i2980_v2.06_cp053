%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, Time
, fmt31
, OnOff
, VG_MoldData
, ProductionTime
, fmt42
, PieceCount
, fmt60
, TwoButtonOperationMode

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tnSafetyGateState
, tnOperationMode
, tnTwoButtonOperationMode
, nManual
, nPressButtonsToStartCylce
, cLevelProcessOperator
, cLevelSuperUser
, cLevelServiceEngineer

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoldSafetyGateState : tnSafetyGateState (* safety gate state for starting auto cycle *)
    ;
 sv_bAllowFullAutoMode : BOOL := TRUE (* FALSE only allow half auto, TRUE allow half and full auto *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelProcessOperator

// Allow full auto mode Allow full automatic mode
;
 sv_dBuzzerTime : TIME := T#60s
 %PLAUSIBILITY T#0ms..T#999s999ms    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Buzzer on time Buzzer on time
;
 sv_dBuzzerPulseTime : TIME := T#2s
 %PLAUSIBILITY T#100ms..%FU.sv_dBuzzerTime    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Buzzer pulse time Buzzer pulse time
;
 sv_DemandedOperationMode : tnOperationMode := nManual
    ;
 sv_iPendingAlarms : DINT (* number of alarms pending with class 1,2,3 *)
    
// Pending alarms Pending alarms count
;
 sv_iPendingMessages : DINT (* number of alarms pending with all other classes *)
    
// Pending messages Pending messages count
;
 sv_bAlarmConfirmVis : BOOL (* alarm have been confirmed in the HMI (alarm mask) -> will be set by HMI *)
    
// Alarm confirm Alarm confirm
;
 sv_bSetAlarmSignal : BOOL (* alarm signal (alarm lamp, buzzer, ..) should be active *)
     %INPUT_LEVEL cLevelSuperUser

// Set alarm signal Set alarm signal
;
 sv_iSetAlarmSignalCount : DINT (* counter how many alarms requested the alarm signal (incremented with evAlarmLampBlink event; decremented with evAlarmLampReset) *)
     %INPUT_LEVEL cLevelSuperUser

// Set alarm signal count Set alarm signal count
;
 sv_bUseBothStartConditions : BOOL (* Start next cycle in half auto mode either with start button or open/close safety gate *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Start half auto with start button or SG Start half auto with start button or SG
;
 sv_rProdTimeAct : REAL (* Actual production time *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %FORMAT fmt42  %UNIT ProductionTime 
// Prod.time Actual production time
;
 sv_rProdTimeTotal : REAL (* Total production time *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %FORMAT fmt42  %UNIT ProductionTime 
// Total production time Total production time
;
 sv_rProdTimeRemaining : REAL (* Remaining production time (Total - Remaining) *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %FORMAT fmt42  %UNIT ProductionTime 
// Remaining production time Remaining production time
;
 sv_iProdCounterRemaining : DINT (* sv_iProdCounterSet - sv_iProdCounterAct *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %FORMAT fmt60  %UNIT PieceCount 
// Remaining prod counter Remaining prod counter
;
 sv_iProdStartCounter : DINT (* Signals the start of a new production on change *)
    ;
 sv_TwoButtonMode : tnTwoButtonOperationMode := nPressButtonsToStartCylce (* press startbuttons only to start the cycle or keep them pressen until high pressure stage is active *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT TwoButtonOperationMode 
// Two button mode Two button mode
;
%END

%SYSTEM_ALARM
  erFullAutoNotAllowed
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Switch to full automatic mode not allowed!{#]Switching to full automatic mode is not \u000aallowed per definition.{#]Switching to full automatic operation mode is not allowed by the control application.{#]This is just a message, no action required.<br><br>\u000aIf full-automatic operation mode is required, please contact the \u000amachine manufacturer.
 ;
  erAutoNotAllowed
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Switch to automatic mode not allowed!{#]Switching to automatic mode while data \u000ais loading.{#]It is not allowed to switch to semi- or full-automatic operation mode while any \u000adata (such as machine data, mold data, material data, sequence data,...) is \u000acurrently loading.{#]Wait for the data loading process to finish before switching to the \u000adesired operation mode.
 ;
  erCloseDoor
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Close door{#]Proceeding in the cycle requires the user to close the door.{#]To start the cycle at this point it is required to close the mold safety gate.{#]Close the mold safety gate to continue operation.
 ;
  erOpenDoor
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Open door{#]Proceeding in the cycle requires the user to open the door.{#]In order to start the cyclic operation the mold safety gate has to be opened and \u000aclosed again.{#]Open the mold safety gate to continue operation.
 ;
  erStartButton
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Press start button{#]Press the start button to start the machine cycle.{#]Starting the machine cyclic operation requires pressing the start button.{#]Press the start button.
 ;
  erOverrideSafetyModeOn
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Override core and ejector safety mode on{#]Override core and ejector safety mode is on.{#]This is just a message. For clearing certain problematic movement states it can be helpful to override ejector and core safety. This alarm only gives the information if this override mode is active.<br><br>\u000aBe aware, in this mode the mold and involved components can be easily broken.{#]This is just a message, no action required.<br><br>\u000aWhen override mode is active handle the machine with extra care! The alarm will disappear after confirmation by the user.
 ;
  erOverrideSafetyModeOff
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Override core and ejector safety mode off{#]Override core and ejector safety mode is off.{#]This is just a message. For clearing certain problematic movement states it can be helpful to override ejector and core safety. This alarm only gives the information if this override mode is not active.{#]This is just a message, no action required.<br><br>\u000aThe alarm will disappear after confirmation by the user.
 ;
  erEmergencyStop
 %CLASS 1 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmMotorLock,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset,system.evAlarmMotorRelease 
// Emergency stop %1n pressed!{#]Emergency stop is pressed!{#]Emergency stop signal is raised and no movement is allowed.{#]Solve the reason for pressing the emergency stop button, before \u000areleasing the emergency stop button to continue with the desired \u000aoperation.
 ;
  erPressButtonOrOpenDoor
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Press start button or open door{#]Press the start button or open and close the door to start the machine cycle.{#]Starting the machine cyclic operation requires either a press of the start button, or opening and closing the mold safety gate.{#]Press the start button or open the mold safety gate.
 ;
  erPressStartButtons
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Press start buttons to start cycle{#]Press both start buttons to start the machine cycle.{#]Starting the machine cyclic operation requires pressing both start buttons.{#]Press both start buttons.
 ;
  erButtonsReleased
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Cycle stopped because buttons released{#]Cyclic operation has stopped because \u000abutton has been released.{#]One possible mode of cyclic operation requires the start button being pressed until mold close is finished and high pressure is built. If the button is released earlier the cycle is stopped.{#]Open the mold in manual operation mode and retry the desired operation with keeping the start button pressed until the mold is closed and high pressure buildup is finished.
 ;
  erStopCycleFinish
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop 
// Cycle stopped because of user request{#]Cyclic operation is being stopped till the end of the cycle.{#]The current cycle is being stopped properly on user-request.
 ;
  erStopCycleImmediately
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual 
// Cycle interrupted because of user request{#]Cyclic operation is interrupted immediately.{#]The current cycle is being forcefully stopped on user-request.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
17 
@SysVar @RT(22)sv_MoldSafetyGateState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnSafetyGateState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)safety gate state for starting auto cycle 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_MoldSafetyGateState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#3s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bAllowFullAutoMode @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(57)FALSE only allow half auto, TRUE allow half and full auto 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Allow full auto mode @RT(25)Allow full automatic mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bAllowFullAutoMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Allow full auto mode @RT(25)Allow full automatic mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_dBuzzerTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#60s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(18)T#0ms..T#999s999ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Buzzer on time @RT(14)Buzzer on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_dBuzzerTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#5s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(18)T#0ms..T#999s999ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Buzzer on time @RT(14)Buzzer on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_dBuzzerPulseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(27)T#100ms..%FU.sv_dBuzzerTime @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Buzzer pulse time @RT(17)Buzzer pulse time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dBuzzerPulseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(27)T#100ms..%FU.sv_dBuzzerTime @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Buzzer pulse time @RT(17)Buzzer pulse time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_DemandedOperationMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnOperationMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)nManual @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_iPendingAlarms @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)number of alarms pending with class 1,2,3 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Pending alarms @RT(20)Pending alarms count @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_iPendingAlarms @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Pending alarms @RT(20)Pending alarms count @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_iPendingMessages @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)number of alarms pending with all other classes 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Pending messages @RT(22)Pending messages count @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_iPendingMessages @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Pending messages @RT(22)Pending messages count @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bAlarmConfirmVis @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)alarm have been confirmed in the HMI (alarm mask) -> will be set by HMI 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Alarm confirm @RT(13)Alarm confirm @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bAlarmConfirmVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)alarm have been confirmed in the HMI (alarm mask) -> will be set by HMI 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Alarm confirm @RT(13)Alarm confirm @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bSetAlarmSignal @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)alarm signal (alarm lamp, buzzer, ..) should be active 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Set alarm signal @RT(16)Set alarm signal @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bSetAlarmSignal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)alarm signal (alarm lamp, buzzer, ..) should be active 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Set alarm signal @RT(16)Set alarm signal @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_iSetAlarmSignalCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(127)counter how many alarms requested the alarm signal (incremented with evAlarmLampBlink event; decremented with evAlarmLampReset) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Set alarm signal count @RT(22)Set alarm signal count @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_iSetAlarmSignalCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(127)counter how many alarms requested the alarm signal (incremented with evAlarmLampBlink event; decremented with evAlarmLampReset) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Set alarm signal count @RT(22)Set alarm signal count @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_bUseBothStartConditions @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)Start next cycle in half auto mode either with start button or open/close safety gate 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(39)Start half auto with start button or SG @RT(39)Start half auto with start button or SG @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_bUseBothStartConditions @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)Start next cycle in half auto mode either with start button or open/close safety gate 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(39)Start half auto with start button or SG @RT(39)Start half auto with start button or SG @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rProdTimeAct @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Actual production time 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt42 @RT(14)ProductionTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Prod.time @RT(22)Actual production time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rProdTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt42 @RT(14)ProductionTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Prod.time @RT(22)Actual production time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rProdTimeTotal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Total production time 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt42 @RT(14)ProductionTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Total production time @RT(21)Total production time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rProdTimeTotal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt42 @RT(14)ProductionTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Total production time @RT(21)Total production time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rProdTimeRemaining @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)Remaining production time (Total - Remaining) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt42 @RT(14)ProductionTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Remaining production time @RT(25)Remaining production time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rProdTimeRemaining @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt42 @RT(14)ProductionTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Remaining production time @RT(25)Remaining production time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_iProdCounterRemaining @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)sv_iProdCounterSet - sv_iProdCounterAct 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Remaining prod counter @RT(22)Remaining prod counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_iProdCounterRemaining @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt60 @RT(10)PieceCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Remaining prod counter @RT(22)Remaining prod counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_iProdStartCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)Signals the start of a new production on change 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_TwoButtonMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tnTwoButtonOperationMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(25)nPressButtonsToStartCylce @RT(99)press startbuttons only to start the cycle or keep them pressen until high pressure stage is active 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(22)TwoButtonOperationMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Two button mode @RT(15)Two button mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_TwoButtonMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(99)press startbuttons only to start the cycle or keep them pressen until high pressure stage is active 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(22)TwoButtonOperationMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Two button mode @RT(15)Two button mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
13 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erFullAutoNotAllowed @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(354)Switch to full automatic mode not allowed!{#]Switching to full automatic mode is not \u000aallowed per definition.{#]Switching to full automatic operation mode is not allowed by the control application.{#]This is just a message, no action required.<br><br>\u000aIf full-automatic operation mode is required, please contact the \u000amachine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erAutoNotAllowed @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(385)Switch to automatic mode not allowed!{#]Switching to automatic mode while data \u000ais loading.{#]It is not allowed to switch to semi- or full-automatic operation mode while any \u000adata (such as machine data, mold data, material data, sequence data,...) is \u000acurrently loading.{#]Wait for the data loading process to finish before switching to the \u000adesired operation mode. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(11)erCloseDoor @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(206)Close door{#]Proceeding in the cycle requires the user to close the door.{#]To start the cycle at this point it is required to close the mold safety gate.{#]Close the mold safety gate to continue operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(10)erOpenDoor @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(225)Open door{#]Proceeding in the cycle requires the user to open the door.{#]In order to start the cyclic operation the mold safety gate has to be opened and \u000aclosed again.{#]Open the mold safety gate to continue operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erStartButton @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(173)Press start button{#]Press the start button to start the machine cycle.{#]Starting the machine cyclic operation requires pressing the start button.{#]Press the start button. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erOverrideSafetyModeOn @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(560)Override core and ejector safety mode on{#]Override core and ejector safety mode is on.{#]This is just a message. For clearing certain problematic movement states it can be helpful to override ejector and core safety. This alarm only gives the information if this override mode is active.<br><br>\u000aBe aware, in this mode the mold and involved components can be easily broken.{#]This is just a message, no action required.<br><br>\u000aWhen override mode is active handle the machine with extra care! The alarm will disappear after confirmation by the user. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erOverrideSafetyModeOff @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(410)Override core and ejector safety mode off{#]Override core and ejector safety mode is off.{#]This is just a message. For clearing certain problematic movement states it can be helpful to override ejector and core safety. This alarm only gives the information if this override mode is not active.{#]This is just a message, no action required.<br><br>\u000aThe alarm will disappear after confirmation by the user. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erEmergencyStop @RT(1)1 @RT(1)y @RT(72)system.evAlarmLampBlink,system.evAlarmMotorLock,system.evAlarmAutoManual @RT(50)system.evAlarmLampReset,system.evAlarmMotorRelease @RT(20)User and Application @RT(272)Emergency stop %1n pressed!{#]Emergency stop is pressed!{#]Emergency stop signal is raised and no movement is allowed.{#]Solve the reason for pressing the emergency stop button, before \u000areleasing the emergency stop button to continue with the desired \u000aoperation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erPressButtonOrOpenDoor @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(296)Press start button or open door{#]Press the start button or open and close the door to start the machine cycle.{#]Starting the machine cyclic operation requires either a press of the start button, or opening and closing the mold safety gate.{#]Press the start button or open the mold safety gate. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erPressStartButtons @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(195)Press start buttons to start cycle{#]Press both start buttons to start the machine cycle.{#]Starting the machine cyclic operation requires pressing both start buttons.{#]Press both start buttons. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erButtonsReleased @RT(1)2 @RT(1)y @RT(48)system.evAlarmAutoManual,system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(477)Cycle stopped because buttons released{#]Cyclic operation has stopped because \u000abutton has been released.{#]One possible mode of cyclic operation requires the start button being pressed until mold close is finished and high pressure is built. If the button is released earlier the cycle is stopped.{#]Open the mold in manual operation mode and retry the desired operation with keeping the start button pressed until the mold is closed and high pressure buildup is finished. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erStopCycleFinish @RT(1)3 @RT(1)y @RT(32)system.evAlarmFinishCycleAndStop @RT(0) @RT(4)User @RT(163)Cycle stopped because of user request{#]Cyclic operation is being stopped till the end of the cycle.{#]The current cycle is being stopped properly on user-request. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erStopCycleImmediately @RT(1)2 @RT(1)y @RT(24)system.evAlarmAutoManual @RT(0) @RT(4)User @RT(153)Cycle interrupted because of user request{#]Cyclic operation is interrupted immediately.{#]The current cycle is being forcefully stopped on user-request. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
