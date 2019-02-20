%IMPORT_OVER_LISTFILE_SOURCE
 fmtPosReached
, Stroke
, fmt31
, VG_MachineData
, VG_MoldData
, VG_SequenceData
, Time
, LG_MoldCloseInterPos
, Percent
, fmt41
, LG_MoldOpenInterPos

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, tsEndPosData
, tyInstanceListArray
, tyInterCondBoolArray
, tsMovementHistory
, tyInterCondTimeArray
, cMoveBwd
, cMoveFwd
, nMoveDirectionMinToMax
, nODCElementMovement
, cMoveBwdForMHAdjust
, cMoveBwdInterPos
, nMoveDirectionMaxToMin
, cMoveCoining
, cMoveAll
, cMoveVenting
, cMoveFwdForMHAdjust
, cMoveFwdInterPos
, cMoveBwdForMHAdjustSetup
, cMoveFwdForMHAdjustSetup
, cMoveBeginSequence
, nODCElementSequenceBound
, cMoveEndSequence
, cMovePVCalib
, cLevelSuperUser
, cLevelStartupTechnican
, cLevelProduction
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveOpen : tsMoveData := (MoveId:=cMoveBwd,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_dLastOpenTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationOpen,prTargetValue:=@%FU.sv_rMoldOpenPosSet,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bDefaultPos:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveFwd,sMoveId:='Bwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveOpen.MoveId
    
// Open Mold open
;
 sv_MoveOpenForMHAdj : tsMoveData := (MoveId:=cMoveBwdForMHAdjust,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* move backward for mold height auto adjustment *)
    
%ELEMENT sv_MoveOpenForMHAdj.MoveId
    
// Open adjust Mold open adjust
;
 sv_MoveOpenInterPos : tsMoveData := (MoveId:=cMoveBwdInterPos,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_MoldOpenTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveFwd,sMoveId:='BwdInterPos',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_MoldOpenInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesOpenInterPos,pLastActiveTimeArray:=@%FU.sv_LastMoveTimesOpenInterPos,pPosReachedArray:=@%FU.sv_PosReachedArrayOpenInterPos,pProgrammedInSequenceArray:=@%FU.sv_OpenInterPosProgInSequ,sInstanceDataVar:='sv_InstanceDataOpenInterPos')) (* move backward to intermediate position *)
    
%ELEMENT sv_MoveOpenInterPos.MoveId
    
// Open up to pos. Mold open up to position
;
 sv_MoveClose : tsMoveData := (MoveId:=cMoveFwd,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastCloseTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationClose,prTargetValue:=@%FU.sv_rMoldClosePosition,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Fwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveClose.MoveId
    
// Close Mold close
;
 sv_MoveCoining : tsMoveData := (MoveId:=cMoveCoining,MoveDir:=cMoveAll,pdLastActiveTime:=@%FU.sv_MoldCoiningTimesAct.dLastMoveTime,pbStartConditionReached:=@%FU.sv_bCoiningStartPointDetected,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=1,sMoveId:='Coining',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsCoining))
    
%ELEMENT sv_MoveCoining.MoveId
    
// Coining Coining
;
 sv_MoveVenting : tsMoveData := (MoveId:=cMoveVenting,MoveDir:=cMoveAll,pdLastActiveTime:=@%FU.sv_MoldVentingTimesAct.dLastMoveTime,pbStartConditionReached:=@%FU.sv_bVentingStartPointDetected,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=1,sMoveId:='Venting',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsVenting))
    
%ELEMENT sv_MoveVenting.MoveId
    
// Venting Venting
;
 sv_MoveCloseForMHAdj : tsMoveData := (MoveId:=cMoveFwdForMHAdjust,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* move forward for mold height auto adjustment *)
    
%ELEMENT sv_MoveCloseForMHAdj.MoveId
    
// Close adjust Mold close adjust
;
 sv_MoveCloseInterPos : tsMoveData := (MoveId:=cMoveFwdInterPos,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_MoldCloseTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='FwdInterPos',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_MoldCloseInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesCloseInterPos,pLastActiveTimeArray:=@%FU.sv_LastMoveTimesCloseInterPos,pPosReachedArray:=@%FU.sv_PosReachedArrayCloseInterPos,pProgrammedInSequenceArray:=@%FU.sv_CloseInterPosProgInSequ,sInstanceDataVar:='sv_InstanceDataCloseInterPos')) (* move forward to intermediate position *)
    
