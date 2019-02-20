CONSTANT
 cMaxTraceFilters : DINT := 4;
 cXYListSize : DINT := 10;
END_CONSTANT

TYPE
 tsSearchDataXY : 
   STRUCT 
    data1 : DINT;
    data2 : DINT;
   END_STRUCT;
 tsElementDataXY : 
   STRUCT 
    data1 : DINT;
    data2 : DINT;
   END_STRUCT;
 tsElementXY : 
   STRUCT 
    SearchData : tsSearchDataXY;
    ElementData : tsElementDataXY;
   END_STRUCT;
 tyListXY : ARRAY  [1..cXYListSize] OF tsElementXY;
 tyElementUsedXY : ARRAY  [1..cXYListSize] OF BOOL;
 tsListStructXY : 
   STRUCT 
    List : tyListXY;
    Used : tyElementUsedXY;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 18 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
2 
@Constant @RT(16)cMaxTraceFilters @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@Constant @RT(11)cXYListSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
6 
@DT @RT(11)tsElementXY @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(10)SearchData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsSearchDataXY @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ElementData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsElementDataXY @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(8)tyListXY @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(11)tsElementXY @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(11)cXYListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsSearchDataXY @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(5)data1 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)data2 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tsElementDataXY @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(5)data1 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)data2 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tyElementUsedXY @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(11)cXYListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsListStructXY @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tyListXY @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Used @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyElementUsedXY @RT(0) @T @T @UNKNOWN 0 @F 
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


@END_Export 

@END_Contents 
