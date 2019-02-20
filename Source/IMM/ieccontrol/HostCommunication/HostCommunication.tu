IMPORT_OVER_LISTFILE
 tenZoneMode

END_IMPORT

CONSTANT
 cHostTypeNone : DINT := 0;
 cHostTypeOPCGeneric : DINT := 1;
 cHostTypeOPC_EM63 : DINT := 2;
 cHostTypeOPCUA_EM77 : DINT := 7;
 cPDRMaxVars : DINT := 128;
 cPDRMaxLines : DINT := 10;
 cMaxHeatingNozzleZones : DINT := 12;
 cMaxHeatingMoldZones : DINT := 72;
 cMaxInjectionUnits : DINT := 2;
 cDataSetErr_NoAvailable : DINT := 1;
 cDataSetErr_InvalidCommand : DINT := 2;
 cDataSetErr_NotAllowed : DINT := 3;
 cDataSetCmdLoadMold : DINT := 0;
 cDataSetCmdLoadMachine : DINT := 1;
 cDataSetCmdSaveMold : DINT := 2;
 cDataSetCmdSaveMachine : DINT := 3;
 cPDRVarTypeNone : DINT := 0;
 cPDRVarTypeBool : DINT := 1;
 cPDRVarTypeByte : DINT := 2;
 cPDRVarTypeWord : DINT := 3;
 cPDRVarTypeDWord : DINT := 4;
 cPDRVarTypeLWord : DINT := 5;
 cPDRVarTypeSInt : DINT := 6;
 cPDRVarTypeInt : DINT := 7;
 cPDRVarTypeDInt : DINT := 8;
 cPDRVarTypeLInt : DINT := 9;
 cPDRVarTypeUSInt : DINT := 10;
 cPDRVarTypeUInt : DINT := 11;
 cPDRVarTypeUDInt : DINT := 12;
 cPDRVarTypeULInt : DINT := 13;
 cPDRVarTypeReal : DINT := 14;
 cPDRVarTypeLReal : DINT := 15;
 cPDRVarTypeDT : DINT := 16;
 cPDRVarTypeTime : DINT := 17;
END_CONSTANT

