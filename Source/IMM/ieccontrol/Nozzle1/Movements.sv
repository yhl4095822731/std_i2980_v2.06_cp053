%IMPORT_OVER_LISTFILE_SOURCE
 Stroke
, fmt31
, VG_MachineData
, fmt32
, Time
, NozzleState

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsEndPosData
, tsMoveData
, tsInjectHoldElementData
, cMoveBwd
, cMoveFwdContactF
, nMoveDirectionMinToMax
, nODCElementMovement
, cMoveFwd
, nMoveDirectionMaxToMin
, nODCElementInjectAndHold
, cMoveBwdContactFRelieve
, cLevelStartupTechnican
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_NozzleBwdMonData : tsEndPosData := (pProfile:=@%FU.sv_NozzleBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rNozzlePosition,pbPosReached:=@%FU.sv_bNozzleBwd)
    ;
 sv_NozzleFwdMonData : tsEndPosData := (pProfile:=@%FU.sv_NozzleFwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rNozzlePosition,pbPosReached:=@%FU.sv_bNozzleFwd)
    ;
 sv_MoveBwdNozzle : tsMoveData := (MoveId:=cMoveBwd,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_NozzleBwdTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveFwdContactF,sMoveId:='Bwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsBwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveBwdNozzle.MoveId
    
// Backward Nozzle backward
;
 sv_MoveFwdNozzle : tsMoveData := (MoveId:=cMoveFwd,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_NozzleFwdTimesAct.dLastMoveTime,prTargetValue:=@%FU.sv_rNozzleFwdPosition,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Fwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsFwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveFwdNozzle.MoveId
    
// Forward Nozzle forward
;
 sv_MoveFwdContactF : tsMoveData := (MoveId:=cMoveFwdContactF,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastFwdTime,pdCalculatedDuration:=@%FU.sv_dCalcDurationFwdContactF,prTargetValue:=@system.sv_rNull,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='FwdContactF',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsFwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementInjectAndHold,sElementData:='sv_NozzleFwdContactFData'))
    
%ELEMENT sv_MoveFwdContactF.MoveId
    
// Forward and contact force Nozzle fwd and contact force
;
 sv_MoveBwdContactFRelieve : tsMoveData := (MoveId:=cMoveBwdContactFRelieve,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_NozzleBwdRelieveTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BwdContactFRelieve',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsBwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement))
    
%ELEMENT sv_MoveBwdContactFRelieve.MoveId
    
// Contact force relieve Backward to relieve contact force
;
 sv_rMonTolerance : REAL := 0.5 (* tolerance for endpos monitoring *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Endposition tolerance Endposition tolerance
;
 sv_rTolerancePosReached : REAL := 0.0 (* tolerance for endpos reached *)
 %PLAUSIBILITY 0.0..%FU.sv_rMonTolerance    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32  %UNIT Stroke 
// Position reached tolerance  Position reached tolerance 
;
 sv_bNozzleBwdActivated : BOOL (* TRUE if nozzle bwd is activated (mode <> nNoNozzleBack) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Bwd activated Nozzle bwd activated
;
 sv_dCalculatedDurationFwd : TIME := T#2s (* Calculated duration for nozzle fwd *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalculatedDurationBwd : TIME := T#2s (* Calculated duration for nozzle bwd *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_iActState : DINT (* actual state (used for displaying a text in odc editor) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT NozzleState 
// Act. state Actual device state
;
 sv_bFwdTimeReached : BOOL (* nozzle fwd time reached (for time dependent nozzle control) (must be FastRetain: cyclical change in AutoCycle) *)
   %FAST_RETAIN ;
 sv_bBwdTimeReached : BOOL (* nozzle bwd time reached (for time dependent nozzle control) (must be FastRetain: cyclical change in AutoCycle) *)
   %FAST_RETAIN ;
 sv_dCalcDurationFwdContactF : TIME := T#2s (* Calculated duration for nozzle fwd *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_dCalcDurationBwdContactFRel : TIME := T#2s (* Calculated duration for nozzle bwd contact force relieve *)
 %PLAUSIBILITY T#0s..T#60s      %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration
;
 sv_NozzleFwdContactFData : tsInjectHoldElementData := (pdInjectDuration:=@%FU.sv_dCalculatedDurationFwd,pdHoldDuration:=@%FU.sv_dNozzleFwdContactFSet)
    ;
 sv_iCtrlParamSet : INT := 2
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// Control Parameter Set Control Parameter Set
;
 sv_dActFwdTime : TIME (* actual nozzle fwd time (includes contact force build up) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_dLastFwdTime : TIME (* last nozzle fwd time (includes contact force build up) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time ;
%END

%SYSTEM_ALARM
  erNozzleNotFwd
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n not forward{#]The nozzle forward movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause nozzle forward has not reached its target endposition.{#]Move the nozzle forward to its target endposition, before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the nozzle forward output settings. Try to move the nozzle forward manually before retrying the desired operation.<br><br>\u000aIn case a sensor is involved indicating the nozzle forward status this \u000acan also be checked, including hardware, wiring and terminal.
 ;
  erNozzleNotBwd
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n not backward{#]The nozzle backward movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause nozzle backward has not reached its target endposition.{#]Move the nozzle backward to its target endposition, before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the nozzle backward output settings. Try to move the nozzle backward manually before retrying the desired operation.<br><br>\u000aIn case a sensor is involved indicating the nozzle backward status this \u000acan also be checked, including hardware, wiring and terminal.
 ;
  erNozzleMustNotBeFwd
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n must not be forward{#]The desired operation cannot be \u000aexecuted as long as the nozzle is in \u000aforward endposition.{#]A desired operation, e.g. mold height adjustment, cannot be performed. The \u000acondition is the nozzle must not be in forward position.{#]Move the nozzle backward to leave its forward endposition, \u000abefore retrying the desired operation.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
20 
@SysVar @RT(19)sv_NozzleBwdMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(136)(pProfile:=@%FU.sv_NozzleBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rNozzlePosition,pbPosReached:=@%FU.sv_bNozzleBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_NozzleBwdMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(131)(pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,pbPosReached:=@%FU.sv_bMoldOpen) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_NozzleFwdMonData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsEndPosData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(136)(pProfile:=@%FU.sv_NozzleFwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rNozzlePosition,pbPosReached:=@%FU.sv_bNozzleFwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_NozzleFwdMonData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(168)(pProfile:=@%FU.sv_MoldBwdProfVis,rTolerance:=@%FU.sv_rMonTolerance,rActPos:=@%FU.sv_rMoldPosition,bFastMonitoring:=@%FU.sv_bDeviceReady,bPosReached:=@%FU.sv_bMoldOpen) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_MoveBwdNozzle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(418)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_NozzleBwdTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveFwdContactF,sMoveId:='Bwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsBwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(16)sv_MoveBwdNozzle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_MoveBwdNozzle.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveBwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Backward @RT(15)Nozzle backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_MoveFwdNozzle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(452)(MoveId:=cMoveFwd,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_NozzleFwdTimesAct.dLastMoveTime,prTargetValue:=@%FU.sv_rNozzleFwdPosition,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='Fwd',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsFwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(16)sv_MoveFwdNozzle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(36)(MoveId:=cMoveBwd,MoveDir:=cMoveBwd) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_MoveFwdNozzle.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)cMoveFwd @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Forward @RT(14)Nozzle forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MoveFwdContactF @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(540)(MoveId:=cMoveFwdContactF,MoveDir:=cMoveFwd,pdLastActiveTime:=@%FU.sv_dLastFwdTime,pdCalculatedDuration:=@%FU.sv_dCalcDurationFwdContactF,prTargetValue:=@system.sv_rNull,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,iMoveIdInverseMovement:=cMoveBwd,sMoveId:='FwdContactF',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsFwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMaxToMin,MovementType:=nODCElementInjectAndHold,sElementData:='sv_NozzleFwdContactFData')) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_MoveFwdContactF.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cMoveFwdContactF @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Forward and contact force @RT(28)Nozzle fwd and contact force @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoveBwdContactFRelieve @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(414)(MoveId:=cMoveBwdContactFRelieve,MoveDir:=cMoveBwd,pdLastActiveTime:=@%FU.sv_NozzleBwdRelieveTimesAct.dLastMoveTime,pbStartConditionReached:=@system.sv_bTRUE,pbActivated:=@system.sv_bTRUE,iSafetyIdentifier:=0,sMoveId:='BwdContactFRelieve',AnaOutData:=(pRequiredPumps:=@%FU.sv_RequiredPumpsBwd,piCtrlParamSet:=@%FU.sv_iCtrlParamSet),EditorData:=(Direction:=nMoveDirectionMinToMax,MovementType:=nODCElementMovement)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(32)sv_MoveBwdContactFRelieve.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(23)cMoveBwdContactFRelieve @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Contact force relieve @RT(33)Backward to relieve contact force @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rMonTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Endposition tolerance @RT(21)Endposition tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rMonTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Endposition tolerance @RT(21)Endposition tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rTolerancePosReached @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(28)tolerance for endpos reached 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt32 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMonTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Position reached tolerance  @RT(27)Position reached tolerance  @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rTolerancePosReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(31)tolerance for endpos monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt32 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMonTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Position reached tolerance  @RT(27)Position reached tolerance  @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bNozzleBwdActivated @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)TRUE if nozzle bwd is activated (mode <> nNoNozzleBack) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Bwd activated @RT(20)Nozzle bwd activated @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bNozzleBwdActivated @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)TRUE if airvalve is activated (mode <> nAirModeOff) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Bwd activated @RT(20)Nozzle bwd activated @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_dCalculatedDurationFwd @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(34)Calculated duration for nozzle fwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dCalculatedDurationFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_dCalculatedDurationBwd @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(34)Calculated duration for nozzle bwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_dCalculatedDurationBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_iActState @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)actual state (used for displaying a text in odc editor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(11)NozzleState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Act. state @RT(19)Actual device state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_iActState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)actual state (used for displaying a text in odc editor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(11)NozzleState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Act. state @RT(19)Actual device state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bFwdTimeReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(110)nozzle fwd time reached (for time dependent nozzle control) (must be FastRetain: cyclical change in AutoCycle) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bFwdTimeReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)Core in time reached (for time dependent core control) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bBwdTimeReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(110)nozzle bwd time reached (for time dependent nozzle control) (must be FastRetain: cyclical change in AutoCycle) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bBwdTimeReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)Core out time reached (for time dependent core control) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_dCalcDurationFwdContactF @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(34)Calculated duration for nozzle fwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_dCalcDurationFwdContactF @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_dCalcDurationBwdContactFRel @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#2s @RT(56)Calculated duration for nozzle bwd contact force relieve 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_dCalcDurationBwdContactFRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_NozzleFwdContactFData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tsInjectHoldElementData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(96)(pdInjectDuration:=@%FU.sv_dCalculatedDurationFwd,pdHoldDuration:=@%FU.sv_dNozzleFwdContactFSet) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_iCtrlParamSet @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Control Parameter Set @RT(21)Control Parameter Set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iCtrlParamSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Control Parameter Set @RT(21)Control Parameter Set @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_dActFwdTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(56)actual nozzle fwd time (includes contact force build up) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_dActFwdTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_dLastFwdTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)last nozzle fwd time (includes contact force build up) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_dLastFwdTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
3 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erNozzleNotFwd @RT(1)3 @RT(1)y @RT(49)system.evAlarmAutoManual, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(703)%1t%2n not forward{#]The nozzle forward movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause nozzle forward has not reached its target endposition.{#]Move the nozzle forward to its target endposition, before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the nozzle forward output settings. Try to move the nozzle forward manually before retrying the desired operation.<br><br>\u000aIn case a sensor is involved indicating the nozzle forward status this \u000acan also be checked, including hardware, wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erNozzleNotBwd @RT(1)3 @RT(1)y @RT(49)system.evAlarmAutoManual, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(710)%1t%2n not backward{#]The nozzle backward movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause nozzle backward has not reached its target endposition.{#]Move the nozzle backward to its target endposition, before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the nozzle backward output settings. Try to move the nozzle backward manually before retrying the desired operation.<br><br>\u000aIn case a sensor is involved indicating the nozzle backward status this \u000acan also be checked, including hardware, wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erNozzleMustNotBeFwd @RT(1)3 @RT(0) @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(376)%1t%2n must not be forward{#]The desired operation cannot be \u000aexecuted as long as the nozzle is in \u000aforward endposition.{#]A desired operation, e.g. mold height adjustment, cannot be performed. The \u000acondition is the nozzle must not be in forward position.{#]Move the nozzle backward to leave its forward endposition, \u000abefore retrying the desired operation. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
