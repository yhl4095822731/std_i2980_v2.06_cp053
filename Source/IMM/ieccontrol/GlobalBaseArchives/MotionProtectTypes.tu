IMPORT_OVER_LISTFILE
 tMoveIdent
, tsDeviceId
//  KMB_MeasureData

END_IMPORT

TYPE
 tsMotionProtectSettings : 
   STRUCT 
    Name : STRING(64) (* name of the KMB profile, must be unique in the system *);
    ErrorEventName : STRING(64) (* name of the KMB_PDSXY_Event that is sent when value is out of the limit curve (same event can be used for several MotionProtection blocks) *);
    sVariableX : STRING(64);
    sVariableY : STRING(64);
    iMaxPoints : DINT (* maximum number of points that can be recorded *);
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    DeviceId : tsDeviceId;
    pTolYUpper : REFTO REAL (* how much the value is allowed to be higher then the ideal curve *);
    pTolYLower : REFTO REAL (* how much the value is allowed to be lower then the ideal curve *);
    pTolX : REFTO REAL (* tolerance in X direction *);
    bEnabled : BOOL (* motion protect function activated *);
    rStartPos : REAL (* FIXME: what start > / < stop *);
    rStopPos : REAL;
    bUseLastCycle : BOOL (* reinitialize limit curves after movement *);
   END_STRUCT;
 // PDGArray : ARRAY  [1..8] OF KMB_MeasureData;
 tsMotionProtectHMIComm : 
   STRUCT 
    bDoRecalc : BOOL (* signal to HMI to recalculate profile *);
    bUseLastProfile : BOOL (* flag to HMI if last recorded profile is used for limit curve calculation *);
    bWantRecalcAfterMovement : BOOL (* flag set by HMI or IEC to request curve recaclulation after Movement *);
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 30 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
3 
@DT @RT(23)tsMotionProtectSettings @RT(0) @T @T @STRUCT 0 15 

@StructElem @RT(4)Name @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)name of the KMB profile, must be unique in the system @RT(0) 
@END_Attrib 

@StructElem @RT(14)ErrorEventName @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(138)name of the KMB_PDSXY_Event that is sent when value is out of the limit curve (same event can be used for several MotionProtection blocks) @RT(0) 
@END_Attrib 

@StructElem @RT(10)sVariableX @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)sVariableY @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)iMaxPoints @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)maximum number of points that can be recorded @RT(0) 
@END_Attrib 

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)pTolYUpper @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(63)how much the value is allowed to be higher then the ideal curve @RT(0) 
@END_Attrib 

@StructElem @RT(10)pTolYLower @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(62)how much the value is allowed to be lower then the ideal curve @RT(0) 
@END_Attrib 

@StructElem @RT(5)pTolX @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)tolerance in X direction @RT(0) 
@END_Attrib 

@StructElem @RT(8)bEnabled @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)motion protect function activated @RT(0) 
@END_Attrib 

@StructElem @RT(9)rStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)FIXME: what start > / < stop @RT(0) 
@END_Attrib 

@StructElem @RT(8)rStopPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bUseLastCycle @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)reinitialize limit curves after movement @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(8)PDGArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)KMB_MeasureData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)8 0 @F @T 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tsMotionProtectHMIComm @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(9)bDoRecalc @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)signal to HMI to recalculate profile @RT(0) 
@END_Attrib 

@StructElem @RT(15)bUseLastProfile @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(72)flag to HMI if last recorded profile is used for limit curve calculation @RT(0) 
@END_Attrib 

@StructElem @RT(24)bWantRecalcAfterMovement @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(68)flag set by HMI or IEC to request curve recaclulation after Movement @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
