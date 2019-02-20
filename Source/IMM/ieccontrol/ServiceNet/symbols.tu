(*
@h    ! WARNING !
@h    The Kemro K2 system (including software) only meets category B according to EN 954-1,
@h    thus it is not intended for usage in safety-relevant control applications in the field 
@h    of personal safety (e.g. emergency stop).
@h    To implement potentially necessary safety-relevant control tasks, always use additional 
@h    external safety devices that are intended for the particular purpose, and meet the necessary 
@h    functional safety.
@h    For further information see EN 954-1 (EN ISO 13849-1) and/or the K2-x00 user manual, chapter 
@h    "CE conformity, directives and standards".

types for ABParser.pu
*)

TYPE
 tnSymbol : (nUnknown, nLBrace, nRBrace, nLBrak, nRBrak, nComma, nSeparator, nIntNumber, nFloatNumber, nString, nTrue, nFalse, nNull);
 tnDataType : (nDTInt, nDTFloat) (* datatype of element *);
 tsDataElem : 
   STRUCT 
    data : DWORD (* value *);
    dataType : tnDataType (* data type *);
   END_STRUCT (* data element in hashtable *);
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 121 @Tou 25 
@@@BEG_Comment@@@
@h    ! WARNING !
@h    The Kemro K2 system (including software) only meets category B according to EN 954-1,
@h    thus it is not intended for usage in safety-relevant control applications in the field 
@h    of personal safety (e.g. emergency stop).
@h    To implement potentially necessary safety-relevant control tasks, always use additional 
@h    external safety devices that are intended for the particular purpose, and meet the necessary 
@h    functional safety.
@h    For further information see EN 954-1 (EN ISO 13849-1) and/or the K2-x00 user manual, chapter 
@h    "CE conformity, directives and standards".

types for ABParser.pu
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
3 
@DT @RT(8)tnSymbol @RT(0) @T @T @ENUM 0 13 
@EnumConst @RT(8)nUnknown @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nLBrace @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(1){ @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nRBrace @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(1)} @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nLBrak @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(1)[ @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nRBrak @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(1)] @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nComma @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(1), @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nSeparator @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(1): @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nIntNumber @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)some integer number @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nFloatNumber @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)some float number @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nString @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(6)string @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nTrue @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(4)true @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nFalse @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)false @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nNull @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(4)null @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tnDataType @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(6)nDTInt @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)int @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDTFloat @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)float @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)datatype of element @RT(0) 
@END_Attrib 


@DT @RT(10)tsDataElem @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)data @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)value @RT(0) 
@END_Attrib 

@StructElem @RT(8)dataType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tnDataType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(9)data type @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)data element in hashtable @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
