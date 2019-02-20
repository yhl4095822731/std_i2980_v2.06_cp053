%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, cMoveIncreaseShotCounter
, cMoveNone

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveShotCounter : tsMoveData := (MoveId:=cMoveIncreaseShotCounter,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0) (* increase shot counter movement *)
    
%ELEMENT sv_MoveShotCounter.MoveId
    
// Increase Increase shotcounter
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
@SysVar @RT(18)sv_MoveShotCounter @RT(0) @T @T @DERIVED 0 @F @RT(10)tsMoveData @F 
@T 
@BEG_Attrib 
4 @RT(146)(MoveId:=cMoveIncreaseShotCounter,MoveDir:=cMoveNone,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0) @RT(30)increase shot counter movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(18)sv_MoveShotCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(14)plast movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoveShotCounter.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(10)cMovePlast @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Increase @RT(20)Increase shotcounter @RT(0) @RT(0) @RT(0) 
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
