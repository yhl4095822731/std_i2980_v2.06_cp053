%IMPORT_OVER_LISTFILE_SOURCE
 WarnAct
, TolAct
, fmt40
, Time
, fmt10

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tySpcSettingsArray
, tySpcMonData
, tsPdProfileChange
, cLevelSuperUser
, FPlausSPCAction
, KMB_PD_SingleEvent

END_IMPORT

%SYSTEMVAR_DECL
  sv_WarnActionTxtSel : INT (* error selection for warning limits *)
 %PLAUSIBILITY FPlausSPCAction      %FORMAT WarnAct 
// Warn limit exceed Exceedance of warn limit
;
 sv_TolActionTxtSel : INT (* error selection for tolerance limits *)
 %PLAUSIBILITY FPlausSPCAction      %FORMAT TolAct 
// Spec limit exceed Exceedance of specification limit
 %UPDATE_CYCLE "Fast";
 sv_PDGArray : tySpcSettingsArray
   RETAIN 
%ELEMENT sv_PDGArray[0].ErrMonActive
    
// Err.Monitor Err.Monitor

%ELEMENT sv_PDGArray[0].NegCount
     %FORMAT fmt40 
// Negative exceedings Negative exceeding counter

%ELEMENT sv_PDGArray[0].PosCount
     %FORMAT fmt40 
// Positive exceedings Positive exceeding counter

%ELEMENT sv_PDGArray[0].TolAction
 %PLAUSIBILITY FPlausSPCAction      %FORMAT TolAct 
// Tolerance action Tolerance action

%ELEMENT sv_PDGArray[0].Variable
    
// Variable Variable

%ELEMENT sv_PDGArray[0].WarnAction
 %PLAUSIBILITY FPlausSPCAction      %FORMAT WarnAct 
// Warn action Warn action

%ELEMENT sv_PDGArray[0].WarnMonActive
    
// Warn.Monitor Warn.Monitor
;
 sv_bPDPTrigger : BOOL
    
// Trigger PDP trigger
;
 sv_PDPTime : TOD (* special variable for SW oszi *)
     %UNIT Time 
