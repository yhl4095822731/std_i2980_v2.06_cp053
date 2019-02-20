IMPORT_OVER_LISTFILE
 tsDeviceId
, tMoveIdent
, tsAddDeviceInfo
, tyMoveDataArray
, tevStartRequestData
, KODC_Sequence
, KODC_Step
, tnMoveDirection
, tsAlarm
, cMaxActiveMovements
, cMaxParallelMovements
, cMaxODCSteps
, cMaxMoveDevicesRegistered
, cMaxIntermediateConditions

END_IMPORT

CONSTANT
 cODCDependencyDontCare : DINT := -1 (* dependency dont care, function unit not safety relevant, interpretation TRUE *);
 cODCNoDependency : DINT := 0 (* no dependency, used for dependency calc, interpretation FALSE *);
 cParseStackSize : DINT := 20 (* must be bigger than cMaxParallelMovements *);
 cODCSequenceBackupCount : DINT := 5 (* number of backup sequence we keep *);
 cTimeOutSempahore : TIME := t#30s;
 cMaxStartConditions : DINT := 10 (* max number of start condition steps in the sequence *);
 cMaxCheckConditions : DINT := 10 (* max number of check condition steps in the sequence *);
 cCycleTimeArraySize : DINT := 3 (* size of array that contains the last cycle times *);
 cMaxIFConditions : DINT := 20 (* max. number of IF - conditions *);
 cMaxAvailableIFConditions : DINT := 30 (* max. number of available IF - conditions *);
 cMaxLoops : DINT := 10 (* max. number of loops *);
 cMaxAvailableLoopConditions : DINT := 10 (* max. number of available loop conditions *);
 cMaxODCGroups : DINT := 10 (* max. number of groups *);
 cFirstBit : LWORD := 16#8000000000000000;
 cNoDependency : LWORD := 16#0;
 cMaxStartParallel : DINT := 50 (* max. number of start parallel steps *);
 cMaxSRInstanceableMovements : DINT := 4 (* max. numer of safety relevant instanceable movements per FU (must not be increased!!!) *);
END_CONSTANT