TYPE
 tsHostDataSetHmi : 
   STRUCT 
    bAvailable : BOOL;
    iTrigger : DINT;
    iCommand : DINT (* 0 ... load, 1...save mold data , 2 ... save machinedata *);
    sFile : STRING(255);
    iError : DINT;
   END_STRUCT (* HMI command for recipe load/save *);
 tsHostHmi : 
   STRUCT 
    bIsConnected : BOOL;
    dataSet : tsHostDataSetHmi;
   END_STRUCT;
 tsHostCom : 
   STRUCT 
    bConnect : BOOL;
    iHostTypeId : DINT;
   END_STRUCT;
 tyPDRActiveVars : ARRAY  [1..cPDRMaxVars] OF DINT;
 tyPDRProcessDataReal : ARRAY  [1..cPDRMaxVars] OF REAL;
 tsPDRProcessData : 
   STRUCT 
    iTrigger : DINT;
    dTimeStamp : DT;
    yParameter : tyPDRProcessDataReal;
   END_STRUCT (* 3.9 *);
 tyPDRProcessDataRaw : ARRAY  [1..cPDRMaxVars] OF LWORD;
 tsPDRProcessDataRaw : 
   STRUCT 
    iTrigger : DINT;
    dTimeStamp : DT;
    yParameter : tyPDRProcessDataRaw;
   END_STRUCT (* 3.9 *);
 tsProcessDataRecorder : 
   STRUCT 
    bActivate : BOOL;
    iReloadConfiguration : DINT;
    yActiveVariables : tyPDRActiveVars;
    data : tsPDRProcessData;
    dataRaw : tsPDRProcessDataRaw;
   END_STRUCT (* 3.9 *);
 tyyPDRProcessDataRaw : ARRAY  [1..cPDRMaxLines] OF tsPDRProcessDataRaw;
 tyyPDRProcessData : ARRAY  [1..cPDRMaxLines] OF tsPDRProcessData;
 tsPDRVarRef : 
   STRUCT 
    sampleGroup : DINT;
    nType : DINT;
    prReal : REFTO REAL;
    prLReal : REFTO LREAL;
    pdDT : REFTO DT;
    pdTime : REFTO TIME;
    pbBool : REFTO BOOL;
    piSInt : REFTO SINT;
    piInt : REFTO INT;
    piDInt : REFTO DINT;
    piLInt : REFTO LINT;
    piUSInt : REFTO USINT;
    piUInt : REFTO UINT;
    piUDInt : REFTO UDINT;
    piULInt : REFTO ULINT;
   END_STRUCT;
 tyPDRConfiguration : ARRAY  [1..cPDRMaxVars] OF tsPDRVarRef;
 tyHeatingNozzleResult : ARRAY  [1..cMaxInjectionUnits,1..cMaxHeatingNozzleZones] OF STRING(1);
 tyHeatingMoldResult : ARRAY  [1..cMaxHeatingMoldZones] OF STRING(1);
 tsEM63 : 
   STRUCT 
    bActivate : BOOL;
    ActStsMachine : STRING(5);
    SetCfgBrlZn : tyHeatingNozzleResult;
    SetCfgMldZn : tyHeatingMoldResult;
   END_STRUCT;
 tenEM83ZoneMode : (nOther_0, nOff_1, nAutomatic_2, nTuning_3, nStandby_4, nOpenLoop_5, nOnlyMeasurement_6) (* according Euromap83 14.6 Table 63 *);
 tyHeatingNozzleEM83ZoneMode : ARRAY  [1..cMaxInjectionUnits,1..cMaxHeatingNozzleZones] OF tenEM83ZoneMode;
 tyHeatingMoldEM83ZoneMode : ARRAY  [1..cMaxHeatingMoldZones] OF tenEM83ZoneMode;
 tsEM77 : 
   STRUCT 
    bAvailable : BOOL (* set after a EM77 client has been connected the first time *);
    bActivate : BOOL;
    SetCfgBrlZn : tyHeatingNozzleEM83ZoneMode;
    SetCfgMldZn : tyHeatingMoldEM83ZoneMode;
   END_STRUCT;
 tsHeatingZone : 
   STRUCT 
    pZoneMode : REFTO tenZoneMode;
    pbOptimizingActive : REFTO BOOL;
    pbEmergencyOperation : REFTO BOOL;
    pbUsed : REFTO BOOL;
   END_STRUCT;
 tyHeatingNozzle : ARRAY  [1..cMaxInjectionUnits,1..cMaxHeatingNozzleZones] OF tsHeatingZone;
 tyHeatingMold : ARRAY  [1..cMaxHeatingMoldZones] OF tsHeatingZone;
 tsHeatingGeneral : 
   STRUCT 
    pbHeatingOn : REFTO BOOL;
    pbKeepWarmActive : REFTO BOOL;
    piZonesAvailable : REFTO DINT;
   END_STRUCT;
 tyHeatingNozzleGeneral : ARRAY  [1..cMaxInjectionUnits] OF tsHeatingGeneral;
 tsHostDataSet : 
   STRUCT 
    iTrigger : DINT;
    iCommand : DINT (* 0 ... load molddata, 1 ... load machinedata, 2 ... save mold data, 3 ... save machinedata *);
    sFile : STRING(255);
    iError : DINT;
   END_STRUCT (* HMI command for recipe load/save *);
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
34 
@Constant @RT(13)cHostTypeNone @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(19)cHostTypeOPCGeneric @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(17)cHostTypeOPC_EM63 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(19)cHostTypeOPCUA_EM77 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)7 @RT(0) 
@END_Attrib 