%ELEMENT sv_MoveCloseInterPos.MoveId
    
// Close up to pos. Mold close up to position
;
 sv_bMoldClosed : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Mold Closed Mold Closed
;
 sv_bMoldOpen : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Mold open Mold open
;
 sv_rMonTolerance : REAL := 0.5 (* tolerance for endpos monitoring *)
 %PLAUSIBILITY 0.0..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Endposition tolerance Endposition tolerance
;
 sv_rTolerancePosReached : REAL := 0.0 (* tolerance for endpos reached *)
 %PLAUSIBILITY 0.0..%FU.sv_rMonTolerance    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Position reached tolerance  Position reached tolerance 
;
 sv_MoldBwdMonData : tsEndPosData := (pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,pbPosReached:=@%FU.sv_bMoldOpen)
    ;
 sv_MoveOpenForMHAdjSetup : tsMoveData := (MoveId:=cMoveBwdForMHAdjustSetup,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* move backward for mold height auto adjustment (setup profile) *)
    
%ELEMENT sv_MoveOpenForMHAdjSetup.MoveId
    
// Open adjust setup Mold open adjust setup
;
 sv_MoveCloseForMHAdjSetup : tsMoveData := (MoveId:=cMoveFwdForMHAdjustSetup,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* move forward for mold height auto adjustment (setup profile) *)
    
%ELEMENT sv_MoveCloseForMHAdjSetup.MoveId
    
// Close adjust setup Mold close adjust setup
;
 sv_MoveBeginClosingSequence : tsMoveData := (MoveId:=cMoveBeginSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginClosingSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for begin of closing sequence *)
    
%ELEMENT sv_MoveBeginClosingSequence.MoveId
    
// Closing sequence Begin mold closing sequence
;
 sv_MoveEndClosingSequence : tsMoveData := (MoveId:=cMoveEndSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndClosingSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for end of closing sequence *)
    
%ELEMENT sv_MoveEndClosingSequence.MoveId
    
// End closing sequence End mold closing sequence
;
 sv_MoveBeginOpeningSequence : tsMoveData := (MoveId:=cMoveBeginSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginOpeningSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for begin of opening sequence *)
    
%ELEMENT sv_MoveBeginOpeningSequence.MoveId
    
// Opening sequence Begin mold opening sequence
;
 sv_MoveEndOpeningSequence : tsMoveData := (MoveId:=cMoveEndSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndOpeningSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for end of opening sequence *)
    
%ELEMENT sv_MoveEndOpeningSequence.MoveId
    
