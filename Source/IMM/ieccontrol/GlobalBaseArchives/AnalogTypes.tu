IMPORT_OVER_LISTFILE
 tsDeviceId
, tMoveIdent

END_IMPORT

CONSTANT
 cLintabNotDef : DINT := 0 (* No special Lintab *);
 cLintabPA : DINT := 1 (* Servovalve Lintab P->A *);
 cLintabPB : DINT := 2 (* Servovalve Lintab P->B  *);
 cLintabAT : DINT := 3 (* Servovalve Lintab A->T *);
 cLintabBT : DINT := 4 (* Servovalve Lintab B->T *);
 cInvalidSystemPressure : DINT := -108;
 cEps : REAL := 1.0e-6;
 cServoValveMoldMaxFwd : REAL := 1.0;
 cServoValveMoldMaxBwd : REAL := -1.0;
END_CONSTANT

TYPE
 tnAnaDevCmd : (nAnaDevStart, nAnaDevStop);
 tnAnaOutputMode : (nAnaOutputModeMid, nAnaOutputModeFast);
 tevAnaDevCmdData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    Cmd : tnAnaDevCmd;
    Mode : tnAnaOutputMode;
    prAnaOutP : REFTO REAL;
    prAnaOutV : REFTO REAL;
    piCtrlParamSet : REFTO INT;
    bMaster : BOOL (* TRUE: pump is master, FALSE: pump is slave (relevant for speedpump) *);
   END_STRUCT;
 tevAnaDevCmd : EVENT WITH tevAnaDevCmdData;
 tnAnaDevState : (nAnaDevStopped, nAnaDevStopping, nAnaDevStarted);
 tevAnaDevResponseData : 
   STRUCT 
    DeviceId : tsDeviceId;
    State : tnAnaDevState;
   END_STRUCT;
 tevAnaDevResponse : EVENT WITH tevAnaDevResponseData;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 103 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
9 
@Constant @RT(13)cLintabNotDef @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(17)No special Lintab 
@END_Attrib 


@Constant @RT(9)cLintabPA @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(22)Servovalve Lintab P->A 
@END_Attrib 


@Constant @RT(9)cLintabPB @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(23)Servovalve Lintab P->B  
@END_Attrib 


@Constant @RT(9)cLintabAT @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(22)Servovalve Lintab A->T 
@END_Attrib 


@Constant @RT(9)cLintabBT @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(22)Servovalve Lintab B->T 
@END_Attrib 


@Constant @RT(22)cInvalidSystemPressure @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)-108 @RT(0) 
@END_Attrib 


@Constant @RT(4)cEps @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)1.0e-6 @RT(0) 
@END_Attrib 


@Constant @RT(21)cServoValveMoldMaxFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)1.0 @RT(0) 
@END_Attrib 


@Constant @RT(21)cServoValveMoldMaxBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)-1.0 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
7 
@DT @RT(12)tevAnaDevCmd @RT(0) @T @T @EVENT 0 @RT(16)tevAnaDevCmdData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tevAnaDevResponse @RT(0) @T @T @EVENT 0 @RT(21)tevAnaDevResponseData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tevAnaDevCmdData @RT(0) @T @T @STRUCT 0 8 

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

@StructElem @RT(3)Cmd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tnAnaDevCmd @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnAnaOutputMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)prAnaOutP @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)prAnaOutV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)piCtrlParamSet @RT(0) @T @T @REFTO 0 @T @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)bMaster @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(67)TRUE: pump is master, FALSE: pump is slave (relevant for speedpump) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tevAnaDevResponseData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)State @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnAnaDevState @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(15)tnAnaOutputMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(17)nAnaOutputModeMid @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nAnaOutputModeFast @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tnAnaDevState @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(14)nAnaDevStopped @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nAnaDevStopping @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nAnaDevStarted @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tnAnaDevCmd @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(12)nAnaDevStart @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nAnaDevStop @RT(0) @F @F 
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
