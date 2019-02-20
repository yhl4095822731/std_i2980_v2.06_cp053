IMPORT_OVER_LISTFILE
 tsMoveData
, KAPPL_LintabData_2P
, tsActTimes
, tsSetTimes

END_IMPORT

CONSTANT
 cTieBarTopFront : DINT := 1;
 cTieBarTopRear : DINT := 2;
 cTieBarBottomRear : DINT := 3;
 cTieBarBottomFront : DINT := 4;
 cTieBarAll : DINT := 5;
END_CONSTANT

TYPE
 tyTieBarMoveData : ARRAY  [1..5] OF tsMoveData;
 tyTieBarLintab : ARRAY  [1..4] OF KAPPL_LintabData_2P;
 tyTieBarMovementActive : ARRAY  [1..4] OF BOOL;
 tyTieBarSensorError : ARRAY  [1..4] OF BOOL;
 tyTieBarPosition : ARRAY  [1..4] OF REAL;
 tyTieBarPressure : ARRAY  [1..4] OF REAL;
 tyTieBarEndpos : ARRAY  [1..4] OF BOOL;
 tyTieBarActTimes : ARRAY  [1..5] OF tsActTimes;
 tyTieBarSetTimes : ARRAY  [1..5] OF tsSetTimes;
 tnHighPressHoldMode : (nNotHold, nAfterInject, nAfterPlast, nAfterCoolingTime);
 tyTieBarStroke : ARRAY  [1..4] OF REAL;
 tnTiebarBtnSelection : (enNotUse, enTopFront, enTopRear, enBottomRear, enBottomFront, enUseAll);
 tyTieBarOutput : ARRAY  [1..4] OF REAL;
 tyTieBarStandStill : ARRAY  [1..4] OF BOOL;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 159 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
5 
@Constant @RT(15)cTieBarTopFront @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(14)cTieBarTopRear @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(17)cTieBarBottomRear @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(18)cTieBarBottomFront @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@Constant @RT(10)cTieBarAll @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
14 
@DT @RT(16)tyTieBarMoveData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)5 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyTieBarLintab @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tyTieBarMovementActive @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyTieBarSensorError @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyTieBarPosition @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyTieBarPressure @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyTieBarEndpos @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyTieBarActTimes @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)5 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyTieBarSetTimes @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)5 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tnHighPressHoldMode @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(8)nNotHold @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nAfterInject @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nAfterPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nAfterCoolingTime @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyTieBarStroke @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tnTiebarBtnSelection @RT(0) @T @T @ENUM 0 6 
@EnumConst @RT(8)enNotUse @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(10)enTopFront @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)enTopRear @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(12)enBottomRear @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(13)enBottomFront @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)enUseAll @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyTieBarOutput @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyTieBarStandStill @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
