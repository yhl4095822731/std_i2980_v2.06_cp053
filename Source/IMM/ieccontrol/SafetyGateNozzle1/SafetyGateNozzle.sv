%SYSTEM_ALARM
  erSafetyGateCycleStop
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Nozzle safety gate open{#]The nozzle safety gate has been opened during cyclic operation.{#]While the machine was operating in cyclic mode the nozzle safety gate has been opened. This causes the current cycle to stop immediately.{#]Close the nozzle safety gate and move all devices into start positions for cyclic operation before restarting cyclic production.
 ;
  erSafetyGate
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Nozzle safety gate open{#]The nozzle safety gate is open.{#]This is just a message, indicating the state of the nozzle safety gate.{#]This is just message, no action required.<br><br>\u000aThe message will disappear as soon as the safety gate is closed.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 86 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
0 
@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
2 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erSafetyGateCycleStop @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(360)Nozzle safety gate open{#]The nozzle safety gate has been opened during cyclic operation.{#]While the machine was operating in cyclic mode the nozzle safety gate has been opened. This causes the current cycle to stop immediately.{#]Close the nozzle safety gate and move all devices into start positions for cyclic operation before restarting cyclic production. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erSafetyGate @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(253)Nozzle safety gate open{#]The nozzle safety gate is open.{#]This is just a message, indicating the state of the nozzle safety gate.{#]This is just message, no action required.<br><br>\u000aThe message will disappear as soon as the safety gate is closed. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