@Constant @RT(11)cPDRMaxVars @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)128 @RT(0) 
@END_Attrib 


@Constant @RT(12)cPDRMaxLines @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(0) 
@END_Attrib 


@Constant @RT(22)cMaxHeatingNozzleZones @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)12 @RT(0) 
@END_Attrib 


@Constant @RT(20)cMaxHeatingMoldZones @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)72 @RT(0) 
@END_Attrib 


@Constant @RT(18)cMaxInjectionUnits @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(23)cDataSetErr_NoAvailable @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(26)cDataSetErr_InvalidCommand @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(22)cDataSetErr_NotAllowed @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(19)cDataSetCmdLoadMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(22)cDataSetCmdLoadMachine @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(19)cDataSetCmdSaveMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(22)cDataSetCmdSaveMachine @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeNone @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeBool @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeByte @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeWord @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(16)cPDRVarTypeDWord @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@Constant @RT(16)cPDRVarTypeLWord @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeSInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(0) 
@END_Attrib 


@Constant @RT(14)cPDRVarTypeInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)7 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeDInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)8 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeLInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)9 @RT(0) 
@END_Attrib 


@Constant @RT(16)cPDRVarTypeUSInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeUInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)11 @RT(0) 
@END_Attrib 


@Constant @RT(16)cPDRVarTypeUDInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)12 @RT(0) 
@END_Attrib 


@Constant @RT(16)cPDRVarTypeULInt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)13 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeReal @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)14 @RT(0) 
@END_Attrib 


@Constant @RT(16)cPDRVarTypeLReal @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)15 @RT(0) 
@END_Attrib 


@Constant @RT(13)cPDRVarTypeDT @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)16 @RT(0) 
@END_Attrib 


@Constant @RT(15)cPDRVarTypeTime @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)17 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
26 
@DT @RT(9)tsHostHmi @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(12)bIsConnected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)dataSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsHostDataSetHmi @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(9)tsHostCom @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)bConnect @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iHostTypeId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(21)tsProcessDataRecorder @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(9)bActivate @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)iReloadConfiguration @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)yActiveVariables @RT(0) @T @T @DERIVED 0 @F @RT(15)tyPDRActiveVars @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)data @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsPDRProcessData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)dataRaw @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsPDRProcessDataRaw @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.9 @RT(0) 
@END_Attrib 


@DT @RT(15)tyPDRActiveVars @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(11)cPDRMaxVars 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsPDRProcessDataRaw @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)iTrigger @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)dTimeStamp @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)yParameter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyPDRProcessDataRaw @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.9 @RT(0) 
@END_Attrib 


@DT @RT(16)tsPDRProcessData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)iTrigger @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)dTimeStamp @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)yParameter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyPDRProcessDataReal @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.9 @RT(0) 
@END_Attrib 


@DT @RT(20)tyyPDRProcessDataRaw @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsPDRProcessDataRaw @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(12)cPDRMaxLines 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tyyPDRProcessData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tsPDRProcessData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(12)cPDRMaxLines 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tyPDRProcessDataReal @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(11)cPDRMaxVars 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyPDRProcessDataRaw @RT(0) @T @T @ARRAY 0 @T @DT @RT(5)LWORD @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(11)cPDRMaxVars 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyPDRConfiguration @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(11)tsPDRVarRef @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(11)cPDRMaxVars 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tsPDRVarRef @RT(0) @T @T @STRUCT 0 15 

