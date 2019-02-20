%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, cMoveCooling
, nODCElementDuration

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveCooling : tsMoveData := (MoveId:=cMoveCooling,MoveDir:=cMoveCooling,pdCalculatedDuration:=@%FU.sv_dCoolingTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveCooling,sMoveId:='Cool',EditorData:=(MovementType:=nODCElementDuration,sLGInstanceProperties:='LG_CoolingTime'))
    
%ELEMENT sv_MoveCooling.MoveId
    
// Cool Cooling
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 86 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(14)sv_MoveCooling @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(321)(MoveId:=cMoveCooling,MoveDir:=cMoveCooling,pdCalculatedDuration:=@%FU.sv_dCoolingTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveCooling,sMoveId:='Cool',EditorData:=(MovementType:=nODCElementDuration,sLGInstanceProperties:='LG_CoolingTime')) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(14)sv_MoveCooling @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_MoveCooling.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(12)cMoveCooling @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Cool @RT(7)Cooling @RT(0) @RT(0) @RT(0) 
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