TYPE
 tsODCStepPos : 
   STRUCT 
    iColumn : DINT;
    iRow : DINT;
   END_STRUCT (* step position in sequence *);
 tsStartedMoveInfoODCExtended : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveDir : tMoveIdent;
    MoveId : tMoveIdent;
    StepPos : tsODCStepPos (* Position in autocycle for cyclic safety check *);
    iInstance : DINT;
   END_STRUCT;
 tyStartedMoveDataODCExtended : ARRAY  [1..cMaxActiveMovements] OF tsStartedMoveInfoODCExtended;
 tsStartedMoveDataODCExtended : 
   STRUCT 
    iStartedMovements : DINT (* number of started movements *);
    MoveData : tyStartedMoveDataODCExtended;
   END_STRUCT;
 tsODCStepInfo : 
   STRUCT 
    iMoveNr : DINT (* depends on a movement *);
    iMoveCount : DINT (* intermediate position for movement in iMoveNr *);
    iFuIndex : DINT (* index of fu in sv_ODCDeviceMovements array *);
    MoveId : tMoveIdent (* MoveId of this step *);
   END_STRUCT (* step info *);
 tnODCStepState : (nStateDefault, nStateActive, nStateReady, nStateError);
 tsODCStepDependency : 
   STRUCT 
    Dependency : LWORD;
   END_STRUCT (* step dependency condition *);
 tyODCDependencyArray : ARRAY  [1..cMaxMoveDevicesRegistered] OF tsODCStepDependency (* step dependency array *);
 tsODCStepInternal : 
   STRUCT 
    iMoveNumber : DINT (* move number (index into sv_MovementsAvailable) *);
    iCount : DINT (* movement count, eg. for movements to intermediate position *);
    iSequentialNumber : DINT (* sequential number of movement for debugging *);
    bStepDone : BOOL (* step is done *);
    bStepActive : BOOL (* step is actually active *);
    StepState : tnODCStepState;
    PosPrevStep : tsODCStepPos (* position of previous step in ODC array *);
    PosNextStep : tsODCStepPos (* position of next step in ODC array *);
    SafetyArray : tyODCDependencyArray (* movement dependencies(checked while movement is active) *);
   END_STRUCT (* step element of internal array *);
 tyODCSequenceInternal : ARRAY  [1..cMaxParallelMovements,1..cMaxODCSteps] OF tsODCStepInternal (* internal odc array for execution and dependency calc *);
 tsODCParallelInfo : 
   STRUCT 
    bDisabled : BOOL (* TRUE: element is disabled (used for step mode) *);
    bStartSent : BOOL (* start condition of this step was reached -> evStart was sent *);
    bColumnActive : BOOL (* the column is currently executing *);
    bStartConditionWarnPrinted : BOOL (* warning that movement was not immediately started (because of pbStartConditionReached) was printed *);
    bSkipAlreadyPosReached : BOOL;
    bActivatedChecked : BOOL (* pbActivated flag was checked already(done at beginning of the step) *);
    bActivated : BOOL (* movement or device is activated *);
    bPosReachedArrayLinked : BOOL (* array with posreached information of programmed instances available *);
    bMovementReadyArrayLinked : BOOL (* array with ready information of programmed instances available *);
    iRow : DINT (* row of this column, where movements are excecuted *);
    dStartTime : DATE_AND_TIME (* time, when start evenet was sent to a movement *);
   END_STRUCT;
 tyODCParallelInfo : ARRAY  [1..cMaxParallelMovements] OF tsODCParallelInfo;
 tsNumberParseElement : 
   STRUCT 
    iColumn : DINT;
    iRow : DINT;
    iRowEnd : DINT;
    bIgnoreStartParallel : BOOL (* ignore the StartParallel for analyzing other branches, but still number it *);
   END_STRUCT;
 tyNumberParseArray : ARRAY  [1..cParseStackSize] OF tsNumberParseElement;
 tnODCRecalcMode : (nODCRecalcNone, nODCRecalcSafety, nODCRecalcInternal, nODCRecalcCylce, nODCRecalcReloadFiles);
 tnODCDependency : (nParallel, nFollowing, nPreceding) (* step dependency for browsing *);
 tyInstanceableMovements : ARRAY  [1..cMaxSRInstanceableMovements] OF DINT;
 tsODCDeviceMovementListElem : 
   STRUCT 
    DeviceId : tsDeviceId;
    sFuName : STRING(31) (* name of this function unit *);
    InstanceableMovements : tyInstanceableMovements (* instanceable movements in this function unit *);
    pbDeviceReady : REFTO BOOL;
    pbDeviceActivated : REFTO BOOL;
    iNumberOfMovements : DINT (* number of movements registered by this function unit *);
    iInstanceableMovements : DINT (* number of instanceable safety relevant movements registered by this function unit *);
    iDefaultMoveNumber : DINT (* number of the default movement of this function unit (this endposition must be reached if no movement of this fu is programmed in the sequence) *);
    AddDeviceInfo : tsAddDeviceInfo (* additional information about this device (needed for graphical editor) *);
    Movements : tyMoveDataArray (* array with registered movements of this function unit *);
   END_STRUCT;
 tyODCDeviceMovementList : ARRAY  [1..cMaxMoveDevicesRegistered] OF tsODCDeviceMovementListElem;
 tsODCDeviceMovementList : 
   STRUCT 
    iCount : DINT;
    Devices : tyODCDeviceMovementList;
   END_STRUCT;
 tsODCSingleMoveInfo : 
   STRUCT 
    iMoveNr : DINT;
    iMoveDir : DINT;
    StepPos : tsODCStepPos;
   END_STRUCT (* singlemovement infos *);
 tyODCSingleMovements : ARRAY  [1..cMaxMoveDevicesRegistered] OF tsODCSingleMoveInfo (* array of singlemovements *);
 tyIntermediateConfirmation : ARRAY  [1..cMaxMoveDevicesRegistered] OF DINT (* 0 nothing done, 1 updated successful, 2 update failed *);
 tyStartRequestData : ARRAY  [1..cMaxParallelMovements] OF tevStartRequestData;
 tsODCSequenceBackup : 
   STRUCT 
    Sequence : KODC_Sequence;
    Date : DATE_AND_TIME;
   END_STRUCT;
 tyODCSequenceBackup : ARRAY  [1..cODCSequenceBackupCount] OF tsODCSequenceBackup;
 tsStartCondInstanceElement : 
   STRUCT 
    DelayedMovement : KODC_Step (* movement which should start after condition is ok *);
    RelatedMovement : KODC_Step (* movement which must reach a start condition *);
    rValue : REAL;
    bStartCondition : BOOL (* use boolean start condition *);
   END_STRUCT;
 tyStartCondInstanceData : ARRAY  [1..cMaxStartConditions] OF tsStartCondInstanceElement (* list with start condition params for all instances *);
 tsCheckCondInstanceElement : 
   STRUCT 
    MoveInEndPos : KODC_Step (* movement that must be in endposition *);
    RelatedMovement : KODC_Step (* related movement *);
    rValue : REAL;
   END_STRUCT;
 tyCheckCondInstanceData : ARRAY  [1..cMaxCheckConditions] OF tsCheckCondInstanceElement (* list with check condition params for all instances *);
 tsLockUnlockData : 
   STRUCT 
    DeviceId : tsDeviceId (* DeviceId to lock *);
    MoveId : tMoveIdent (* MoveId to lock *);
    MoveDir : tMoveIdent (* MoveDir to lock *);
    Alarm : tsAlarm;
   END_STRUCT;
 tsCheckCondHelpData : 
   STRUCT 
    bMovementLocked : BOOL (* TRUE: lock to related movement was sent *);
    MoveDirection : tnMoveDirection (* move direction of related movement *);
    prActValue : REFTO REAL (* refto actual value of realted movement *);
    pbPosReached : REFTO BOOL (* refto posreached flag of the movement which must be in endposition *);
    AlarmMoveInEndPos : tsAlarm (* registered alarm of the movement that should be in endposition  *);
    LockUnlockData : tsLockUnlockData (* used data for lock/unlock the related movement *);
   END_STRUCT (* structure needed for execution of check condition *);
 tyCheckCondHelpData : ARRAY  [1..cMaxCheckConditions] OF tsCheckCondHelpData;
 tyCycleTime : ARRAY  [1..cCycleTimeArraySize] OF TIME;
 tyStartConditionPosArray : ARRAY  [1..cMaxStartConditions] OF tsODCStepPos (* array with information about the position of each start condition in the internal sequence *);
 tnCompareOperator : (nCompOperatorEqual, nCompOperatorNotEqual, nCompOperatorLowerThan, nCompOperatorLowerEqual, nCompOperatorGreaterThan, nCompOperatorGreaterEqual, nCompOperatorModulo);
 tsIFConditionData : 
   STRUCT 
    sName : STRING(4) (* short discription (not translated!) *);
    sTextKey : STRING(32) (* key for getting according text from propertie file *);
    sIconKey : STRING(32) (* key for getting according icon from propertie file *);
    sVariable1 : STRING(64) (* variable name (variable that should be compared) *);
    sVariable2 : STRING(64) (* second variable for comparison *);
    CompareOperator : tnCompareOperator (* operator for variable comparison *);
    rValue : REAL (* real value for comparison *);
    iValue : DINT (* integer value for comparison (for example necessary with condition "every x cycle") *);
   END_STRUCT (* data for a single IF - condition *);
 tyIFConditionData : ARRAY  [1..cMaxIFConditions] OF tsIFConditionData (* array with data for all if conditions *);
 tsVariable : 
   STRUCT 
    bVisible : BOOL;
    sVariable : STRING(64);
    sVarGroup : STRING(32);
   END_STRUCT;
 tsOperator : 
   STRUCT 
    bVisible : BOOL;
    Value : tnCompareOperator;
   END_STRUCT;
 tsODCCondition : 
   STRUCT 
    bSelectable : BOOL (* selector if the condition should be visible (available) *);
    sTextKey : STRING(32) (* key for getting according text from propertie file *);
    sIconKey : STRING(32) (* key for getting according icon from propertie file *);
    Variable1 : tsVariable;
    Variable2 : tsVariable;
    Operator : tsOperator;
    bRealValueVisible : BOOL;
    bDintValueVisible : BOOL;
   END_STRUCT;
 tyAvailableIFConditions : ARRAY  [1..cMaxAvailableIFConditions] OF tsODCCondition;
 tyAvailableLoops : ARRAY  [1..cMaxAvailableLoopConditions] OF tsODCCondition;
 tsLoopData : 
   STRUCT 
    sName : STRING(4) (* short discription (not translated!) *);
    sTextKey : STRING(32) (* key for getting according text from propertie file *);
    sIconKey : STRING(32) (* key for getting according icon from propertie file *);
    sVariable1 : STRING(64) (* variable name (variable that should be compared) *);
    sVariable2 : STRING(64) (* second variable for comparison *);
    CompareOperator : tnCompareOperator (* operator for variable comparison *);
    rValue : REAL (* real value for comparison *);
    iValue : DINT (* integer value for comparison (for example necessary with condition "every x cycle") *);
   END_STRUCT (* data for a single loop *);
 tyLoopData : ARRAY  [1..cMaxLoops] OF tsLoopData (* array with data for all loops *);
 tsLoopHelpData : 
   STRUCT 
    Operator : tnCompareOperator (* compare operator *);
    pbVariable1 : REFTO BOOL (* refto BOOL variable 1 (EMPTY if not used) *);
    pbVariable2 : REFTO BOOL (* refto BOOL variable 2 (EMPTY if not used) *);
    prVariable1 : REFTO REAL (* refto REAL variable 1 (EMPTY if not used) *);
    prVariable2 : REFTO REAL (* refto REAL variable 2 (EMPTY if not used) *);
    bRealVar2Used : BOOL;
    piVariable1 : REFTO DINT (* refto DINT variable 1 (EMPTY if not used) *);
    piVariable2 : REFTO DINT (* refto DINT variable 2 (EMPTY if not used) *);
    bDintVar2Used : BOOL;
    rValue : REAL (* real value for comparison (0.0 if not used) *);
    iValue : DINT (* integer value for comparison (0 if not used) *);
    bLoopCounter : BOOL (* TRUE: use loop counter as condition parameter *);
    iActCount : DINT (* loop counter *);
   END_STRUCT;
 tsIFConditionHelpData : 
   STRUCT 
    Operator : tnCompareOperator (* compare operator *);
    pbVariable1 : REFTO BOOL (* refto BOOL variable 1 (EMPTY if not used) *);
    pbVariable2 : REFTO BOOL (* refto BOOL variable 2 (EMPTY if not used) *);
    prVariable1 : REFTO REAL (* refto REAL variable 1 (EMPTY if not used) *);
    prVariable2 : REFTO REAL (* refto REAL variable 2 (EMPTY if not used) *);
    bRealVar2Used : BOOL;
    piVariable1 : REFTO DINT (* refto DINT variable 1 (EMPTY if not used) *);
    piVariable2 : REFTO DINT (* refto DINT variable 2 (EMPTY if not used) *);
    bDintVar2Used : BOOL;
    rValue : REAL (* real value for comparison (0.0 if not used) *);
    iValue : DINT (* integer value for comparison (0 if not used) *);
    iInternalCount : DINT;
   END_STRUCT;
 tyIFConditionHelpData : ARRAY  [1..cMaxIFConditions] OF tsIFConditionHelpData;
 tyLoopHelpData : ARRAY  [1..cMaxLoops] OF tsLoopHelpData;
 tsODCGroupData : 
   STRUCT 
    sName : STRING(31) (* name of this group (defined by user) *);
    sDescription : STRING(255) (* description for this group *);
    sIcon : STRING(31) (* name of according icon *);
    iDisplayLevel : DINT (* display level *);
    iInputLevel : DINT (* input level *);
   END_STRUCT;
 tyODCGroupData : ARRAY  [1..cMaxODCGroups] OF tsODCGroupData;
 tsActiveSequence : 
   STRUCT 
    iCount : DINT (* will be increased if a combined sequence is started *);
    DeviceId : tsDeviceId (* DeviceId of active sequence (not resetted after end of sequence!!) *);
    MoveDir : tMoveIdent (* MoveDir of active sequence (not resetted after end of sequence!!) *);
    bActive : BOOL (* information if sequence is actually active *);
   END_STRUCT;
 tsSingleGroupActive : 
   STRUCT 
    bActive : BOOL;
    dStartTime : DATE_AND_TIME;
   END_STRUCT;
 tyGroupActive : ARRAY  [1..cMaxIntermediateConditions] OF tsSingleGroupActive;
 tsGroupActiveData : 
   STRUCT 
    iActiveGroups : DINT;
    Group : tyGroupActive;
   END_STRUCT;
 tyDeviceRegistered : ARRAY  [1..cMaxMoveDevicesRegistered] OF BOOL;
 tsMoveInfo : 
   STRUCT 
    iMoveNr : DINT;
    iCount : DINT;
   END_STRUCT;
 tyProgrammedMovement : ARRAY  [1..cMaxMoveDevicesRegistered] OF tsMoveInfo;
 tsHelpData : 
   STRUCT 
    bParallelOpen : BOOL (* TRUE: ParallelOpen column *);
    iStartParallelOpenLine : DINT (* line number of start paralle open step in this column *);
    Dependency : tyODCDependencyArray;
    OptionalDevices : tyDeviceRegistered;
   END_STRUCT;
 tyHelpData : ARRAY  [1..cMaxParallelMovements] OF tsHelpData;
 tyParallelOpenHelpData : ARRAY  [1..cMaxParallelMovements] OF tsHelpData;
 tyStartParallelDependencys : ARRAY  [1..cMaxStartParallel] OF tyODCDependencyArray;
 tyStartParallelOpenDependencys : ARRAY  [1..cMaxParallelMovements] OF tyODCDependencyArray;
 tsStepBwdMovements : 
   STRUCT 
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    MoveDir : tMoveIdent;
   END_STRUCT;
 tyStepBwdMovements : ARRAY  [1..cMaxParallelMovements] OF tsStepBwdMovements;
 tsSequenceDimension : 
   STRUCT 
    iMaxColumns : DINT;
    iMaxRows : DINT;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
