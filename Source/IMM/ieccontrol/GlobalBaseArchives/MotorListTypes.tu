CONSTANT
 cMotorLockListSize : DINT := 20;
END_CONSTANT

TYPE
 tsSearchDataMotorLock : 
   STRUCT 
    Alarm : ALARM;
    SubID1 : DINT;
    SubID2 : DINT;
    SubID3 : DINT;
    SubID4 : DINT;
   END_STRUCT;
 tsElementDataMotorLock : 
   STRUCT 
    Alarm : ALARM;
    SubID1 : DINT;
    SubID2 : DINT;
    SubID3 : DINT;
    SubID4 : DINT;
   END_STRUCT;
 tsElementMotorLock : 
   STRUCT 
    SearchData : tsSearchDataMotorLock;
    ElementData : tsElementDataMotorLock;
   END_STRUCT;
 tyListMotorLock : ARRAY  [1..cMotorLockListSize] OF tsElementMotorLock;
 tyElementUsedMotorLock : ARRAY  [1..cMotorLockListSize] OF BOOL;
 tsListStructMotorLock : 
   STRUCT 
    List : tyListMotorLock;
    Used : tyElementUsedMotorLock;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 20 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
1 
@Constant @RT(18)cMotorLockListSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
6 
@DT @RT(18)tsElementMotorLock @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(10)SearchData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsSearchDataMotorLock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ElementData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsElementDataMotorLock @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(15)tyListMotorLock @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(18)tsElementMotorLock @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cMotorLockListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsSearchDataMotorLock @RT(0) @T @T @STRUCT 0 5 

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


@DT @RT(22)tsElementDataMotorLock @RT(0) @T @T @STRUCT 0 5 

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


@DT @RT(22)tyElementUsedMotorLock @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(18)cMotorLockListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsListStructMotorLock @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyListMotorLock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Used @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tyElementUsedMotorLock @RT(0) @T @T @UNKNOWN 0 @F 
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
