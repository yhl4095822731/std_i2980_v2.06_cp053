%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, cMoveFwd
, cMoveBwd
, cMHAProdClosedLoop
, cMoveAll
, cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveForward : tsMoveData := (MoveId:=cMoveFwd,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet))
    
%ELEMENT sv_MoveForward.MoveId
    
// Fwd Mold height forward
;
 sv_MoveBackward : tsMoveData := (MoveId:=cMoveBwd,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet))
    
%ELEMENT sv_MoveBackward.MoveId
    
// Bwd Mold height backward
;
 sv_MoveClosedLoop : tsMoveData := (MoveId:=cMHAProdClosedLoop,MoveDir:=cMoveAll,pbActivated:=@system.sv_bTRUE,sMoveId:='PrdClosedLoop',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet))
    
// Closed loop Adjust during production in closed loop

%ELEMENT sv_MoveClosedLoop.MoveId
    
// Closed Loop Mold Height Adjust in Closed Loop
;
 sv_iCtrlParamSet : INT := 2 (* pid control set of speed pump  *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// Control Parameter Set Control Parameter Set
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(14)sv_MoveForward @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(126)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(14)sv_MoveForward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveCore,MoveDir:=cMoveIn) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_MoveForward.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveFwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Fwd @RT(19)Mold height forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MoveBackward @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(126)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd,AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(15)sv_MoveBackward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(37)(MoveId:=cMoveCore,MoveDir:=cMoveOut) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_MoveBackward.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveBwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Bwd @RT(20)Mold height backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_MoveClosedLoop @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(191)(MoveId:=cMHAProdClosedLoop,MoveDir:=cMoveAll,pbActivated:=@system.sv_bTRUE,sMoveId:='PrdClosedLoop',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumps,piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Closed loop @RT(39)Adjust during production in closed loop @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(17)sv_MoveClosedLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(174)(MoveId:=cMHAProdClosedLoop,MoveDir:=cMoveAll,pbPosReached:=@system.sv_bTRUE,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,sMoveId:='PrdClosedLoop') @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Closed loop @RT(39)Adjust during production in closed loop @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_MoveClosedLoop.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(18)cMHAProdClosedLoop @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Closed Loop @RT(33)Mold Height Adjust in Closed Loop @RT(0) @RT(0) @RT(0) 
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
