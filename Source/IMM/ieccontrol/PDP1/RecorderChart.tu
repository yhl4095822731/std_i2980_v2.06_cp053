IMPORT_OVER_LISTFILE
 tsDeviceId
, tMoveIdent

END_IMPORT

CONSTANT
 cMaxTriggerCnt : UDINT := 4;
END_CONSTANT

TYPE
 tsMovementTrigger : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    MoveDir : tMoveIdent;
   END_STRUCT;
 tyMovementTrigger : ARRAY  [1..cMaxTriggerCnt] OF tsMovementTrigger;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 131 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
1 
@Constant @RT(14)cMaxTriggerCnt @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
2 
@DT @RT(17)tsMovementTrigger @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tyMovementTrigger @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsMovementTrigger @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cMaxTriggerCnt 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
