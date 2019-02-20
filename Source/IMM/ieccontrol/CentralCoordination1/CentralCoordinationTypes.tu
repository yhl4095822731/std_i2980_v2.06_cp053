IMPORT_OVER_LISTFILE
 tsDeviceId
, tMoveIdent
, tnCoreInMode
, tnCoreOutMode
, tnCoreType
, cMaxDeviceIndex

END_IMPORT

CONSTANT
 cMoveClampClose : DINT := 1 (* clamp close movement *);
 cMoveClampOpen : DINT := 2 (* clamp open movement *);
 cClampListSize : DINT := 21 (* maximum number of cores (here cMaxDeviceIndex) *2 + 1 *);
END_CONSTANT

TYPE
 tsClampMovement : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    MoveDir : tMoveIdent;
    rTargetPosition : REAL;
    rTargetPosAcc : REAL;
    rTargetPosDeacc : REAL;
   END_STRUCT;
 tyClampMoveOrder : ARRAY  [1..cClampListSize] OF tsClampMovement;
 tsCoreData : 
   STRUCT 
    InMode : tnCoreInMode (* when the core will move in *);
    rCoreInPosition : REAL (* mold close position when the core will start to move in if inMode is set to enDuringMoldClose *);
    rCoreInMoldAcc : REAL := 100.0 (* start acceleration mold after stopping at InPosition *);
    rCoreInMoldDeacc : REAL := 100.0 (* stop acceleration mold at InPosition *);
    iCoreInPriority : DINT;
    OutMode : tnCoreOutMode (* when the core will move out *);
    rCoreOutPosition : REAL (* mold open position when the core will start to move out if outMode is set to enDuringMoldOpen *);
    rCoreOutMoldAcc : REAL := 100.0 (* start acceleration mold after stopping at OutPosition *);
    rCoreOutMoldDeacc : REAL := 100.0 (* stop acceleration mold at OutPosition *);
    iCoreOutPriority : DINT;
    bAvailable : BOOL (* Core is available on the machine *);
   END_STRUCT;
 tyCoreData : ARRAY  [1..cMaxDeviceIndex] OF tsCoreData;
 tyArray : ARRAY  [1..cMaxDeviceIndex] OF DINT;
 tsList : 
   STRUCT 
    iCount : DINT;
    List : tyArray;
   END_STRUCT;
 tyCoreTypeArray : ARRAY  [1..cMaxDeviceIndex] OF tnCoreType;
 tsClampMoveOrder : 
   STRUCT 
    iNumberOfMoves : DINT;
    Moves : tyClampMoveOrder;
   END_STRUCT;
 tyDeviceAvailable : ARRAY  [1..cMaxDeviceIndex] OF BOOL;
 tyCoreInModePlaus : ARRAY  [1..5] OF tnCoreInMode;
 tyCoreOutModePlaus : ARRAY  [1..6] OF tnCoreOutMode;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 30 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
3 
@Constant @RT(15)cMoveClampClose @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(20)clamp close movement 
@END_Attrib 


@Constant @RT(14)cMoveClampOpen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(19)clamp open movement 
@END_Attrib 


@Constant @RT(14)cClampListSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)21 @RT(53)maximum number of cores (here cMaxDeviceIndex) *2 + 1 
@END_Attrib 


@RT(17)TypeTreeContainer 
11 
@DT @RT(15)tsClampMovement @RT(0) @T @T @STRUCT 0 6 

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

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rTargetPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)rTargetPosAcc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rTargetPosDeacc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tyClampMoveOrder @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tsClampMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cClampListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsCoreData @RT(0) @T @T @STRUCT 0 11 

@StructElem @RT(6)InMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCoreInMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)when the core will move in @RT(0) 
@END_Attrib 

@StructElem @RT(15)rCoreInPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(93)mold close position when the core will start to move in if inMode is set to enDuringMoldClose @RT(0) 
@END_Attrib 

@StructElem @RT(14)rCoreInMoldAcc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(52)start acceleration mold after stopping at InPosition @RT(0) 
@END_Attrib 

@StructElem @RT(16)rCoreInMoldDeacc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(36)stop acceleration mold at InPosition @RT(0) 
@END_Attrib 

@StructElem @RT(15)iCoreInPriority @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)OutMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnCoreOutMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)when the core will move out @RT(0) 
@END_Attrib 

@StructElem @RT(16)rCoreOutPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(93)mold open position when the core will start to move out if outMode is set to enDuringMoldOpen @RT(0) 
@END_Attrib 

@StructElem @RT(15)rCoreOutMoldAcc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(53)start acceleration mold after stopping at OutPosition @RT(0) 
@END_Attrib 

@StructElem @RT(17)rCoreOutMoldDeacc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(37)stop acceleration mold at OutPosition @RT(0) 
@END_Attrib 

@StructElem @RT(16)iCoreOutPriority @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)Core is available on the machine @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(95)(rCoreInMoldAcc:=100.0,rCoreInMoldDeacc:=100.0,rCoreOutMoldAcc:=100.0,rCoreOutMoldDeacc:=100.0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tyCoreData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsCoreData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cMaxDeviceIndex 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(6)tsList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tyArray @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(7)tyArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(15)cMaxDeviceIndex 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tyCoreTypeArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tnCoreType @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cMaxDeviceIndex 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsClampMoveOrder @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(14)iNumberOfMoves @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Moves @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyClampMoveOrder @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tyDeviceAvailable @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(15)cMaxDeviceIndex 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tyCoreInModePlaus @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(12)tnCoreInMode 1 @RT(1)1 @RT(1)5 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyCoreOutModePlaus @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(13)tnCoreOutMode 1 @RT(1)1 @RT(1)6 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
