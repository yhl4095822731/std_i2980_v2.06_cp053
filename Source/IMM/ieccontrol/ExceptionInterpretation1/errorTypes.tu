CONSTANT
 cErrorKind_Error : INT := 1;
 cErrorKind_Info : INT := 2;
 cErrorKind_Warning : INT := 3;
END_CONSTANT

TYPE
 tySubID : ARRAY  [1..4] OF DINT;
 tyAlarmParams : ARRAY  [1..4] OF STRING(255);
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
3 
@Constant @RT(16)cErrorKind_Error @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(15)cErrorKind_Info @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(18)cErrorKind_Warning @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
2 
@DT @RT(7)tySubID @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tyAlarmParams @RT(0) @T @T @ARRAY 0 @T @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
