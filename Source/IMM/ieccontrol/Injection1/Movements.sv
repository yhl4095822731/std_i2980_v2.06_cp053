%IMPORT_OVER_LISTFILE_SOURCE
 fmtPosReached
, fmt31
, VG_MachineData
, Stroke
, fmt32
, Time
, InjectVolume
, InjectStroke
, YesNo

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, tsEndPosData
, tsCombinedPlastData
, tyInterCondBoolArray
, tsInjectHoldElementData
, tyInterCondTimeArray
, cMoveInject
, cMoveFwd
, nMoveDirectionMaxToMin
, nODCElementInjectAndHold
, cMoveHold
, cMovePlast
, cMoveBwd
, nMoveDirectionMinToMax
, nODCElementMovement
, cMoveIntrusion
, nODCElementDuration
, cMovePVCalib
, cMoveDecompBefPlast
, cMoveDecompAftPlast
, cMovePlastPurge
, cMoveFwdInterPos
, cMoveInjectPurge
, cMoveDecompPurge
, cMoveColdDrop
, cMoveBeginSequence
, nODCElementSequenceBound
, cMoveEndSequence
, cMoveDecompInterPos
, cMoveCombinedPlast
, nODCElementCombinedPlast
, cMoveInjectCalib
, cLevelSuperUser
, cLevelStartupTechnican
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveInject : tsMoveData := (MoveId:=cMoveInject,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastInjectHoldTime,pdCalculatedDuration:=@%FU.sv_dDurationInjectAndHold,prTargetValue:=@%FU.sv_rInjectTargetPosition,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bFinishAtInterrupt:=TRUE,iSafetyIdentifier:=0,sMoveId:='Inject',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(pbReferenceCondition:=@%FU.sv_bHoldActive,Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementInjectAndHold,sElementData:='sv_InjectAndHoldData')) (* inject movement *)
    
%ELEMENT sv_MoveInject.MoveId
    
// Inject Inject
;
 sv_MoveHold : tsMoveData := (MoveId:=cMoveHold,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastHoldTime,AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* hold movement *)
    
%ELEMENT sv_MoveHold.MoveId
    
// Hold Inject hold
;
 sv_MovePlast : tsMoveData := (MoveId:=cMovePlast,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_PlastTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bDefaultPos:=TRUE,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsPlast,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) (* plast movement *)
    
%ELEMENT sv_MovePlast.MoveId
    
// Plast Plasticize
;
 sv_MoveIntrusion : tsMoveData := (MoveId:=cMoveIntrusion,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_IntrusionTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_IntrusionSettings.dIntrusionTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='Intrusion',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsPlast,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementDuration)) (* intrusion movement *)
    
%ELEMENT sv_MoveIntrusion.MoveId
    
// Intrusion Intrusion
;
 sv_MovePVCalib : tsMoveData := (MoveId:=cMovePVCalib,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* inject movement *)
    
%ELEMENT sv_MovePVCalib.MoveId
    
// Calib PV calib
;
 sv_MoveDecompBefPlast : tsMoveData := (MoveId:=cMoveDecompBefPlast,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_dLastDecompBeforeTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationDecompBef,prTargetValue:=@%FU.sv_rTargetValueDecBefPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@%FU.sv_bActivatedDecompBeforePlast,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) (* decomp before plast movement *)
    
%ELEMENT sv_MoveDecompBefPlast.MoveId
    
// Decomp before Decomp before plast
;
 sv_MoveDecompAftPlast : tsMoveData := (MoveId:=cMoveDecompAftPlast,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_dLastDecompAfterTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationDecompAft,prTargetValue:=@%FU.sv_rTargetValueDecAftPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@%FU.sv_bActivatedDecompAfterPlast,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) (* decomp after plast movement *)
    
%ELEMENT sv_MoveDecompAftPlast.MoveId
    
