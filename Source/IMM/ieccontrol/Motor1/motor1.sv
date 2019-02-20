%IMPORT_OVER_LISTFILE_SOURCE
 UseNoUse
, VG_MachineData
, Time
, fmt31
, LimitSwitchMode
, MotorDisplay

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_bUseMotor2 : BOOL
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Use motor 2 Use motor 2
;
 sv_bMotorStarting : BOOL
    
// Motor starting Motor is starting
;
 sv_dYOnTime : TIME := t#5s
 %PLAUSIBILITY t#10ms..t#999s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Motor wye on time Motor wye on time
;
 sv_dDeltaDelayTime : TIME := t#0.1s
 %PLAUSIBILITY t#10ms..t#999s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Motor delta-wye delay time Motor delta-wye delay time
;
 sv_bMotorOverloadMode : BOOL
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT LimitSwitchMode 
// Motor overload mode Motor overload mode
;
 sv_dDelayStartMotor2 : TIME
 %PLAUSIBILITY t#0.0s..t#30s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Motor2 start delay Motor 2 start delay
;
 sv_bMotor2Starting : BOOL
    
// Motor 2 is starting Motor 2 is starting
;
 sv_bMotorRunning : BOOL
    
// Motor is running Motor is running
;
 sv_bMotorStarted : BOOL
     %FORMAT MotorDisplay 
// Motor started Motor started
;
 sv_bMotorLocked : BOOL
     %INPUT_LEVEL 16

// Motor locked Motor locked
;
%END

%SYSTEM_ALARM
  erMotorStarting
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Motor %1n starting{#]Motor is starting.{#]This is just a message.<br>\u000aIt is given once the user presses the motor start button. As long as the \u000astar-delta motor starting process is not finished this message will be displayed. \u000aOnce the motor is fully started the message will disappear by itself.{#]This is just a message, no action required!
 ;
  erMotorNotRunning
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Motor not running{#]The motor is not running.{#]For a desired operation the motor is required to run.{#]Switch on the motor before retrying the desired operation.
 ;
  erMotorOverLoad
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmMotorLock,system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmMotorRelease,system.evAlarmLampReset 
// Motor %1n overload{#]Motor overload signal received. No more movements possible.{#]The digital input for motor overload signals an overload state. In case of a motor \u000aoverload no further movement is possible, except movements that use other \u000apower sources. Usually the overload signal is valid \u000aand the motor needs to cool down / get back into operational state. In rare \u000acases the sensor might be broken.{#]Let the motor cool down / get back into operational state before \u000aretrying the desired operation.<br>\u000aIn case the overload stays check the hardware including the \u000awiring and terminal.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
10 
@SysVar @RT(13)sv_bUseMotor2 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Use motor 2 @RT(11)Use motor 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bUseMotor2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Use motor 2 @RT(11)Use motor 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_bMotorStarting @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Motor starting @RT(17)Motor is starting @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_bMotorStarting @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Motor starting @RT(17)Motor is starting @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_dYOnTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#5s @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#10ms..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Motor wye on time @RT(17)Motor wye on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_dYOnTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#10ms..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Motor wye on time @RT(17)Motor wye on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dDeltaDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#0.1s @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#10ms..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Motor delta-wye delay time @RT(26)Motor delta-wye delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dDeltaDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#10ms..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Motor delta-wye delay time @RT(26)Motor delta-wye delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bMotorOverloadMode @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)LimitSwitchMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Motor overload mode @RT(19)Motor overload mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bMotorOverloadMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)LimitSwitchMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Motor overload mode @RT(19)Motor overload mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_dDelayStartMotor2 @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(13)t#0.0s..t#30s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Motor2 start delay @RT(19)Motor 2 start delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_dDelayStartMotor2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(13)t#0.0s..t#30s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Motor2 start delay @RT(19)Motor 2 start delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bMotor2Starting @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Motor 2 is starting @RT(19)Motor 2 is starting @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bMotor2Starting @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Motor 2 is starting @RT(19)Motor 2 is starting @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bMotorRunning @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Motor is running @RT(16)Motor is running @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bMotorRunning @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Motor is running @RT(16)Motor is running @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bMotorStarted @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(12)MotorDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Motor started @RT(13)Motor started @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bMotorStarted @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(12)MotorDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Motor started @RT(13)Motor started @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_bMotorLocked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Motor locked @RT(12)Motor locked @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_bMotorLocked @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Motor locked @RT(12)Motor locked @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
3 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erMotorStarting @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(357)Motor %1n starting{#]Motor is starting.{#]This is just a message.<br>\u000aIt is given once the user presses the motor start button. As long as the \u000astar-delta motor starting process is not finished this message will be displayed. \u000aOnce the motor is fully started the message will disappear by itself.{#]This is just a message, no action required! 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erMotorNotRunning @RT(1)1 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(162)Motor not running{#]The motor is not running.{#]For a desired operation the motor is required to run.{#]Switch on the motor before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erMotorOverLoad @RT(1)2 @RT(1)y @RT(47)system.evAlarmMotorLock,system.evAlarmLampBlink @RT(50)system.evAlarmMotorRelease,system.evAlarmLampReset @RT(20)User and Application @RT(626)Motor %1n overload{#]Motor overload signal received. No more movements possible.{#]The digital input for motor overload signals an overload state. In case of a motor \u000aoverload no further movement is possible, except movements that use other \u000apower sources. Usually the overload signal is valid \u000aand the motor needs to cool down / get back into operational state. In rare \u000acases the sensor might be broken.{#]Let the motor cool down / get back into operational state before \u000aretrying the desired operation.<br>\u000aIn case the overload stays check the hardware including the \u000awiring and terminal. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