// End opening sequence End mold opening sequence
;
 sv_InstanceDataCloseInterPos : tyInstanceListArray (* array with target positions of mold close interpos movements *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData 
%ELEMENT sv_InstanceDataCloseInterPos[0].dCalculatedDuration
 %PLAUSIBILITY t#0s..t#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration

%ELEMENT sv_InstanceDataCloseInterPos[0].dDelay
 %PLAUSIBILITY t#0s..t#60s      %LIST_GROUP LG_MoldCloseInterPos(4,4)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Delay

%ELEMENT sv_InstanceDataCloseInterPos[0].rAcceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %LIST_GROUP LG_MoldCloseInterPos(3,3)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp up Ramp up

%ELEMENT sv_InstanceDataCloseInterPos[0].rDeceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %LIST_GROUP LG_MoldCloseInterPos(2,2)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp down Ramp down

%ELEMENT sv_InstanceDataCloseInterPos[0].rTargetValue
 %PLAUSIBILITY Mold1.sv_MoldFwdProfVisSrc.Profile.Points[19].rStartPos..%FU.sv_rMoldOpenPosSet      %LIST_GROUP LG_MoldCloseInterPos(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Position Target Position
;
 sv_InstanceDataOpenInterPos : tyInstanceListArray (* array with target positions of mold open interpos movements *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData 
%ELEMENT sv_InstanceDataOpenInterPos[0].dCalculatedDuration
 %PLAUSIBILITY t#0s..t#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration

%ELEMENT sv_InstanceDataOpenInterPos[0].dDelay
 %PLAUSIBILITY t#0s..t#60s      %LIST_GROUP LG_MoldOpenInterPos(4,4)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Delay

%ELEMENT sv_InstanceDataOpenInterPos[0].rAcceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %LIST_GROUP LG_MoldOpenInterPos(3,3)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp up Ramp up

%ELEMENT sv_InstanceDataOpenInterPos[0].rDeceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %LIST_GROUP LG_MoldOpenInterPos(2,2)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp down Ramp down

%ELEMENT sv_InstanceDataOpenInterPos[0].rTargetValue
 %PLAUSIBILITY 0.0..%FU.sv_rMoldOpenPosSet      %LIST_GROUP LG_MoldOpenInterPos(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Position Target Position
;
 sv_dCalculatedDurationOpen : TIME := T#2s (* Calculated duration for mold open *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalculatedDurationClose : TIME := T#2s (* Calculated duration for mold close *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_CloseInterPosProgInSequ : tyInterCondBoolArray (* information, which instances of mold close interpos movement are programmed in sequence  *)
    ;
 sv_OpenInterPosProgInSequ : tyInterCondBoolArray (* information, which instances of mold open interpos movement are programmed in sequence *)
    ;
 sv_PosReachedArrayCloseInterPos : tyInterCondBoolArray (* array with pos reached information for all instances of mold close inter pos movement *)
    ;
 sv_PosReachedArrayOpenInterPos : tyInterCondBoolArray (* array with pos reached information for all instances of mold open inter pos movement *)
    ;
 sv_bIgnoreDefaultConditions : BOOL (* TRUE: ignore programmed default conditions in ABDefaultConditions.pu *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
;
 sv_rInterPosMonTolerance : REAL (* tolerance for intermediate position monitoring *)
 %PLAUSIBILITY 0.0..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Stroke ;
 sv_iCtrlParamSet : INT := 2 (* pid control set of speed pump  *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// Control Parameter Set Control Parameter Set
;
 sv_MovementHistory : tsMovementHistory
    ;
 sv_bStepPosReached : BOOL (* TRUE: target position of step bwd movement reached (only needed for stepping bwd) *)
    ;
 sv_dActCloseTime : TIME (* includes pressure build up time, this time is not increased when interpos movement is active *)
     %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_dActOpenTime : TIME (* this time is not increased when interpos movement is active *)
     %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_dLastCloseTime : TIME
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_dLastOpenTime : TIME
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_ActiveTimesCloseInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_ActiveTimesOpenInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_LastMoveTimesCloseInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_LastMoveTimesOpenInterPos : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
 sv_MovePVCalib : tsMoveData := (MoveId:=cMovePVCalib,MoveDir:=cMoveFwd,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) (* movement for pressure calib *)
    
%ELEMENT sv_MovePVCalib.MoveId
    
// Calib PV calib
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
41 
@SysVar @RT(11)sv_MoveOpen @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(504)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_dLastOpenTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationOpen,prTargetValue:=@%FU.sv_rMoldOpenPosSet,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bDefaultPos:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveFwd,sMoveId:='Bwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_MoveOpen.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveBwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Open @RT(9)Mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoveOpenForMHAdj @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(141)(MoveId:=cMoveBwdForMHAdjust,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(45)move backward for mold height auto adjustment 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(19)sv_MoveOpenForMHAdj @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(45)move backward for mold height auto adjustment 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_MoveOpenForMHAdj.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)cMoveBwdForMHAdjust @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Open adjust @RT(16)Mold open adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoveOpenInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(774)(MoveId:=cMoveBwdInterPos,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_MoldOpenTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveFwd,sMoveId:='BwdInterPos',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_MoldOpenInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesOpenInterPos,pLastActiveTimeArray:=@%FU.sv_LastMoveTimesOpenInterPos,pPosReachedArray:=@%FU.sv_PosReachedArrayOpenInterPos,pProgrammedInSequenceArray:=@%FU.sv_OpenInterPosProgInSequ,sInstanceDataVar:='sv_InstanceDataOpenInterPos')) @RT(38)move backward to intermediate position 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_MoveOpenInterPos.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cMoveBwdInterPos @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Open up to pos. @RT(24)Mold open up to position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_MoveClose @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(492)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastCloseTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationClose,prTargetValue:=@%FU.sv_rMoldClosePosition,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Fwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_MoveClose.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveFwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Close @RT(10)Mold close @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_MoveCoining @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(289)(MoveId:=cMoveCoining,MoveDir:=cMoveAll,pdLastActiveTime:=@%FU.sv_MoldCoiningTimesAct.dLastMoveTime,pbStartConditionReached:=@%FU.sv_bCoiningStartPointDetected,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=1,sMoveId:='Coining',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsCoining)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_MoveCoining.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveFwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Coining @RT(7)Coining @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_MoveVenting @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(289)(MoveId:=cMoveVenting,MoveDir:=cMoveAll,pdLastActiveTime:=@%FU.sv_MoldVentingTimesAct.dLastMoveTime,pbStartConditionReached:=@%FU.sv_bVentingStartPointDetected,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=1,sMoveId:='Venting',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsVenting)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_MoveVenting.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveFwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Venting @RT(7)Venting @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_MoveCloseForMHAdj @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(142)(MoveId:=cMoveFwdForMHAdjust,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(44)move forward for mold height auto adjustment 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(20)sv_MoveCloseForMHAdj @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(44)move forward for mold height auto adjustment 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_MoveCloseForMHAdj.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)cMoveFwdForMHAdjust @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Close adjust @RT(17)Mold close adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_MoveCloseInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(782)(MoveId:=cMoveFwdInterPos,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_MoldCloseTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='FwdInterPos',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement,sLGInstanceProperties:='LG_MoldCloseInterPos'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActiveTimesCloseInterPos,pLastActiveTimeArray:=@%FU.sv_LastMoveTimesCloseInterPos,pPosReachedArray:=@%FU.sv_PosReachedArrayCloseInterPos,pProgrammedInSequenceArray:=@%FU.sv_CloseInterPosProgInSequ,sInstanceDataVar:='sv_InstanceDataCloseInterPos')) @RT(37)move forward to intermediate position 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_MoveCloseInterPos.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cMoveFwdInterPos @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Close up to pos. @RT(25)Mold close up to position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bMoldClosed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Mold Closed @RT(11)Mold Closed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bMoldClosed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Mold Closed @RT(11)Mold Closed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_bMoldOpen @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Mold open @RT(9)Mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_bMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Mold open @RT(9)Mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rMonTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Endposition tolerance @RT(21)Endposition tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rMonTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Endposition tolerance @RT(21)Endposition tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rTolerancePosReached @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(28)tolerance for endpos reached 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMonTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Position reached tolerance  @RT(27)Position reached tolerance  @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rTolerancePosReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMonTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Position reached tolerance  @RT(27)Position reached tolerance  @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_MoldBwdMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(131)(pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,pbPosReached:=@%FU.sv_bMoldOpen) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(24)sv_MoveOpenForMHAdjSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(146)(MoveId:=cMoveBwdForMHAdjustSetup,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsOpen,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(61)move backward for mold height auto adjustment (setup profile) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(24)sv_MoveOpenForMHAdjSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(61)move backward for mold height auto adjustment (setup profile) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_MoveOpenForMHAdjSetup.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(24)cMoveBwdForMHAdjustSetup @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Open adjust setup @RT(22)Mold open adjust setup @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoveCloseForMHAdjSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(147)(MoveId:=cMoveFwdForMHAdjustSetup,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(60)move forward for mold height auto adjustment (setup profile) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(25)sv_MoveCloseForMHAdjSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(60)move forward for mold height auto adjustment (setup profile) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoveCloseForMHAdjSetup.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(24)cMoveFwdForMHAdjustSetup @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Close adjust setup @RT(23)Mold close adjust setup @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_MoveBeginClosingSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(276)(MoveId:=cMoveBeginSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginClosingSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(44)dummy movement for begin of closing sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(27)sv_MoveBeginClosingSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MoveBeginClosingSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Closing sequence @RT(27)Begin mold closing sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoveEndClosingSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(272)(MoveId:=cMoveEndSequence,MoveDir:=cMoveFwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndClosingSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(42)dummy movement for end of closing sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(25)sv_MoveEndClosingSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoveEndClosingSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)End closing sequence @RT(25)End mold closing sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_MoveBeginOpeningSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(276)(MoveId:=cMoveBeginSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginOpeningSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(44)dummy movement for begin of opening sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(27)sv_MoveBeginOpeningSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MoveBeginOpeningSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Opening sequence @RT(27)Begin mold opening sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoveEndOpeningSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(272)(MoveId:=cMoveEndSequence,MoveDir:=cMoveBwd,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndOpeningSequence',AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(42)dummy movement for end of opening sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(25)sv_MoveEndOpeningSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoveEndOpeningSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)End opening sequence @RT(25)End mold opening sequence @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_InstanceDataCloseInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyInstanceListArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)array with target positions of mold close interpos movements 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(28)sv_InstanceDataCloseInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(51)sv_InstanceDataCloseInterPos[0].dCalculatedDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_InstanceDataCloseInterPos[0].dDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)set delaytime 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(25)LG_MoldCloseInterPos(4,4) @RT(0) 
@RT(5)Delay @RT(5)Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_InstanceDataCloseInterPos[0].rAcceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(28)acceleration from this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(25)LG_MoldCloseInterPos(3,3) @RT(0) 
@RT(7)Ramp up @RT(7)Ramp up @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_InstanceDataCloseInterPos[0].rDeceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(32)deceleration to reach this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(25)LG_MoldCloseInterPos(2,2) @RT(0) 
@RT(9)Ramp down @RT(9)Ramp down @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_InstanceDataCloseInterPos[0].rTargetValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(79)Mold1.sv_MoldFwdProfVisSrc.Profile.Points[19].rStartPos..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(25)LG_MoldCloseInterPos(1,1) @RT(0) 
@RT(8)Position @RT(15)Target Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_InstanceDataOpenInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyInstanceListArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)array with target positions of mold open interpos movements 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(27)sv_InstanceDataOpenInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(50)sv_InstanceDataOpenInterPos[0].dCalculatedDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_InstanceDataOpenInterPos[0].dDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)set delaytime 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(24)LG_MoldOpenInterPos(4,4) @RT(0) 
@RT(5)Delay @RT(5)Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_InstanceDataOpenInterPos[0].rAcceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)acceleration from this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(24)LG_MoldOpenInterPos(3,3) @RT(0) 
@RT(7)Ramp up @RT(7)Ramp up @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_InstanceDataOpenInterPos[0].rDeceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)deceleration to reach this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(24)LG_MoldOpenInterPos(2,2) @RT(0) 
@RT(9)Ramp down @RT(9)Ramp down @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_InstanceDataOpenInterPos[0].rTargetValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(24)LG_MoldOpenInterPos(1,1) @RT(0) 
@RT(8)Position @RT(15)Target Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_dCalculatedDurationOpen @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(33)Calculated duration for mold open 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_dCalculatedDurationOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_dCalculatedDurationClose @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(34)Calculated duration for mold close 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_dCalculatedDurationClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_CloseInterPosProgInSequ @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)information, which instances of mold close interpos movement are programmed in sequence  
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_CloseInterPosProgInSequ @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)information, which instances of mold close interpos movement are programmed in sequence  
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_OpenInterPosProgInSequ @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(86)information, which instances of mold open interpos movement are programmed in sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(31)sv_PosReachedArrayCloseInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)array with pos reached information for all instances of mold close inter pos movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(30)sv_PosReachedArrayOpenInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(84)array with pos reached information for all instances of mold open inter pos movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(27)sv_bIgnoreDefaultConditions @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(68)TRUE: ignore programmed default conditions in ABDefaultConditions.pu 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_bIgnoreDefaultConditions @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rInterPosMonTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)tolerance for intermediate position monitoring 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rInterPosMonTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iCtrlParamSet @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(30)pid control set of speed pump  
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


@SysVar @RT(18)sv_MovementHistory @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsMovementHistory @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_bStepPosReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(81)TRUE: target position of step bwd movement reached (only needed for stepping bwd) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_dActCloseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(92)includes pressure build up time, this time is not increased when interpos movement is active 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_dActCloseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_dActOpenTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)this time is not increased when interpos movement is active 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_dActOpenTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_dLastCloseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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
@AttrSym @RT(17)sv_dLastCloseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_dLastOpenTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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
@AttrSym @RT(16)sv_dLastOpenTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_ActiveTimesCloseInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(27)sv_ActiveTimesCloseInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_ActiveTimesOpenInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(26)sv_ActiveTimesOpenInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_LastMoveTimesCloseInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(29)sv_LastMoveTimesCloseInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_LastMoveTimesOpenInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(28)sv_LastMoveTimesOpenInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_MovePVCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(156)(MoveId:=cMovePVCalib,MoveDir:=cMoveFwd,iSafetyIdentifier:=0,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsClose,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(27)movement for pressure calib 
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


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
0 

@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
