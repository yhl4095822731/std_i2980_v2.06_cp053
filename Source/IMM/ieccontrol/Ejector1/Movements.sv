%IMPORT_OVER_LISTFILE_SOURCE
 fmtPosReached
, Stroke
, fmt31
, VG_MachineData
, fmt32
, Time
, EjectorState
, fmt41
, LG_EjectorShake
, VG_SequenceData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, tsEndPosData
, tsShakeParams
, cMoveFwd
, cMoveBwd
, nMoveDirectionMinToMax
, nODCElementMovement
, nMoveDirectionMaxToMin
, cMoveShake
, cMoveAll
, nODCElementShake
, cLevelSuperUser
, cLevelStartupTechnican
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveFwd : tsMoveData := (MoveId:=cMoveFwd,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_EjectorFwdTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationFwd,prTargetValue:=@%FU.sv_rSetFwdPosition,pbStartConditionReached:=@system.sv_bTRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Fwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveFwd.MoveId
    
// Forward Ejector forward
;
 sv_MoveBwd : tsMoveData := (MoveId:=cMoveBwd,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_EjectorBwdTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationBwd,prTargetValue:=@%FU.sv_rSetBwdPosition,pbStartConditionReached:=@system.sv_bTRUE,bDefaultPos:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveFwd,sMoveId:='Bwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveBwd.MoveId
    
// Backward Ejector backward
;
 sv_MoveShake : tsMoveData := (MoveId:=cMoveShake,MoveDir:=cMoveAll,pdLastActiveTime:=@%FU.sv_EjectorShakeTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationShake,prTargetValue:=@%FU.sv_ShakeParams.rShakePosition,pbStartConditionReached:=@system.sv_bTRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Shake',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementShake,sElementData:='sv_ShakeParams',sLGInstanceProperties:='LG_EjectorShake'))
    
%ELEMENT sv_MoveShake.MoveId
    
// Shake Ejector shake
;
 sv_EjectorBwdMonData : tsEndPosData := (pProfile:=@%FU.sv_EjectorBwdVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rEjectorPosition,pbDI:=@%FU.di_EjectorBwd,pbPosReached:=@%FU.sv_bEjectorBwd)
    ;
 sv_EjectorFwdMonData : tsEndPosData := (pProfile:=@%FU.sv_EjectorFwdVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rEjectorPosition,pbPosReached:=@%FU.sv_bEjectorFwd)
    ;
 sv_bEjectorBwd : BOOL (* ejector is in bwd endposition *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Ejector bwd Ejector bwd
;
 sv_bEjectorFwd : BOOL (* ejector is in fwd endposition *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Ejector fwd Ejector fwd
;
 sv_rMonTolerance : REAL := 0.5 (* tolerance for endpos monitoring *)
 %PLAUSIBILITY 0.0..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Endposition tolerance Endposition tolerance
;
 sv_rTolerancePosReached : REAL := 0.0 (* tolerance for endpos reached *)
 %PLAUSIBILITY 0.0..%FU.sv_rMonTolerance    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32  %UNIT Stroke 
// Position reached tolerance  Position reached tolerance 
;
 sv_bActivated : BOOL (* TRUE if ejector is activated (mode <> nNoUse) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Ejector activated Ejector activated
;
 sv_iODCSelector : INT (* selector variable (for sequence generation) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Selector Selector
;
 sv_bStartConditionReached : BOOL (* start condition for parallel ejector movement reached *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Start condition ok Start condition reached
;
 sv_ShakeParams : tsShakeParams := (rShakePosition:=20.0,iShakeCounter:=1)
    ;
 sv_rSetFwdPosition : REAL (* set fwd position *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Set fwd pos. Set fwd position
;
 sv_rSetBwdPosition : REAL (* set bwd position *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Set bwd pos. Set bwd position
;
 sv_dCalculatedDurationFwd : TIME := T#2s (* Calculated duration for ejector fwd *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalculatedDurationBwd : TIME := T#2s (* Calculated duration for ejector bwd *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalculatedDurationShake : TIME := T#2s (* Calculated duration for complete ejector shake *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalculatedDurationShakeFwd : TIME := T#2s (* Calculated duration for ejector shake fwd (1 count) *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated shake fwd duration Calculated shake fwd duration
;
 sv_dCalculatedDurationShakeBwd : TIME := T#2s (* Calculated duration for ejector shake bwd (1 count) *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Calculated shake bwd duration Calculated shake bwd duration
;
 sv_rFwdCalcDurationStartPos : REAL (* Start position for calculation of ejector fwd duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rEjectorStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Stroke 
// Start pos ejector fwd calc duration Start pos ejector fwd calc duration
;
 sv_rBwdCalcDurationStartPos : REAL (* Start position for calculation of ejector bwd duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rEjectorStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Stroke 
// Start pos ejector bwd calc duration Start pos ejector bwd calc duration
;
 sv_rShakeFwdCalcDurStartPos : REAL (* Start position for calculation of ejector fwd shake duration *)
 %PLAUSIBILITY 0.0..%FU.sv_rEjectorStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Stroke 
// Start pos ejector fwd shake calc duration Start pos ejector fwd shake calc duration
;
 sv_iActState : DINT (* actual state (used for displaying a text in odc editor) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT EjectorState 
// Act. state Actual device state
;
 sv_bIgnoreDefaultConditions : BOOL (* TRUE: ignore programmed default conditions in ABDefaultConditions.pu *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
;
 sv_rShakeTargetPos : REAL
 %PLAUSIBILITY %FU.sv_rMinPlausShakeTargetPos..%FU.sv_rMaxPlausShakeTargetPos    RETAIN  %VARIABLE_GROUP VG_SequenceData  %LIST_GROUP LG_EjectorShake(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Shake target position Shake target position
;
 sv_rMinPlausShakeTargetPos : REAL (* minimum plaus for shake target position *)
    ;
 sv_rMaxPlausShakeTargetPos : REAL (* maximum plaus for shake target position *)
    ;
 sv_iCtrlParamSet : INT := 2 (* pid control set of speed pump  *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// Control Parameter Set Control Parameter Set
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
29 
@SysVar @RT(10)sv_MoveFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(470)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_EjectorFwdTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationFwd,prTargetValue:=@%FU.sv_rSetFwdPosition,pbStartConditionReached:=@system.sv_bTRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Fwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(10)sv_MoveFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(17)sv_MoveFwd.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveFwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Forward @RT(15)Ejector forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_MoveBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(488)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_EjectorBwdTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationBwd,prTargetValue:=@%FU.sv_rSetBwdPosition,pbStartConditionReached:=@system.sv_bTRUE,bDefaultPos:=TRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveFwd,sMoveId:='Bwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(10)sv_MoveBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(17)sv_MoveBwd.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveBwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Backward @RT(16)Ejector backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_MoveShake @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(524)(MoveId:=cMoveShake,MoveDir:=cMoveAll,pdLastActiveTime:=@%FU.sv_EjectorShakeTimesAct.dLastMoveTime,pdCalculatedDuration:=@%FU.sv_dCalculatedDurationShake,prTargetValue:=@%FU.sv_ShakeParams.rShakePosition,pbStartConditionReached:=@system.sv_bTRUE,iSafetyIdentifier:=1,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Shake',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(MovementType:=nODCElementShake,sElementData:='sv_ShakeParams',sLGInstanceProperties:='LG_EjectorShake')) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(12)sv_MoveShake @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_MoveShake.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(10)cMoveShake @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Shake @RT(13)Ejector shake @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_EjectorBwdMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(160)(pProfile:=@%FU.sv_EjectorBwdVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rEjectorPosition,pbDI:=@%FU.di_EjectorBwd,pbPosReached:=@%FU.sv_bEjectorBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_EjectorBwdMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(168)(pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,bFastMonitoring:=@%FU.sv_bDeviceReady,bPosReached:=@%FU.sv_bMoldOpen) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_EjectorFwdMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(135)(pProfile:=@%FU.sv_EjectorFwdVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rEjectorPosition,pbPosReached:=@%FU.sv_bEjectorFwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_EjectorFwdMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(168)(pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,bFastMonitoring:=@%FU.sv_bDeviceReady,bPosReached:=@%FU.sv_bMoldOpen) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bEjectorBwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ejector is in bwd endposition 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Ejector bwd @RT(11)Ejector bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bEjectorBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ejector is in bwd endposition 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Ejector bwd @RT(11)Ejector bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bEjectorFwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ejector is in fwd endposition 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Ejector fwd @RT(11)Ejector fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bEjectorFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ejector is in fwd endposition 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Ejector fwd @RT(11)Ejector fwd @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(13)sv_bActivated @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)TRUE if ejector is activated (mode <> nNoUse) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Ejector activated @RT(17)Ejector activated @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bActivated @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)TRUE if airvalve is activated (mode <> nAirModeOff) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Ejector activated @RT(17)Ejector activated @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_iODCSelector @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)selector variable (for sequence generation) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Selector @RT(8)Selector @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_iODCSelector @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)selector variable (for sequence generation) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Selector @RT(8)Selector @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_bStartConditionReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)start condition for parallel ejector movement reached 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Start condition ok @RT(23)Start condition reached @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_bStartConditionReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Start condition ok @RT(23)Start condition reached @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ShakeParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsShakeParams @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(39)(rShakePosition:=20.0,iShakeCounter:=1) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_rSetFwdPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)set fwd position 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Set fwd pos. @RT(16)Set fwd position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rSetFwdPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)set fwd position 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Set fwd pos. @RT(16)Set fwd position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rSetBwdPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)set bwd position 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Set bwd pos. @RT(16)Set bwd position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rSetBwdPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)set fwd position 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Set bwd pos. @RT(16)Set bwd position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_dCalculatedDurationFwd @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(35)Calculated duration for ejector fwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dCalculatedDurationFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_dCalculatedDurationBwd @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(35)Calculated duration for ejector bwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dCalculatedDurationBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_dCalculatedDurationShake @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(46)Calculated duration for complete ejector shake 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_dCalculatedDurationShake @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_dCalculatedDurationShakeFwd @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(51)Calculated duration for ejector shake fwd (1 count) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Calculated shake fwd duration @RT(29)Calculated shake fwd duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_dCalculatedDurationShakeFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Calculated shake fwd duration @RT(29)Calculated shake fwd duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_dCalculatedDurationShakeBwd @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(51)Calculated duration for ejector shake bwd (1 count) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Calculated shake bwd duration @RT(29)Calculated shake bwd duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_dCalculatedDurationShakeBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Calculated shake bwd duration @RT(29)Calculated shake bwd duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_rFwdCalcDurationStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)Start position for calculation of ejector fwd duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Start pos ejector fwd calc duration @RT(35)Start pos ejector fwd calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_rFwdCalcDurationStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Start pos ejector fwd calc duration @RT(35)Start pos ejector fwd calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_rBwdCalcDurationStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)Start position for calculation of ejector bwd duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Start pos ejector bwd calc duration @RT(35)Start pos ejector bwd calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_rBwdCalcDurationStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Start pos ejector bwd calc duration @RT(35)Start pos ejector bwd calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_rShakeFwdCalcDurStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)Start position for calculation of ejector fwd shake duration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(41)Start pos ejector fwd shake calc duration @RT(41)Start pos ejector fwd shake calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_rShakeFwdCalcDurStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(41)Start pos ejector fwd shake calc duration @RT(41)Start pos ejector fwd shake calc duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_iActState @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)actual state (used for displaying a text in odc editor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(12)EjectorState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Act. state @RT(19)Actual device state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_iActState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)actual state (used for displaying a text in odc editor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(12)EjectorState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Act. state @RT(19)Actual device state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


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


@SysVar @RT(18)sv_rShakeTargetPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(15)VG_SequenceData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(62)%FU.sv_rMinPlausShakeTargetPos..%FU.sv_rMaxPlausShakeTargetPos @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(20)LG_EjectorShake(1,1) @RT(0) 
@RT(21)Shake target position @RT(21)Shake target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rShakeTargetPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(15)VG_SequenceData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(62)%FU.sv_rMinPlausShakeTargetPos..%FU.sv_rMaxPlausShakeTargetPos @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(20)LG_EjectorShake(1,1) @RT(0) 
@RT(21)Shake target position @RT(21)Shake target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_rMinPlausShakeTargetPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)minimum plaus for shake target position 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(26)sv_rMaxPlausShakeTargetPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)maximum plaus for shake target position 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


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
