%IMPORT_OVER_LISTFILE_SOURCE
 Time
, fmt41
, LG_DelayTime
, VG_MoldData
, VG_SequenceData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, tyInterCondTimeArray
, tyInstanceListArrayDuration
, tyInterCondBoolArray
, cMoveStartAndWait
, cMoveNone
, nODCElementInstanceableDuration
, cLevelSuperUser
, cLevelProduction

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveDelay : tsMoveData := (MoveId:=cMoveStartAndWait,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveStartAndWait,sMoveId:='Delay',EditorData:=(MovementType:=nODCElementInstanceableDuration,sLGInstanceProperties:='LG_DelayTime'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActDelayTimes,pPosReachedArray:=@%FU.sv_TimeReachedArray,pMovementReadyArray:=@%FU.sv_TimeReachedArray,sInstanceDataVar:='sv_SetDelayTimes'))
    
%ELEMENT sv_MoveDelay.MoveId
    
// Delay Delay
;
 sv_ActDelayTimes : tyInterCondTimeArray
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Time ;
 sv_SetDelayTimes : tyInstanceListArrayDuration := 10((dDelay:=t#1s))
    
%ELEMENT sv_SetDelayTimes[0].dDelay
 %PLAUSIBILITY t#0s..t#3600s    RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData  %LIST_GROUP LG_DelayTime(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Time 
// Delay time Delay time
;
 sv_TimeReachedArray : tyInterCondBoolArray
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 86 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(12)sv_MoveDelay @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(498)(MoveId:=cMoveStartAndWait,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,bInstanceable:=TRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveStartAndWait,sMoveId:='Delay',EditorData:=(MovementType:=nODCElementInstanceableDuration,sLGInstanceProperties:='LG_DelayTime'),InstanceData:=(pActiveTimeArray:=@%FU.sv_ActDelayTimes,pPosReachedArray:=@%FU.sv_TimeReachedArray,pMovementReadyArray:=@%FU.sv_TimeReachedArray,sInstanceDataVar:='sv_SetDelayTimes')) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(12)sv_MoveDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_MoveDelay.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(12)cMoveCooling @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(5)Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ActDelayTimes @RT(0) @T @T @DERIVED 0 @F @RT(20)tyInterCondTimeArray @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ActDelayTimes @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_SetDelayTimes @RT(0) @T @T @DERIVED 0 @F @RT(27)tyInstanceListArrayDuration @F 
@T 
@BEG_Attrib 
4 @RT(18)10((dDelay:=t#1s)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_SetDelayTimes[0].dDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)set delaytime 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_MoldData,VG_SequenceData @RT(5)fmt41 @RT(4)Time @RT(0) @RT(0) 
@RT(13)t#0s..t#3600s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(17)LG_DelayTime(1,1) @RT(0) 
@RT(10)Delay time @RT(10)Delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_TimeReachedArray @RT(0) @T @T @DERIVED 0 @F @RT(20)tyInterCondBoolArray @F 
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
