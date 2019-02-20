(*
ODC datatypes for interface with firmware
*)

CONSTANT
 cMaxODCMovements : DINT := 150 (* max number of movements that are avaliable to ODC *);
 cMaxParallelMovements : DINT := 6 (* maximum number of columns in odc array (<=cMaxActiveMovements) *);
 cMaxODCSteps : DINT := 100 (* maximum number of rows in odc array *);
END_CONSTANT

TYPE
 KODC_Movement : 
   STRUCT 
    sComponent : STRING(31) (* component name with index appended *);
    sMoveId : STRING(31) (* move id string *);
    iCompId : DINT;
    iIndexId : DINT;
    iMoveDir : DINT;
    iMoveId : DINT;
    piInstancePrio : REFTO DINT;
   END_STRUCT;
 KODC_Movements : ARRAY  [1..cMaxODCMovements] OF KODC_Movement;
 KODC_Step : 
   STRUCT 
    iCompId : DINT;
    iMoveDir : DINT;
    iMoveId : DINT;
    iIndexId : INT;
    iCount : INT;
   END_STRUCT;
 KODC_Sequence : ARRAY  [1..cMaxParallelMovements,1..cMaxODCSteps] OF KODC_Step;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Tou 25 
@@@BEG_Comment@@@
ODC datatypes for interface with firmware
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
3 
@Constant @RT(16)cMaxODCMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)150 @RT(49)max number of movements that are avaliable to ODC 
@END_Attrib 


@Constant @RT(21)cMaxParallelMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(62)maximum number of columns in odc array (<=cMaxActiveMovements) 
@END_Attrib 


@Constant @RT(12)cMaxODCSteps @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)100 @RT(35)maximum number of rows in odc array 
@END_Attrib 


@RT(17)TypeTreeContainer 
4 
@DT @RT(13)KODC_Movement @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(10)sComponent @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)component name with index appended @RT(0) 
@END_Attrib 

@StructElem @RT(7)sMoveId @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)move id string @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCompId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iIndexId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iMoveDir @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iMoveId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)piInstancePrio @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)KODC_Movements @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)KODC_Movement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxODCMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(9)KODC_Step @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(7)iCompId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iMoveDir @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iMoveId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iIndexId @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)KODC_Sequence @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(9)KODC_Step @RT(0) @T @T @UNKNOWN 0 @F 
@F 2 @RT(1)1 @RT(21)cMaxParallelMovements @RT(1)1 @RT(12)cMaxODCSteps 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
@@@BEG_Password@@@
NGhzZm9kYzQ=
@@@END_Password@@@