17 
@Constant @RT(22)cODCDependencyDontCare @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)-1 @RT(76)dependency dont care, function unit not safety relevant, interpretation TRUE 
@END_Attrib 


@Constant @RT(16)cODCNoDependency @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(61)no dependency, used for dependency calc, interpretation FALSE 
@END_Attrib 


@Constant @RT(15)cParseStackSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(41)must be bigger than cMaxParallelMovements 
@END_Attrib 


@Constant @RT(23)cODCSequenceBackupCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(33)number of backup sequence we keep 
@END_Attrib 


@Constant @RT(17)cTimeOutSempahore @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)t#30s @RT(0) 
@END_Attrib 


@Constant @RT(19)cMaxStartConditions @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(51)max number of start condition steps in the sequence 
@END_Attrib 


@Constant @RT(19)cMaxCheckConditions @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(51)max number of check condition steps in the sequence 
@END_Attrib 


@Constant @RT(19)cCycleTimeArraySize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(48)size of array that contains the last cycle times 
@END_Attrib 


@Constant @RT(16)cMaxIFConditions @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(30)max. number of IF - conditions 
@END_Attrib 


@Constant @RT(25)cMaxAvailableIFConditions @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)30 @RT(40)max. number of available IF - conditions 
@END_Attrib 


@Constant @RT(9)cMaxLoops @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(20)max. number of loops 
@END_Attrib 


