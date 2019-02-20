%IMPORT_OVER_LISTFILE_SOURCE
 fmtODCStepActive
, fmtODCStepDone
, VG_MachineData
, VG_MoldData
, Percent
, fmt31
, VG_SequenceData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KODC_Movements
, tyODCSequenceInternal
, tsStartedMoveDataODCExtended
, tsODCDeviceMovementList
, tyODCSequenceBackup
, tyODCParallelInfo
, tsActiveSequence
, tsSequenceDimension
, cMaxParallelMovements
, cMaxODCSteps
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_ODCMovements : KODC_Movements (* list with registered movements in the necessary format for the ODC Builder *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_ODCSequenceInt : tyODCSequenceInternal (* additional information for ODC sequence *)
    
%ELEMENT sv_ODCSequenceInt[0,0].bStepActive
     %FORMAT fmtODCStepActive 
%ELEMENT sv_ODCSequenceInt[0,0].bStepDone
     %FORMAT fmtODCStepDone ;
 sv_StartedManualMovements : tsStartedMoveDataODCExtended (* list of movements started by ODC when in manual mode *)
    ;
 sv_bCombinedMovementsInManual : BOOL := TRUE (* start combined movements on evStartRequest(manual buttons) *)
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_ODCDeviceMovements : tsODCDeviceMovementList (* list of all devices that registered movements for the ODC *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_ODCSequenceGenerateTime : DATE_AND_TIME (* date when the odc sequence array was last changed/generated *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
;
 sv_ODCSequenceBackup : tyODCSequenceBackup (* history of ODC sequences *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iODCSequenceAct : DINT := 1 (* actual entry in ODC sequence history *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
;
 sv_iSequenceToRestore : DINT (* which ODC sequence to restore from backup *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_ODCDescriptionPath : STRING(255) := '/workspace/data/sequence/std' (* path of folder containing the odc description files *)
    ;
 sv_InterpreterParallelInfo : tyODCParallelInfo (* internal state information of the interpreter, useful for HMI *)
    ;
 sv_iODCSequenceUpdated : DINT (* counted up when sequence array is updated *)
    ;
 sv_iUsedColumns : DINT (* number of used columns in current ODC array *)
    ;
 sv_iUsedRows : DINT (* number of used rows in current ODC array *)
    ;
 sv_iInitOK : DINT (* 0 nothing initialized, 10 sequence array initialized, 20 sequence array + safety initialized *)
    ;
 sv_iActiveEditors : DINT (* number of actual active ODC Editors (written by HMI) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Active editors Active ODC editors
;
 sv_bSEDataLoaded : BOOL (* flag to indicate that MoldData.xml contains SafetyProgram *)
   RETAIN  %VARIABLE_GROUP VG_MoldData ;
 sv_rMoveDurationTolerance : REAL := 3.0 (* duration tolerance in percent for an ODC movement *)
 %PLAUSIBILITY 0.0..100.0    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Percent 
// Movement Tolerance Move Duration Tolerance
;
 sv_ActiveSequence : tsActiveSequence
    ;
 sv_iLoopPropertiesChanged : DINT (* !! only written by HMI !! (will be increased if a loop propertie has changed) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Loop properties changed Loop properties changed
;
 sv_iGroupPropertiesChanged : DINT (* !! only written by HMI !! (will be increased if a group propertie has changed) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Group properties changed Group properties changed
;
 sv_iConditionPropertiesChanged : DINT (* !! only written by HMI !! (will be increased if a condition propertie has changed) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Condition properties changed Condition properties changed
;
 sv_SequenceDimension : tsSequenceDimension := (iMaxColumns:=cMaxParallelMovements,iMaxRows:=cMaxODCSteps) (* contains the maximum size of the sequence array *)
     %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
%END

%SYSTEM_ALARM
  erMaxODCMovesExceeded
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmMotorLock 
// Too much ODC movements registered. (max: %1n){#]Too many odc movements registered.{#]The odc handles a maximum number of movements. This number must not be \u000aexceeded by the movements trying to register. In case it is exceeded this alarm \u000ais raised. An update of the application software is necessary.{#]Please contact the machine manufacturer.
 ;
  erODCComponentLocked
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n locked by %3t%4n{#]A component is locked by another \u000acomponent/device.{#]A desired movement or action cannot be performed because it is locked by \u000aanother component. In order to allow the desired operation the locking \u000acomponent needs to change its state first.{#]Try to change the state of the locking component in order to allow \u000athe desired operation.
 ;
  erODCInitFailed
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual 
// Creation of machine sequence failed, undo last change and send status report to manufacturer{#]The creation of the machine sequence \u000ais not possible.{#]For every user change of the machine cycle sequence the control application \u000asoftware will calculate a new machine sequence. If this sequence cannot be \u000acalculated this alarm is raised. In addition further alarms will be raised explaining \u000athe details of the problem(s) during calculation of the new sequence.{#]Revert the most recent changes of the machine sequence to \u000aallow calculation of a valid sequence.<br>\u000aCheck corresponding alarms with details about the problems \u000acalculating the new sequence and follow solution instructions.
 ;
  erTeachModeActive
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Teachmode active{#]Sequence teachmode is active.{#]When sequence teachmode is active, no movements can be started. Also \u000athe operation mode cannot be switched to semi- or full-automatic mode.{#]Close teachmode for machine sequence in order to enable further\u000a operation of movements as well as switching to semi- and full-\u000aautomatic mode.
 ;
  erSafetyEditorNotAvailable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmMotorRelease 
// No Safety Editor available. Safety settings won't be transfered{#]The safety editor settings are not considered because no safety editor is available.{#]The loaded mold data contains data for safety editor but the safety editor is not available on this machine.{#]Check the loaded mold data and the machine sequence. If everything is ok, the alarm can be confirmed.
 ;
  erMovementDuringActiveSequence
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%1s %2t during %3t %4t sequence not allowed{#]A movement cannot be started because a \u000asequence is active.{#]When a sequence, such as for example mold close, is active, no additional \u000amovement can be started.{#]Wait for the sequence to finish before retrying the desired operation.
 ;
  erSequenceDuringActiveMovement
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n %3t sequence during active movement not allowed{#]A sequence cannot be started because a \u000amovement is active.{#]When a movement is active, no sequence (for example mold close sequence) \u000acan be started.{#]Wait for the movement to finish before retrying to start the desired \u000asequence.
 ;
  erMachineSequenceNotCreated
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Machine sequence not created{#]No valid machine sequence is created or \u000acreation of a new sequence is still active.{#]For every user change in the machine cycle sequence the control application \u000asoftware will calculate a new machine sequence. While this calculation is \u000aactive all movements are locked with this alarm. Once the calculation finished successfully the movements are unlocked with this alarm again. \u000a<br>\u000aIn case the sequence couldn't be calculated properly the movements will keep locked with this alarm. \u000aAdditionally detailed information about the problem will be \u000arepresented by other alarms.{#]In case the calculation of a new sequence is still active, this is just a message, no action required!<br><br>\u000aIf the calculation of a new sequence was not successful the \u000adetailed reason and solution will be represented by other alarms. \u000aPlease check these alarms and the according suggested solutions.
 ;
  erInstanceableMovements
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmMotorLock 
// Device %1t%2n: more than %3n safetyrelevant instanceable movements registered.{#]Too many safetyrelevant instanceable movements try to register for one device.{#]For each device only two safetyrelevant instanceable movements are allowed to register. \u000aIf more than two such movements try to register per device this alarm is \u000araised and the motor is locked permanently. \u000aapplication software.{#]Please contact the machine manufacturer.
 ;
  erReadyAndNotPosReached
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Movement %1t%2n %3t finished but not in endposition{#]A movement finished without reaching its \u000atarget endposition during full automatic cycle.{#]During operation in full automatic mode a movement didn't finish properly because \u000ait didn't reach its target endposition.{#]Check the according movements output settings and other options \u000ain order to allow a successful movement up to its target endposition.<br>\u000aCheck in manual operation mode if the movement can reach its \u000atarget endposition.
 ;
  erNoInverseMovement
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// No inverse movement for %1t%2n %3t defined. Stepping backward not possible!{#]Stepping backward is not possible because there is no inverse movement defined.{#]Stepping backward in the interrupted machine sequence stops at this step and can not be continued.{#]Confirm the alarm and continue autocycle.
 ;
  erNoStepBwdIntoCondition
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Stepping backward into a condition element is not possible{#]It is not possible to step backward into a condition element.{#]Stepping backward in the interrupted machine sequence stops at this step because a condition element is reached.{#]Confirm the alarm and continue autocycle.
 ;
  erNoStepBwdIntoLoop
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Stepping backward into a loop is not possible{#]It is not possible to step backward into a loop.{#]Stepping backward in the interrupted machine sequence stops at this step because a loop is reached.{#]Confirm the alarm and continue autocycle.
 ;
  erNoStepBwdOutOfLoop
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Stepping backward out of a loop is not possible{#]It is not possible to step backward out of a loop.{#]Stepping backward in the interrupted machine sequence stops at this step because stepping out of a loop is not allowed.{#]Confirm the alarm and continue autocycle.
 ;
  erTooManyStartParallel
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// Too many parallel trees in machine sequence. Calculation of mold safety conditions not possible{#]Too many parallel trees in machine \u000asequence.{#]The control application can only handle a limited amount of parallel trees in \u000athe machine sequence.{#]Adapt the machine sequence to use less parallel trees.<br>\u000aIf this is not possible please contact the machine manufacturer.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
23 
@SysVar @RT(15)sv_ODCMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KODC_Movements @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)list with registered movements in the necessary format for the ODC Builder 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ODCMovements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)list with registered movements in the necessary format for the ODC Builder 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_ODCSequenceInt @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tyODCSequenceInternal @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)additional information for ODC sequence 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(34)sv_ODCSequenceInt[0,0].bStepActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)step is actually active 
@RT(0) @RT(0) @RT(0) @RT(16)fmtODCStepActive @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ODCSequenceInt[0,0].bStepDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)step is done 
@RT(0) @RT(0) @RT(0) @RT(14)fmtODCStepDone @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_StartedManualMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(28)tsStartedMoveDataODCExtended @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)list of movements started by ODC when in manual mode 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_StartedManualMovements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)list of movements where a start event was sent 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_bCombinedMovementsInManual @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(58)start combined movements on evStartRequest(manual buttons) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_bCombinedMovementsInManual @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_ODCDeviceMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tsODCDeviceMovementList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)list of all devices that registered movements for the ODC 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_ODCDeviceMovements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_ODCSequenceGenerateTime @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)date when the odc sequence array was last changed/generated 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_ODCSequenceGenerateTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_ODCSequenceBackup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyODCSequenceBackup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)history of ODC sequences 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_ODCSequenceBackup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iODCSequenceAct @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(36)actual entry in ODC sequence history 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iODCSequenceAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_iSequenceToRestore @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)which ODC sequence to restore from backup 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_iSequenceToRestore @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_ODCDescriptionPath @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(30)'/workspace/data/sequence/std' @RT(51)path of folder containing the odc description files 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(26)sv_InterpreterParallelInfo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyODCParallelInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(61)internal state information of the interpreter, useful for HMI 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(22)sv_iODCSequenceUpdated @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)counted up when sequence array is updated 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(15)sv_iUsedColumns @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)number of used columns in current ODC array 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(12)sv_iUsedRows @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(40)number of used rows in current ODC array 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(10)sv_iInitOK @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(92)0 nothing initialized, 10 sequence array initialized, 20 sequence array + safety initialized 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_iActiveEditors @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)number of actual active ODC Editors (written by HMI) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Active editors @RT(18)Active ODC editors @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_iActiveEditors @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)number of actual active ODC Editors 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Active editors @RT(18)Active ODC editors @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bSEDataLoaded @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)flag to indicate that MoldData.xml contains SafetyProgram 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bSEDataLoaded @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)flag to indicate that MoldData.xml contains SafetyProgram 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rMoveDurationTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)3.0 @RT(49)duration tolerance in percent for an ODC movement 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Movement Tolerance @RT(23)Move Duration Tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMoveDurationTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)flag to indicate that MoldData.xml contains SafetyProgram 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Movement Tolerance @RT(23)Move Duration Tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_ActiveSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsActiveSequence @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(25)sv_iLoopPropertiesChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(77)!! only written by HMI !! (will be increased if a loop propertie has changed) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Loop properties changed @RT(23)Loop properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_iLoopPropertiesChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)properties that are relevant for ODC editor changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Loop properties changed @RT(23)Loop properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_iGroupPropertiesChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(78)!! only written by HMI !! (will be increased if a group propertie has changed) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Group properties changed @RT(24)Group properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_iGroupPropertiesChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)properties that are relevant for ODC editor changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Group properties changed @RT(24)Group properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_iConditionPropertiesChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(82)!! only written by HMI !! (will be increased if a condition propertie has changed) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Condition properties changed @RT(28)Condition properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_iConditionPropertiesChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)properties that are relevant for ODC editor changed 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Condition properties changed @RT(28)Condition properties changed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_SequenceDimension @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsSequenceDimension @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(59)(iMaxColumns:=cMaxParallelMovements,iMaxRows:=cMaxODCSteps) @RT(47)contains the maximum size of the sequence array 
@RT(1)1 @RT(15)cLevelSuperUser @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_SequenceDimension @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
15 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erMaxODCMovesExceeded @RT(1)1 @RT(1)y @RT(23)system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(353)Too much ODC movements registered. (max: %1n){#]Too many odc movements registered.{#]The odc handles a maximum number of movements. This number must not be \u000aexceeded by the movements trying to register. In case it is exceeded this alarm \u000ais raised. An update of the application software is necessary.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erODCComponentLocked @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(381)%1t%2n locked by %3t%4n{#]A component is locked by another \u000acomponent/device.{#]A desired movement or action cannot be performed because it is locked by \u000aanother component. In order to allow the desired operation the locking \u000acomponent needs to change its state first.{#]Try to change the state of the locking component in order to allow \u000athe desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erODCInitFailed @RT(1)1 @RT(1)y @RT(24)system.evAlarmAutoManual @RT(0) @RT(11)Application @RT(723)Creation of machine sequence failed, undo last change and send status report to manufacturer{#]The creation of the machine sequence \u000ais not possible.{#]For every user change of the machine cycle sequence the control application \u000asoftware will calculate a new machine sequence. If this sequence cannot be \u000acalculated this alarm is raised. In addition further alarms will be raised explaining \u000athe details of the problem(s) during calculation of the new sequence.{#]Revert the most recent changes of the machine sequence to \u000aallow calculation of a valid sequence.<br>\u000aCheck corresponding alarms with details about the problems \u000acalculating the new sequence and follow solution instructions. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erTeachModeActive @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(352)Teachmode active{#]Sequence teachmode is active.{#]When sequence teachmode is active, no movements can be started. Also \u000athe operation mode cannot be switched to semi- or full-automatic mode.{#]Close teachmode for machine sequence in order to enable further\u000a operation of movements as well as switching to semi- and full-\u000aautomatic mode. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erSafetyEditorNotAvailable @RT(1)3 @RT(1)y @RT(23)system.evAlarmMotorLock @RT(26)system.evAlarmMotorRelease @RT(4)User @RT(365)No Safety Editor available. Safety settings won't be transfered{#]The safety editor settings are not considered because no safety editor is available.{#]The loaded mold data contains data for safety editor but the safety editor is not available on this machine.{#]Check the loaded mold data and the machine sequence. If everything is ok, the alarm can be confirmed. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erMovementDuringActiveSequence @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(293)%1t%1s %2t during %3t %4t sequence not allowed{#]A movement cannot be started because a \u000asequence is active.{#]When a sequence, such as for example mold close, is active, no additional \u000amovement can be started.{#]Wait for the sequence to finish before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erSequenceDuringActiveMovement @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(305)%1t%2n %3t sequence during active movement not allowed{#]A sequence cannot be started because a \u000amovement is active.{#]When a movement is active, no sequence (for example mold close sequence) \u000acan be started.{#]Wait for the movement to finish before retrying to start the desired \u000asequence. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erMachineSequenceNotCreated @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(965)Machine sequence not created{#]No valid machine sequence is created or \u000acreation of a new sequence is still active.{#]For every user change in the machine cycle sequence the control application \u000asoftware will calculate a new machine sequence. While this calculation is \u000aactive all movements are locked with this alarm. Once the calculation finished successfully the movements are unlocked with this alarm again. \u000a<br>\u000aIn case the sequence couldn't be calculated properly the movements will keep locked with this alarm. \u000aAdditionally detailed information about the problem will be \u000arepresented by other alarms.{#]In case the calculation of a new sequence is still active, this is just a message, no action required!<br><br>\u000aIf the calculation of a new sequence was not successful the \u000adetailed reason and solution will be represented by other alarms. \u000aPlease check these alarms and the according suggested solutions. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erInstanceableMovements @RT(1)1 @RT(1)y @RT(23)system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(449)Device %1t%2n: more than %3n safetyrelevant instanceable movements registered.{#]Too many safetyrelevant instanceable movements try to register for one device.{#]For each device only two safetyrelevant instanceable movements are allowed to register. \u000aIf more than two such movements try to register per device this alarm is \u000araised and the motor is locked permanently. \u000aapplication software.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erReadyAndNotPosReached @RT(1)2 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(516)Movement %1t%2n %3t finished but not in endposition{#]A movement finished without reaching its \u000atarget endposition during full automatic cycle.{#]During operation in full automatic mode a movement didn't finish properly because \u000ait didn't reach its target endposition.{#]Check the according movements output settings and other options \u000ain order to allow a successful movement up to its target endposition.<br>\u000aCheck in manual operation mode if the movement can reach its \u000atarget endposition. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erNoInverseMovement @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(302)No inverse movement for %1t%2n %3t defined. Stepping backward not possible!{#]Stepping backward is not possible because there is no inverse movement defined.{#]Stepping backward in the interrupted machine sequence stops at this step and can not be continued.{#]Confirm the alarm and continue autocycle. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erNoStepBwdIntoCondition @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(281)Stepping backward into a condition element is not possible{#]It is not possible to step backward into a condition element.{#]Stepping backward in the interrupted machine sequence stops at this step because a condition element is reached.{#]Confirm the alarm and continue autocycle. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erNoStepBwdIntoLoop @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(242)Stepping backward into a loop is not possible{#]It is not possible to step backward into a loop.{#]Stepping backward in the interrupted machine sequence stops at this step because a loop is reached.{#]Confirm the alarm and continue autocycle. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erNoStepBwdOutOfLoop @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(266)Stepping backward out of a loop is not possible{#]It is not possible to step backward out of a loop.{#]Stepping backward in the interrupted machine sequence stops at this step because stepping out of a loop is not allowed.{#]Confirm the alarm and continue autocycle. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erTooManyStartParallel @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(11)Application @RT(387)Too many parallel trees in machine sequence. Calculation of mold safety conditions not possible{#]Too many parallel trees in machine \u000asequence.{#]The control application can only handle a limited amount of parallel trees in \u000athe machine sequence.{#]Adapt the machine sequence to use less parallel trees.<br>\u000aIf this is not possible please contact the machine manufacturer. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
