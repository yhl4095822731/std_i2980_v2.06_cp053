%IMPORT_OVER_LISTFILE_SOURCE
 LubricationDisplay
, VG_MachineData
, Time
, fmt31
, fmt50

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsLubValues
, cLevelServiceEngineer
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  miShotCounterLastLub : UDINT
   %FAST_RETAIN ;
 sv_bLubricationActive : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT LubricationDisplay 
// Lubrication active Lubrication active
;
 sv_LubricationSetValues : tsLubValues := (iInterval:=100,dLubTime:=t#30s,dOnTime:=t#10s,dOffTime:=t#5s)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_LubricationSetValues.dLubTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Lubrication time Lubrication time

%ELEMENT sv_LubricationSetValues.dOffTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Off time Off time

%ELEMENT sv_LubricationSetValues.dOnTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// On time On time

%ELEMENT sv_LubricationSetValues.iInterval
 %PLAUSIBILITY 0..99999      %DISPLAY_LEVEL 1  %FORMAT fmt50 
// Lubrication interval Lubrication interval
;
 sv_LubricationActValues : tsLubValues
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_LubricationActValues.dLubTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. lubrication time Act. lubrication time

%ELEMENT sv_LubricationActValues.dOffTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. off time Act. off time

%ELEMENT sv_LubricationActValues.dOnTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. on time Act. on time

%ELEMENT sv_LubricationActValues.iInterval
     %DISPLAY_LEVEL 1  %FORMAT fmt50 
// Act. lubrication interval Act. lubrication interval
;
%END

%SYSTEM_ALARM
  erLubLimitAchieved
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmFinishCycleAndStop  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Lubrication level low{#]Lubrication level is too low.{#]During lubrication the desired level could not be reached.{#]Change the {Lubrication1.sv_LubricationSetValues.dLubTime} settings and check whether \u000alubrication can be performed now or the problem cannot be \u000asolved by adjusting the lubrication settings.<br><br>\u000aIn this case check the hardware lubrication system. Also check \u000athe sensor for lubrication limit including hardware, wiring and terminal.
 ;
  erCentralLubError
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmFinishCycleAndStop  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Lubrication failed{#]Lubrication failed because of lubrication \u000apressure feedback.{#]There are two situations that trigger this alarm.<br><br>\u000aFirst the lubrication pressure feedback is already indicating that the desired \u000alubrication pressure is achieved before lubrication starts. This could either be \u000acorrect or caused by faulty hardware.<br><br>\u000aThe second cause is simply when lubrication doesn't reach the desired pressure \u000awithin the lubrication time set by the user. In this case either the time is too short \u000aor a hardware problem (e.g. a leak) is the real cause.{#]Try a manual lubrication in order to check if the alarm is raised right \u000aat the beginning of lubrication or at the end.<br><br>\u000aIf it is raised at the beginning check the situation at the machine. \u000aDecide if actually no lubrication is necessary because the pressure \u000areally is achieved, or if there is a hardware problem with the lubrication system (e.g. clogged lubrication lines)<br><br>\u000aIn case the alarm is raised in the end of lubrication try to increase the \u000a{Lubrication1.sv_LubricationSetValues.dLubTime} settings and restart lubrication manually in order to \u000acheck if lubrication pressure can be reached with the new settings. \u000aIf this is not the case check the lubrication pressure sensor \u000afeedback, its wiring and terminal.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(20)miShotCounterLastLub @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)miShotCounterLastLub @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bLubricationActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(18)LubricationDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Lubrication active @RT(18)Lubrication active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bLubricationActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(18)LubricationDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Lubrication active @RT(18)Lubrication active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_LubricationSetValues @RT(0) @T @T @DERIVED 0 @F @RT(11)tsLubValues @F 
@T 
@BEG_Attrib 
4 @RT(62)(iInterval:=100,dLubTime:=t#30s,dOnTime:=t#10s,dOffTime:=t#5s) @RT(0) 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(23)sv_LubricationSetValues @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_LubricationSetValues.dLubTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Lubrication time @RT(16)Lubrication time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_LubricationSetValues.dOffTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Off time @RT(8)Off time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_LubricationSetValues.dOnTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)On time @RT(7)On time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_LubricationSetValues.iInterval @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt50 @RT(0) @RT(0) @RT(0) 
@RT(8)0..99999 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Lubrication interval @RT(20)Lubrication interval @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_LubricationActValues @RT(0) @T @T @DERIVED 0 @F @RT(11)tsLubValues @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(23)sv_LubricationActValues @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_LubricationActValues.dLubTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Act. lubrication time @RT(21)Act. lubrication time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_LubricationActValues.dOffTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Act. off time @RT(13)Act. off time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_LubricationActValues.dOnTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Act. on time @RT(12)Act. on time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_LubricationActValues.iInterval @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt50 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Act. lubrication interval @RT(25)Act. lubrication interval @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
2 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erLubLimitAchieved @RT(1)2 @RT(1)y @RT(56)system.evAlarmLampBlink,system.evAlarmFinishCycleAndStop @RT(23)system.evAlarmLampReset @RT(4)User @RT(474)Lubrication level low{#]Lubrication level is too low.{#]During lubrication the desired level could not be reached.{#]Change the {Lubrication1.sv_LubricationSetValues.dLubTime} settings and check whether \u000alubrication can be performed now or the problem cannot be \u000asolved by adjusting the lubrication settings.<br><br>\u000aIn this case check the hardware lubrication system. Also check \u000athe sensor for lubrication limit including hardware, wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erCentralLubError @RT(1)2 @RT(1)y @RT(56)system.evAlarmLampBlink,system.evAlarmFinishCycleAndStop @RT(23)system.evAlarmLampReset @RT(4)User @RT(1390)Lubrication failed{#]Lubrication failed because of lubrication \u000apressure feedback.{#]There are two situations that trigger this alarm.<br><br>\u000aFirst the lubrication pressure feedback is already indicating that the desired \u000alubrication pressure is achieved before lubrication starts. This could either be \u000acorrect or caused by faulty hardware.<br><br>\u000aThe second cause is simply when lubrication doesn't reach the desired pressure \u000awithin the lubrication time set by the user. In this case either the time is too short \u000aor a hardware problem (e.g. a leak) is the real cause.{#]Try a manual lubrication in order to check if the alarm is raised right \u000aat the beginning of lubrication or at the end.<br><br>\u000aIf it is raised at the beginning check the situation at the machine. \u000aDecide if actually no lubrication is necessary because the pressure \u000areally is achieved, or if there is a hardware problem with the lubrication system (e.g. clogged lubrication lines)<br><br>\u000aIn case the alarm is raised in the end of lubrication try to increase the \u000a{Lubrication1.sv_LubricationSetValues.dLubTime} settings and restart lubrication manually in order to \u000acheck if lubrication pressure can be reached with the new settings. \u000aIf this is not the case check the lubrication pressure sensor \u000afeedback, its wiring and terminal. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