@Constant @RT(27)cMaxAvailableLoopConditions @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(40)max. number of available loop conditions 
@END_Attrib 


@Constant @RT(13)cMaxODCGroups @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(21)max. number of groups 
@END_Attrib 


@Constant @RT(9)cFirstBit @RT(0) @T @F @DT @RT(5)LWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(19)16#8000000000000000 @RT(0) 
@END_Attrib 


@Constant @RT(13)cNoDependency @RT(0) @T @F @DT @RT(5)LWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)16#0 @RT(0) 
@END_Attrib 


@Constant @RT(17)cMaxStartParallel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)50 @RT(35)max. number of start parallel steps 
@END_Attrib 


@Constant @RT(27)cMaxSRInstanceableMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(86)max. numer of safety relevant instanceable movements per FU (must not be increased!!!) 
@END_Attrib 


@RT(17)TypeTreeContainer 
66 
@DT @RT(28)tsStartedMoveInfoODCExtended @RT(0) @T @T @STRUCT 0 5 

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

@StructElem @RT(7)StepPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsODCStepPos @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)Position in autocycle for cyclic safety check @RT(0) 
@END_Attrib 

@StructElem @RT(9)iInstance @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(28)tyStartedMoveDataODCExtended @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(28)tsStartedMoveInfoODCExtended @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxActiveMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(28)tsStartedMoveDataODCExtended @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(17)iStartedMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)number of started movements @RT(0) 
@END_Attrib 

