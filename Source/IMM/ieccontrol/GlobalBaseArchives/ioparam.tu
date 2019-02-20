IMPORT_OVER_LISTFILE
 tsDeviceId

END_IMPORT

CONSTANT
 cNaxNumOfDOs : DINT := 10;
END_CONSTANT

TYPE
 tnModus : (nRising, nFalling, nValueChange);
 tsSV : 
   STRUCT 
    pbBOOLSV : REFTO BOOL;
    piBYTESV : REFTO BYTE;
    piWORDSV : REFTO WORD;
    piDWORDSV : REFTO DWORD;
    piLWORDSV : REFTO LWORD;
    piINTSV : REFTO INT;
    piUINTSV : REFTO UINT;
    piDINTSV : REFTO DINT;
    piUDINTSV : REFTO UDINT;
    piSINTSV : REFTO SINT;
    piUSINTSV : REFTO USINT;
    piLINTSV : REFTO LINT;
    piULINTSV : REFTO ULINT;
    prREALSV : REFTO REAL;
    prLREALSV : REFTO LREAL;
    pdTIMESV : REFTO TIME;
   END_STRUCT;
 tsSVOldValue : 
   STRUCT 
    bBOOLSV : BOOL;
    iLINTSV : LINT;
    rREALSV : REAL;
    dTIMESV : TIME;
   END_STRUCT;
 tnSVDataTypes : (nDT_NONE, nDT_BOOL, nDT_BYTE, nDT_WORD, nDT_DWORD, nDT_LWORD, nDT_INT, nDT_UINT, nDT_DINT, nDT_UDINT, nDT_SINT, nDT_USINT, nDT_LINT, nDT_ULINT, nDT_REAL, nDT_LREAL, nDT_TIME);
 tsCondition : 
   STRUCT 
    bCondition : BOOL (* TRUE = ON, FALSE = OFF condition *);
    pSvDeviceId : REFTO tsDeviceId (* refto sv_DeviceId of sSVName *);
    sSVName : STRING(255);
    SVDataType : tnSVDataTypes;
    SVPointer : tsSV;
    rThreshold : REAL;
    dThresholdTime : TIME;
    Modus : tnModus;
    dSetDelayTime : TIME;
    dActDelayTime : TIME;
    dStartDelayTime : TIME;
    bRunDelayTime : BOOL;
    iSetModulo : DINT := 1;
    iActModulo : DINT;
   END_STRUCT;
 tyOnOffConditions : ARRAY  [1..2] OF tsCondition := (bCondition:=TRUE),(bCondition:=FALSE);
 tsIOParamOnOffConditions : 
   STRUCT 
    bIsUsed : BOOL := FALSE;
    sDOName : STRING(255);
    pbDO : REFTO BOOL;
    sDOFunction : STRING(255);
    sDOHWPath : STRING(255);
    OnOffConditions : tyOnOffConditions;
   END_STRUCT;
 tyIOParamConditions : ARRAY  [1..10] OF tsIOParamOnOffConditions := (sDOName:='IOParam.do_Output1'),(sDOName:='IOParam.do_Output2'),(sDOName:='IOParam.do_Output3'),(sDOName:='IOParam.do_Output4'),(sDOName:='IOParam.do_Output5'),(sDOName:='IOParam.do_Output6'),(sDOName:='IOParam.do_Output7'),(sDOName:='IOParam.do_Output8'),(sDOName:='IOParam.do_Output9'),(sDOName:='IOParam.do_Output10');
 tyOldValue : ARRAY  [1..2] OF tsSVOldValue;
 tyOldOnOffCondSVValues : ARRAY  [1..10] OF tyOldValue;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 113 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
1 
@Constant @RT(12)cNaxNumOfDOs @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
10 
@DT @RT(7)tnModus @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(7)nRising @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nFalling @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nValueChange @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(4)tsSV @RT(0) @T @T @STRUCT 0 16 

@StructElem @RT(8)pbBOOLSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)piBYTESV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)piWORDSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)WORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)piDWORDSV @RT(0) @T @T @REFTO 0 @T @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)piLWORDSV @RT(0) @T @T @REFTO 0 @T @DT @RT(5)LWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)piINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)piUINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)piDINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)piUDINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)piSINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)SINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)piUSINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(5)USINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)piLINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)piULINTSV @RT(0) @T @T @REFTO 0 @T @DT @RT(5)ULINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)prREALSV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)prLREALSV @RT(0) @T @T @REFTO 0 @T @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)pdTIMESV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(12)tsSVOldValue @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)bBOOLSV @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iLINTSV @RT(0) @T @F @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)rREALSV @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)dTIMESV @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)tnSVDataTypes @RT(0) @T @T @ENUM 0 17 
@EnumConst @RT(8)nDT_NONE @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_BOOL @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_BYTE @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_WORD @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nDT_DWORD @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nDT_LWORD @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nDT_INT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_UINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_DINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nDT_UDINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_SINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nDT_USINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_LINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nDT_ULINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_REAL @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nDT_LREAL @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nDT_TIME @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tsCondition @RT(0) @T @T @STRUCT 0 14 

@StructElem @RT(10)bCondition @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)TRUE = ON, FALSE = OFF condition @RT(0) 
@END_Attrib 

@StructElem @RT(11)pSvDeviceId @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)refto sv_DeviceId of sSVName @RT(0) 
@END_Attrib 

@StructElem @RT(7)sSVName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)SVDataType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnSVDataTypes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)SVPointer @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(4)tsSV @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rThreshold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)dThresholdTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Modus @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tnModus @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)dSetDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)dActDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)dStartDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bRunDelayTime @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)iSetModulo @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(1)1 @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)iActModulo @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(15)(iSetModulo:=1) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tyOnOffConditions @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(11)tsCondition 1 @RT(1)1 @RT(1)2 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(38)(bCondition:=TRUE),(bCondition:=FALSE) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tsIOParamOnOffConditions @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(7)bIsUsed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)FALSE @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)sDOName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)pbDO @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)sDOFunction @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sDOHWPath @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)OnOffConditions @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyOnOffConditions @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(16)(bIsUsed:=FALSE) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyIOParamConditions @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(24)tsIOParamOnOffConditions 1 @RT(1)1 @RT(2)10 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(320)(sDOName:='IOParam.do_Output1'),(sDOName:='IOParam.do_Output2'),(sDOName:='IOParam.do_Output3'),(sDOName:='IOParam.do_Output4'),(sDOName:='IOParam.do_Output5'),(sDOName:='IOParam.do_Output6'),(sDOName:='IOParam.do_Output7'),(sDOName:='IOParam.do_Output8'),(sDOName:='IOParam.do_Output9'),(sDOName:='IOParam.do_Output10') @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tyOldValue @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(12)tsSVOldValue 1 @RT(1)1 @RT(1)2 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tyOldOnOffCondSVValues @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(10)tyOldValue 1 @RT(1)1 @RT(2)10 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
