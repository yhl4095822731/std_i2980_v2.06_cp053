(*
MoveIDs:
1  -  79 are reserved for KEBA
80 - 100 are free for use by customer
*)

IMPORT_OVER_LISTFILE
 KCTRL_YXGen_RampType
, cLockGroupNone
, cMaxTraceFilters

END_IMPORT

CONSTANT
 cMinMoveIdent : DINT := 1 (* lower limit for MoveId / MoveDir *);
 cMaxMoveIdent : DINT := 600 (* upper limit for MoveId / MoveDir *);
 cMinLockGroupId : DINT := 60 (* lower limit for LockGroup identifier *);
 cMaxGroupLocks : DINT := 10 (* maximum number of group-membership per movement *);
 cMaxLockGroupId : DINT := 100 (* upper limit for LockGroup identifier *);
 cMaxDeviceIndex : DINT := 10 (* maximum number of devices per component *);
 cAllDevIndex : DINT := 11 (* to lock all devices of a component ( = cMaxDeviceIndex + 1) *);
 cMaxMoveRegistered : DINT := 150 (* maximum number of registered movements *);
 cMaxMoveDevicesRegistered : DINT := 50 (* max number of devices which are serving movements *);
 cMaxActiveMovements : DINT := 6 (* number of movements that are active at the same time *);
 cMinCompId : DINT := 100 (* minimum Component ID  *);
 cMaxCompId : DINT := 250 (* maximum Component ID  *);
 cMaxComponents : DINT := 150 (* max number of Components ( = cMaxCompId - cMinCompId) *);
 cLockListSize : DINT := 80 (* size of the locklist *);
 cMaxDeviceMovements : DINT := 20 (* max number of movements per device *);
 cMaxZones : DINT := 72 (* max number of heating zones *);
 cMoveNone : DINT := 1 (* None *);
 cMoveIf : DINT := 2 (* IF *);
 cMoveElse : DINT := 3 (* ELSE *);
 cMoveEndIf : DINT := 4 (* END_IF *);
 cMoveBeginLoop : DINT := 5 (* Begin loop *);
 cMoveEndLoop : DINT := 6 (* End loop *);
 cMoveBeginGroup : DINT := 7 (* Begin group *);
 cMoveEndGroup : DINT := 8 (* End group *);
 cMoveStartParallelOpen : DINT := 9 (* StartParallelOpen *);
 cMoveEndParallelOpen : DINT := 10 (* EndParallelOpen *);
 cMoveBwd : DINT := 11 (* movement backward *);
 cMoveFwd : DINT := 12 (* movement forward *);
 cMovePlast : DINT := 13 (* plast movement (rotate) *);
 cMoveInject : DINT := 14 (* inject movement *);
 cMoveHold : DINT := 15 (* hold phase *);
 cMoveBwdInterPos : DINT := 16 (* move backward to intermediate position *);
 cMoveFwdInterPos : DINT := 17 (* move forward to intermediate position *);
 cMoveShake : DINT := 18 (* shaking movement (for example ejector vibrate mode) *);
 cMoveStart : DINT := 19 (* start (eg Airvalve) *);
 cMoveStop : DINT := 20 (* stop (eg Airvalve) *);
 cMoveIn : DINT := 21 (* move in (for example core) *);
 cMoveOut : DINT := 22 (* move out (for example core) *);
 cModeAutomatic : DINT := 23 (* for locking/unlocking half and full automatic mode *);
 cModeFullAutomatic : DINT := 24 (* for locking/unlocking only full automatic mode *);
 cMoveCooling : DINT := 25 (* cooling time *);
 cMoveDecompBefPlast : DINT := 26 (* decompression before plast *);
 cMoveDecompAftPlast : DINT := 27 (* decompression after plast *);
 cMoveIntrusion : DINT := 28 (* intrusion *);
 cMoveMoldHeight : DINT := 29 (* movement of mold height *);
 cMoldHeightAutomatic : DINT := 31 (* procedure of automatic mold height adjustment *);
 cMoveFwdForMHAdjust : DINT := 32 (* mold forward movement during automatic mold height adjustment *);
 cMoveBwdForMHAdjust : DINT := 33 (* mold backward movement during automatic mold height adjustment *);
 cMovePlastPurge : DINT := 34 (* plast movement for purging *);
 cMoveInjectPurge : DINT := 35 (* inject movement for purging *);
 cMoveDecompPurge : DINT := 36 (* decomp movement for purging *);
 cMoveAutoPurge : DINT := 37 (* autopurge movement *);
 cMovePVCalib : DINT := 38 (* injection movement with voltage output *);
 cMoveFwdForMHAdjustSetup : DINT := 39 (* mold forward movement during automatic mold height adjustment *);
 cMoveBwdForMHAdjustSetup : DINT := 40 (* mold backward movement during automatic mold height adjustment *);
 cMoveRef : DINT := 41 (* Dummymovement for displaying referencing symbol in vis *);
 cMoveFwdWithoutPressBuildUp : DINT := 42 (* movement forward without building up clamp pressure *);
 cMoveBeginSequence : DINT := 43 (* dummy movement for begin of a sequence *);
 cMoveEndSequence : DINT := 44 (* dummy movement for end of a sequence *);
 cMoveStartParallel : DINT := 45 (* dummy movement for "StartParallel" *);
 cMoveEndParallel : DINT := 46 (* dummy movement for "EndParallel" *);
 cMoveIncreaseShotCounter : DINT := 47 (* increase shot counter *);
 cMoveWaitForReady : DINT := 48 (* wait for ready (eg Airvalve) *);
 cMoveColdDrop : DINT := 49 (* cold drop (time dependent inject movement) *);
 cMoveOpen : DINT := 50 (* open movement (for example shut off nozzle) *);
 cMoveClose : DINT := 51 (* close movement (for example shut off nozzle) *);
 cMoveStartCondition : DINT := 52 (* dummy movement for "StartCondition" *);
 cMoveCheckCondition : DINT := 53 (* dummy movement for "CheckCondition" *);
 cMoveDecompInterPos : DINT := 54 (* instanceable decompression movement *);
 cMoveCombinedPlast : DINT := 55 (* combined plast movement (decomp before, plast, decomp after) *);
 cMoveStartAndWait : DINT := 56 (* start movement and wait untill is is ready *);
 cMoveEvent1 : DINT := 57 (* event 1 *);
 cMoveEvent2 : DINT := 58 (* event 2 *);
 cMoveEvent3 : DINT := 59 (* event 3 *);
 cMoveEvent4 : DINT := 60 (* event 4 *);
 cMoveEvent5 : DINT := 61 (* event 5 *);
 cMoveEvent6 : DINT := 62 (* event 6 *);
 cMoveEvent7 : DINT := 63 (* event 7 *);
 cMoveEvent8 : DINT := 64 (* event 8 *);
 cMoveDeclaredEndpoint : DINT := 65 (* declared endpoint *);
 cMoveFwdContactF : DINT := 66 (* nozzle forward with building up contact force *);
 cMoveBwdContactFRelieve : DINT := 67 (* contact force relieve *);
 cMoveServoATCalib : DINT := 68 (* calibration movement for servo AT characteristic *);
 cMoveServoCalib : DINT := 69 (* calibration movement for servovalve *);
 cMoveInjectCalib : DINT := 70 (* calibration movement for servo inject controller *);
 cMoveRotateCW : DINT := 71 (* rotate table in clockwise direction *);
 cMoveRotateCCW : DINT := 72 (* rotate table in counter clockwise direction *);
 cMoveRotate : DINT := 73 (* rotate table in direction needed for autocycle *);
 cMHAProdClosedLoop : DINT := 74 (* mold height adjustment during production in closed loop *);
 cMoveCoining : DINT := 75 (* coining for the injection compression moulding *);
 cMoveVenting : DINT := 76 (* venting for the injection compression moulding *);
 cMoveAll : DINT := 100 (* all movements (for evLockUnlock) *);
 // cMoveKEBALast : DINT := 79 (* MoveIDs 1 - 79 are reserved for KEBA, MoveIDs 80 - 99 are free for use by customer *);
 cMeasureReductionFactor : DINT := 5 (* reduction factor for measure block (reduction is active if no movement of this function unit is active) *);
 cEndPosMonReductionFactor : DINT := 5 (* reduction factor for endpos monitoring block (reduction is active if no movement of this function unit is active) *);
 cMaxIntermediateConditions : DINT := 10 (* max. number of intermediate conditions *);
 cMaxImpulseGain : DINT := 10 (* max. number of gains for impulse measuring *);
 cMovementHistoryLength : DINT := 30 (* number of entries in movement history array *);
 cMaxNrOfPumps : DINT := 3 (* maximum number of pumps  *);
 // cMoveKEBASecondMoveIdRange : DINT := 400 (* second range for MoveIds from 400 - 600  (IDs up to 399 are reserved for possible extension of component ID - range) *);
 cMoveTarget : DINT := 400 (* movement to target position *);
 cMoveTieBarTopFront : DINT := 401 (* tiebar top front *);
 cMoveTieBarTopRear : DINT := 402 (* tiebar top rear *);
 cMoveTieBarBottomRear : DINT := 403 (* tiebar bottom front *);
 cMoveTieBarBottomFront : DINT := 404 (* tiebar bottom rear *);
 cMoveTieBarAll : DINT := 405 (* all tiebars moving together *);
 cMoveHighPressureBuildUp : DINT := 406 (* high pressure build up *);
 cMoveHighPressureHold : DINT := 407 (* high pressure holding *);
 cMoveHighPressureRelease : DINT := 408 (* high pressure release *);