@StructElem @RT(8)MoveData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(28)tyStartedMoveDataODCExtended @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(12)tsODCStepPos @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)iColumn @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)iRow @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)step position in sequence @RT(0) 
@END_Attrib 


@DT @RT(13)tsODCStepInfo @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)iMoveNr @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)depends on a movement @RT(0) 
@END_Attrib 

@StructElem @RT(10)iMoveCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)intermediate position for movement in iMoveNr @RT(0) 
@END_Attrib 

@StructElem @RT(8)iFuIndex @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)index of fu in sv_ODCDeviceMovements array @RT(0) 
@END_Attrib 

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)MoveId of this step @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(9)step info @RT(0) 
@END_Attrib 


@DT @RT(17)tsODCStepInternal @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(11)iMoveNumber @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)move number (index into sv_MovementsAvailable) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)movement count, eg. for movements to intermediate position @RT(0) 
@END_Attrib 

@StructElem @RT(17)iSequentialNumber @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)sequential number of movement for debugging @RT(0) 
@END_Attrib 

@StructElem @RT(9)bStepDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)step is done @RT(0) 
@END_Attrib 

@StructElem @RT(11)bStepActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)step is actually active @RT(0) 
@END_Attrib 

@StructElem @RT(9)StepState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnODCStepState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)PosPrevStep @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsODCStepPos @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)position of previous step in ODC array @RT(0) 
@END_Attrib 

@StructElem @RT(11)PosNextStep @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsODCStepPos @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)position of next step in ODC array @RT(0) 
@END_Attrib 

@StructElem @RT(11)SafetyArray @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyODCDependencyArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)movement dependencies(checked while movement is active) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)step element of internal array @RT(0) 
@END_Attrib 


@DT @RT(21)tyODCSequenceInternal @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsODCStepInternal @RT(0) @T @T @UNKNOWN 0 @F 
@F 2 @RT(1)1 @RT(21)cMaxParallelMovements @RT(1)1 @RT(12)cMaxODCSteps 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)internal odc array for execution and dependency calc @RT(0) 
@END_Attrib 


@DT @RT(17)tyODCParallelInfo @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsODCParallelInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(21)cMaxParallelMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsODCParallelInfo @RT(0) @T @T @STRUCT 0 11 

@StructElem @RT(9)bDisabled @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)TRUE: element is disabled (used for step mode) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bStartSent @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(60)start condition of this step was reached -> evStart was sent @RT(0) 
@END_Attrib 

@StructElem @RT(13)bColumnActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)the column is currently executing @RT(0) 
@END_Attrib 

@StructElem @RT(26)bStartConditionWarnPrinted @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(98)warning that movement was not immediately started (because of pbStartConditionReached) was printed @RT(0) 
@END_Attrib 

@StructElem @RT(22)bSkipAlreadyPosReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)bActivatedChecked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(67)pbActivated flag was checked already(done at beginning of the step) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bActivated @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(31)movement or device is activated @RT(0) 
@END_Attrib 

