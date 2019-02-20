IMPORT_OVER_LISTFILE
 tsDeviceId
, tMoveIdent
, tnAnaOutputMode
, tnAnaDevState
, cMaxNrOfPumps

END_IMPORT

CONSTANT
 cMaxCoordListSize : DINT := 20;
END_CONSTANT

TYPE
 tsSearchDataCoord : 
   STRUCT 
    DeviceIdAnaDev : tsDeviceId;
   END_STRUCT;
 tsElementDataCoord : 
   STRUCT 
    DeviceIdSource : tsDeviceId;
    MoveId : tMoveIdent;
    AnaOutputMode : tnAnaOutputMode;
    AnaDevState : tnAnaDevState;
    prPressureSource : REFTO REAL;
    prVelocitySource : REFTO REAL;
    piCtrlParamSet : REFTO INT;
    bMaster : BOOL (* TRUE: pump is master, FALSE: pump is slave (relevant for speedpump) *);
   END_STRUCT;
 tsElementCoord : 
   STRUCT 
    SearchData : tsSearchDataCoord;
    ElementData : tsElementDataCoord;
   END_STRUCT;
 tyElementUsedCoord : ARRAY  [1..cMaxCoordListSize] OF BOOL;
 tyListCoord : ARRAY  [1..cMaxCoordListSize] OF tsElementCoord;
 tsListStructCoord : 
   STRUCT 
    List : tyListCoord;
    Used : tyElementUsedCoord;
   END_STRUCT;
 tyCoordElementData : ARRAY  [1..cMaxNrOfPumps] OF tsElementDataCoord;
 tyStopForInterrupt : ARRAY  [1..cMaxNrOfPumps] OF BOOL;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 10 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
1 
@Constant @RT(17)cMaxCoordListSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
8 
@DT @RT(14)tsElementCoord @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(10)SearchData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsSearchDataCoord @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ElementData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tsElementDataCoord @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tsSearchDataCoord @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(14)DeviceIdAnaDev @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(18)tsElementDataCoord @RT(0) @T @T @STRUCT 0 8 

@StructElem @RT(14)DeviceIdSource @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(13)AnaOutputMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnAnaOutputMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)AnaDevState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnAnaDevState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)prPressureSource @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)prVelocitySource @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(18)tyElementUsedCoord @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(17)cMaxCoordListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tyListCoord @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsElementCoord @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(17)cMaxCoordListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsListStructCoord @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyListCoord @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Used @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tyElementUsedCoord @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(18)tyCoordElementData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(18)tsElementDataCoord @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(13)cMaxNrOfPumps 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyStopForInterrupt @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(13)cMaxNrOfPumps 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