END_CONSTANT

TYPE
 tsDataActionsEnable : 
   STRUCT 
    bMoldDataLoad : BOOL;
    bMoldDataSave : BOOL;
    bMachineDataLoad : BOOL;
    bMachineDataSave : BOOL;
    bSequenceDataLoad : BOOL;
    bSequenceDataSave : BOOL;
   END_STRUCT;
 tnDataState : (nReady, nReadMoldData, nWriteMoldData, nReadMachineData, nWriteMachineData, nReadMaterialData, nWriteMaterialData, nReadSequenceData, nWriteSequenceData);
 tCompId : DINT(cMinCompId..cMaxCompId) := cMinCompId;
 tIndexId : DINT(1..cAllDevIndex) := 1;
 tMoveIdent : DINT(cMinMoveIdent..cMaxMoveIdent) := cMinMoveIdent;
 tLockGroup : DINT(cMinLockGroupId..cMaxLockGroupId) := cMinLockGroupId;
 tsDeviceId : 
   STRUCT 
    CompId : tCompId;
    IndexId : tIndexId;
   END_STRUCT;
 tyNumberOfDevices : ARRAY  [cMinCompId..cMaxCompId] OF DINT;
 tyRegisteredDevices : ARRAY  [cMinCompId..cMaxCompId,1..cMaxDeviceIndex] OF BOOL;
 tyLockGroups : ARRAY  [1..cMaxGroupLocks] OF tLockGroup := cLockGroupNone;
 tsStartedMoveInfo : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
   END_STRUCT;
 tyStartedMoveData : ARRAY  [1..cMaxActiveMovements] OF tsStartedMoveInfo;
 tsStartedMoveData : 
   STRUCT 
    iStartedMovements : DINT (* number of started movements *);
    MoveData : tyStartedMoveData;
   END_STRUCT;
 tyRequiredPumps : ARRAY  [1..cMaxNrOfPumps] OF BOOL;
 tsRequiredPumps : 
   STRUCT 
    RequiredPumps : tyRequiredPumps (* required pumps for this movement *);
    iOrder : DINT (* relevant for display order in HMI *);
   END_STRUCT;
 tsAnaOutData : 
   STRUCT 
    pRequiredPumps : REFTO tsRequiredPumps;
    piCtrlParamSet : REFTO INT;
   END_STRUCT;
 tySubId : ARRAY  [1..4] OF DINT;
 tsAlarm : 
   STRUCT 
    AlarmId : ALARM;
    SubId : tySubId;
    Param1 : STRING(99);
    Param2 : STRING(99);
   END_STRUCT;
 tnMoveDirection : (nMoveDirectionNo, nMoveDirectionMinToMax, nMoveDirectionMaxToMin) (* necessary for drawing the rectangles in graphical editor *);
 tnODCElemement : (nODCElementDuration, nODCElementMovement, nODCElementShake, nODCElementEventIn, nODCElementEventOut, nODCElementStartCondition, nODCElementCheckCondition, nODCElementSequenceBound, nODCElementBranchBound, nODCElementInjectAndHold, nODCElementCombinedPlast, nODCElementDelaredInput, nODCElementIFCondition, nODCElementLoop, nODCElementGroup, nODCElementInstanceableDuration);
 tsEditorData : 
   STRUCT 
    pbReferenceCondition : REFTO BOOL (* reference to a boolean condition that (can be used in start condition dialogue) *);
    Direction : tnMoveDirection;
    MovementType : tnODCElemement;
    sElementData : STRING(31) (* name of systemvariable that contains the necessary data for the according ODCElementType attention: different ODCElements require systemvariables with different types of sElementData *);
    sODCIcon : STRING(31) (* addtional icon which is displayed in the graphical editor *);
    sLGInstanceProperties : STRING(255) (* string containing the listgroup names for instance properties *);
    bReadOnly : BOOL (* flag for indicating read only movements in editor *);
   END_STRUCT;
 tyInterCondTimeArray : ARRAY  [1..cMaxIntermediateConditions] OF TIME;
 tyInterCondBoolArray : ARRAY  [1..cMaxIntermediateConditions] OF BOOL;
 tsInstanceData : 
   STRUCT 
    pActiveTimeArray : REFTO tyInterCondTimeArray (* reference to array with active move times *);
    pLastActiveTimeArray : REFTO tyInterCondTimeArray (* reference to array with last active times *);
    pPosReachedArray : REFTO tyInterCondBoolArray (* reference to array with posreached information for all instances *);
    pProgrammedInSequenceArray : REFTO tyInterCondBoolArray (* reference to array with bProgrammedInSequence info of all instances *);
    pMovementReadyArray : REFTO tyInterCondBoolArray (* reference to array with ready information of all instances *);
    sInstanceDataVar : STRING(31) (* variable name that contains the data for the different instances of this movement *);
   END_STRUCT;
 tsMoveData : 
   STRUCT 
    MoveId : tMoveIdent;
    MoveDir : tMoveIdent;
    LockGroups : tyLockGroups;
    pbPosReached : REFTO BOOL;
    pdStartDelaySet : REFTO TIME;
    pdStartDelayAct : REFTO TIME;
    pbStartDelayActive : REFTO BOOL;
    pdActiveTimeAct : REFTO TIME;
    pdLastActiveTime : REFTO TIME (* reference to variable with the last movement time *);
    pdTimeLimit : REFTO TIME;
    pdCalculatedDuration : REFTO TIME (* refto to calculated duration of this movement *);
    prTargetValue : REFTO REAL (* refto to target value of this movement *);
    piInstancePrio : REFTO DINT (* pointer to a calculated priority *);
    pbStartConditionReached : REFTO BOOL (* start condition (for example a position) reached *);
    pbActivated : REFTO BOOL (* information if movement is activated or not; deactivated movements are not started *);
    bDefaultPos : BOOL (* TRUE: if a safety relevant component is not programmed in sequence then this movement is the defaultposition for the component *);
    bIsWaitStep : BOOL (* movement is a wait step -> no start necessary, just wait for PosReached of this movement *);
    bContinueWithoutReady : BOOL (* TRUE: after start of the movement the autocyle continues without waiting for ready flag of this movement *);
    bInstanceable : BOOL (* TRUE: movement can be used with different parameters (for example mold close inter pos) *);
    bProgrammedInSequence : BOOL (* TRUE: programmed machine sequence (from ODC) includes this movement; flag is written by ODC!! *);
    bIgnoreByABControl : BOOL (* TRUE: start event for this movement is ignored by ABControl *);
    bAllowedDuringInterrupt : BOOL (* TRUE: this movement can be started (by manual button) during sequence interruption is active *);
    bFinishAtInterrupt : BOOL (* FALSE: movement is stopped immediately at sequence interruption; TRUE: this movement can finished after interrupt *);
    Alarm : tsAlarm;
    iSafetyIdentifier : DINT (* 0: not safety relevant, 1: safety relevant, 2:partially safety relevant(not safety relevant itself but checks other safety relevant movements)  3: sequence safetyrelevant  but not mold safety relvant (Safetyeditor)  *);
    iMoveIdInverseMovement : tMoveIdent (* move id of the according inverse movement in this function unit (needed for stepping bwd during sequence interruption is active) *);
    sIconPath : STRING(50) (* movement icon (displayed if movement is active) *);
    sMoveId : STRING(31) (* string to identify a movement *);
    AnaOutData : tsAnaOutData;
    EditorData : tsEditorData;
    InstanceData : tsInstanceData;
   END_STRUCT;
 tpMoveData : REFTO tsMoveData;
 tyMoveDataArray : ARRAY  [1..cMaxDeviceMovements] OF tpMoveData;
 tsMoveCtrl : 
   STRUCT 
    pData : tpMoveData;
    bStop : BOOL;
    bReady : BOOL := TRUE;
    iCount : DINT;
   END_STRUCT;
 tnLockUnlock : (nLockAbort, nLockResume, nUnlock);
 tsLockEntry : 
   STRUCT 
    DeviceIdSender : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    bStopDevice : BOOL;
    Alarm : tsAlarm;
   END_STRUCT;
 tsLockListElem : 
   STRUCT 
    bUsed : BOOL;
    bDisabled : BOOL (* this locklist entry is disabled (=ignored) *);
    bAlarmSet : BOOL;
    entry : tsLockEntry;
   END_STRUCT;
 tyyLockList : ARRAY  [1..cLockListSize] OF tsLockListElem;
 tnStartedStopped : (nStarted, nStopped, nStartNotAllowed);
 tnActiveInactive : (nInactive, nActive);
 tnMoveRegMode : (nMoveRegModeArm, nMoveRegModeFire);
 tsMovementRegisterListElem : 
   STRUCT 
    DeviceId : tsDeviceId;
    iFuIndex : DINT (* index of this function unit in sv_ODCDeviceMovements *);
    pbDeviceReady : REFTO BOOL;
    iODCSafetyMovementsEntry : DINT (* index to ODC1.sv_SafetyMovements if available *);
    iSESafetyProgIdx : DINT (* indext to ODC1.sv_SafetyList *);
    pMovementData : REFTO tsMoveData;
   END_STRUCT;
 tyMovementRegisterList : ARRAY  [1..cMaxMoveRegistered] OF tsMovementRegisterListElem;
 tyDeviceMovementListElem : 
   STRUCT 
    DeviceId : tsDeviceId;
    pbDeviceReady : REFTO BOOL;
    iNumberOfMovements : DINT (* number of movements registered by this function unit *);
    iDefaultMoveNumber : DINT (* number of the default movement of this function unit (this endposition must be reached if no movement of this fu is programmed in the sequence) *);
    Movements : tyMoveDataArray (* array with registered movements of this function unit *);
   END_STRUCT;
 tDeviceMovementList : ARRAY  [1..cMaxMoveDevicesRegistered] OF tyDeviceMovementListElem;
 tnOperationMode : (nSetup, nManual, nHalfAutomatic, nFullAutomatic);
 tnSafetyGateState : (nClosed, nOpen, nError);
 tnTraceLevel : (nApplication, nRegistration, nLockUnlock, nDeviceState, nAnalog, nServo, nODCInterpreter, nODCDependencies);
 tsConstOutputData : 
   STRUCT 
    rOutputValue : REAL;
    rRamp : REAL := 1000.0;
    RampType : KCTRL_YXGen_RampType;
   END_STRUCT;
 tsOutput : 
   STRUCT 
    Output : tsConstOutputData;
    PreOutput : tsConstOutputData;
    rMinOutput : REAL;
   END_STRUCT;
 tsVelPre : 
   STRUCT 
    Velocity : tsOutput;
    Pressure : tsOutput;
   END_STRUCT;
 tsErrorInfo : 
   STRUCT 
    Velocity : DINT;
    Pressure : DINT;
   END_STRUCT;
 tyActiveMovements : ARRAY  [1..cMaxActiveMovements] OF DINT;
 tsActiveMovements : 
   STRUCT 
    iNumberOfActiveMovements : DINT;
    ActiveMovements : tyActiveMovements;
   END_STRUCT;
 tsSetActTime : 
   STRUCT 
    dSet : TIME;
    dAct : TIME;
   END_STRUCT;
 tsSetActMaxTime : 
   STRUCT 
    dSet : TIME;
    dAct : TIME;
    dMax : TIME;
   END_STRUCT;
 tsSetActUDint : 
   STRUCT 
    iSet : UDINT;
    iAct : UDINT;
   END_STRUCT;
 tsSetActReal : 
   STRUCT 
    rSetReal : REAL;
    rActReal : REAL;
   END_STRUCT;
 tsInjectHoldNumbers : 
   STRUCT 
    iInjectMovement : DINT (* number of inject movement *);
    iHoldMovement : DINT (* number of hold movement *);
    bHoldActive : BOOL (* cut off was detected -> holding is active *);
   END_STRUCT;
 tyInjectHoldNumbers : ARRAY  [1..cMaxDeviceIndex] OF tsInjectHoldNumbers;
 tyTraceDeviceFilter : ARRAY  [1..cMaxTraceFilters] OF tsDeviceId;
 tsTraceFilter : 
   STRUCT 
    bFilterOn : BOOL;
    DeviceFilter : tyTraceDeviceFilter;
   END_STRUCT;
 tsTraceLevel : 
   STRUCT 
    bApplication : BOOL;
    bRegistration : BOOL;
    bLockUnlock : BOOL;
    bDeviceState : BOOL;
    bAnalog : BOOL;
    bServo : BOOL;
    bExceptionInterpretation : BOOL;
    bODCInterpreter : BOOL;
    bODCDependencies : BOOL (* general debug flag for dependency calculation *);
    bODCDependTrace : BOOL (* log dependency calc to system trace *);
    bODCDependFile : BOOL (* log dependency calc to file *);
    bODCBrowseTrace : BOOL (* log sequence browsing to system trace *);
    bODCBrowseFile : BOOL (* log sequence browsing to system file *);
    bKVB : BOOL (* traces from KVB function unit *);
    bDebugCalibration : BOOL (* write measured data to file during calibration  *);
   END_STRUCT;
 tsLimitDataReal : 
   STRUCT 
    rLowerLimit : REAL;
    rUpperLimit : REAL;
   END_STRUCT;
 tsSetTimes : 
   STRUCT 
    dSetDelayTime : TIME (* movement delay time *);
    dSetDelayTimePump : TIME (* delay time between valve on and pump start *);
    dSetDelayTimeValve : TIME (* delay time between pump stop and valve off *);
    dMaxMoveTime : TIME;
   END_STRUCT;
 tsSetTimesExtended : 
   STRUCT 
    dSetDelayTime : TIME;
    dSetDelayTimePump : TIME (* delay time between valve on and pump start *);
    dSetDelayTimeValve : TIME (* delay time between pump stop and valve off *);
    dSetMoveTime : TIME;
    dMaxMoveTime : TIME;
   END_STRUCT;
 tsActTimes : 
   STRUCT 
    dActDelayTime : TIME;
    dActMoveTime : TIME;
    dLastMoveTime : TIME;
   END_STRUCT;
 tsInterCondListElement : 
   STRUCT 
    rTargetValue : REAL (* target value (position, pressure, ...) *);
    rDeceleration : REAL (* deceleration to reach this point *);
    rAcceleration : REAL (* acceleration from this point *);
    DeviceIdSender : tsDeviceId (* device that requires a target value (e.g.: Core1) *);
   END_STRUCT (* element of list with intermediate conditions *);
 tyInterCondArray : ARRAY  [1..cMaxIntermediateConditions] OF tsInterCondListElement (* array with intermediate conditions *);
 tsInterCondList : 
   STRUCT 
    iUsedElements : DINT (* number of used elements *);
    List : tyInterCondArray;
   END_STRUCT (* list containing the intermediate conditions *);
 tnInterCondChangedMode : (nInterCondUpdate, nInterCondRemove);
 tnLimitSwitchMode : (nLimitSwitchNormallyClosed, nLimitSwitchNormallyOpen);
 tyLockList : 
   STRUCT 
    iElementsUsed : DINT;
    iListChanged : DINT;
    lockList : tyyLockList;
   END_STRUCT;
 tnDeviceDirection : (nDeviceDirectionNo, nDeviceDirectionLeftToRight, nDeviceDirectionRightToLeft) (* direction of the device *);
 tsInstanceListElement : 
   STRUCT 
    rTargetValue : REAL;
    rDeceleration : REAL := 100.0 (* percent ramp deceleration to reach this point *);
    rAcceleration : REAL := 100.0 (* percent ramp acceleration from this point *);
    dDelay : TIME (* set delaytime *);
    dCalculatedDuration : TIME;
   END_STRUCT;
 tyInstanceListArray : ARRAY  [1..cMaxIntermediateConditions] OF tsInstanceListElement;
 tnInitPosition : (nInitPosMaximum, nInitPosMinimum);
 tsAddDeviceInfo : 
   STRUCT 
    prActValue : REFTO REAL (* refto actual value (for example actual position) *);
    prMaxValue : REFTO REAL (* refto maximum value of the device (for example stroke) *);
    piActState : REFTO DINT (* refto actual state (integer variable with according format to display a status text in the editor) *);
    Direction : tnDeviceDirection (* move direction of the component *);
    InitPosition : tnInitPosition;
   END_STRUCT (* additional information about this device (needed for graphical editor) *);
 tnBadPartReason : (nReason_GoodPart, nReason_Unknown, nReason_PDS, nReason_InjectGraph, nReason_MoldProtection);
 tsProduction : 
   STRUCT 
    iRejectCounter : DINT (* number of bad parts *);
    iRejectsPerTime : DINT (* actual number of rejected  parts per timespan (see next element) *);
    iRejectTimeSpan : DINT;
    iGoodPartsPerReject : DINT (* count parts until bad part *);
    iRejectsInSeries : DINT (* increase if bad part, reset if to 0 if good part. *);
   END_STRUCT (* production data *);
 tyImpulseArray : ARRAY  [1..cMaxImpulseGain] OF REAL;
 tsMoveAndDurationElementData : 
   STRUCT 
    pdMovementDuration : REFTO TIME (* refto movement duration *);
    pdDuration : REFTO TIME (* refto duration *);
    sODCMovementIcon : STRING(31) (* icon that should be displayed in the movement part of the element *);
    sODCDurationIcon : STRING(31) (* icon that should be displayed in the duration part of the element *);
   END_STRUCT (* necessary data to display an element that contains of a movement and a duration in machine sequencer *);
 tnCoreControl : (nRoundsCount, nTime, nLimitSwitch) (* how the core is controlled *);
 tnCombinedCoreInMode : (nCoreInOff, nCoreInBeforeMoldClose, nCoreInDuringMoldClose, nCoreInAfterMoldClose, nCoreInAfterMoldNutsClose, nCoreInAfterHighPress) (* combination of core in mode (before, during,..) and coretype (off, screw,..) *);
 tnCombinedCoreOutMode : (nCoreOutOff, nCoreOutBeforeMoldOpen, nCoreOutDuringMoldOpen, nCoreOutAfterMoldOpen, nCoreOutBeforeHiPressRel, nCoreOutAfterHiPressRel, nCoreOutBeforeMoldNutsOpen) (* combination of core out mode (before, during,..) and coretype (off, screw,..) *);
 tnServiceType : (nNoService, nServiceInterval, nServicePowerOnTime);
 tnAirMode : (nAirModeOff, nAirModeAfterPlast, nAirModeAfterMoldOpen, nAirModeAfterEject, nAirModeDuringMoldOpen, nAirModeBeforePlast, nAirModeAfterInject, nAirModeDuringMoldClose);
 tsInjectHoldElementData : 
   STRUCT 
    pdInjectDuration : REFTO TIME (* inject duration *);
    pdHoldDuration : REFTO TIME (* hold duration *);
    sODCInjectIcon : STRING(31);
    sODCHoldIcon : STRING(31);
   END_STRUCT (* necessary data to display inject and hold in odc editor *);
 tyLockGroupDisabled : ARRAY  [1..cMaxGroupLocks] OF BOOL;
 tyDisabledLockGroups : ARRAY  [1..cMaxDeviceMovements] OF tyLockGroupDisabled;
 tenDatatype : (enBOOL, enSINT, enINT, enDINT, enUSINT, enUINT, enUDINT, enREAL, enSTRING, enLINT, enBYTE, enWORD, enDWORD);
 tyHeatingPower : ARRAY  [1..cMaxZones] OF REAL;
 tnRobotInterface : (nSwitchedOff, nEuromap12, nEuromap67, nUserDefIF);
 tnSequInterrupt : (nSequenceInterrupt, nSequenceContinue);
 tsMoveHistoryData : 
   STRUCT 
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    iCount : DINT;
   END_STRUCT;
 tyMoveHistory : ARRAY  [1..cMovementHistoryLength] OF tsMoveHistoryData;
 tsMovementHistory : 
   STRUCT 
    iActCount : DINT;
    Data : tyMoveHistory;
   END_STRUCT;
 tsInstanceListElementDuration : 
   STRUCT 
    dDelay : TIME (* set delaytime *);
   END_STRUCT;
 tyInstanceListArrayDuration : ARRAY  [1..cMaxIntermediateConditions] OF tsInstanceListElementDuration;
 tsLimitDataINT : 
   STRUCT 
    iLowerLimit : INT;
    iUpperLimit : INT;
   END_STRUCT;
 tnPumpState : (nPumpStateFree, nPumpStateBusy);
 tsPumpData : 
   STRUCT 
    prAnaOutP : REFTO REAL (* reference to actual pressure output [bar] of pump *);
    prAnaOutV : REFTO REAL (* reference to actual velocity output  [%] of pump *);
    prAbsFlow : REFTO REAL (* reference to absolute flow [l/min] of pump *);
    prMaxPressure : REFTO REAL (* reference to maximum pressure [bar] of pump *);
    prActVoltageP : REFTO REAL (* reference to actual pressure output voltage [V] of pump *);
    prMaxVoltageP : REFTO REAL (* reference to maximum output voltage [V] of pump pressure (during pressure calib) *);
    prActVoltageV : REFTO REAL (* reference to actual velocity output voltage [V] of pump *);
    prMaxVoltageV : REFTO REAL (* reference to maximum output voltage [V] of pump velocity (during velocity calib) *);
    prActSysPressure : REFTO REAL (* reference to actual system pressure [bar] *);
    PumpState : tnPumpState (* actual state (free or busy) *);
    ActiveDevice : tsDeviceId (* device which actually writes to the pump *);
    ActiveMoveId : tMoveIdent (* move ID of the movement which actually writes to the pump *);
   END_STRUCT;
 tyPumpData : ARRAY  [1..cMaxNrOfPumps] OF tsPumpData;
 tsHydrMaxValues : 
   STRUCT 
    rAbsFlow : REAL;
    rMaxPressure : REAL;
   END_STRUCT;
 tsPumpConnectionElement : REFTO tsRequiredPumps;
 tyPumpConnectionList : ARRAY  [1..cMaxMoveRegistered] OF tsPumpConnectionElement;
 tsPumpConnectionList : 
   STRUCT 
    iCount : DINT;
    Movements : tyPumpConnectionList;
   END_STRUCT;
 tsResourceLock : 
   STRUCT 
    iLocked : UDINT;
    iRequest : DWORD;
    iResponse : DWORD;
   END_STRUCT (* do not change type for compatibiltiy reasons -> HostCommunication FU should be binary compatible *);
 tpsResourceLock : REFTO tsResourceLock;
 tsLockOperationModeAuto : 
   STRUCT 
    sResourceLock : tsResourceLock;
    iLockCounter : DINT;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 150 @Tou 25 