@StructElem @RT(22)bPosReachedArrayLinked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(67)array with posreached information of programmed instances available @RT(0) 
@END_Attrib 

@StructElem @RT(25)bMovementReadyArrayLinked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(62)array with ready information of programmed instances available @RT(0) 
@END_Attrib 

@StructElem @RT(4)iRow @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)row of this column, where movements are excecuted @RT(0) 
@END_Attrib 

@StructElem @RT(10)dStartTime @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)time, when start evenet was sent to a movement @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tsNumberParseElement @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)iColumn @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)iRow @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iRowEnd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)bIgnoreStartParallel @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(74)ignore the StartParallel for analyzing other branches, but still number it @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyNumberParseArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(20)tsNumberParseElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cParseStackSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsODCStepDependency @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(10)Dependency @RT(0) @T @F @DT @RT(5)LWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)step dependency condition @RT(0) 
@END_Attrib 


@DT @RT(20)tyODCDependencyArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsODCStepDependency @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)step dependency array @RT(0) 
@END_Attrib 


@DT @RT(15)tnODCRecalcMode @RT(0) @T @T @ENUM 0 5 
@EnumConst @RT(14)nODCRecalcNone @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)do nothing @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nODCRecalcSafety @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)only recalc dependency array @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nODCRecalcInternal @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(81)new sequence from graphical editor -> recalc internal array and safety conditions @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nODCRecalcCylce @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)create a new sequence array after changed program switches @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nODCRecalcReloadFiles @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)reload the sequence description files @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tnODCDependency @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(9)nParallel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)parallel according to reference, || @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nFollowing @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)following according to reference, -> @RT(0) 
@END_Attrib 
@EnumConst @RT(10)nPreceding @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)preceding according to reference, <- @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)step dependency for browsing @RT(0) 
@END_Attrib 


@DT @RT(27)tsODCDeviceMovementListElem @RT(0) @T @T @STRUCT 0 10 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)sFuName @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)name of this function unit @RT(0) 
@END_Attrib 

@StructElem @RT(21)InstanceableMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tyInstanceableMovements @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)instanceable movements in this function unit @RT(0) 
@END_Attrib 

@StructElem @RT(13)pbDeviceReady @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)pbDeviceActivated @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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

@StructElem @RT(22)iInstanceableMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(81)number of instanceable safety relevant movements registered by this function unit @RT(0) 
@END_Attrib 

@StructElem @RT(18)iDefaultMoveNumber @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(143)number of the default movement of this function unit (this endposition must be reached if no movement of this fu is programmed in the sequence) @RT(0) 
@END_Attrib 

@StructElem @RT(13)AddDeviceInfo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsAddDeviceInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(70)additional information about this device (needed for graphical editor) @RT(0) 
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


@DT @RT(23)tyODCDeviceMovementList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(27)tsODCDeviceMovementListElem @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tsODCDeviceMovementList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)Devices @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tyODCDeviceMovementList @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(19)tsODCSingleMoveInfo @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(7)iMoveNr @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iMoveDir @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)StepPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsODCStepPos @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)singlemovement infos @RT(0) 
@END_Attrib 


@DT @RT(20)tyODCSingleMovements @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsODCSingleMoveInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)array of singlemovements @RT(0) 
@END_Attrib 


@DT @RT(26)tyIntermediateConfirmation @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)0 nothing done, 1 updated successful, 2 update failed @RT(0) 
@END_Attrib 


@DT @RT(18)tyStartRequestData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tevStartRequestData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(21)cMaxParallelMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsODCSequenceBackup @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)Sequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)KODC_Sequence @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Date @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(19)tyODCSequenceBackup @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsODCSequenceBackup @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(23)cODCSequenceBackupCount 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tnODCStepState @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(13)nStateDefault @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nStateActive @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nStateReady @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nStateError @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tsStartCondInstanceElement @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(15)DelayedMovement @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)KODC_Step @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)movement which should start after condition is ok @RT(0) 
@END_Attrib 

@StructElem @RT(15)RelatedMovement @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)KODC_Step @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)movement which must reach a start condition @RT(0) 
@END_Attrib 

@StructElem @RT(6)rValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)bStartCondition @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)use boolean start condition @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(23)tyStartCondInstanceData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(26)tsStartCondInstanceElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxStartConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)list with start condition params for all instances @RT(0) 
@END_Attrib 


@DT @RT(26)tsCheckCondInstanceElement @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(12)MoveInEndPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)KODC_Step @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)movement that must be in endposition @RT(0) 
@END_Attrib 

@StructElem @RT(15)RelatedMovement @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)KODC_Step @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)related movement @RT(0) 
@END_Attrib 

@StructElem @RT(6)rValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(23)tyCheckCondInstanceData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(26)tsCheckCondInstanceElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxCheckConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)list with check condition params for all instances @RT(0) 
@END_Attrib 


