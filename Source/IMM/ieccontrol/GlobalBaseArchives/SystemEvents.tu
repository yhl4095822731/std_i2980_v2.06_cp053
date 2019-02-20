IMPORT_OVER_LISTFILE
 tsDeviceId
, tMoveIdent
, tsMoveData
, tsAlarm
, tnLockUnlock
, tLockGroup
, tnStartedStopped
, tnMoveRegMode
, tpMoveData
, tnAnaOutputMode
, tnActiveInactive
, tnSafetyGateState
, tsCalibMovement
, tnInterCondChangedMode
, tsIdentMovement
, tsIdentSpeedMovement
, tnSequInterrupt

END_IMPORT

TYPE
 tevStartData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    IntermediateCond : DINT;
    pbPosReached : REFTO BOOL;
    pMovementData : REFTO tsMoveData;
   END_STRUCT;
 tevStopData : 
   STRUCT 
    DeviceId : tsDeviceId;
   END_STRUCT;
 tevStart : EVENT WITH tevStartData;
 tevStop : EVENT WITH tevStopData;
 tevLockUnlockData : 
   STRUCT 
    DeviceId : tsDeviceId;
    DeviceIdSender : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    Alarm : tsAlarm;
    Mode : tnLockUnlock;
    bSetAlarmImmediately : BOOL;
   END_STRUCT;
 tevLockUnlock : EVENT WITH tevLockUnlockData;
 tevLockUnlockGroupData : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
    Group : tLockGroup;
    Alarm : tsAlarm;
    Mode : tnLockUnlock;
    bSetAlarmImmediately : BOOL;
   END_STRUCT;
 tevLockUnlockGroup : EVENT WITH tevLockUnlockGroupData;
 tevStartedStoppedData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    MoveDir : tMoveIdent;
    iInstance : DINT;
    State : tnStartedStopped;
   END_STRUCT;
 tevStartedStopped : EVENT WITH tevStartedStoppedData;
 tevDeviceRegisterData : 
   STRUCT 
    DeviceId : tsDeviceId;
   END_STRUCT;
 tevDeviceRegister : EVENT WITH tevDeviceRegisterData;
 tevMovementRegisterData : 
   STRUCT 
    sFuName : STRING(31);
    Mode : tnMoveRegMode;
    DeviceId : tsDeviceId;
    pbDeviceReady : REFTO BOOL;
    pMovementData : REFTO tsMoveData;
   END_STRUCT;
 tevMovementRegister : EVENT WITH tevMovementRegisterData;
 tevCheckLocklistData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    pbPosReached : REFTO BOOL;
    pMovementData : REFTO tsMoveData;
   END_STRUCT;
 tevCheckLocklist : EVENT WITH tevCheckLocklistData;
 tevStartRequestData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    IntermediateCond : DINT;
   END_STRUCT;
 tevStartRequest : EVENT WITH tevStartRequestData;
 tevStopRequestData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
   END_STRUCT;
 tevStopRequest : EVENT WITH tevStopRequestData;
 tevOutputRequestData : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
    pMoveData : tpMoveData;
    bRelease : BOOL;
    AnaOutputMode : tnAnaOutputMode;
    prVelocity : REFTO REAL;
    prPressure : REFTO REAL;
   END_STRUCT;
 tevOutputRequest : EVENT WITH tevOutputRequestData;
 tevOutputResponseData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
   END_STRUCT;
 tevOutputResponse : EVENT WITH tevOutputResponseData;
 tevAlarmConfirmData : (nConfirmedByPanel, nConfirmedByVis);
 tevAlarmConfirm : EVENT WITH tevAlarmConfirmData;
 tevCycleStart : EVENT;
 tevCoreTypeChangedData : 
   STRUCT 
    DeviceId : tsDeviceId;
    bCoreOff : BOOL (* core is switched off *);
   END_STRUCT;
 tevCoreTypeChanged : EVENT WITH tevCoreTypeChangedData;
 tevMovementStateData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    MoveDir : tMoveIdent;
    State : tnActiveInactive;
   END_STRUCT;
 tevMovementState : EVENT WITH tevMovementStateData;
 tevSafetyGateData : 
   STRUCT 
    DeviceId : tsDeviceId;
    State : tnSafetyGateState;
   END_STRUCT;
 tevSafetyGate : EVENT WITH tevSafetyGateData;
 tevRedoEventData : 
   STRUCT 
    pMovement : REFTO tsCalibMovement;
   END_STRUCT;
 tevRedoEvent : EVENT WITH tevRedoEventData;
 tevProtectData : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
    DeviceIdReceiver : tsDeviceId;
   END_STRUCT;
 tevProtect : EVENT WITH tevProtectData;
 tevInterCondChangedData : 
   STRUCT 
    DeviceIdSender : tsDeviceId (* device that requires a target value (e.g.: Core1) *);
    DeviceIdReceiver : tsDeviceId (* device that should stop at a certain target value (e.g.: Mold1) *);
    MoveDir : tMoveIdent (* move direction that should be interrupted *);
    InterCondChangedMode : tnInterCondChangedMode (* update/add or remove condition from list *);
    rTargetValue : REAL (* target value (position, pressure, ...) *);
    rDeceleration : REAL (* deceleration to reach this point *);
    rAcceleration : REAL (* acceleration from this point *);
   END_STRUCT;
 tevInterCondChanged : EVENT WITH tevInterCondChangedData;
 tevUpdateIntermedConditionData : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    iIntermediate : DINT;
    piUpdateStatus : REFTO DINT;
   END_STRUCT;
 tevPartCheckData : 
   STRUCT 
    DeviceID : tsDeviceId (* Device ID of sender *);
    bBadPart : BOOL (* sender detected a bad part *);
    bReject : BOOL (* sender wants the part to be rejected *);
   END_STRUCT;
 tevPartCheck : EVENT WITH tevPartCheckData;
 tevEmergencyStopData : 
   STRUCT 
    bActive : BOOL;
   END_STRUCT;
 tevEmergencyStop : EVENT WITH tevEmergencyStopData;
 tevRedoIdentEventData : 
   STRUCT 
    pMovement : REFTO tsIdentMovement;
   END_STRUCT;
 tevRedoIdentEvent : EVENT WITH tevRedoIdentEventData;
 tevRedoIdentSpeedEventData : 
   STRUCT 
    pMovement : REFTO tsIdentSpeedMovement;
   END_STRUCT;
 tevRedoIdentSpeedEvent : EVENT WITH tevRedoIdentSpeedEventData;
 tnLockGroupEnableDisable : (nLockGroupEnable, nLockGroupDisable);
 tevLockGroupEnableDisableData : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
    DeviceIdReceiver : tsDeviceId;
    LockGroup : DINT;
    Mode : tnLockGroupEnableDisable (* enable or disable existing lockgroup *);
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    Alarm : tsAlarm;
   END_STRUCT;
 tevLockGroupEnableDisable : EVENT WITH tevLockGroupEnableDisableData;
 tevSequInterruptData : 
   STRUCT 
    DeviceIdSender : tsDeviceId (* device ID of sender *);
    SequenceInterrupt : tnSequInterrupt;
   END_STRUCT;
 tevSequenceInterrupt : EVENT WITH tevSequInterruptData;
 tevHoldScrapData : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
   END_STRUCT;
 tevHoldScrap : EVENT WITH tevHoldScrapData;
 tevReleaseSinglePumpData : 
   STRUCT 
    iPump : DINT;
    DeviceIdSender : tsDeviceId;
   END_STRUCT;
 tevReleaseSinglePump : EVENT WITH tevReleaseSinglePumpData;
 tevInterruptActivePumpData : 
   STRUCT 
    iPump : DINT;
    DeviceIdSender : tsDeviceId;
    pMoveData : tpMoveData;
    AnaOutputMode : tnAnaOutputMode;
    prVelocity : REFTO REAL;
    prPressure : REFTO REAL;
   END_STRUCT;
 tevInterruptActivePump : EVENT WITH tevInterruptActivePumpData;
 tevRequestSinglePumpData : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
    pMoveData : tpMoveData;
    iPump : DINT (* number of pump which should be requested *);
    AnaOutputMode : tnAnaOutputMode;
    prVelocity : REFTO REAL (* optional parameter; by default sv_rVelocity is used *);
    prPressure : REFTO REAL (* optional parameter; by default sv_rPressure is used *);
   END_STRUCT;
 tevRequestSinglePump : EVENT WITH tevRequestSinglePumpData;
 tevModifyCycleStartCondData : 
   STRUCT 
    iMode : DINT (* 0: reserved for later usage, 1: add additional start condition *);
    DeviceId : tsDeviceId (* Device for which the start condition should be modified *);
    MoveDir : tMoveIdent (* MoveDir of start condition *);
    MoveId : tMoveIdent (* MoveId of start condition *);
    iCount : DINT (* instance number *);
   END_STRUCT;
 tevModifyCycleStartCondition : EVENT WITH tevModifyCycleStartCondData;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