@@@BEG_Comment@@@
MoveIDs:
1  -  79 are reserved for KEBA
80 - 100 are free for use by customer
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
109 
@Constant @RT(13)cMinMoveIdent @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(32)lower limit for MoveId / MoveDir 
@END_Attrib 


@Constant @RT(13)cMaxMoveIdent @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)600 @RT(32)upper limit for MoveId / MoveDir 
@END_Attrib 


@Constant @RT(15)cMinLockGroupId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)60 @RT(36)lower limit for LockGroup identifier 
@END_Attrib 


@Constant @RT(14)cMaxGroupLocks @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(47)maximum number of group-membership per movement 
@END_Attrib 


@Constant @RT(15)cMaxLockGroupId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)100 @RT(36)upper limit for LockGroup identifier 
@END_Attrib 


@Constant @RT(15)cMaxDeviceIndex @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(39)maximum number of devices per component 
@END_Attrib 


@Constant @RT(12)cAllDevIndex @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)11 @RT(59)to lock all devices of a component ( = cMaxDeviceIndex + 1) 
@END_Attrib 


@Constant @RT(18)cMaxMoveRegistered @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)150 @RT(38)maximum number of registered movements 
@END_Attrib 


@Constant @RT(25)cMaxMoveDevicesRegistered @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)50 @RT(49)max number of devices which are serving movements 
@END_Attrib 