// Time Act.time
;
 sv_bInitInjectGraph : BOOL (* activation of ABInjectGraph *)
    ;
 sv_iPreShotCounter : DINT (* shot counter for spc (increased before ejector movement) *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt10 
// Pre Shotcounter Pre Shotcounter
;
 sv_iSpcTotalErrCount : UINT (* total error counter for spc *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1 ;
 sv_iSpcTotalErrWarnCount : UINT (* total error + warn counter for spc *)
   %FAST_RETAIN  %DISPLAY_LEVEL 1 
// Scrap Scrap
;
 sv_SpcMonData : tySpcMonData (* array for collecting spc monitoring data *)
   %FAST_RETAIN ;
 sv_bSpcMonDataReset : BOOL (* triggers resetting of spc monitoring data *)
    ;
 sv_bSpcResampleActive : BOOL (* true, if the SPC resampling phase is currently active *)
    ;
 sv_SpcPreProfileChange : tsPdProfileChange (* signals a variable change in the pre profile *)
    ;
 sv_SpcPostProfileChange : tsPdProfileChange (* signals a variable change in the post profile *)
    ;
%END

%SYSTEMEVENT_DECL
  SystemEventPdcSingle : KMB_PD_SingleEvent
;
%END

%SYSTEM_ALARM
  erPDSOutOfTol
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// SPC limit exceeded (%1vs){#]An SPC limitation has been violated.{#]The statistic process control limitation for a single variable has been violated. Depending on the degree of violation there's either just this alarm, the alarm with rejecting the part or both with stopping cyclic operation after this parts cycle.{#]Analyse the variable value exceeding the limits and apply according actions.<br><br>\u000aIf the SPC limits are to narrow, limits can be changed.<br><br>\u000aIn some cases this can be seen as a warning where no immediate action is required.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 93 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
14 
@SysVar @RT(19)sv_WarnActionTxtSel @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)error selection for warning limits 
@RT(0) @RT(0) @RT(0) @RT(7)WarnAct @RT(0) @RT(0) @RT(0) 
@RT(15)FPlausSPCAction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Warn limit exceed @RT(24)Exceedance of warn limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_WarnActionTxtSel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)error selection for warning limits 
@RT(0) @RT(0) @RT(0) @RT(7)WarnAct @RT(0) @RT(0) @RT(0) 
@RT(15)FPlausSPCAction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Warn limit exceed @RT(24)Exceedance of warn limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_TolActionTxtSel @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)error selection for tolerance limits 
@RT(0) @RT(0) @RT(0) @RT(6)TolAct @RT(0) @RT(0) @RT(4)Fast 
@RT(15)FPlausSPCAction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Spec limit exceed @RT(33)Exceedance of specification limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_TolActionTxtSel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)error selection for tolerance limits 
@RT(0) @RT(0) @RT(0) @RT(6)TolAct @RT(0) @RT(0) @RT(4)Fast 
@RT(15)FPlausSPCAction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Spec limit exceed @RT(33)Exceedance of specification limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_PDGArray @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tySpcSettingsArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
8 
@AttrSym @RT(11)sv_PDGArray @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_PDGArray[0].ErrMonActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)Error monitoring is active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Err.Monitor @RT(11)Err.Monitor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_PDGArray[0].NegCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)Count of neg. Limit exceedings 
@RT(0) @RT(0) @RT(0) @RT(5)fmt40 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Negative exceedings @RT(26)Negative exceeding counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_PDGArray[0].PosCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)Count of pos. Limit exceedings 
@RT(0) @RT(0) @RT(0) @RT(5)fmt40 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Positive exceedings @RT(26)Positive exceeding counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_PDGArray[0].TolAction @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)Action in case of exceeding tolerance limit 
@RT(0) @RT(0) @RT(0) @RT(6)TolAct @RT(0) @RT(0) @RT(0) 
@RT(15)FPlausSPCAction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Tolerance action @RT(16)Tolerance action @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_PDGArray[0].Variable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)Name of supervised Variable 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Variable @RT(8)Variable @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_PDGArray[0].WarnAction @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)Action in case of exceeding warning limit 
@RT(0) @RT(0) @RT(0) @RT(7)WarnAct @RT(0) @RT(0) @RT(0) 
@RT(15)FPlausSPCAction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Warn action @RT(11)Warn action @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_PDGArray[0].WarnMonActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)Warning monitoring is active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Warn.Monitor @RT(12)Warn.Monitor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bPDPTrigger @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Trigger @RT(11)PDP trigger @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bPDPTrigger @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Trigger @RT(11)PDP trigger @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_PDPTime @RT(0) @T @F @DT @RT(3)TOD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)special variable for SW oszi 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(8)Act.time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)sv_PDPTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)special variable for SW oszi 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(8)Act.time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bInitInjectGraph @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)activation of ABInjectGraph 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_iPreShotCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(56)shot counter for spc (increased before ejector movement) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Pre Shotcounter @RT(15)Pre Shotcounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iPreShotCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(56)shot counter for PDS (increased before ejector movement) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Pre Shotcounter @RT(15)Pre Shotcounter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_iSpcTotalErrCount @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)total error counter for spc 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_iSpcTotalErrCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)total error counter for spc 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_iSpcTotalErrWarnCount @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)total error + warn counter for spc 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Scrap @RT(5)Scrap @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_iSpcTotalErrWarnCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)total error + warn counter for spc 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Scrap @RT(5)Scrap @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_SpcMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tySpcMonData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(40)array for collecting spc monitoring data 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_SpcMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(40)array for collecting spc monitoring data 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bSpcMonDataReset @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)triggers resetting of spc monitoring data 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bSpcMonDataReset @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)triggers resetting of spc monitoring data 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bSpcResampleActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)true, if the SPC resampling phase is currently active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(22)sv_SpcPreProfileChange @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsPdProfileChange @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)signals a variable change in the pre profile 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(23)sv_SpcPostProfileChange @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsPdProfileChange @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)signals a variable change in the post profile 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@RT(15)SETreeContainer 
1 
@SysEvent @RT(20)SystemEventPdcSingle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KMB_PD_SingleEvent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erPDSOutOfTol @RT(1)3 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(558)SPC limit exceeded (%1vs){#]An SPC limitation has been violated.{#]The statistic process control limitation for a single variable has been violated. Depending on the degree of violation there's either just this alarm, the alarm with rejecting the part or both with stopping cyclic operation after this parts cycle.{#]Analyse the variable value exceeding the limits and apply according actions.<br><br>\u000aIf the SPC limits are to narrow, limits can be changed.<br><br>\u000aIn some cases this can be seen as a warning where no immediate action is required. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
