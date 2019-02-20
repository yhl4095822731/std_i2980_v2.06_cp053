IMPORT_OVER_LISTFILE
 cMaxIntermediateConditions

END_IMPORT

TYPE
 tsDelayTimeData : 
   STRUCT 
    bActive : BOOL;
    dStartTime : TIME;
   END_STRUCT;
 tyDelayTimeData : ARRAY  [1..cMaxIntermediateConditions] OF tsDelayTimeData;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 144 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
2 
@DT @RT(15)tsDelayTimeData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)bActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)dStartTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tyDelayTimeData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tsDelayTimeData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