@DT @RT(19)tsCheckCondHelpData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(15)bMovementLocked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)TRUE: lock to related movement was sent @RT(0) 
@END_Attrib 

@StructElem @RT(13)MoveDirection @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnMoveDirection @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)move direction of related movement @RT(0) 
@END_Attrib 

@StructElem @RT(10)prActValue @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)refto actual value of realted movement @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbPosReached @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(66)refto posreached flag of the movement which must be in endposition @RT(0) 
@END_Attrib 

@StructElem @RT(17)AlarmMoveInEndPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsAlarm @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(63)registered alarm of the movement that should be in endposition  @RT(0) 
@END_Attrib 

@StructElem @RT(14)LockUnlockData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsLockUnlockData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)used data for lock/unlock the related movement @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)structure needed for execution of check condition @RT(0) 
@END_Attrib 


@DT @RT(19)tyCheckCondHelpData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsCheckCondHelpData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxCheckConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsLockUnlockData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)DeviceId to lock @RT(0) 
@END_Attrib 

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)MoveId to lock @RT(0) 
@END_Attrib 

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)MoveDir to lock @RT(0) 
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


@DT @RT(11)tyCycleTime @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(19)cCycleTimeArraySize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tyStartConditionPosArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(12)tsODCStepPos @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxStartConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(90)array with information about the position of each start condition in the internal sequence @RT(0) 
@END_Attrib 


@DT @RT(17)tnCompareOperator @RT(0) @T @T @ENUM 0 7 
@EnumConst @RT(18)nCompOperatorEqual @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)equal @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nCompOperatorNotEqual @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(9)not equal @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nCompOperatorLowerThan @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)lower than @RT(0) 
@END_Attrib 
@EnumConst @RT(23)nCompOperatorLowerEqual @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)lower or equal @RT(0) 
@END_Attrib 
@EnumConst @RT(24)nCompOperatorGreaterThan @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(7)greater @RT(0) 
@END_Attrib 
@EnumConst @RT(25)nCompOperatorGreaterEqual @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)greater or equal @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nCompOperatorModulo @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(6)modulo @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsIFConditionData @RT(0) @T @T @STRUCT 0 8 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(9)STRING(4) @RT(0) @T @T @STRING 0 @F @RT(1)4 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)short discription (not translated!) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sTextKey @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)key for getting according text from propertie file @RT(0) 
@END_Attrib 

@StructElem @RT(8)sIconKey @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)key for getting according icon from propertie file @RT(0) 
@END_Attrib 

@StructElem @RT(10)sVariable1 @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)variable name (variable that should be compared) @RT(0) 
@END_Attrib 

@StructElem @RT(10)sVariable2 @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)second variable for comparison @RT(0) 
@END_Attrib 

@StructElem @RT(15)CompareOperator @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnCompareOperator @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)operator for variable comparison @RT(0) 
@END_Attrib 

@StructElem @RT(6)rValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)real value for comparison @RT(0) 
@END_Attrib 

@StructElem @RT(6)iValue @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(83)integer value for comparison (for example necessary with condition "every x cycle") @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)data for a single IF - condition @RT(0) 
@END_Attrib 


@DT @RT(17)tyIFConditionData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsIFConditionData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxIFConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)array with data for all if conditions @RT(0) 
@END_Attrib 


@DT @RT(10)tsVariable @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)bVisible @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sVariable @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sVarGroup @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
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


@DT @RT(10)tsOperator @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)bVisible @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Value @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnCompareOperator @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(14)tsODCCondition @RT(0) @T @T @STRUCT 0 8 

@StructElem @RT(11)bSelectable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)selector if the condition should be visible (available) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sTextKey @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)key for getting according text from propertie file @RT(0) 
@END_Attrib 

@StructElem @RT(8)sIconKey @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)key for getting according icon from propertie file @RT(0) 
@END_Attrib 

@StructElem @RT(9)Variable1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsVariable @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)Variable2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsVariable @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)Operator @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsOperator @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)bRealValueVisible @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)bDintValueVisible @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(23)tyAvailableIFConditions @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsODCCondition @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxAvailableIFConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyAvailableLoops @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsODCCondition @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(27)cMaxAvailableLoopConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsLoopData @RT(0) @T @T @STRUCT 0 8 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(9)STRING(4) @RT(0) @T @T @STRING 0 @F @RT(1)4 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)short discription (not translated!) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sTextKey @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)key for getting according text from propertie file @RT(0) 
@END_Attrib 

@StructElem @RT(8)sIconKey @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)key for getting according icon from propertie file @RT(0) 
@END_Attrib 

@StructElem @RT(10)sVariable1 @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)variable name (variable that should be compared) @RT(0) 
@END_Attrib 