@StructElem @RT(11)sampleGroup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)nType @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)prReal @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)prLReal @RT(0) @T @T @REFTO 0 @T @DT @RT(5)LREAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)pdDT @RT(0) @T @T @REFTO 0 @T @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)pdTime @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)pbBool @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)piSInt @RT(0) @T @T @REFTO 0 @T @DT @RT(4)SINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)piInt @RT(0) @T @T @REFTO 0 @T @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)piDInt @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)piLInt @RT(0) @T @T @REFTO 0 @T @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)piUSInt @RT(0) @T @T @REFTO 0 @T @DT @RT(5)USINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)piUInt @RT(0) @T @T @REFTO 0 @T @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)piUDInt @RT(0) @T @T @REFTO 0 @T @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)piULInt @RT(0) @T @T @REFTO 0 @T @DT @RT(5)ULINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(6)tsEM63 @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(9)bActivate @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)ActStsMachine @RT(0) @T @F @DT @RT(9)STRING(5) @RT(0) @T @T @STRING 0 @F @RT(1)5 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)SetCfgBrlZn @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tyHeatingNozzleResult @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)SetCfgMldZn @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyHeatingMoldResult @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(6)tsEM77 @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(10)bAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(57)set after a EM77 client has been connected the first time @RT(0) 
@END_Attrib 

@StructElem @RT(9)bActivate @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)SetCfgBrlZn @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(27)tyHeatingNozzleEM83ZoneMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)SetCfgMldZn @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tyHeatingMoldEM83ZoneMode @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(13)tsHeatingZone @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(9)pZoneMode @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(11)tenZoneMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)pbOptimizingActive @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)pbEmergencyOperation @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)pbUsed @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tenEM83ZoneMode @RT(0) @T @T @ENUM 0 7 
@EnumConst @RT(8)nOther_0 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nOff_1 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nAutomatic_2 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nTuning_3 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nStandby_4 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nOpenLoop_5 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nOnlyMeasurement_6 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)according Euromap83 14.6 Table 63 @RT(0) 
@END_Attrib 


@DT @RT(15)tyHeatingNozzle @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsHeatingZone @RT(0) @T @T @UNKNOWN 0 @F 
@F 2 @RT(1)1 @RT(18)cMaxInjectionUnits @RT(1)1 @RT(22)cMaxHeatingNozzleZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tyHeatingMold @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsHeatingZone @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(20)cMaxHeatingMoldZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tyHeatingNozzleResult @RT(0) @T @T @ARRAY 0 @T @DT @RT(9)STRING(1) @RT(0) @T @T @STRING 0 @F @RT(1)1 @F 
@F 2 @RT(1)1 @RT(18)cMaxInjectionUnits @RT(1)1 @RT(22)cMaxHeatingNozzleZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyHeatingMoldResult @RT(0) @T @T @ARRAY 0 @T @DT @RT(9)STRING(1) @RT(0) @T @T @STRING 0 @F @RT(1)1 @F 
@F 1 @RT(1)1 @RT(20)cMaxHeatingMoldZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(27)tyHeatingNozzleEM83ZoneMode @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tenEM83ZoneMode @RT(0) @T @T @UNKNOWN 0 @F 
@F 2 @RT(1)1 @RT(18)cMaxInjectionUnits @RT(1)1 @RT(22)cMaxHeatingNozzleZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(25)tyHeatingMoldEM83ZoneMode @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tenEM83ZoneMode @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(20)cMaxHeatingMoldZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsHeatingGeneral @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(11)pbHeatingOn @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)pbKeepWarmActive @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)piZonesAvailable @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(22)tyHeatingNozzleGeneral @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tsHeatingGeneral @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cMaxInjectionUnits 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsHostDataSetHmi @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(10)bAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iTrigger @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iCommand @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)0 ... load, 1...save mold data , 2 ... save machinedata @RT(0) 
@END_Attrib 

@StructElem @RT(5)sFile @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iError @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)HMI command for recipe load/save @RT(0) 
@END_Attrib 


@DT @RT(13)tsHostDataSet @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(8)iTrigger @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iCommand @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(89)0 ... load molddata, 1 ... load machinedata, 2 ... save mold data, 3 ... save machinedata @RT(0) 
@END_Attrib 

@StructElem @RT(5)sFile @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iError @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)HMI command for recipe load/save @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