63 
@DT @RT(12)tevStartData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)IntermediateCond @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbPosReached @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pMovementData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(11)tevStopData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(8)tevStart @RT(0) @T @T @EVENT 0 @RT(12)tevStartData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(7)tevStop @RT(0) @T @T @EVENT 0 @RT(11)tevStopData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tevLockUnlockData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Alarm @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsAlarm @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnLockUnlock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)bSetAlarmImmediately @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)tevLockUnlock @RT(0) @T @T @EVENT 0 @RT(17)tevLockUnlockData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tevLockUnlockGroupData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Group @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tLockGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Alarm @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsAlarm @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnLockUnlock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)bSetAlarmImmediately @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(18)tevLockUnlockGroup @RT(0) @T @T @EVENT 0 @RT(22)tevLockUnlockGroupData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tevStartedStoppedData @RT(0) @T @T @STRUCT 0 5 

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

@StructElem @RT(9)iInstance @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)State @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tnStartedStopped @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tevStartedStopped @RT(0) @T @T @EVENT 0 @RT(21)tevStartedStoppedData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tevDeviceRegisterData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tevDeviceRegister @RT(0) @T @T @EVENT 0 @RT(21)tevDeviceRegisterData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tevMovementRegisterData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(7)sFuName @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnMoveRegMode @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(13)pbDeviceReady @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pMovementData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(19)tevMovementRegister @RT(0) @T @T @EVENT 0 @RT(23)tevMovementRegisterData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tevCheckLocklistData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbPosReached @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pMovementData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(16)tevCheckLocklist @RT(0) @T @T @EVENT 0 @RT(20)tevCheckLocklistData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tevStartRequestData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)IntermediateCond @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tevStartRequest @RT(0) @T @T @EVENT 0 @RT(19)tevStartRequestData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tevStopRequestData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(14)tevStopRequest @RT(0) @T @T @EVENT 0 @RT(18)tevStopRequestData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tevOutputRequestData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)pMoveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tpMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)bRelease @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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