// Decomp after Decomp after plast
;
 sv_PlastEndMonData : tsEndPosData := (pPlastProfile:=@%FU.sv_PlastProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rScrewPosition,pbPosReached:=@%FU.sv_bPlastEndReached) (* structure for maintenance of plasticizing endposition *)
    ;
 sv_bPlastEndReached : BOOL (* flag if plast icizing endposition is reached *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Plast End Reached Plast Endposition Reached
;
 sv_MovePlastPurge : tsMoveData := (MoveId:=cMovePlastPurge,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsPlast,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* plast movement for purging *)
    
%ELEMENT sv_MovePlastPurge.MoveId
    
// Purge Plast purge
;
 sv_InjectMonData : tsEndPosData := (pProfile:=@%FU.sv_InjectProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rScrewPosition,pbPosReached:=@%FU.sv_bInjectEnd)
    ;
 sv_rMonTolerance : REAL := 0.5 (* tolerance for endpos monitoring *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Endposition tolerance Endposition tolerance
;
 sv_rTolerancePosReached : REAL := 0.0 (* tolerance for endpos reached *)
 %PLAUSIBILITY 0.0..%FU.sv_rMonTolerance    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32  %UNIT Stroke 
// Position reached tolerance  Position reached tolerance 
;
 sv_MoveInjectInterPos : tsMoveData := (MoveId:=cMoveFwdInterPos,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_InjectTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='InjectInterPos',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_InjectInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesInjectInterPos,pLastActiveTimeArray:=@%FU.sv_LastTimesInjectInterPos,sInstanceDataVar:='sv_InstanceDataInjectInterPos')) (* instanceable inject movement *)
    
%ELEMENT sv_MoveInjectInterPos.MoveId
    
// Inject up to pos. Inject up to position
;
 sv_MoveInjectPurge : tsMoveData := (MoveId:=cMoveInjectPurge,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* inject movement for purging *)
    
%ELEMENT sv_MoveInjectPurge.MoveId
    
// Purge Inject Purge
;
 sv_MoveDecompPurge : tsMoveData := (MoveId:=cMoveDecompPurge,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* decomop movement for purging *)
    
%ELEMENT sv_MoveDecompPurge.MoveId
    
// Purge Decomp purge
;
 sv_MoveColdDrop : tsMoveData := (MoveId:=cMoveColdDrop,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_ColdDropTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_ColdDropSettings.dColdDropTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='ColdDrop',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementDuration)) (* cold drop movement (time dependent inject movement) *)
    
%ELEMENT sv_MoveColdDrop.MoveId
    
// Cold slug eject Cold slug eject
;
 sv_bInjectEnd : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Screw fwd Screw fwd
;
 sv_MoveBeginInjectSequence : tsMoveData := (MoveId:=cMoveBeginSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginInjectSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for begin of inject sequence *)
    
%ELEMENT sv_MoveBeginInjectSequence.MoveId
    
// Inject sequence Begin inject sequence
;
 sv_MoveEndInjectSequence : tsMoveData := (MoveId:=cMoveEndSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndInjectSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for end of inject sequence *)
    
%ELEMENT sv_MoveEndInjectSequence.MoveId
    
// End inject sequence End inject sequence
;
 sv_MoveBeginPlastSequence : tsMoveData := (MoveId:=cMoveBeginSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginPlastSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for begin of plast sequence *)
    
%ELEMENT sv_MoveBeginPlastSequence.MoveId
    
// Plast sequence Begin plast sequence
;
 sv_MoveEndPlastSequence : tsMoveData := (MoveId:=cMoveEndSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndPlastSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for end of plast sequence *)
    
%ELEMENT sv_MoveEndPlastSequence.MoveId
    
// End plast sequence End plast sequence
;
 sv_bActivatedDecompBeforePlast : BOOL (* indicates if movement decompress should be activated if start event is sent *)
    ;
 sv_bActivatedDecompAfterPlast : BOOL (* indicates if movement decompress should be activated if start event is sent *)
    ;
 sv_dCalculatedDurationInject : TIME := T#2s (* Calculated inject duration (without hold) *)
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated inject duration Calculated inject duration
;
 sv_dCalculatedDurationHold : TIME := T#2s (* Calculated hold duration *)
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated hold duration Calculated hold duration
;
 sv_dDurationInjectAndHold : TIME := T#2s (* Duration of inject + hold *)
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalculatedDurationDecompAft : TIME := T#2s (* Calculated duration for decomp after plast *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated decomp after duration Calculated decomp after duration
;
 sv_dCalculatedDurationDecompBef : TIME := T#2s (* Calculated duration for decomp before plast *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated decomp before duration Calculated decomp before duration
