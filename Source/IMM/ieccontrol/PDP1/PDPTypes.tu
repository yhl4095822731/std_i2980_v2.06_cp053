CONSTANT
 cMaxNumberPDSVars : INT := 50 (* maximum numbers of SVs which can be supervised with SPC *);
 cNoAction : INT := 0;
 cLamp : INT := 1;
 cReject : INT := 2;
 cLampAndReject : INT := 3;
 cStopCycle : INT := 4;
 cHoldScrap : INT := 5;
END_CONSTANT

TYPE
 tsSpcMonSettings : 
   STRUCT 
    Variable : STRING(65) (* Name of variable in spc *);
    TolAction : INT (* Action in case of exceeding spc error limit *);
    WarnAction : INT (* Action in case of exceeding spc warn limit *);
    PosCount : INT (* Count of pos. error and warning limit exceedings *);
    NegCount : INT (* Count of neg. error and warning limit exceedings *);
    ErrMonActive : BOOL := FALSE (* Error monitoring is active *);
    WarnMonActive : BOOL := FALSE (* Warning monitoring is active *);
    PosTol : LREAL (* Pos. error tolerance *);
    NegTol : LREAL (* Neg. error tolerance *);
    PosWarn : LREAL (* Pos. warn. tolerance *);
    NegWarn : LREAL (* Neg. warn. tolerance *);
    TolPercent : REAL (* Error tol. percentage *);
    WarnPercent : REAL (* Warn. tol. percentage *);
   END_STRUCT;
 tySpcSettingsArray : ARRAY  [1..cMaxNumberPDSVars] OF tsSpcMonSettings;
 TPMode : (PDS_Mode_PosTol, PDS_Mode_NegTol, PDS_Mode_PosWarn, PDS_Mode_NegWarn);
 TPdErrorStruct : 
   STRUCT 
    profileName : STRING(32);
    profileType : DINT;
    varName : STRING(65);
    id : TPMode;
    limit : LREAL;
    errorVal : LREAL;
   END_STRUCT;
 TPdErrorEvent : EVENT WITH TPdErrorStruct;
 tsSpcMonData : 
   STRUCT 
    iErrCnt : UINT;
    iWarnCnt : UINT;
   END_STRUCT;
 tySpcMonData : ARRAY  [1..cMaxNumberPDSVars] OF tsSpcMonData;
 tyPdVarMap : ARRAY  [0..63] OF USINT;
 tsPdProfileMap : 
   STRUCT 
    ProfileIndex : DINT (* Profile index from catalog *);
    Map : tyPdVarMap (* Mapping between tySpcSettingsArray and MeasureStatistic event structure *);
   END_STRUCT;
 tsPdProfileChange : 
   STRUCT 
    ChangeCounter : DINT (* Profile change counter *);
    ProfileName : STRING(64) (* Associated profile *);
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 10 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
7 
@Constant @RT(17)cMaxNumberPDSVars @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)50 @RT(55)maximum numbers of SVs which can be supervised with SPC 
@END_Attrib 


@Constant @RT(9)cNoAction @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(5)cLamp @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(7)cReject @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(14)cLampAndReject @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(10)cStopCycle @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@Constant @RT(10)cHoldScrap @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
10 
@DT @RT(18)tySpcSettingsArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tsSpcMonSettings @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(17)cMaxNumberPDSVars 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)TPdErrorStruct @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(11)profileName @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)profileType @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)varName @RT(0) @T @F @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(2)id @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(6)TPMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)limit @RT(0) @T @F @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)errorVal @RT(0) @T @F @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(6)TPMode @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(15)PDS_Mode_PosTol @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)Positive Tolerance @RT(0) 
@END_Attrib 
@EnumConst @RT(15)PDS_Mode_NegTol @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)Negative Tolerance @RT(0) 
@END_Attrib 
@EnumConst @RT(16)PDS_Mode_PosWarn @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)Positive Warning @RT(0) 
@END_Attrib 
@EnumConst @RT(16)PDS_Mode_NegWarn @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)Negative Warning @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)TPdErrorEvent @RT(0) @T @T @EVENT 0 @RT(14)TPdErrorStruct @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tySpcMonData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(12)tsSpcMonData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(17)cMaxNumberPDSVars 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tsSpcMonData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)iErrCnt @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iWarnCnt @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tsSpcMonSettings @RT(0) @T @T @STRUCT 0 13 

@StructElem @RT(8)Variable @RT(0) @T @F @DT @RT(10)STRING(65) @RT(0) @T @T @STRING 0 @F @RT(2)65 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)Name of variable in spc @RT(0) 
@END_Attrib 

@StructElem @RT(9)TolAction @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)Action in case of exceeding spc error limit @RT(0) 
@END_Attrib 

@StructElem @RT(10)WarnAction @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)Action in case of exceeding spc warn limit @RT(0) 
@END_Attrib 

@StructElem @RT(8)PosCount @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)Count of pos. error and warning limit exceedings @RT(0) 
@END_Attrib 

@StructElem @RT(8)NegCount @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)Count of neg. error and warning limit exceedings @RT(0) 
@END_Attrib 

@StructElem @RT(12)ErrMonActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)FALSE @RT(26)Error monitoring is active @RT(0) 
@END_Attrib 

@StructElem @RT(13)WarnMonActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)FALSE @RT(28)Warning monitoring is active @RT(0) 
@END_Attrib 

@StructElem @RT(6)PosTol @RT(0) @T @F @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)Pos. error tolerance @RT(0) 
@END_Attrib 

@StructElem @RT(6)NegTol @RT(0) @T @F @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)Neg. error tolerance @RT(0) 
@END_Attrib 

@StructElem @RT(7)PosWarn @RT(0) @T @F @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)Pos. warn. tolerance @RT(0) 
@END_Attrib 

@StructElem @RT(7)NegWarn @RT(0) @T @F @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)Neg. warn. tolerance @RT(0) 
@END_Attrib 

@StructElem @RT(10)TolPercent @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)Error tol. percentage @RT(0) 
@END_Attrib 

@StructElem @RT(11)WarnPercent @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)Warn. tol. percentage @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(42)(ErrMonActive:=FALSE,WarnMonActive:=FALSE) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tyPdVarMap @RT(0) @T @T @ARRAY 0 @T @DT @RT(5)USINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)0 @RT(2)63 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsPdProfileMap @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(12)ProfileIndex @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)Profile index from catalog @RT(0) 
@END_Attrib 

@StructElem @RT(3)Map @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tyPdVarMap @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(71)Mapping between tySpcSettingsArray and MeasureStatistic event structure @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsPdProfileChange @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)ChangeCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)Profile change counter @RT(0) 
@END_Attrib 

@StructElem @RT(11)ProfileName @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)Associated profile @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