@StructElem @RT(10)prVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)prPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tevOutputRequest @RT(0) @T @T @EVENT 0 @RT(20)tevOutputRequestData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tevOutputResponseData @RT(0) @T @T @STRUCT 0 2 

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
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tevOutputResponse @RT(0) @T @T @EVENT 0 @RT(21)tevOutputResponseData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tevAlarmConfirmData @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(17)nConfirmedByPanel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nConfirmedByVis @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tevAlarmConfirm @RT(0) @T @T @EVENT 0 @RT(19)tevAlarmConfirmData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tevCycleStart @RT(0) @T @T @EVENT 0 @RT(0) @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tevCoreTypeChangedData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)bCoreOff @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)core is switched off @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tevCoreTypeChanged @RT(0) @T @T @EVENT 0 @RT(22)tevCoreTypeChangedData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tevMovementStateData @RT(0) @T @T @STRUCT 0 4 

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

@StructElem @RT(5)State @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tnActiveInactive @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(16)tevMovementState @RT(0) @T @T @EVENT 0 @RT(20)tevMovementStateData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tevSafetyGateData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)State @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnSafetyGateState @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(13)tevSafetyGate @RT(0) @T @T @EVENT 0 @RT(17)tevSafetyGateData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tevRedoEventData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(9)pMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(12)tevRedoEvent @RT(0) @T @T @EVENT 0 @RT(16)tevRedoEventData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tevProtectData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)DeviceIdReceiver @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(10)tevProtect @RT(0) @T @T @EVENT 0 @RT(14)tevProtectData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tevInterCondChangedData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)device that requires a target value (e.g.: Core1) @RT(0) 
@END_Attrib 

