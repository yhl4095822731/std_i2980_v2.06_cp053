%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, cMoveAutoPurge
, cMoveFwd

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveAutoPurge : tsMoveData := (MoveId:=cMoveAutoPurge,MoveDir:=cMoveFwd)
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 10 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(16)sv_MoveAutoPurge @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(42)(MoveId:=cMoveAutoPurge,MoveDir:=cMoveFwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_MoveAutoPurge @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(35)(MoveId:=cMoveIn,MoveDir:=cMoveFwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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
