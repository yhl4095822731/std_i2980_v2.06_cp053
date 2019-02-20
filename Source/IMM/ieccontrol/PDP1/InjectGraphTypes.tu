CONSTANT
 cIndexMaxValue : INT := 1 (* index of max value *);
 cIndexMinValue : INT := 3 (* index of min value *);
 cIndexMeanValue : INT := 2 (* index of mean value *);
 cIndexActualValue : INT := 4 (* index of last Value  *);
 cSizeSwitchOverHistory : INT := 20 (* size of history Array *);
 cIndexFirstHistoryValue : INT := 5 (* index of first value of History *);
 cInjGraphMaxDataCnt : INT := 2000 (* Inject graph data recorder length *);
 cMaxNoOfVariables : INT := 20 (* max. number of process variables in inject graph *);
 cMaxNoOfCharVariables : INT := 20 (* max. number of characteristic variables in inject graph *);
END_CONSTANT

TYPE
 tsSwitchOver : 
   STRUCT 
    rSwitchOverPosition : REAL;
    rSwitchOverPressure : REAL;
    rSwitchOverTime : REAL;
   END_STRUCT;
 tySwitchOverHistory : ARRAY  [1..cSizeSwitchOverHistory] OF tsSwitchOver;
 tsVariableUsed : 
   STRUCT 
    name : STRING(255);
    iErrorAction : INT;
   END_STRUCT;
 tyVariablesUsed : ARRAY  [1..cMaxNoOfVariables] OF tsVariableUsed;
 tnErrorAction : (nInjectGraph_No_Action, nInjectGraph_Lamp, nInjectGraph_Reject, nInjectGraph_Lamp_Reject, nInjectGraph_StopAfterCycle);
 tyInjGraphCurveData : ARRAY  [0..cInjGraphMaxDataCnt] OF REAL;
 tsInjGraphCurveData : 
   STRUCT 
    data : tyInjGraphCurveData (* Inject graph curve data array (8kB) *);
    iDataCnt : DINT (* Number of data points in array *);
   END_STRUCT;
 tyCharVariablesUsed : ARRAY  [1..cMaxNoOfCharVariables] OF STRING(65);
 tsCharVariablesUsed : 
   STRUCT 
    CharVars : tyCharVariablesUsed (* Array of used characteristic variables in inject graph (set by HMI) *);
    ChangeCounter : DINT (* Signalization HMI -> IEC (set by HMI) *);
    iNrOfVariables : INT (* Number of used characteristic variables (not set by HMI) *);
   END_STRUCT;
 tsCharValues : 
   STRUCT 
    bUsed : BOOL (* Any char variable of this structure in use *);
    curveName : STRING(65) (* Name of curve data (process parameter) *);
    curveData : tsInjGraphCurveData;
    nameCharVariableMean : STRING(65) (* Name of char variable for mean value *);
    prMean : REFTO REAL;
    nameCharVariableMin : STRING(65) (* Name of char variable for minimum value *);
    prMin : REFTO REAL;
    nameCharVariableMax : STRING(65) (* Name of char variable for maximum value *);
    prMax : REFTO REAL;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 103 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
9 
@Constant @RT(14)cIndexMaxValue @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(18)index of max value 
@END_Attrib 


@Constant @RT(14)cIndexMinValue @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(18)index of min value 
@END_Attrib 


@Constant @RT(15)cIndexMeanValue @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(19)index of mean value 
@END_Attrib 


@Constant @RT(17)cIndexActualValue @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(20)index of last Value  
@END_Attrib 


@Constant @RT(22)cSizeSwitchOverHistory @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(21)size of history Array 
@END_Attrib 


@Constant @RT(23)cIndexFirstHistoryValue @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(31)index of first value of History 
@END_Attrib 


@Constant @RT(19)cInjGraphMaxDataCnt @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)2000 @RT(33)Inject graph data recorder length 
@END_Attrib 


@Constant @RT(17)cMaxNoOfVariables @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(48)max. number of process variables in inject graph 
@END_Attrib 


@Constant @RT(21)cMaxNoOfCharVariables @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(55)max. number of characteristic variables in inject graph 
@END_Attrib 


@RT(17)TypeTreeContainer 
10 
@DT @RT(19)tySwitchOverHistory @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(12)tsSwitchOver @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(22)cSizeSwitchOverHistory 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tsSwitchOver @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(19)rSwitchOverPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)rSwitchOverPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rSwitchOverTime @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tsVariableUsed @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)name @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)iErrorAction @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tyVariablesUsed @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsVariableUsed @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(17)cMaxNoOfVariables 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tnErrorAction @RT(0) @T @T @ENUM 0 5 
@EnumConst @RT(22)nInjectGraph_No_Action @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nInjectGraph_Lamp @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nInjectGraph_Reject @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nInjectGraph_Lamp_Reject @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(27)nInjectGraph_StopAfterCycle @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyInjGraphCurveData @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)0 @RT(19)cInjGraphMaxDataCnt 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsInjGraphCurveData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)data @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyInjGraphCurveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)Inject graph curve data array (8kB) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iDataCnt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)Number of data points in array @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyCharVariablesUsed @RT(0) @T @T @ARRAY 0 @T @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F 1 @RT(1)1 @RT(21)cMaxNoOfCharVariables 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsCharVariablesUsed @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)CharVars @RT(0) @T @T @DERIVED 0 @F @RT(19)tyCharVariablesUsed @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(67)Array of used characteristic variables in inject graph (set by HMI) @RT(0) 
@END_Attrib 

@StructElem @RT(13)ChangeCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)Signalization HMI -> IEC (set by HMI) @RT(0) 
@END_Attrib 

@StructElem @RT(14)iNrOfVariables @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(56)Number of used characteristic variables (not set by HMI) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tsCharValues @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(5)bUsed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)Any char variable of this structure in use @RT(0) 
@END_Attrib 

@StructElem @RT(9)curveName @RT(0) @T @F @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)Name of curve data (process parameter) @RT(0) 
@END_Attrib 

@StructElem @RT(9)curveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsInjGraphCurveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)nameCharVariableMean @RT(0) @T @F @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)Name of char variable for mean value @RT(0) 
@END_Attrib 

@StructElem @RT(6)prMean @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)nameCharVariableMin @RT(0) @T @F @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)Name of char variable for minimum value @RT(0) 
@END_Attrib 

@StructElem @RT(5)prMin @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)nameCharVariableMax @RT(0) @T @F @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)Name of char variable for maximum value @RT(0) 
@END_Attrib 

@StructElem @RT(5)prMax @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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
