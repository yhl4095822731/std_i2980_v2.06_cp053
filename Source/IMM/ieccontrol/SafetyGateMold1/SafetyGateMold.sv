%IMPORT_OVER_LISTFILE_SOURCE
 Time
, fmt31
, VG_MachineData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_dSupervisionTime : TIME := t#1s (* SupervisionTime for SG Mold *)
 %PLAUSIBILITY T#0s..T#3s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Mold gate supervision time Mold gate supervision time
;
%END

%SYSTEM_ALARM
  erSafetyGateDefect
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mold safety gate defect! Please check the wiring, then try to open, close and quit the error{#]The mold safety gate open/close signal indicates a problem.{#]The mold safety gates signals for 'open' and 'closed' have the same state for an exceeding time period which is not allowed. This indicates a broken sensor or wiring problem.{#]Check the mold safety gate limitswitch sensor hardware, wiring and terminal.
 ;
  erSafetyGateCycleStop
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mold safety gate open{#]The mold safety gate has been opened during cyclic operation.{#]While the machine was operating in cyclic mode the mold safety gate has been opened. This causes the current cycle to stop immediately.{#]Close the mold safety gate and move all devices into start positions for cyclic operation before restarting cyclic production.
 ;
  erSafetyGate
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Mold safety gate open{#]The mold safety gate is open.{#]This is just a message, indicating the state of the mold safety gate.{#]This is just message, no action required.<br><br>\u000aThe message will disappear as soon as the safety gate is closed.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(19)sv_dSupervisionTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#1s @RT(27)SupervisionTime for SG Mold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#3s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Mold gate supervision time @RT(26)Mold gate supervision time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dSupervisionTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#3s @RT(27)SupervisionTime for SG Mold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#3s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Mold gate supervision time @RT(26)Mold gate supervision time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
3 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erSafetyGateDefect @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(410)Mold safety gate defect! Please check the wiring, then try to open, close and quit the error{#]The mold safety gate open/close signal indicates a problem.{#]The mold safety gates signals for 'open' and 'closed' have the same state for an exceeding time period which is not allowed. This indicates a broken sensor or wiring problem.{#]Check the mold safety gate limitswitch sensor hardware, wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erSafetyGateCycleStop @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(352)Mold safety gate open{#]The mold safety gate has been opened during cyclic operation.{#]While the machine was operating in cyclic mode the mold safety gate has been opened. This causes the current cycle to stop immediately.{#]Close the mold safety gate and move all devices into start positions for cyclic operation before restarting cyclic production. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erSafetyGate @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(247)Mold safety gate open{#]The mold safety gate is open.{#]This is just a message, indicating the state of the mold safety gate.{#]This is just message, no action required.<br><br>\u000aThe message will disappear as soon as the safety gate is closed. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
