%SYSTEM_ALARM
  erSafetyGate
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset,system.evAlarmMotorRelease 
// Rear safety gate open{#]The rear safety gate is open.{#]The motor is locked as soon as the rear safety gate is open.{#]Close the rear safety gate.<br><br>\u000aThe alarm will disappear after the safety gate is closed and the user confirmed the alarm.
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
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erSafetyGate @RT(1)2 @RT(1)y @RT(47)system.evAlarmLampBlink,system.evAlarmMotorLock @RT(50)system.evAlarmLampReset,system.evAlarmMotorRelease @RT(20)User and Application @RT(250)Rear safety gate open{#]The rear safety gate is open.{#]The motor is locked as soon as the rear safety gate is open.{#]Close the rear safety gate.<br><br>\u000aThe alarm will disappear after the safety gate is closed and the user confirmed the alarm. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