@Constant @RT(19)cMaxActiveMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(52)number of movements that are active at the same time 
@END_Attrib 


@Constant @RT(10)cMinCompId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)100 @RT(21)minimum Component ID  
@END_Attrib 


@Constant @RT(10)cMaxCompId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)250 @RT(21)maximum Component ID  
@END_Attrib 


@Constant @RT(14)cMaxComponents @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)150 @RT(53)max number of Components ( = cMaxCompId - cMinCompId) 
@END_Attrib 


@Constant @RT(13)cLockListSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)80 @RT(20)size of the locklist 
@END_Attrib 


@Constant @RT(19)cMaxDeviceMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(34)max number of movements per device 
@END_Attrib 


@Constant @RT(9)cMaxZones @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)72 @RT(27)max number of heating zones 
@END_Attrib 


@Constant @RT(9)cMoveNone @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(4)None 
@END_Attrib 


@Constant @RT(7)cMoveIf @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(2)IF 
@END_Attrib 


@Constant @RT(9)cMoveElse @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(4)ELSE 
@END_Attrib 


@Constant @RT(10)cMoveEndIf @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(6)END_IF 
@END_Attrib 


@Constant @RT(14)cMoveBeginLoop @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(10)Begin loop 
@END_Attrib 


@Constant @RT(12)cMoveEndLoop @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(8)End loop 
@END_Attrib 


@Constant @RT(15)cMoveBeginGroup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)7 @RT(11)Begin group 
@END_Attrib 


@Constant @RT(13)cMoveEndGroup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)8 @RT(9)End group 
@END_Attrib 


@Constant @RT(22)cMoveStartParallelOpen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)9 @RT(17)StartParallelOpen 
@END_Attrib 


@Constant @RT(20)cMoveEndParallelOpen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(15)EndParallelOpen 
@END_Attrib 


@Constant @RT(8)cMoveBwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)11 @RT(17)movement backward 
@END_Attrib 


@Constant @RT(8)cMoveFwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)12 @RT(16)movement forward 
@END_Attrib 


@Constant @RT(10)cMovePlast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)13 @RT(23)plast movement (rotate) 
@END_Attrib 


@Constant @RT(11)cMoveInject @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)14 @RT(15)inject movement 
@END_Attrib 


@Constant @RT(9)cMoveHold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)15 @RT(10)hold phase 
@END_Attrib 


@Constant @RT(16)cMoveBwdInterPos @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)16 @RT(38)move backward to intermediate position 
@END_Attrib 