;
 sv_dCalculatedDurationPlast : TIME := T#4s (* Calculated duration for plasticizing *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated plasticize duration Calculated plasticize duration
;
 sv_dDurationCombinedPlast : TIME := T#4s (* Calculated duration for combined plasticizing *)
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Calculated plasticize duration
;
 sv_rInjectCalcDurationStartPos : REAL (* Start position for calculation of inject duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rScrewVolume      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Start pos inject calc duration Start pos inject calc duration
;
 sv_rDecompAftCalcDurStartPos : REAL (* Start position for calculation of decomp after plast duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rScrewStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectStroke 
// Start pos decomp after calc duration Start pos decomp after calc duration
;
 sv_rDecompAftCalcDurEndPos : REAL (* End position for calculation of decomp after plast duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rScrewStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectStroke 
// End pos decomp after calc duration End pos decomp after calc duration
;
 sv_rDecompBefCalcDurStartPos : REAL (* Start position for calculation of decomp before plast duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rScrewStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectStroke 
// Start pos decomp bef calc duration Start pos decomp bef calc duration
;
 sv_rDecompBefCalcDurEndPos : REAL (* End position for calculation of decomp before plast duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rScrewStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectStroke 
// End pos decomp bef calc duration End pos decomp bef calc duration
;
 sv_rTargetValueDecBefPlast : REAL (* target value of decomp before plast (in cm³) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Target value dec bef plast Target value decomp before plast
;
 sv_rTargetValueDecAftPlast : REAL (* target value of decomp after plast (in cm³) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Plasticize stroke Plasticize stroke
;
 sv_MoveDecompInterPos : tsMoveData := (MoveId:=cMoveDecompInterPos,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Decompression',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_DecompInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesDecompInterPos,pLastActiveTimeArray:=@%FU.sv_LastTimesDecompInterPos,pProgrammedInSequenceArray:=@%FU.sv_DecompInterPosProgInSequ,sInstanceDataVar:='sv_InstanceDataDecompInterPos')) (* instanceable decompression movement *)
    
%ELEMENT sv_MoveDecompInterPos.MoveId
    
// Decomp. up to pos. Decompression up to position
;
 sv_MoveCombinedPlast : tsMoveData := (MoveId:=cMoveCombinedPlast,MoveDir:=cMoveBwd,pdActiveTimeAct:=@%FU.sv_dActPlastDecompTime,pdLastActiveTime:=@%FU.sv_dLastPlastDecompTime,pdCalculatedDuration:=@%FU.sv_dDurationCombinedPlast,prTargetValue:=@%FU.sv_rTargetValueDecAftPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bIgnoreByABControl:=TRUE,iSafetyIdentifier:=0,sMoveId:='Plast',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementCombinedPlast,sElementData:='sv_CombinedPlastData',sLGInstanceProperties:='LG_CombinedPlast')) (* combined plast movement (decomp bef -> plast -> decomp after) *)
    
%ELEMENT sv_MoveCombinedPlast.MoveId
    
// Plast Plasticize
;
 sv_bCombinedPlastReady : BOOL := TRUE (* combined plast ready *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Combined plast ready Combined plast ready
;
 sv_CombinedPlastData : tsCombinedPlastData := (DecompBefore:=(prTargetValue:=@%FU.sv_rTargetValueDecBefPlast,pdDelayTime:=@%FU.sv_DecompTimesSet.dSetDelayTime,pdDuration:=@%FU.sv_dCalculatedDurationDecompBef,sODCIcon:='\hmi\images\editDecomp.gif'),Plast:=(pdDelayTime:=@%FU.sv_PlastTimesSet.dSetDelayTime,pdDuration:=@%FU.sv_dCalculatedDurationPlast,sODCIcon:='\hmi\images\editPlast.gif'),DecompAfter:=(prTargetValue:=@%FU.sv_rTargetValueDecAftPlast,pdDelayTime:=@%FU.sv_DecompTimesSet.dSetDelayTime,pdDuration:=@%FU.sv_dCalculatedDurationDecompAft,sODCIcon:='\hmi\images\editDecomp.gif')) (* necessary data for diplaying combined plast movement in odc editor *)
    ;
 sv_DecompInterPosProgInSequ : tyInterCondBoolArray (* information, which instances are programmed in sequence *)
    ;
 sv_InjectAndHoldData : tsInjectHoldElementData := (pdInjectDuration:=@%FU.sv_dCalculatedDurationInject,pdHoldDuration:=@%FU.sv_dCalculatedDurationHold,sODCHoldIcon:='\hmi\images\editHold.gif') (* necessary data for diplaying inject and hold movement in odc editor *)
    ;
 sv_rInjectInterruptPosition : REAL (* interrupt position (for instanceable inject movement) *)
    ;
 sv_rInjectInterruptAcc : REAL (* Acceleration to continune after inject interrupt position *)
    ;
 sv_rInjectInterruptDec : REAL (* Deceleration to reach inject interrupt position *)
    ;
 sv_bHoldActive : BOOL (* TRUE: holding is active; attention: SV is resetted after end of inject movement *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Hold active Hold active
;
 sv_MoveInjectCalib : tsMoveData := (MoveId:=cMoveInjectCalib,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* inject movement for inject controller calib *)
    
%ELEMENT sv_MoveInjectCalib.MoveId
    
// Cold slug eject Cold slug eject
;
 sv_bInjectionActive : BOOL (* any inject (screw fwd) movement is active   Attention: this variable is set in every operation mode *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Inject active Injection active
;
 sv_bDecompActive : BOOL (* any decompression movement active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Decomp active Decompression active
;
 sv_bPlastActive : BOOL (* plasticize movement is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Plast active Plast active
;
 sv_dActPlastDecompTime : TIME (* act time for combined plast movement *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_dLastPlastDecompTime : TIME (* last time for combined plast movement *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_iCtrlParamSet : INT := 1 (* pid control set of speed pump  *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// Control Parameter Set Control Parameter Set
;
 sv_ActiveTimesInjectInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_ActiveTimesDecompInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_LastTimesInjectInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_LastTimesDecompInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_dActInjectHoldTime : TIME (* actual time (contains inject and hold) *)
     %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_dLastInjectHoldTime : TIME (* last movement time (contains inject and hold) *)
     %FORMAT fmt31  %UNIT Time ;
 sv_bIgnoreStopAtCutOffNoHold : BOOL := TRUE
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT YesNo 
// Ignore stop at cutoff Ignore stop at cutoff
;
%END

%SYSTEM_ALARM
  erNotPlasticized
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n not plasticized{#]The plasticizing movement has not \u000areached its end or targetposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause plasticizing has not reached its end or targetposition.{#]Activate plasticizing to reach its end- or targetposition before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check the \u000aplasticizing output settings ({Injection1.sv_PlastProfVis.Profile.Points[1].rRotation:c:backpressure} / {Injection1.sv_PlastProfVis.Profile.Points[1].rRotation:c:speed}) and if necessary adjust them to \u000aallow plasticizing to finish properly before restarting cyclic operation.<br>\u000aIt is also possible to check if the material feed has been interrupted.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
62 
@SysVar @RT(13)sv_MoveInject @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(581)(MoveId:=cMoveInject,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastInjectHoldTime,pdCalculatedDuration:=@%FU.sv_dDurationInjectAndHold,prTargetValue:=@%FU.sv_rInjectTargetPosition,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bFinishAtInterrupt:=TRUE,iSafetyIdentifier:=0,sMoveId:='Inject',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(pbReferenceCondition:=@%FU.sv_bHoldActive,Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementInjectAndHold,sElementData:='sv_InjectAndHoldData')) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(13)sv_MoveInject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_MoveInject.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Inject @RT(6)Inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_MoveHold @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(129)(MoveId:=cMoveHold,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastHoldTime,AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(13)hold movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(11)sv_MoveHold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(13)hold movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(18)sv_MoveHold.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(9)cMoveHold @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Hold @RT(11)Inject hold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_MovePlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(435)(MoveId:=cMovePlast,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_PlastTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bDefaultPos:=TRUE,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsPlast,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(14)plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(12)sv_MovePlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(14)plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_MovePlast.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(10)cMovePlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Plast @RT(10)Plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_MoveIntrusion @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(420)(MoveId:=cMoveIntrusion,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_IntrusionTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_IntrusionSettings.dIntrusionTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='Intrusion',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsPlast,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementDuration)) @RT(18)intrusion movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(16)sv_MoveIntrusion @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(18)intrusion movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_MoveIntrusion.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(14)cMoveIntrusion @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Intrusion @RT(9)Intrusion @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_MovePVCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(136)(MoveId:=cMovePVCalib,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(14)sv_MovePVCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_MovePVCalib.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(12)cMovePVCalib @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Calib @RT(8)PV calib @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoveDecompBefPlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(491)(MoveId:=cMoveDecompBefPlast,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_dLastDecompBeforeTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationDecompBef,prTargetValue:=@%FU.sv_rTargetValueDecBefPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@%FU.sv_bActivatedDecompBeforePlast,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(28)decomp before plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_MoveDecompBefPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(28)decomp before plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoveDecompBefPlast.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)cMoveDecompBefPlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Decomp before @RT(19)Decomp before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoveDecompAftPlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(489)(MoveId:=cMoveDecompAftPlast,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_dLastDecompAfterTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationDecompAft,prTargetValue:=@%FU.sv_rTargetValueDecAftPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@%FU.sv_bActivatedDecompAfterPlast,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(27)decomp after plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_MoveDecompAftPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(27)decomp after plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoveDecompAftPlast.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)cMoveDecompAftPlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Decomp after @RT(18)Decomp after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_PlastEndMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(142)(pPlastProfile:=@%FU.sv_PlastProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rScrewPosition,pbPosReached:=@%FU.sv_bPlastEndReached) @RT(53)structure for maintenance of plasticizing endposition 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_PlastEndMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(180)(pPlastProfile:=@%FU.sv_PlastProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rScrewPosition,bFastMonitoring:=@%FU.sv_bDeviceReady,bPosReached:=@%FU.sv_bChargeEndReached) @RT(53)structure for maintenance of plasticizing endposition 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bPlastEndReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)flag if plast icizing endposition is reached 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Plast End Reached @RT(25)Plast Endposition Reached @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bPlastEndReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)flag if plast icizing endposition is reached 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Plast End Reached @RT(25)Plast Endposition Reached @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_MovePlastPurge @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(138)(MoveId:=cMovePlastPurge,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsPlast,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(26)plast movement for purging 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(17)sv_MovePlastPurge @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)(MoveDir:=cMoveBwd) @RT(26)plast movement for purging 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_MovePlastPurge.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(15)cMovePlastPurge @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Purge @RT(11)Plast purge @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_InjectMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(132)(pProfile:=@%FU.sv_InjectProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rScrewPosition,pbPosReached:=@%FU.sv_bInjectEnd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_InjectMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(168)(pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,bFastMonitoring:=@%FU.sv_bDeviceReady,bPosReached:=@%FU.sv_bMoldOpen) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rMonTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Endposition tolerance @RT(21)Endposition tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rMonTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Endposition tolerance @RT(21)Endposition tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rTolerancePosReached @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(28)tolerance for endpos reached 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt32 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMonTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Position reached tolerance  @RT(27)Position reached tolerance  @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rTolerancePosReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt32 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMonTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Position reached tolerance  @RT(27)Position reached tolerance  @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoveInjectInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(631)(MoveId:=cMoveFwdInterPos,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_InjectTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='InjectInterPos',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_InjectInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesInjectInterPos,pLastActiveTimeArray:=@%FU.sv_LastTimesInjectInterPos,sInstanceDataVar:='sv_InstanceDataInjectInterPos')) @RT(28)instanceable inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_MoveInjectInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(27)decomp after plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoveInjectInterPos.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)cMoveDecompAftPlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Inject up to pos. @RT(21)Inject up to position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MoveInjectPurge @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(140)(MoveId:=cMoveInjectPurge,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(27)inject movement for purging 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(18)sv_MoveInjectPurge @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)(MoveDir:=cMoveBwd) @RT(27)inject movement for purging 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoveInjectPurge.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cMoveInjectPurge @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Purge @RT(12)Inject Purge @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MoveDecompPurge @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(140)(MoveId:=cMoveDecompPurge,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(28)decomop movement for purging 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(18)sv_MoveDecompPurge @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)(MoveDir:=cMoveBwd) @RT(28)decomop movement for purging 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoveDecompPurge.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cMoveDecompPurge @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Purge @RT(12)Decomp purge @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MoveColdDrop @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(450)(MoveId:=cMoveColdDrop,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_ColdDropTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_ColdDropSettings.dColdDropTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='ColdDrop',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementDuration)) @RT(51)cold drop movement (time dependent inject movement) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(15)sv_MoveColdDrop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(18)intrusion movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_MoveColdDrop.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(14)cMoveIntrusion @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Cold slug eject @RT(15)Cold slug eject @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bInjectEnd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Screw fwd @RT(9)Screw fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bInjectEnd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Screw fwd @RT(9)Screw fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_MoveBeginInjectSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(275)(MoveId:=cMoveBeginSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginInjectSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(43)dummy movement for begin of inject sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(26)sv_MoveBeginInjectSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoveBeginInjectSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject sequence @RT(21)Begin inject sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_MoveEndInjectSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(271)(MoveId:=cMoveEndSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndInjectSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(41)dummy movement for end of inject sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(24)sv_MoveEndInjectSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_MoveEndInjectSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)End inject sequence @RT(19)End inject sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoveBeginPlastSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(274)(MoveId:=cMoveBeginSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginPlastSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(42)dummy movement for begin of plast sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(25)sv_MoveBeginPlastSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoveBeginPlastSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Plast sequence @RT(20)Begin plast sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_MoveEndPlastSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(270)(MoveId:=cMoveEndSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndPlastSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(40)dummy movement for end of plast sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(23)sv_MoveEndPlastSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_MoveEndPlastSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)End plast sequence @RT(18)End plast sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_bActivatedDecompBeforePlast @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(75)indicates if movement decompress should be activated if start event is sent 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(29)sv_bActivatedDecompAfterPlast @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(75)indicates if movement decompress should be activated if start event is sent 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(28)sv_dCalculatedDurationInject @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(41)Calculated inject duration (without hold) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Calculated inject duration @RT(26)Calculated inject duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_dCalculatedDurationInject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Calculated inject duration @RT(26)Calculated inject duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_dCalculatedDurationHold @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(24)Calculated hold duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Calculated hold duration @RT(24)Calculated hold duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_dCalculatedDurationHold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Calculated hold duration @RT(24)Calculated hold duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_dDurationInjectAndHold @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(25)Duration of inject + hold 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dDurationInjectAndHold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_dCalculatedDurationDecompAft @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(42)Calculated duration for decomp after plast 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(32)Calculated decomp after duration @RT(32)Calculated decomp after duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_dCalculatedDurationDecompAft @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(32)Calculated decomp after duration @RT(32)Calculated decomp after duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_dCalculatedDurationDecompBef @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(43)Calculated duration for decomp before plast 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(33)Calculated decomp before duration @RT(33)Calculated decomp before duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_dCalculatedDurationDecompBef @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(33)Calculated decomp before duration @RT(33)Calculated decomp before duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_dCalculatedDurationPlast @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#4s @RT(36)Calculated duration for plasticizing 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Calculated plasticize duration @RT(30)Calculated plasticize duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_dCalculatedDurationPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Calculated plasticize duration @RT(30)Calculated plasticize duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_dDurationCombinedPlast @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#4s @RT(45)Calculated duration for combined plasticizing 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(30)Calculated plasticize duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dDurationCombinedPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(30)Calculated plasticize duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_rInjectCalcDurationStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(49)Start position for calculation of inject duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Start pos inject calc duration @RT(30)Start pos inject calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_rInjectCalcDurationStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Start pos inject calc duration @RT(30)Start pos inject calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_rDecompAftCalcDurStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(61)Start position for calculation of decomp after plast duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(36)Start pos decomp after calc duration @RT(36)Start pos decomp after calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_rDecompAftCalcDurStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(36)Start pos decomp after calc duration @RT(36)Start pos decomp after calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_rDecompAftCalcDurEndPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)End position for calculation of decomp after plast duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(34)End pos decomp after calc duration @RT(34)End pos decomp after calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rDecompAftCalcDurEndPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(34)End pos decomp after calc duration @RT(34)End pos decomp after calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_rDecompBefCalcDurStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(62)Start position for calculation of decomp before plast duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(34)Start pos decomp bef calc duration @RT(34)Start pos decomp bef calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_rDecompBefCalcDurStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(34)Start pos decomp bef calc duration @RT(34)Start pos decomp bef calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_rDecompBefCalcDurEndPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)End position for calculation of decomp before plast duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(32)End pos decomp bef calc duration @RT(32)End pos decomp bef calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rDecompBefCalcDurEndPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(32)End pos decomp bef calc duration @RT(32)End pos decomp bef calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_rTargetValueDecBefPlast @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)target value of decomp before plast (in cm³) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Target value dec bef plast @RT(32)Target value decomp before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rTargetValueDecBefPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Target value dec bef plast @RT(32)Target value decomp before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_rTargetValueDecAftPlast @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)target value of decomp after plast (in cm³) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Plasticize stroke @RT(17)Plasticize stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rTargetValueDecAftPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Plasticize stroke @RT(17)Plasticize stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoveDecompInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(639)(MoveId:=cMoveDecompInterPos,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Decompression',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsDecomp,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_DecompInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesDecompInterPos,pLastActiveTimeArray:=@%FU.sv_LastTimesDecompInterPos,pProgrammedInSequenceArray:=@%FU.sv_DecompInterPosProgInSequ,sInstanceDataVar:='sv_InstanceDataDecompInterPos')) @RT(35)instanceable decompression movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_MoveDecompInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(27)decomp after plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoveDecompInterPos.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)cMoveDecompAftPlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Decomp. up to pos. @RT(28)Decompression up to position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_MoveCombinedPlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(591)(MoveId:=cMoveCombinedPlast,MoveDir:=cMoveBwd,pdActiveTimeAct:=@%FU.sv_dActPlastDecompTime,pdLastActiveTime:=@%FU.sv_dLastPlastDecompTime,pdCalculatedDuration:=@%FU.sv_dDurationCombinedPlast,prTargetValue:=@%FU.sv_rTargetValueDecAftPlast,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bIgnoreByABControl:=TRUE,iSafetyIdentifier:=0,sMoveId:='Plast',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementCombinedPlast,sElementData:='sv_CombinedPlastData',sLGInstanceProperties:='LG_CombinedPlast')) @RT(61)combined plast movement (decomp bef -> plast -> decomp after) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(20)sv_MoveCombinedPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(14)plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_MoveCombinedPlast.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(10)cMovePlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Plast @RT(10)Plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bCombinedPlastReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(20)combined plast ready 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Combined plast ready @RT(20)Combined plast ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bCombinedPlastReady @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(20)combined plast ready 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Combined plast ready @RT(20)Combined plast ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_CombinedPlastData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsCombinedPlastData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(543)(DecompBefore:=(prTargetValue:=@%FU.sv_rTargetValueDecBefPlast,pdDelayTime:=@%FU.sv_DecompTimesSet.dSetDelayTime,pdDuration:=@%FU.sv_dCalculatedDurationDecompBef,sODCIcon:='\hmi\images\editDecomp.gif'),Plast:=(pdDelayTime:=@%FU.sv_PlastTimesSet.dSetDelayTime,pdDuration:=@%FU.sv_dCalculatedDurationPlast,sODCIcon:='\hmi\images\editPlast.gif'),DecompAfter:=(prTargetValue:=@%FU.sv_rTargetValueDecAftPlast,pdDelayTime:=@%FU.sv_DecompTimesSet.dSetDelayTime,pdDuration:=@%FU.sv_dCalculatedDurationDecompAft,sODCIcon:='\hmi\images\editDecomp.gif')) @RT(66)necessary data for diplaying combined plast movement in odc editor 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(27)sv_DecompInterPosProgInSequ @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)information, which instances are programmed in sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(20)sv_InjectAndHoldData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tsInjectHoldElementData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(142)(pdInjectDuration:=@%FU.sv_dCalculatedDurationInject,pdHoldDuration:=@%FU.sv_dCalculatedDurationHold,sODCHoldIcon:='\hmi\images\editHold.gif') @RT(67)necessary data for diplaying inject and hold movement in odc editor 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(27)sv_rInjectInterruptPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)interrupt position (for instanceable inject movement) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_rInjectInterruptPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rInjectInterruptAcc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)Acceleration to continune after inject interrupt position 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rInjectInterruptAcc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rInjectInterruptDec @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)Deceleration to reach inject interrupt position 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rInjectInterruptDec @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Fwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bHoldActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(79)TRUE: holding is active; attention: SV is resetted after end of inject movement 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Hold active @RT(11)Hold active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bHoldActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(70)holding is active; attention: is resetted after end of inject movement 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Hold active @RT(11)Hold active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MoveInjectCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(233)(MoveId:=cMoveInjectCalib,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsInject,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(43)inject movement for inject controller calib 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(18)sv_MoveInjectCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(18)intrusion movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoveInjectCalib.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(14)cMoveIntrusion @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Cold slug eject @RT(15)Cold slug eject @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bInjectionActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(99)any inject (screw fwd) movement is active   Attention: this variable is set in every operation mode 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Inject active @RT(16)Injection active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bInjectionActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)Injection is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Inject active @RT(16)Injection active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bDecompActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)any decompression movement active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Decomp active @RT(20)Decompression active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bDecompActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)Injection is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Decomp active @RT(20)Decompression active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_bPlastActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)plasticize movement is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Plast active @RT(12)Plast active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_bPlastActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)Plasticize is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Plast active @RT(12)Plast active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dActPlastDecompTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)act time for combined plast movement 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dActPlastDecompTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dLastPlastDecompTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)last time for combined plast movement 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dLastPlastDecompTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iCtrlParamSet @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(30)pid control set of speed pump  
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Control Parameter Set @RT(21)Control Parameter Set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iCtrlParamSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Control Parameter Set @RT(21)Control Parameter Set @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_ActiveTimesInjectInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_ActiveTimesInjectInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_ActiveTimesDecompInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_ActiveTimesDecompInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_LastTimesInjectInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_LastTimesInjectInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_LastTimesDecompInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_LastTimesDecompInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_dActInjectHoldTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(38)actual time (contains inject and hold) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_dActInjectHoldTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(38)actual time (contains inject and hold) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dLastInjectHoldTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)last movement time (contains inject and hold) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dLastInjectHoldTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(38)actual time (contains inject and hold) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_bIgnoreStopAtCutOffNoHold @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ignore stop at cutoff @RT(21)Ignore stop at cutoff @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_bIgnoreStopAtCutOffNoHold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ignore stop at cutoff @RT(21)Ignore stop at cutoff @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erNotPlasticized @RT(1)3 @RT(1)y @RT(49)system.evAlarmAutoManual, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(793)%1t%2n not plasticized{#]The plasticizing movement has not \u000areached its end or targetposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause plasticizing has not reached its end or targetposition.{#]Activate plasticizing to reach its end- or targetposition before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check the \u000aplasticizing output settings ({Injection1.sv_PlastProfVis.Profile.Points[1].rRotation:c:backpressure} / {Injection1.sv_PlastProfVis.Profile.Points[1].rRotation:c:speed}) and if necessary adjust them to \u000aallow plasticizing to finish properly before restarting cyclic operation.<br>\u000aIt is also possible to check if the material feed has been interrupted. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
