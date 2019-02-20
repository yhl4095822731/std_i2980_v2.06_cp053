CONSTANT
 cENEvType_ProductivityState : DWORD := 1;
 cENEvType_StandStillReason : DWORD := 2;
 cENEvType_Job : DWORD := 3;
 cENEvPS_PowerOff : DWORD := 1;
 cENEvPS_Setup : DWORD := 2;
 cENEvPS_Standstill : DWORD := 3;
 cENEvPS_Production : DWORD := 6;
 cENEvJob_Begin : DWORD := 1;
 cENEvJob_End : DWORD := 2;
 cILogSubClassProductivityState : LINT := 16#00000001_00000000;
END_CONSTANT

TYPE
 tsENHmi : 
   STRUCT 
    bIsConnected : BOOL;
   END_STRUCT;
 tsENMachineStatus : 
   STRUCT 
    iStandstillReasonTextsChanged : DINT (* must be increased by EN to signal a new resourcefile with standstillreason texts  *);
   END_STRUCT;
 tsENCom : 
   STRUCT 
    bConnect : BOOL;
    iVersion : DINT := 100;
    machineStatus : tsENMachineStatus;
   END_STRUCT;
 tsENEventData : 
   STRUCT 
    iType : DINT;
    iParam1 : DINT;
    iParam2 : DINT;
    iParam3 : DINT;
    iParam4 : DINT;
    dTimeStamp : DATE_AND_TIME;
   END_STRUCT;
 tsENBaseEventInfo : 
   STRUCT 
    TimeStamp : DT;
    iShotCnt : ULINT;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
10 
@Constant @RT(27)cENEvType_ProductivityState @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(26)cENEvType_StandStillReason @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(13)cENEvType_Job @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(16)cENEvPS_PowerOff @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(13)cENEvPS_Setup @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(18)cENEvPS_Standstill @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(18)cENEvPS_Production @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(0) 
@END_Attrib 


@Constant @RT(14)cENEvJob_Begin @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(12)cENEvJob_End @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(30)cILogSubClassProductivityState @RT(0) @T @F @DT @RT(4)LINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(20)16#00000001_00000000 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
5 
@DT @RT(7)tsENHmi @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(12)bIsConnected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(7)tsENCom @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)bConnect @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iVersion @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(3)100 @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)machineStatus @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsENMachineStatus @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(15)(iVersion:=100) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsENMachineStatus @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(29)iStandstillReasonTextsChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(81)must be increased by EN to signal a new resourcefile with standstillreason texts  @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsENEventData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(5)iType @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iParam1 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iParam2 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iParam3 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iParam4 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)dTimeStamp @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(17)tsENBaseEventInfo @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(9)TimeStamp @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iShotCnt @RT(0) @T @F @DT @RT(5)ULINT @RT(0) @T @T @BASIC 0 @F 
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
