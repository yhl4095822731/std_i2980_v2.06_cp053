%IMPORT_OVER_LISTFILE_SOURCE
 ActivateButtonText
, GraphErrorActionText
, fmt33
, ShotCount
, fmt100

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tySwitchOverHistory
, tyVariablesUsed
, tnErrorAction
, tsCharVariablesUsed
, cLevelSuperUser
, KMB_PDSXY_Event
, KMB_PDSC_Event

END_IMPORT

%SYSTEMVAR_DECL
  sv_bResetSwitchOverHistory : BOOL (* resets the content of SwichtOverHistroyArray *)
    ;
 sv_SwitchOverHistoryArray : tySwitchOverHistory := 2((rSwitchOverPosition:=0.0,rSwitchOverPressure:=0.0)),(rSwitchOverPosition:=1000.0,rSwitchOverPressure:=0.0)
   %FAST_RETAIN ;
 sv_rDurationProposal : REAL (* calculated duration of inject and hold based on profile *)
    ;
 sv_dCycleProposal : TIME (* proposal for measure cycle *)
    ;
 sv_bActivateRecord : BOOL := FALSE (* SET BY HMI: True: YX / XT1 / XT2 Recorder are started *)
   RETAIN  %FORMAT ActivateButtonText ;
 sv_yVariablesUsed : tyVariablesUsed (* Array of variable which are actual used in inject graph *)
   RETAIN ;
 sv_GraphErrorAction : tnErrorAction
     %FORMAT GraphErrorActionText 