@StructElem @RT(16)DeviceIdReceiver @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(63)device that should stop at a certain target value (e.g.: Mold1) @RT(0) 
@END_Attrib 

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)move direction that should be interrupted @RT(0) 
@END_Attrib 

@StructElem @RT(20)InterCondChangedMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tnInterCondChangedMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)update/add or remove condition from list @RT(0) 
@END_Attrib 

@StructElem @RT(12)rTargetValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)target value (position, pressure, ...) @RT(0) 
@END_Attrib 

@StructElem @RT(13)rDeceleration @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)deceleration to reach this point @RT(0) 
@END_Attrib 

@StructElem @RT(13)rAcceleration @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)acceleration from this point @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tevInterCondChanged @RT(0) @T @T @EVENT 0 @RT(23)tevInterCondChangedData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(30)tevUpdateIntermedConditionData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)iIntermediate @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)piUpdateStatus @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tevPartCheckData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)DeviceID @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)Device ID of sender @RT(0) 
@END_Attrib 

@StructElem @RT(8)bBadPart @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)sender detected a bad part @RT(0) 
@END_Attrib 

@StructElem @RT(7)bReject @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)sender wants the part to be rejected @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tevPartCheck @RT(0) @T @T @EVENT 0 @RT(16)tevPartCheckData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tevEmergencyStopData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(7)bActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tevEmergencyStop @RT(0) @T @T @EVENT 0 @RT(20)tevEmergencyStopData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tevRedoIdentEventData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(9)pMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(15)tsIdentMovement @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tevRedoIdentEvent @RT(0) @T @T @EVENT 0 @RT(21)tevRedoIdentEventData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tevRedoIdentSpeedEventData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(9)pMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tsIdentSpeedMovement @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(22)tevRedoIdentSpeedEvent @RT(0) @T @T @EVENT 0 @RT(26)tevRedoIdentSpeedEventData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(29)tevLockGroupEnableDisableData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)DeviceIdReceiver @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)LockGroup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tnLockGroupEnableDisable @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)enable or disable existing lockgroup @RT(0) 
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

@StructElem @RT(5)Alarm @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsAlarm @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(24)tnLockGroupEnableDisable @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(16)nLockGroupEnable @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nLockGroupDisable @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(25)tevLockGroupEnableDisable @RT(0) @T @T @EVENT 0 @RT(29)tevLockGroupEnableDisableData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tevSequInterruptData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)device ID of sender @RT(0) 
@END_Attrib 

@StructElem @RT(17)SequenceInterrupt @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnSequInterrupt @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(20)tevSequenceInterrupt @RT(0) @T @T @EVENT 0 @RT(20)tevSequInterruptData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tevHoldScrapData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(12)tevHoldScrap @RT(0) @T @T @EVENT 0 @RT(16)tevHoldScrapData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tevReleaseSinglePumpData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(5)iPump @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(20)tevReleaseSinglePump @RT(0) @T @T @EVENT 0 @RT(24)tevReleaseSinglePumpData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tevInterruptActivePumpData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(5)iPump @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)pMoveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tpMoveData @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(10)prVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)prPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(22)tevInterruptActivePump @RT(0) @T @T @EVENT 0 @RT(26)tevInterruptActivePumpData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tevRequestSinglePumpData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)pMoveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tpMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)iPump @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)number of pump which should be requested @RT(0) 
@END_Attrib 

@StructElem @RT(13)AnaOutputMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnAnaOutputMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)prVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(51)optional parameter; by default sv_rVelocity is used @RT(0) 
@END_Attrib 

@StructElem @RT(10)prPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(51)optional parameter; by default sv_rPressure is used @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tevRequestSinglePump @RT(0) @T @T @EVENT 0 @RT(24)tevRequestSinglePumpData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(27)tevModifyCycleStartCondData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(5)iMode @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(62)0: reserved for later usage, 1: add additional start condition @RT(0) 
@END_Attrib 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)Device for which the start condition should be modified @RT(0) 
@END_Attrib 

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)MoveDir of start condition @RT(0) 
@END_Attrib 

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)MoveId of start condition @RT(0) 
@END_Attrib 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)instance number @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(28)tevModifyCycleStartCondition @RT(0) @T @T @EVENT 0 @RT(27)tevModifyCycleStartCondData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