@StructElem @RT(10)sVariable2 @RT(0) @T @F @DT @RT(10)STRING(64) @RT(0) @T @T @STRING 0 @F @RT(2)64 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)second variable for comparison @RT(0) 
@END_Attrib 

@StructElem @RT(15)CompareOperator @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnCompareOperator @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)operator for variable comparison @RT(0) 
@END_Attrib 

@StructElem @RT(6)rValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)real value for comparison @RT(0) 
@END_Attrib 

@StructElem @RT(6)iValue @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(83)integer value for comparison (for example necessary with condition "every x cycle") @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)data for a single loop @RT(0) 
@END_Attrib 


@DT @RT(10)tyLoopData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsLoopData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxLoops 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)array with data for all loops @RT(0) 
@END_Attrib 


@DT @RT(14)tsLoopHelpData @RT(0) @T @T @STRUCT 0 13 

@StructElem @RT(8)Operator @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnCompareOperator @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)compare operator @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbVariable1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto BOOL variable 1 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbVariable2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto BOOL variable 2 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prVariable1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto REAL variable 1 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prVariable2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto REAL variable 2 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bRealVar2Used @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)piVariable1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto DINT variable 1 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)piVariable2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto DINT variable 2 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bDintVar2Used @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)rValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)real value for comparison (0.0 if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iValue @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)integer value for comparison (0 if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(12)bLoopCounter @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)TRUE: use loop counter as condition parameter @RT(0) 
@END_Attrib 

@StructElem @RT(9)iActCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)loop counter @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tyIFConditionHelpData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(21)tsIFConditionHelpData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxIFConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyLoopHelpData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsLoopHelpData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxLoops 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsIFConditionHelpData @RT(0) @T @T @STRUCT 0 12 

@StructElem @RT(8)Operator @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnCompareOperator @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)compare operator @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbVariable1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto BOOL variable 1 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbVariable2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto BOOL variable 2 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prVariable1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto REAL variable 1 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prVariable2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto REAL variable 2 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bRealVar2Used @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)piVariable1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto DINT variable 1 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(11)piVariable2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)refto DINT variable 2 (EMPTY if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bDintVar2Used @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)rValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)real value for comparison (0.0 if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iValue @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)integer value for comparison (0 if not used) @RT(0) 
@END_Attrib 

@StructElem @RT(14)iInternalCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tsODCGroupData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)name of this group (defined by user) @RT(0) 
@END_Attrib 

@StructElem @RT(12)sDescription @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)description for this group @RT(0) 
@END_Attrib 

@StructElem @RT(5)sIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)name of according icon @RT(0) 
@END_Attrib 

@StructElem @RT(13)iDisplayLevel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)display level @RT(0) 
@END_Attrib 

@StructElem @RT(11)iInputLevel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)input level @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyODCGroupData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsODCGroupData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(13)cMaxODCGroups 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsActiveSequence @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(51)will be increased if a combined sequence is started @RT(0) 
@END_Attrib 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(66)DeviceId of active sequence (not resetted after end of sequence!!) @RT(0) 
@END_Attrib 

@StructElem @RT(7)MoveDir @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(65)MoveDir of active sequence (not resetted after end of sequence!!) @RT(0) 
@END_Attrib 

@StructElem @RT(7)bActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)information if sequence is actually active @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsSingleGroupActive @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)bActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)dStartTime @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)tyGroupActive @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsSingleGroupActive @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsGroupActiveData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)iActiveGroups @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Group @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyGroupActive @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(23)tyInstanceableMovements @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(27)cMaxSRInstanceableMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyDeviceRegistered @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tyProgrammedMovement @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(25)cMaxMoveDevicesRegistered 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsMoveInfo @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)iMoveNr @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(10)tsHelpData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(13)bParallelOpen @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)TRUE: ParallelOpen column @RT(0) 
@END_Attrib 

@StructElem @RT(22)iStartParallelOpenLine @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)line number of start paralle open step in this column @RT(0) 
@END_Attrib 

@StructElem @RT(10)Dependency @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyODCDependencyArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)OptionalDevices @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tyDeviceRegistered @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(10)tyHelpData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(10)tsHelpData 1 @RT(1)1 @RT(21)cMaxParallelMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tyParallelOpenHelpData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(10)tsHelpData 1 @RT(1)1 @RT(21)cMaxParallelMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tyStartParallelDependencys @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(20)tyODCDependencyArray @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(17)cMaxStartParallel 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(30)tyStartParallelOpenDependencys @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(20)tyODCDependencyArray 1 @RT(1)1 @RT(21)cMaxParallelMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tsStepBwdMovements @RT(0) @T @T @STRUCT 0 3 

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
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyStepBwdMovements @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(18)tsStepBwdMovements @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(21)cMaxParallelMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsSequenceDimension @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(11)iMaxColumns @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iMaxRows @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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
@@@BEG_Password@@@
NGhzZm9kYzQ=
@@@END_Password@@@
