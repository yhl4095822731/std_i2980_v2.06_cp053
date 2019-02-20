TYPE
 tnEjectorMode : (nNoUse, nHold, nNormal, nVibrate);
 tsShakeParams : 
   STRUCT 
    rShakePosition : REAL;
    iShakeCounter : DINT;
   END_STRUCT (* necessary parameters to display a shake movement in odc editor *);
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 10 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
2 
@DT @RT(13)tnEjectorMode @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(6)nNoUse @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nHold @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nNormal @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nVibrate @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsShakeParams @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(14)rShakePosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)iShakeCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(62)necessary parameters to display a shake movement in odc editor @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