@Constant @RT(16)cMoveFwdInterPos @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)17 @RT(37)move forward to intermediate position 
@END_Attrib 


@Constant @RT(10)cMoveShake @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)18 @RT(51)shaking movement (for example ejector vibrate mode) 
@END_Attrib 


@Constant @RT(10)cMoveStart @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)19 @RT(19)start (eg Airvalve) 
@END_Attrib 


@Constant @RT(9)cMoveStop @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(18)stop (eg Airvalve) 
@END_Attrib 


@Constant @RT(7)cMoveIn @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)21 @RT(26)move in (for example core) 
@END_Attrib 


@Constant @RT(8)cMoveOut @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)22 @RT(27)move out (for example core) 
@END_Attrib 


@Constant @RT(14)cModeAutomatic @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)23 @RT(50)for locking/unlocking half and full automatic mode 
@END_Attrib 


@Constant @RT(18)cModeFullAutomatic @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)24 @RT(46)for locking/unlocking only full automatic mode 
@END_Attrib 


@Constant @RT(12)cMoveCooling @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)25 @RT(12)cooling time 
@END_Attrib 


@Constant @RT(19)cMoveDecompBefPlast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)26 @RT(26)decompression before plast 
@END_Attrib 


@Constant @RT(19)cMoveDecompAftPlast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)27 @RT(25)decompression after plast 
@END_Attrib 


@Constant @RT(14)cMoveIntrusion @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)28 @RT(9)intrusion 
@END_Attrib 


@Constant @RT(15)cMoveMoldHeight @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)29 @RT(23)movement of mold height 
@END_Attrib 


@Constant @RT(20)cMoldHeightAutomatic @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)31 @RT(45)procedure of automatic mold height adjustment 
@END_Attrib 


@Constant @RT(19)cMoveFwdForMHAdjust @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)32 @RT(61)mold forward movement during automatic mold height adjustment 
@END_Attrib 


@Constant @RT(19)cMoveBwdForMHAdjust @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)33 @RT(62)mold backward movement during automatic mold height adjustment 
@END_Attrib 


@Constant @RT(15)cMovePlastPurge @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)34 @RT(26)plast movement for purging 
@END_Attrib 


@Constant @RT(16)cMoveInjectPurge @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)35 @RT(27)inject movement for purging 
@END_Attrib 


@Constant @RT(16)cMoveDecompPurge @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)36 @RT(27)decomp movement for purging 
@END_Attrib 


@Constant @RT(14)cMoveAutoPurge @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)37 @RT(18)autopurge movement 
@END_Attrib 


@Constant @RT(12)cMovePVCalib @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)38 @RT(38)injection movement with voltage output 
@END_Attrib 


@Constant @RT(24)cMoveFwdForMHAdjustSetup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)39 @RT(61)mold forward movement during automatic mold height adjustment 
@END_Attrib 


@Constant @RT(24)cMoveBwdForMHAdjustSetup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)40 @RT(62)mold backward movement during automatic mold height adjustment 
@END_Attrib 


@Constant @RT(8)cMoveRef @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)41 @RT(54)Dummymovement for displaying referencing symbol in vis 
@END_Attrib 


@Constant @RT(27)cMoveFwdWithoutPressBuildUp @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)42 @RT(51)movement forward without building up clamp pressure 
@END_Attrib 


@Constant @RT(18)cMoveBeginSequence @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)43 @RT(38)dummy movement for begin of a sequence 
@END_Attrib 


@Constant @RT(16)cMoveEndSequence @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)44 @RT(36)dummy movement for end of a sequence 
@END_Attrib 


@Constant @RT(18)cMoveStartParallel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)45 @RT(34)dummy movement for "StartParallel" 
@END_Attrib 


@Constant @RT(16)cMoveEndParallel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)46 @RT(32)dummy movement for "EndParallel" 
@END_Attrib 


@Constant @RT(24)cMoveIncreaseShotCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)47 @RT(21)increase shot counter 
@END_Attrib 


@Constant @RT(17)cMoveWaitForReady @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)48 @RT(28)wait for ready (eg Airvalve) 
@END_Attrib 


@Constant @RT(13)cMoveColdDrop @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)49 @RT(42)cold drop (time dependent inject movement) 
@END_Attrib 


@Constant @RT(9)cMoveOpen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)50 @RT(43)open movement (for example shut off nozzle) 
@END_Attrib 


@Constant @RT(10)cMoveClose @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)51 @RT(44)close movement (for example shut off nozzle) 
@END_Attrib 


@Constant @RT(19)cMoveStartCondition @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)52 @RT(35)dummy movement for "StartCondition" 
@END_Attrib 


@Constant @RT(19)cMoveCheckCondition @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)53 @RT(35)dummy movement for "CheckCondition" 
@END_Attrib 


@Constant @RT(19)cMoveDecompInterPos @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)54 @RT(35)instanceable decompression movement 
@END_Attrib 


@Constant @RT(18)cMoveCombinedPlast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)55 @RT(60)combined plast movement (decomp before, plast, decomp after) 
@END_Attrib 


@Constant @RT(17)cMoveStartAndWait @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)56 @RT(42)start movement and wait untill is is ready 
@END_Attrib 


@Constant @RT(11)cMoveEvent1 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)57 @RT(7)event 1 
@END_Attrib 


@Constant @RT(11)cMoveEvent2 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)58 @RT(7)event 2 
@END_Attrib 


@Constant @RT(11)cMoveEvent3 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)59 @RT(7)event 3 
@END_Attrib 


@Constant @RT(11)cMoveEvent4 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)60 @RT(7)event 4 
@END_Attrib 


@Constant @RT(11)cMoveEvent5 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)61 @RT(7)event 5 
@END_Attrib 


@Constant @RT(11)cMoveEvent6 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)62 @RT(7)event 6 
@END_Attrib 


@Constant @RT(11)cMoveEvent7 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)63 @RT(7)event 7 
@END_Attrib 


@Constant @RT(11)cMoveEvent8 @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)64 @RT(7)event 8 
@END_Attrib 


@Constant @RT(21)cMoveDeclaredEndpoint @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)65 @RT(17)declared endpoint 
@END_Attrib 


@Constant @RT(16)cMoveFwdContactF @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)66 @RT(45)nozzle forward with building up contact force 
@END_Attrib 


@Constant @RT(23)cMoveBwdContactFRelieve @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)67 @RT(21)contact force relieve 
@END_Attrib 


@Constant @RT(17)cMoveServoATCalib @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)68 @RT(48)calibration movement for servo AT characteristic 
@END_Attrib 


@Constant @RT(15)cMoveServoCalib @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)69 @RT(35)calibration movement for servovalve 
@END_Attrib 


@Constant @RT(16)cMoveInjectCalib @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)70 @RT(48)calibration movement for servo inject controller 
@END_Attrib 


@Constant @RT(13)cMoveRotateCW @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)71 @RT(35)rotate table in clockwise direction 
@END_Attrib 


@Constant @RT(14)cMoveRotateCCW @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)72 @RT(43)rotate table in counter clockwise direction 
@END_Attrib 


@Constant @RT(11)cMoveRotate @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)73 @RT(46)rotate table in direction needed for autocycle 
@END_Attrib 


@Constant @RT(18)cMHAProdClosedLoop @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)74 @RT(55)mold height adjustment during production in closed loop 
@END_Attrib 


@Constant @RT(12)cMoveCoining @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)75 @RT(46)coining for the injection compression moulding 
@END_Attrib 


@Constant @RT(12)cMoveVenting @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)76 @RT(46)venting for the injection compression moulding 
@END_Attrib 


@Constant @RT(8)cMoveAll @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)100 @RT(32)all movements (for evLockUnlock) 
@END_Attrib 


@Constant @RT(13)cMoveKEBALast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(2)79 @RT(82)MoveIDs 1 - 79 are reserved for KEBA, MoveIDs 80 - 99 are free for use by customer 
@END_Attrib 


@Constant @RT(23)cMeasureReductionFactor @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(103)reduction factor for measure block (reduction is active if no movement of this function unit is active) 
@END_Attrib 


@Constant @RT(25)cEndPosMonReductionFactor @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(113)reduction factor for endpos monitoring block (reduction is active if no movement of this function unit is active) 
@END_Attrib 


@Constant @RT(26)cMaxIntermediateConditions @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(38)max. number of intermediate conditions 
@END_Attrib 


@Constant @RT(15)cMaxImpulseGain @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(42)max. number of gains for impulse measuring 
@END_Attrib 


@Constant @RT(22)cMovementHistoryLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)30 @RT(43)number of entries in movement history array 
@END_Attrib 


@Constant @RT(13)cMaxNrOfPumps @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(24)maximum number of pumps  
@END_Attrib 


@Constant @RT(26)cMoveKEBASecondMoveIdRange @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(3)400 @RT(116)second range for MoveIds from 400 - 600  (IDs up to 399 are reserved for possible extension of component ID - range) 
@END_Attrib 


@Constant @RT(11)cMoveTarget @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)400 @RT(27)movement to target position 
@END_Attrib 


