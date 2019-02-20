CONSTANT
 cAlarmSignalListSize : DINT := 100;
END_CONSTANT

TYPE
 tsSearchDataAlarmSignal : 
   STRUCT 
    Alarm : ALARM;
    SubID1 : DINT;
    SubID2 : DINT;
    SubID3 : DINT;
    SubID4 : DINT;
   END_STRUCT;
 tsElementDataAlarmSignal : 
   STRUCT 
    Alarm : ALARM;
    SubID1 : DINT;
    SubID2 : DINT;
    SubID3 : DINT;
    SubID4 : DINT;
   END_STRUCT;
 tsElementAlarmSignal : 
   STRUCT 
    SearchData : tsSearchDataAlarmSignal;
    ElementData : tsElementDataAlarmSignal;
   END_STRUCT;
 tyListAlarmSignal : ARRAY  [1..cAlarmSignalListSize] OF tsElementAlarmSignal;
 tyElementUsedAlarmSignal : ARRAY  [1..cAlarmSignalListSize] OF BOOL;
 tsListStructAlarmSignal : 
   STRUCT 
    List : tyListAlarmSignal;
    Used : tyElementUsedAlarmSignal;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 22 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
1 
@Constant @RT(20)cAlarmSignalListSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)100 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
6 
@DT @RT(20)tsElementAlarmSignal @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(10)SearchData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tsSearchDataAlarmSignal @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ElementData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tsElementDataAlarmSignal @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tyListAlarmSignal @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(20)tsElementAlarmSignal @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(20)cAlarmSignalListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tsSearchDataAlarmSignal @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(5)Alarm @RT(0) @T @F @DT @RT(5)ALARM @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID1 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID2 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID3 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID4 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(24)tsElementDataAlarmSignal @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(5)Alarm @RT(0) @T @F @DT @RT(5)ALARM @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID1 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID2 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID3 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)SubID4 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(24)tyElementUsedAlarmSignal @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(20)cAlarmSignalListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tsListStructAlarmSignal @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyListAlarmSignal @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Used @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tyElementUsedAlarmSignal @RT(0) @T @T @UNKNOWN 0 @F 
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