// Graph Error Action Inject Graph Error Action
;
 sv_rDurationHoldProposal : REAL (* calculated duration of hold *)
    ;
 sv_rSampleTimeYXProposal : REAL (* proposal sample time YX recorder *)
     %FORMAT fmt33 ;
 sv_iShotCounterActInjGraph : DINT (* Actual shot counter for inject graph *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt100  %UNIT ShotCount ;
 sv_dShotTimeActInjGraph : DATE_AND_TIME (* Actual shot time for inject graph *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iExportTriggerInjGraph : DINT (* Export trigger for inject graph *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iDisplayModeInjGraph : SINT (* Selected display mode in inject graph *)
    ;
 sv_CharVariablesUsed : tsCharVariablesUsed (* Characteristic variables which are actually used in inject graph. Signalization of change is done via ChangeCounter sub element *)
   RETAIN ;
%END

%SYSTEMEVENT_DECL
  evInject_Graph_YX : KMB_PDSXY_Event
;
 evInject_Graph_XT1 : KMB_PDSC_Event
;
 evInject_Graph_XT2 : KMB_PDSC_Event
;
%END

%SYSTEM_ALARM
  erInjectGraphAlarmLamp
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1s: %2vs out of boundary{#]Inject graph recognized a tolerance violation.{#]This is just a message. A violation of of the tolerance band has been recognized by the inject graph functionality. This indicates a bad part which will be rejected. Cyclic production will continue. If this alarm is raised inappropriately the reference curve might be problematic.{#]This is just a message, indicating a bad part has been produced, which will be rejected. No action required. Cyclic production will continue.<br><br>\u000aCheck and adjust the injection settings to allow for a proper operation.<br><br>\u000aIs the alarm raised inappropriately the reference curve can be reset.
 ;
  erInjectGraphDisplayWarning
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1s: %2vs out of boundary{#]Inject graph recognized a tolerance violation.{#]This is just a message. A violation of of the tolerance band has been recognized by the inject graph functionality. This indicates a bad part which will be rejected. Cyclic production will continue. If this alarm is raised inappropriately the reference curve might be problematic.{#]This is just a message, indicating a bad part has been produced, which will be rejected. No action required. Cyclic production will continue.<br><br>\u000aCheck and adjust the injection settings to allow for a proper operation.<br><br>\u000aIs the alarm raised inappropriately the reference curve can be reset.
 ;
  erInjectGraphStopAfterCycle
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1s: %2vs out of boundary , stop after cycle{#]Inject graph recognized a serious tolerance violation.{#]A serious violation of of the tolerance band has been recognized by the inject graph functionality. This indicates a bad part which will be rejected. Cyclic production is stopped after this cycle. If this alarm is raised inappropriately the reference curve might be problematic.{#]Check and adjust the injection settings to allow for a proper operation.<br><br>\u000aIs the alarm raised inappropriately the reference curve can be reset.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
14 
@SysVar @RT(26)sv_bResetSwitchOverHistory @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)resets the content of SwichtOverHistroyArray 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(25)sv_SwitchOverHistoryArray @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tySwitchOverHistory @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(109)2((rSwitchOverPosition:=0.0,rSwitchOverPressure:=0.0)),(rSwitchOverPosition:=1000.0,rSwitchOverPressure:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_SwitchOverHistoryArray @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(109)2((rSwitchOverPosition:=0.0,rSwitchOverPressure:=0.0)),(rSwitchOverPosition:=1000.0,rSwitchOverPressure:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rDurationProposal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)calculated duration of inject and hold based on profile 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_dCycleProposal @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)proposal for measure cycle 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_bActivateRecord @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(53)SET BY HMI: True: YX / XT1 / XT2 Recorder are started 
@RT(0) @RT(0) @RT(0) @RT(18)ActivateButtonText @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bActivateRecord @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(53)SET BY HMI: True: YX / XT1 / XT2 Recorder are started 
@RT(0) @RT(0) @RT(0) @RT(18)ActivateButtonText @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_yVariablesUsed @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyVariablesUsed @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)Array of variable which are actual used in inject graph 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_yVariablesUsed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)Array of variable which are actual used in inject graph 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_GraphErrorAction @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnErrorAction @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(20)GraphErrorActionText @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Graph Error Action @RT(25)Inject Graph Error Action @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_GraphErrorAction @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(20)GraphErrorActionText @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Graph Error Action @RT(25)Inject Graph Error Action @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rDurationHoldProposal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)calculated duration of hold 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(24)sv_rSampleTimeYXProposal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)proposal sample time YX recorder 
@RT(0) @RT(0) @RT(0) @RT(5)fmt33 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rSampleTimeYXProposal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)proposal sample time YX recorder 
@RT(0) @RT(0) @RT(0) @RT(5)fmt33 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_iShotCounterActInjGraph @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)Actual shot counter for inject graph 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(6)fmt100 @RT(9)ShotCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_iShotCounterActInjGraph @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(6)fmt100 @RT(9)ShotCount @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dShotTimeActInjGraph @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)Actual shot time for inject graph 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dShotTimeActInjGraph @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)RTC Time of actual shot 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_iExportTriggerInjGraph @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)Export trigger for inject graph 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_iExportTriggerInjGraph @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_iDisplayModeInjGraph @RT(0) @T @F @DT @RT(4)SINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)Selected display mode in inject graph 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(20)sv_CharVariablesUsed @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsCharVariablesUsed @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(127)Characteristic variables which are actually used in inject graph. Signalization of change is done via ChangeCounter sub element 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_CharVariablesUsed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)Array of variable which are actual used in inject graph 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
3 
@SysEvent @RT(17)evInject_Graph_YX @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)KMB_PDSXY_Event @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(18)evInject_Graph_XT1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KMB_PDSC_Event @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(18)evInject_Graph_XT2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KMB_PDSC_Event @RT(0) @T @T @UNKNOWN 0 @F 
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
3 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erInjectGraphAlarmLamp @RT(1)5 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(670)%1s: %2vs out of boundary{#]Inject graph recognized a tolerance violation.{#]This is just a message. A violation of of the tolerance band has been recognized by the inject graph functionality. This indicates a bad part which will be rejected. Cyclic production will continue. If this alarm is raised inappropriately the reference curve might be problematic.{#]This is just a message, indicating a bad part has been produced, which will be rejected. No action required. Cyclic production will continue.<br><br>\u000aCheck and adjust the injection settings to allow for a proper operation.<br><br>\u000aIs the alarm raised inappropriately the reference curve can be reset. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erInjectGraphDisplayWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(670)%1s: %2vs out of boundary{#]Inject graph recognized a tolerance violation.{#]This is just a message. A violation of of the tolerance band has been recognized by the inject graph functionality. This indicates a bad part which will be rejected. Cyclic production will continue. If this alarm is raised inappropriately the reference curve might be problematic.{#]This is just a message, indicating a bad part has been produced, which will be rejected. No action required. Cyclic production will continue.<br><br>\u000aCheck and adjust the injection settings to allow for a proper operation.<br><br>\u000aIs the alarm raised inappropriately the reference curve can be reset. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erInjectGraphStopAfterCycle @RT(1)3 @RT(1)y @RT(57)system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(540)%1s: %2vs out of boundary , stop after cycle{#]Inject graph recognized a serious tolerance violation.{#]A serious violation of of the tolerance band has been recognized by the inject graph functionality. This indicates a bad part which will be rejected. Cyclic production is stopped after this cycle. If this alarm is raised inappropriately the reference curve might be problematic.{#]Check and adjust the injection settings to allow for a proper operation.<br><br>\u000aIs the alarm raised inappropriately the reference curve can be reset. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