@Constant @RT(19)cMoveTieBarTopFront @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)401 @RT(16)tiebar top front 
@END_Attrib 


@Constant @RT(18)cMoveTieBarTopRear @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)402 @RT(15)tiebar top rear 
@END_Attrib 


@Constant @RT(21)cMoveTieBarBottomRear @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)403 @RT(19)tiebar bottom front 
@END_Attrib 


@Constant @RT(22)cMoveTieBarBottomFront @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)404 @RT(18)tiebar bottom rear 
@END_Attrib 


@Constant @RT(14)cMoveTieBarAll @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)405 @RT(27)all tiebars moving together 
@END_Attrib 


@Constant @RT(24)cMoveHighPressureBuildUp @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)406 @RT(22)high pressure build up 
@END_Attrib 


@Constant @RT(21)cMoveHighPressureHold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)407 @RT(21)high pressure holding 
@END_Attrib 


@Constant @RT(24)cMoveHighPressureRelease @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)408 @RT(21)high pressure release 
@END_Attrib 


@RT(17)TypeTreeContainer 
104 
@DT @RT(19)tsDataActionsEnable @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(13)bMoldDataLoad @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bMoldDataSave @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bMachineDataLoad @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bMachineDataSave @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)bSequenceDataLoad @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)bSequenceDataSave @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(11)tnDataState @RT(0) @T @T @ENUM 0 9 
@EnumConst @RT(6)nReady @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(13)nReadMoldData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nWriteMoldData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nReadMachineData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nWriteMachineData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nReadMaterialData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nWriteMaterialData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nReadSequenceData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nWriteSequenceData @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(7)tCompId @RT(0) @T @T @SUBRANGE 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @RT(10)cMinCompId @RT(10)cMaxCompId @F 
@T 
@BEG_Attrib 
2 @RT(10)cMinCompId @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(8)tIndexId @RT(0) @T @T @SUBRANGE 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @RT(1)1 @RT(12)cAllDevIndex @F 
@T 
@BEG_Attrib 
2 @RT(1)1 @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tMoveIdent @RT(0) @T @T @SUBRANGE 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @RT(13)cMinMoveIdent @RT(13)cMaxMoveIdent @F 
@T 
@BEG_Attrib 
2 @RT(13)cMinMoveIdent @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tLockGroup @RT(0) @T @T @SUBRANGE 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @RT(15)cMinLockGroupId @RT(15)cMaxLockGroupId @F 
@T 
@BEG_Attrib 
2 @RT(15)cMinLockGroupId @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsDeviceId @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)CompId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tCompId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)IndexId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tIndexId @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(17)tyNumberOfDevices @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(10)cMinCompId @RT(10)cMaxCompId 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyRegisteredDevices @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 2 @RT(10)cMinCompId @RT(10)cMaxCompId @RT(1)1 @RT(15)cMaxDeviceIndex 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tyLockGroups @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tLockGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cMaxGroupLocks 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(14)cLockGroupNone @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsStartedMoveInfo @RT(0) @T @T @STRUCT 0 3 

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


@DT @RT(17)tyStartedMoveData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsStartedMoveInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxActiveMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsStartedMoveData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(17)iStartedMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)number of started movements @RT(0) 
@END_Attrib 

@StructElem @RT(8)MoveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyStartedMoveData @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(12)tsAnaOutData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(14)pRequiredPumps @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
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
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsMoveData @RT(0) @T @T @STRUCT 0 31 

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

@StructElem @RT(10)LockGroups @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tyLockGroups @RT(0) @T @T @UNKNOWN 0 @F 
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

@StructElem @RT(15)pdStartDelaySet @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pdStartDelayAct @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)pbStartDelayActive @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pdActiveTimeAct @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)pdLastActiveTime @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)reference to variable with the last movement time @RT(0) 
@END_Attrib 

@StructElem @RT(11)pdTimeLimit @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)pdCalculatedDuration @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)refto to calculated duration of this movement @RT(0) 
@END_Attrib 

@StructElem @RT(13)prTargetValue @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)refto to target value of this movement @RT(0) 
@END_Attrib 

@StructElem @RT(14)piInstancePrio @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)pointer to a calculated priority @RT(0) 
@END_Attrib 

@StructElem @RT(23)pbStartConditionReached @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)start condition (for example a position) reached @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbActivated @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(82)information if movement is activated or not; deactivated movements are not started @RT(0) 
@END_Attrib 

@StructElem @RT(11)bDefaultPos @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(126)TRUE: if a safety relevant component is not programmed in sequence then this movement is the defaultposition for the component @RT(0) 
@END_Attrib 

@StructElem @RT(11)bIsWaitStep @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(88)movement is a wait step -> no start necessary, just wait for PosReached of this movement @RT(0) 
@END_Attrib 

@StructElem @RT(21)bContinueWithoutReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(104)TRUE: after start of the movement the autocyle continues without waiting for ready flag of this movement @RT(0) 
@END_Attrib 

@StructElem @RT(13)bInstanceable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(87)TRUE: movement can be used with different parameters (for example mold close inter pos) @RT(0) 
@END_Attrib 

@StructElem @RT(21)bProgrammedInSequence @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(93)TRUE: programmed machine sequence (from ODC) includes this movement; flag is written by ODC!! @RT(0) 
@END_Attrib 

@StructElem @RT(18)bIgnoreByABControl @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)TRUE: start event for this movement is ignored by ABControl @RT(0) 
@END_Attrib 

@StructElem @RT(23)bAllowedDuringInterrupt @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(92)TRUE: this movement can be started (by manual button) during sequence interruption is active @RT(0) 
@END_Attrib 

@StructElem @RT(18)bFinishAtInterrupt @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(113)FALSE: movement is stopped immediately at sequence interruption; TRUE: this movement can finished after interrupt @RT(0) 
@END_Attrib 

@StructElem @RT(5)Alarm @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsAlarm @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)iSafetyIdentifier @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(215)0: not safety relevant, 1: safety relevant, 2:partially safety relevant(not safety relevant itself but checks other safety relevant movements)  3: sequence safetyrelevant  but not mold safety relvant (Safetyeditor)  @RT(0) 
@END_Attrib 

@StructElem @RT(22)iMoveIdInverseMovement @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(128)move id of the according inverse movement in this function unit (needed for stepping bwd during sequence interruption is active) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sIconPath @RT(0) @T @F @DT @RT(10)STRING(50) @RT(0) @T @T @STRING 0 @F @RT(2)50 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)movement icon (displayed if movement is active) @RT(0) 
@END_Attrib 

@StructElem @RT(7)sMoveId @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)string to identify a movement @RT(0) 
@END_Attrib 

@StructElem @RT(10)AnaOutData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsAnaOutData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)EditorData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEditorData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)InstanceData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsInstanceData @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(10)tpMoveData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tyMoveDataArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tpMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxDeviceMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsMoveCtrl @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(5)pData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tpMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)bStop @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)bReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(4)TRUE @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(14)(bReady:=TRUE) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tnLockUnlock @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(10)nLockAbort @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nLockResume @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nUnlock @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tsLockEntry @RT(0) @T @T @STRUCT 0 5 

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

@StructElem @RT(11)bStopDevice @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tsLockListElem @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(5)bUsed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bDisabled @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)this locklist entry is disabled (=ignored) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bAlarmSet @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)entry @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsLockEntry @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(11)tyyLockList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsLockListElem @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(13)cLockListSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(7)tsAlarm @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)AlarmId @RT(0) @T @F @DT @RT(5)ALARM @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)SubId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tySubId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)Param1 @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)Param2 @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
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


@DT @RT(7)tySubId @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tnStartedStopped @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(8)nStarted @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nStopped @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nStartNotAllowed @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)Starting the movement was not allowed because of lock list @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tnActiveInactive @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(9)nInactive @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nActive @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tnMoveRegMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(15)nMoveRegModeArm @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)arm Movement-Reg: increments registrationCounter @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nMoveRegModeFire @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)Movement-Reg is executed, decrements registration counter.  @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tsMovementRegisterListElem @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iFuIndex @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)index of this function unit in sv_ODCDeviceMovements @RT(0) 
@END_Attrib 

@StructElem @RT(13)pbDeviceReady @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(24)iODCSafetyMovementsEntry @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)index to ODC1.sv_SafetyMovements if available @RT(0) 
@END_Attrib 

@StructElem @RT(16)iSESafetyProgIdx @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)indext to ODC1.sv_SafetyList @RT(0) 
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


@DT @RT(22)tyMovementRegisterList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(26)tsMovementRegisterListElem @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cMaxMoveRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tyDeviceMovementListElem @RT(0) @T @T @STRUCT 0 5 

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

@StructElem @RT(18)iNumberOfMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)number of movements registered by this function unit @RT(0) 
@END_Attrib 

@StructElem @RT(18)iDefaultMoveNumber @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(143)number of the default movement of this function unit (this endposition must be reached if no movement of this fu is programmed in the sequence) @RT(0) 
@END_Attrib 

