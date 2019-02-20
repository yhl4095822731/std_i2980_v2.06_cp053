%IMPORT_OVER_LISTFILE_SOURCE
 Time
, fmt31

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, tyAvailableIFConditions
, tyAvailableLoops
, tyInterCondTimeArray
, tsGroupActiveData
, cMoveBeginSequence
, cMoveNone
, nODCElementSequenceBound
, cMoveEndSequence
, cMoveStartParallel
, nODCElementBranchBound
, cMoveEndParallel
, cMoveStartCondition
, nODCElementStartCondition
, cMoveCheckCondition
, nODCElementCheckCondition
, nCompOperatorEqual
, nCompOperatorNotEqual
, nCompOperatorModulo
, cMoveIf
, nODCElementIFCondition
, cMoveElse
, cMoveEndIf
, cMoveBeginLoop
, nODCElementLoop
, cMoveEndLoop
, cMoveBeginGroup
, nODCElementGroup
, cMoveEndGroup
, cMoveStartParallelOpen
, cMoveEndParallelOpen
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveBeginSequence : tsMoveData := (MoveId:=cMoveBeginSequence,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginSequence',EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for begin of programmed sequence *)
    
%ELEMENT sv_MoveBeginSequence.MoveId
    
// Sequence begin Sequence begin
;
 sv_MoveEndSequence : tsMoveData := (MoveId:=cMoveEndSequence,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndSequence',EditorData:=(MovementType:=nODCElementSequenceBound)) (* dummy movement for end of programmed sequence *)
    
%ELEMENT sv_MoveEndSequence.MoveId
    
// Sequence end Sequence end
;
 sv_MoveStartParallel : tsMoveData := (MoveId:=cMoveStartParallel,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='StartParallel',EditorData:=(MovementType:=nODCElementBranchBound)) (* movement for begin of parallel branch *)
    
%ELEMENT sv_MoveStartParallel.MoveId
    
// Start parallel Start parallel
;
 sv_MoveEndParallel : tsMoveData := (MoveId:=cMoveEndParallel,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndParallel',EditorData:=(MovementType:=nODCElementBranchBound)) (* movement for end of parallel branch *)
    
%ELEMENT sv_MoveEndParallel.MoveId
    
// End parallel End parallel
;
 sv_MoveStartCondition : tsMoveData := (MoveId:=cMoveStartCondition,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=2,sMoveId:='StartCondition',EditorData:=(MovementType:=nODCElementStartCondition),InstanceData:=(sInstanceDataVar:='sv_StartConditionInstanceData')) (* start condition movement *)
    
%ELEMENT sv_MoveStartCondition.MoveId
    
// Start condition Start condition
;
 sv_MoveCheckCondition : tsMoveData := (MoveId:=cMoveCheckCondition,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='CheckCondition',EditorData:=(MovementType:=nODCElementCheckCondition),InstanceData:=(sInstanceDataVar:='sv_CheckConditionInstanceData')) (* check condition movement *)
    
%ELEMENT sv_MoveCheckCondition.MoveId
    
// Check condition Check condition
;
 sv_AvailableConditions : tyAvailableIFConditions := (bSelectable:=TRUE,sTextKey:='TxtFirstCycle',sIconKey:='IconFirstCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bFirstCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtEvenCycle',sIconKey:='IconEvenCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bEvenCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtOddCycle',sIconKey:='IconOddCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bEvenCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bFALSE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorNotEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtNCycle',sIconKey:='IconNCylce',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_iShotCounterAct'),Variable2:=(bVisible:=FALSE),Operator:=(bVisible:=FALSE,Value:=nCompOperatorModulo),bDintValueVisible:=TRUE),(bSelectable:=TRUE,sTextKey:='TxtCheckDI',sIconKey:='IconCheckDI',Variable1:=(bVisible:=TRUE,sVarGroup:='DigIn'),Variable2:=(bVisible:=TRUE,sVarGroup:='CompareDigIn'),Operator:=(bVisible:=TRUE)),(bSelectable:=TRUE,sTextKey:='TxtCheckValue',sIconKey:='IconCheckValue',Variable1:=(bVisible:=TRUE,sVarGroup:='CheckValue'),Variable2:=(bVisible:=TRUE,sVarGroup:='CompareValue'),Operator:=(bVisible:=TRUE),bRealValueVisible:=TRUE,bDintValueVisible:=TRUE),(bSelectable:=TRUE,sTextKey:='TxtAutoCycleRunning',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bAutoCycleRunning'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual))
    ;
 sv_MoveIf : tsMoveData := (MoveId:=cMoveIf,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='If',EditorData:=(MovementType:=nODCElementIFCondition)) (* "If" movement *)
    
%ELEMENT sv_MoveIf.MoveId
    
// If If
;
 sv_MoveElse : tsMoveData := (MoveId:=cMoveElse,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Else',EditorData:=(MovementType:=nODCElementIFCondition)) (* "Else" movement *)
    
%ELEMENT sv_MoveElse.MoveId
    
// Else Else
;
 sv_MoveEndIf : tsMoveData := (MoveId:=cMoveEndIf,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='End_If',EditorData:=(MovementType:=nODCElementIFCondition)) (* "End_If" movement *)
    
%ELEMENT sv_MoveEndIf.MoveId
    
// End If End If
;
 sv_MoveBeginLoop : tsMoveData := (MoveId:=cMoveBeginLoop,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Begin_Loop',EditorData:=(MovementType:=nODCElementLoop)) (* "Begin loop" movement *)
    
%ELEMENT sv_MoveBeginLoop.MoveId
    
// Begin loop Begin loop
;
 sv_MoveEndLoop : tsMoveData := (MoveId:=cMoveEndLoop,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='End_Loop',EditorData:=(MovementType:=nODCElementLoop)) (* "End_loop" movement *)
    
%ELEMENT sv_MoveEndLoop.MoveId
    
// End loop End loop
;
 sv_MoveBeginGroup : tsMoveData := (MoveId:=cMoveBeginGroup,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bFALSE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Begin_Group',EditorData:=(MovementType:=nODCElementGroup),InstanceData:=(pActiveTimeArray:=@%FU.sv_GroupActiveTimes)) (* "Begin_group" movement *)
    
%ELEMENT sv_MoveBeginGroup.MoveId
    
// Begin group Begin group
;
 sv_MoveEndGroup : tsMoveData := (MoveId:=cMoveEndGroup,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bFALSE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='End_Group',EditorData:=(MovementType:=nODCElementGroup)) (* "End_group" movement *)
    
%ELEMENT sv_MoveEndGroup.MoveId
    
// End group End group
;
 sv_AvailableLoopConditions : tyAvailableLoops := (bSelectable:=TRUE,sTextKey:='TxtAutoCycleLoop',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bFALSE'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtLoopCounter',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_iLoopCounter'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorModulo),bDintValueVisible:=TRUE)
    ;
 sv_MoveStartParallelOpen : tsMoveData := (MoveId:=cMoveStartParallelOpen,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='StartParallelOpen',EditorData:=(MovementType:=nODCElementBranchBound)) (* movement for begin of parallel branch *)
    
%ELEMENT sv_MoveStartParallelOpen.MoveId
    
// Start parallel open Start parallel open
;
 sv_MoveEndParallelOpen : tsMoveData := (MoveId:=cMoveEndParallelOpen,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndParallelOpen',EditorData:=(MovementType:=nODCElementBranchBound)) (* movement for end of parallel branch *)
    
%ELEMENT sv_MoveEndParallelOpen.MoveId
    
// End parallel open End parallel open
;
 sv_GroupActiveTimes : tyInterCondTimeArray (* array with act. times for all groups *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. group time Actual group time
;
 sv_GroupActiveData : tsGroupActiveData
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
19 
@SysVar @RT(20)sv_MoveBeginSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(218)(MoveId:=cMoveBeginSequence,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BeginSequence',EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(47)dummy movement for begin of programmed sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(20)sv_MoveBeginSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_MoveBeginSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Sequence begin @RT(14)Sequence begin @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MoveEndSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(214)(MoveId:=cMoveEndSequence,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndSequence',EditorData:=(MovementType:=nODCElementSequenceBound)) @RT(45)dummy movement for end of programmed sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(18)sv_MoveEndSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoveEndSequence.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Sequence end @RT(12)Sequence end @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_MoveStartParallel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(216)(MoveId:=cMoveStartParallel,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='StartParallel',EditorData:=(MovementType:=nODCElementBranchBound)) @RT(37)movement for begin of parallel branch 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(20)sv_MoveStartParallel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_MoveStartParallel.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Start parallel @RT(14)Start parallel @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MoveEndParallel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(212)(MoveId:=cMoveEndParallel,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndParallel',EditorData:=(MovementType:=nODCElementBranchBound)) @RT(35)movement for end of parallel branch 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(18)sv_MoveEndParallel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoveEndParallel.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)End parallel @RT(12)End parallel @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoveStartCondition @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(307)(MoveId:=cMoveStartCondition,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=2,sMoveId:='StartCondition',EditorData:=(MovementType:=nODCElementStartCondition),InstanceData:=(sInstanceDataVar:='sv_StartConditionInstanceData')) @RT(24)start condition movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_MoveStartCondition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoveStartCondition.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Start condition @RT(15)Start condition @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoveCheckCondition @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(307)(MoveId:=cMoveCheckCondition,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='CheckCondition',EditorData:=(MovementType:=nODCElementCheckCondition),InstanceData:=(sInstanceDataVar:='sv_CheckConditionInstanceData')) @RT(24)check condition movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_MoveCheckCondition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoveCheckCondition.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Check condition @RT(15)Check condition @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_AvailableConditions @RT(0) @T @T @DERIVED 0 @F @RT(23)tyAvailableIFConditions @F 
@T 
@BEG_Attrib 
4 @RT(1816)(bSelectable:=TRUE,sTextKey:='TxtFirstCycle',sIconKey:='IconFirstCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bFirstCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtEvenCycle',sIconKey:='IconEvenCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bEvenCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtOddCycle',sIconKey:='IconOddCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bEvenCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bFALSE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorNotEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtNCycle',sIconKey:='IconNCylce',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_iShotCounterAct'),Variable2:=(bVisible:=FALSE),Operator:=(bVisible:=FALSE,Value:=nCompOperatorModulo),bDintValueVisible:=TRUE),(bSelectable:=TRUE,sTextKey:='TxtCheckDI',sIconKey:='IconCheckDI',Variable1:=(bVisible:=TRUE,sVarGroup:='DigIn'),Variable2:=(bVisible:=TRUE,sVarGroup:='CompareDigIn'),Operator:=(bVisible:=TRUE)),(bSelectable:=TRUE,sTextKey:='TxtCheckValue',sIconKey:='IconCheckValue',Variable1:=(bVisible:=TRUE,sVarGroup:='CheckValue'),Variable2:=(bVisible:=TRUE,sVarGroup:='CompareValue'),Operator:=(bVisible:=TRUE),bRealValueVisible:=TRUE,bDintValueVisible:=TRUE),(bSelectable:=TRUE,sTextKey:='TxtAutoCycleRunning',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bAutoCycleRunning'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_AvailableConditions @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1533)(bSelectable:=TRUE,sTextKey:='TxtFirstCycle',sIconKey:='IconFirstCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bFirstCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtEvenCycle',sIconKey:='IconEvenCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bEvenCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtOddCycle',sIconKey:='IconOddCycle',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bEvenCycle'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorNotEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtNCycle',sIconKey:='IconNCylce',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_iShotCounterAct'),Variable2:=(bVisible:=FALSE),Operator:=(bVisible:=FALSE,Value:=nCompOperatorModulo),bDintValueVisible:=TRUE),(bSelectable:=TRUE,sTextKey:='TxtCheckDI',sIconKey:='IconCheckDI',Variable1:=(bVisible:=TRUE,sVarGroup:='DigIn'),Variable2:=(bVisible:=TRUE,sVarGroup:='CompareDigIn'),Operator:=(bVisible:=TRUE)),(bSelectable:=TRUE,sTextKey:='TxtCheckValue',sIconKey:='IconCheckValue',Variable1:=(bVisible:=TRUE,sVarGroup:='CheckValue'),Variable2:=(bVisible:=TRUE,sVarGroup:='CompareValue'),Operator:=(bVisible:=TRUE)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_MoveIf @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(214)(MoveId:=cMoveIf,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='If',EditorData:=(MovementType:=nODCElementIFCondition)) @RT(13)"If" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(9)sv_MoveIf @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_MoveIf.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)If @RT(2)If @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_MoveElse @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(218)(MoveId:=cMoveElse,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Else',EditorData:=(MovementType:=nODCElementIFCondition)) @RT(15)"Else" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(11)sv_MoveElse @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(18)sv_MoveElse.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Else @RT(4)Else @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_MoveEndIf @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(221)(MoveId:=cMoveEndIf,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='End_If',EditorData:=(MovementType:=nODCElementIFCondition)) @RT(17)"End_If" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(12)sv_MoveEndIf @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_MoveEndIf.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)End If @RT(6)End If @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_MoveBeginLoop @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(222)(MoveId:=cMoveBeginLoop,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Begin_Loop',EditorData:=(MovementType:=nODCElementLoop)) @RT(21)"Begin loop" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(16)sv_MoveBeginLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_MoveBeginLoop.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Begin loop @RT(10)Begin loop @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_MoveEndLoop @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(218)(MoveId:=cMoveEndLoop,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='End_Loop',EditorData:=(MovementType:=nODCElementLoop)) @RT(19)"End_loop" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(14)sv_MoveEndLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_MoveEndLoop.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)End loop @RT(8)End loop @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_MoveBeginGroup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(285)(MoveId:=cMoveBeginGroup,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bFALSE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='Begin_Group',EditorData:=(MovementType:=nODCElementGroup),InstanceData:=(pActiveTimeArray:=@%FU.sv_GroupActiveTimes)) @RT(22)"Begin_group" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(17)sv_MoveBeginGroup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_MoveBeginGroup.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Begin group @RT(11)Begin group @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MoveEndGroup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(222)(MoveId:=cMoveEndGroup,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bFALSE,bInstanceable:=TRUE,iSafetyIdentifier:=0,sMoveId:='End_Group',EditorData:=(MovementType:=nODCElementGroup)) @RT(20)"End_group" movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(15)sv_MoveEndGroup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_MoveEndGroup.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)End group @RT(9)End group @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_AvailableLoopConditions @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyAvailableLoops @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(460)(bSelectable:=TRUE,sTextKey:='TxtAutoCycleLoop',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_bFALSE'),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtLoopCounter',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_iLoopCounter'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorModulo),bDintValueVisible:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_AvailableLoopConditions @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(430)(bSelectable:=TRUE,sTextKey:='TxtAutoCycleLoop',Variable1:=(bVisible:=FALSE),Variable2:=(bVisible:=FALSE,sVariable:='system.sv_bTRUE'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorEqual),bRealValueVisible:=FALSE,bDintValueVisible:=FALSE),(bSelectable:=TRUE,sTextKey:='TxtLoopCounter',Variable1:=(bVisible:=FALSE,sVariable:='system.sv_iLoopCounter'),Operator:=(bVisible:=FALSE,Value:=nCompOperatorModulo),bDintValueVisible:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_MoveStartParallelOpen @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(224)(MoveId:=cMoveStartParallelOpen,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='StartParallelOpen',EditorData:=(MovementType:=nODCElementBranchBound)) @RT(37)movement for begin of parallel branch 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(24)sv_MoveStartParallelOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_MoveStartParallelOpen.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Start parallel open @RT(19)Start parallel open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_MoveEndParallelOpen @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(220)(MoveId:=cMoveEndParallelOpen,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='EndParallelOpen',EditorData:=(MovementType:=nODCElementBranchBound)) @RT(35)movement for end of parallel branch 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(22)sv_MoveEndParallelOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(MoveId:=cMoveInject,MoveDir:=cMoveFwd) @RT(15)inject movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_MoveEndParallelOpen.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)cMoveInject @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)End parallel open @RT(17)End parallel open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_GroupActiveTimes @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)array with act. times for all groups 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. group time @RT(17)Actual group time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_GroupActiveTimes @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. group time @RT(17)Actual group time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_GroupActiveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsGroupActiveData @RT(0) @T @T @UNKNOWN 0 @F 
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