@StructElem @RT(9)Movements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyMoveDataArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)array with registered movements of this function unit @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tDeviceMovementList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(24)tyDeviceMovementListElem @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tnOperationMode @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(6)nSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)Setup mode only for service engineer @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nManual @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(31)manual mode, play with switches @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nHalfAutomatic @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)confirmation every cycle necessary @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nFullAutomatic @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)confirmation only for the first cycle necessary @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tnSafetyGateState @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(7)nClosed @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nError @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tnTraceLevel @RT(0) @T @T @ENUM 0 8 
@EnumConst @RT(12)nApplication @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(13)nRegistration @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nLockUnlock @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nDeviceState @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nAnalog @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nServo @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nODCInterpreter @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nODCDependencies @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(8)tsVelPre @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)Velocity @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)Pressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsOutput @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(8)tsOutput @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(6)Output @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsConstOutputData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)PreOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsConstOutputData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rMinOutput @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(11)tsErrorInfo @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)Velocity @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)Pressure @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(17)tyActiveMovements @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxActiveMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsActiveMovements @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(24)iNumberOfActiveMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)ActiveMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyActiveMovements @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(12)tsSetActTime @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)dSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)dAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tsSetActMaxTime @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(4)dSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)dAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)dMax @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)tsSetActUDint @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)iSet @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)iAct @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(12)tsSetActReal @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)rSetReal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)rActReal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(17)tsConstOutputData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(12)rOutputValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)rRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(6)1000.0 @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)RampType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_YXGen_RampType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(15)(rRamp:=1000.0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsInjectHoldNumbers @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(15)iInjectMovement @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)number of inject movement @RT(0) 
@END_Attrib 

@StructElem @RT(13)iHoldMovement @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)number of hold movement @RT(0) 
@END_Attrib 

@StructElem @RT(11)bHoldActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)cut off was detected -> holding is active @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyInjectHoldNumbers @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsInjectHoldNumbers @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cMaxDeviceIndex 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyTraceDeviceFilter @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxTraceFilters 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsTraceFilter @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(9)bFilterOn @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)DeviceFilter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyTraceDeviceFilter @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(12)tsTraceLevel @RT(0) @T @T @STRUCT 0 15 

@StructElem @RT(12)bApplication @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bRegistration @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)bLockUnlock @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)bDeviceState @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)bAnalog @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)bServo @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(24)bExceptionInterpretation @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)bODCInterpreter @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bODCDependencies @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)general debug flag for dependency calculation @RT(0) 
@END_Attrib 

@StructElem @RT(15)bODCDependTrace @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)log dependency calc to system trace @RT(0) 
@END_Attrib 

@StructElem @RT(14)bODCDependFile @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)log dependency calc to file @RT(0) 
@END_Attrib 

@StructElem @RT(15)bODCBrowseTrace @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)log sequence browsing to system trace @RT(0) 
@END_Attrib 

@StructElem @RT(14)bODCBrowseFile @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)log sequence browsing to system file @RT(0) 
@END_Attrib 

@StructElem @RT(4)bKVB @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)traces from KVB function unit @RT(0) 
@END_Attrib 

@StructElem @RT(17)bDebugCalibration @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)write measured data to file during calibration  @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsLimitDataReal @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(11)rLowerLimit @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)rUpperLimit @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(10)tsSetTimes @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(13)dSetDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)movement delay time @RT(0) 
@END_Attrib 

@StructElem @RT(17)dSetDelayTimePump @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)delay time between valve on and pump start @RT(0) 
@END_Attrib 

@StructElem @RT(18)dSetDelayTimeValve @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)delay time between pump stop and valve off @RT(0) 
@END_Attrib 

@StructElem @RT(12)dMaxMoveTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(18)tsSetTimesExtended @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(13)dSetDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)dSetDelayTimePump @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)delay time between valve on and pump start @RT(0) 
@END_Attrib 

@StructElem @RT(18)dSetDelayTimeValve @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)delay time between pump stop and valve off @RT(0) 
@END_Attrib 

@StructElem @RT(12)dSetMoveTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)dMaxMoveTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(10)tsActTimes @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(13)dActDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)dActMoveTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)dLastMoveTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(22)tsInterCondListElement @RT(0) @T @T @STRUCT 0 4 

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

@StructElem @RT(14)DeviceIdSender @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)device that requires a target value (e.g.: Core1) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)element of list with intermediate conditions @RT(0) 
@END_Attrib 


@DT @RT(16)tyInterCondArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(22)tsInterCondListElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)array with intermediate conditions @RT(0) 
@END_Attrib 


@DT @RT(15)tsInterCondList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)iUsedElements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)number of used elements @RT(0) 
@END_Attrib 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyInterCondArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)list containing the intermediate conditions @RT(0) 
@END_Attrib 


@DT @RT(22)tnInterCondChangedMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(16)nInterCondUpdate @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)update/add condition to list @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nInterCondRemove @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)remove condition from list @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tnLimitSwitchMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(26)nLimitSwitchNormallyClosed @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nLimitSwitchNormallyOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tyLockList @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(13)iElementsUsed @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)iListChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)lockList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyyLockList @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(14)tnODCElemement @RT(0) @T @T @ENUM 0 16 
@EnumConst @RT(19)nODCElementDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)duration element (cooling, airvalve, ..) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nODCElementMovement @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)movement element (mold close, inject, ......) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nODCElementShake @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)shake element @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nODCElementEventIn @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)event in element @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nODCElementEventOut @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)event out element @RT(0) 
@END_Attrib 
@EnumConst @RT(25)nODCElementStartCondition @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)start condition @RT(0) 
@END_Attrib 
@EnumConst @RT(25)nODCElementCheckCondition @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)check condition @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nODCElementSequenceBound @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)begin/end of sequences @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nODCElementBranchBound @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)begin/end of branches @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nODCElementInjectAndHold @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)inject (movement) combined with hold (duration) @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nODCElementCombinedPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)combination of decomp before, plast and decomp after @RT(0) 
@END_Attrib 
@EnumConst @RT(23)nODCElementDelaredInput @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)all declared (configured) DI´s @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nODCElementIFCondition @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)if - condition element (if, else, end_if) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nODCElementLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)loop element (begin loop, end loop) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nODCElementGroup @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)group element (begin group, end group) @RT(0) 
@END_Attrib 
@EnumConst @RT(31)nODCElementInstanceableDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tnMoveDirection @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(16)nMoveDirectionNo @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)no move direction (init value) @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nMoveDirectionMinToMax @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)movement from min. value to max. value @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nMoveDirectionMaxToMin @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)movement from max. value to min. value @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(56)necessary for drawing the rectangles in graphical editor @RT(0) 
@END_Attrib 


@DT @RT(17)tnDeviceDirection @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(18)nDeviceDirectionNo @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)no direction (init value) @RT(0) 
@END_Attrib 
@EnumConst @RT(27)nDeviceDirectionLeftToRight @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)max. value on the right side @RT(0) 
@END_Attrib 
@EnumConst @RT(27)nDeviceDirectionRightToLeft @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)max. value on the left side @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)direction of the device @RT(0) 
@END_Attrib 


@DT @RT(12)tsEditorData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(20)pbReferenceCondition @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(79)reference to a boolean condition that (can be used in start condition dialogue) @RT(0) 
@END_Attrib 

@StructElem @RT(9)Direction @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnMoveDirection @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)MovementType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnODCElemement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)sElementData @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(182)name of systemvariable that contains the necessary data for the according ODCElementType attention: different ODCElements require systemvariables with different types of sElementData @RT(0) 
@END_Attrib 

@StructElem @RT(8)sODCIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(57)addtional icon which is displayed in the graphical editor @RT(0) 
@END_Attrib 

@StructElem @RT(21)sLGInstanceProperties @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(61)string containing the listgroup names for instance properties @RT(0) 
@END_Attrib 

@StructElem @RT(9)bReadOnly @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)flag for indicating read only movements in editor @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsInstanceListElement @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(12)rTargetValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)rDeceleration @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(45)percent ramp deceleration to reach this point @RT(0) 
@END_Attrib 

@StructElem @RT(13)rAcceleration @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(41)percent ramp acceleration from this point @RT(0) 
@END_Attrib 

@StructElem @RT(6)dDelay @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)set delaytime @RT(0) 
@END_Attrib 

@StructElem @RT(19)dCalculatedDuration @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(43)(rDeceleration:=100.0,rAcceleration:=100.0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyInstanceListArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(21)tsInstanceListElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsAddDeviceInfo @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(10)prActValue @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)refto actual value (for example actual position) @RT(0) 
@END_Attrib 

@StructElem @RT(10)prMaxValue @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(54)refto maximum value of the device (for example stroke) @RT(0) 
@END_Attrib 

@StructElem @RT(10)piActState @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(98)refto actual state (integer variable with according format to display a status text in the editor) @RT(0) 
@END_Attrib 

@StructElem @RT(9)Direction @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnDeviceDirection @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(31)move direction of the component @RT(0) 
@END_Attrib 

@StructElem @RT(12)InitPosition @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnInitPosition @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(70)additional information about this device (needed for graphical editor) @RT(0) 
@END_Attrib 


@DT @RT(14)tnInitPosition @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(15)nInitPosMaximum @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)init position is the maximum position @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nInitPosMinimum @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)init position is the minimum position @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tnBadPartReason @RT(0) @T @T @ENUM 0 5 
@EnumConst @RT(16)nReason_GoodPart @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nReason_Unknown @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nReason_PDS @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nReason_InjectGraph @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nReason_MoldProtection @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tsProduction @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(14)iRejectCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)number of bad parts @RT(0) 
@END_Attrib 

@StructElem @RT(15)iRejectsPerTime @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(64)actual number of rejected  parts per timespan (see next element) @RT(0) 
@END_Attrib 

@StructElem @RT(15)iRejectTimeSpan @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)iGoodPartsPerReject @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)count parts until bad part @RT(0) 
@END_Attrib 

@StructElem @RT(16)iRejectsInSeries @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)increase if bad part, reset if to 0 if good part. @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)production data @RT(0) 
@END_Attrib 


@DT @RT(14)tyImpulseArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(15)cMaxImpulseGain 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsInstanceData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(16)pActiveTimeArray @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)reference to array with active move times @RT(0) 
@END_Attrib 

@StructElem @RT(20)pLastActiveTimeArray @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)reference to array with last active times @RT(0) 
@END_Attrib 

@StructElem @RT(16)pPosReachedArray @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(64)reference to array with posreached information for all instances @RT(0) 
@END_Attrib 

@StructElem @RT(26)pProgrammedInSequenceArray @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(67)reference to array with bProgrammedInSequence info of all instances @RT(0) 
@END_Attrib 

@StructElem @RT(19)pMovementReadyArray @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)reference to array with ready information of all instances @RT(0) 
@END_Attrib 

@StructElem @RT(16)sInstanceDataVar @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(81)variable name that contains the data for the different instances of this movement @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tyInterCondBoolArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(28)tsMoveAndDurationElementData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(18)pdMovementDuration @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)refto movement duration @RT(0) 
@END_Attrib 

@StructElem @RT(10)pdDuration @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)refto duration @RT(0) 
@END_Attrib 

@StructElem @RT(16)sODCMovementIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(65)icon that should be displayed in the movement part of the element @RT(0) 
@END_Attrib 

@StructElem @RT(16)sODCDurationIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(65)icon that should be displayed in the duration part of the element @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(100)necessary data to display an element that contains of a movement and a duration in machine sequencer @RT(0) 
@END_Attrib 


@DT @RT(13)tnCoreControl @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(12)nRoundsCount @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)for core type screw, count the rounds @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nTime @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)move the core time dependent @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nLimitSwitch @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)move the core limit switch dependent @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)how the core is controlled @RT(0) 
@END_Attrib 


@DT @RT(20)tnCombinedCoreInMode @RT(0) @T @T @ENUM 0 6 
@EnumConst @RT(10)nCoreInOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)coretype = off @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nCoreInBeforeMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)core in before mold close @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nCoreInDuringMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)core in during mold close @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nCoreInAfterMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)core in after mold close @RT(0) 
@END_Attrib 
@EnumConst @RT(25)nCoreInAfterMoldNutsClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)core in after mold nuts close (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nCoreInAfterHighPress @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)core in after high pressure build up (2 PL machines) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(76)combination of core in mode (before, during,..) and coretype (off, screw,..) @RT(0) 
@END_Attrib 


@DT @RT(21)tnCombinedCoreOutMode @RT(0) @T @T @ENUM 0 7 
@EnumConst @RT(11)nCoreOutOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)coretype = off @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nCoreOutBeforeMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)core out before mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nCoreOutDuringMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)core out during mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nCoreOutAfterMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)core out after mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nCoreOutBeforeHiPressRel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)core out before high press release (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)nCoreOutAfterHiPressRel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)core out after high press release (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(26)nCoreOutBeforeMoldNutsOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)core out after mold nuts open (2 PL machines) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(77)combination of core out mode (before, during,..) and coretype (off, screw,..) @RT(0) 
@END_Attrib 


@DT @RT(13)tnServiceType @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(10)nNoService @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nServiceInterval @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nServicePowerOnTime @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(9)tnAirMode @RT(0) @T @T @ENUM 0 8 
@EnumConst @RT(11)nAirModeOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nAirModeAfterPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nAirModeAfterMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nAirModeAfterEject @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nAirModeDuringMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nAirModeBeforePlast @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nAirModeAfterInject @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)nAirModeDuringMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tsInjectHoldElementData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(16)pdInjectDuration @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)inject duration @RT(0) 
@END_Attrib 

@StructElem @RT(14)pdHoldDuration @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)hold duration @RT(0) 
@END_Attrib 

@StructElem @RT(14)sODCInjectIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)sODCHoldIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)necessary data to display inject and hold in odc editor @RT(0) 
@END_Attrib 


@DT @RT(20)tyDisabledLockGroups @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tyLockGroupDisabled @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxDeviceMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tyLockGroupDisabled @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(14)cMaxGroupLocks 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tenDatatype @RT(0) @T @T @ENUM 0 13 
@EnumConst @RT(6)enBOOL @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enSINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(5)enINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enDINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)enUSINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enUINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)enUDINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enREAL @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)enSTRING @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enLINT @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enBYTE @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(6)enWORD @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(7)enDWORD @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyHeatingPower @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tnRobotInterface @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(12)nSwitchedOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)robot interface switched off @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nEuromap12 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)use euromap 12 @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nEuromap67 @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)use euromap 67 @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nUserDefIF @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)userdefined @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tyInterCondTimeArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tnSequInterrupt @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(18)nSequenceInterrupt @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)interrupt sequence @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nSequenceContinue @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)continue sequence @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsMoveHistoryData @RT(0) @T @T @STRUCT 0 3 

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

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)tyMoveHistory @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsMoveHistoryData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(22)cMovementHistoryLength 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsMovementHistory @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(9)iActCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Data @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyMoveHistory @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(29)tsInstanceListElementDuration @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(6)dDelay @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)set delaytime @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(27)tyInstanceListArrayDuration @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(29)tsInstanceListElementDuration @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsLimitDataINT @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(11)iLowerLimit @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iUpperLimit @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tyRequiredPumps @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(13)cMaxNrOfPumps 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tnPumpState @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(14)nPumpStateFree @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)pump is free @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nPumpStateBusy @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)pump is busy @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsPumpData @RT(0) @T @T @STRUCT 0 12 

@StructElem @RT(9)prAnaOutP @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)reference to actual pressure output [bar] of pump @RT(0) 
@END_Attrib 

@StructElem @RT(9)prAnaOutV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)reference to actual velocity output  [%] of pump @RT(0) 
@END_Attrib 

@StructElem @RT(9)prAbsFlow @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)reference to absolute flow [l/min] of pump @RT(0) 
@END_Attrib 

@StructElem @RT(13)prMaxPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)reference to maximum pressure [bar] of pump @RT(0) 
@END_Attrib 

@StructElem @RT(13)prActVoltageP @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)reference to actual pressure output voltage [V] of pump @RT(0) 
@END_Attrib 

@StructElem @RT(13)prMaxVoltageP @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(80)reference to maximum output voltage [V] of pump pressure (during pressure calib) @RT(0) 
@END_Attrib 

@StructElem @RT(13)prActVoltageV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)reference to actual velocity output voltage [V] of pump @RT(0) 
@END_Attrib 

@StructElem @RT(13)prMaxVoltageV @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(80)reference to maximum output voltage [V] of pump velocity (during velocity calib) @RT(0) 
@END_Attrib 

@StructElem @RT(16)prActSysPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)reference to actual system pressure [bar] @RT(0) 
@END_Attrib 

@StructElem @RT(9)PumpState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tnPumpState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)actual state (free or busy) @RT(0) 
@END_Attrib 

@StructElem @RT(12)ActiveDevice @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)device which actually writes to the pump @RT(0) 
@END_Attrib 

@StructElem @RT(12)ActiveMoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(57)move ID of the movement which actually writes to the pump @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tyPumpData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsPumpData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(13)cMaxNrOfPumps 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsRequiredPumps @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)RequiredPumps @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)required pumps for this movement @RT(0) 
@END_Attrib 

@StructElem @RT(6)iOrder @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)relevant for display order in HMI @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsHydrMaxValues @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)rAbsFlow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rMaxPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(23)tsPumpConnectionElement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tyPumpConnectionList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(23)tsPumpConnectionElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cMaxMoveRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tsPumpConnectionList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)Movements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyPumpConnectionList @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(15)tpsResourceLock @RT(0) @T @T @REFTO 0 @T @DT @RT(14)tsResourceLock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsResourceLock @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(7)iLocked @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iRequest @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)iResponse @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(96)do not change type for compatibiltiy reasons -> HostCommunication FU should be binary compatible @RT(0) 
@END_Attrib 


@DT @RT(23)tsLockOperationModeAuto @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)sResourceLock @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsResourceLock @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)iLockCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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
