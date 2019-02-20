%IMPORT_OVER_LISTFILE_SOURCE
 Stroke
, fmt41
, VG_MachineData
, VG_MoldData
, AdjustMode
, OnOff
, UseNoUse
, LG_ActMold
, fmt23
, Time
, fmt31
, Pressure
, NoRelative
, fmt40

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsEndpointMonitor
, tsMoldHeightPositions
, tnMoldHeightAdjustMode
, tsMoldHeightSetupPosMeasurement
, nForceOpenLoop
, cLevelStartupTechnican
, cLevelMoldPrepare
, cLevelServiceEngineer
, cLevelSuperUser
, cLevelProduction
, cLevelProcessOperator
, FPlausAdjustMode
, ALARM_EVENT

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoldHeightEndpoints : tsEndpointMonitor
    ;
 sv_MoldHeightPositions : tsMoldHeightPositions := (rMinMoldHeightPosition:=130.0,rMaxMoldHeightPosition:=360.0,rOriginMoldHeightPosition:=0.0)
   RETAIN 
%ELEMENT sv_MoldHeightPositions.rMaxMoldHeightPosition
 %PLAUSIBILITY 0.0..9999.9      %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Max. mold height Maximum mold height

%ELEMENT sv_MoldHeightPositions.rMinMoldHeightPosition
 %PLAUSIBILITY 0.0..9999.9      %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Min. mold height Minimum mold height

%ELEMENT sv_MoldHeightPositions.rMoveToMoldHeightPosition
 %PLAUSIBILITY %FU.sv_MoldHeightPositions.rMinMoldHeightPosition..%FU.sv_MoldHeightPositions.rMaxMoldHeightPosition      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT fmt41  %UNIT Stroke 
// Mold height Mold height

%ELEMENT sv_MoldHeightPositions.rOriginMoldHeightPosition
 %PLAUSIBILITY %FU.sv_MoldHeightPositions.rMinMoldHeightPosition..%FU.sv_MoldHeightPositions.rMaxMoldHeightPosition      %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Mold height origin Set mold height origin
;
 sv_bStandStillDetectionArmed : BOOL (* do standstill detection while mold height movement *)
    ;
 sv_MoldHeightAdjustMode : tnMoldHeightAdjustMode := nForceOpenLoop
 %PLAUSIBILITY FPlausAdjustMode    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT AdjustMode 
// Adjust mode Adjust mode
;
 sv_bMoldHeightAutoAdjHMI : BOOL (* hmi can start/stop automh adjust with this SV *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT OnOff 
// Auto mold adjust Auto mold adjust
;
 sv_bAutoMoldHeightAdjustActive : BOOL (* is TRUE when auto mold height adjust is acitve *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff 
// Auto mold adjust Auto mold adjust
;
 sv_bSetMoldHeightOrigin : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Set mold height origin Set mold height origin
;
 sv_rActMoldHeightPosition : REAL
     %LIST_GROUP LG_ActMold(1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Stroke 
// Mold height Mold height
;
 sv_rDistancePerImpulse : REAL
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Stroke 
// Dist. per imp. Calculate dinstance per impulse
;
 sv_dSetStandstillDetectionTime : TIME := t#10s
 %PLAUSIBILITY t#1s..t#999s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Standstill Standstill detection time
;
 sv_dActMovementTime : TIME
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. mold height movement time Act. mold height movement time
 %UPDATE_CYCLE "Fast";
 sv_dMaxMovementTime : TIME := t#60s
 %PLAUSIBILITY t#0s..t#999s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Time 
// Mold height movement time Mold height movement time
;
 sv_iAbsoluteImpulsesFromOrigin : DINT
   %FAST_RETAIN ;
 sv_iThisStepsActImpulses : UDINT
    ;
 sv_iThisStepsSetImpulses : UDINT
    ;
 sv_dActMoldHeightAdjustTime : TIME (* actual time for HMI to display *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_dMaxMoldHeightAdjustTime : TIME := t#5m (* max time for HMI to display *)
 %PLAUSIBILITY t#0s..t#10m    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Monitor time Mold height monitor time
;
 sv_bCalculateDistancePerImpulse : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Calculate distance/impulse Calculate distance per impulse
;
 sv_MoldHeightSetPosMeasurement : tsMoldHeightSetupPosMeasurement
   RETAIN 
%ELEMENT sv_MoldHeightSetPosMeasurement.bDistancePerImpulseValid
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT OnOff 
// Distance/impulse valid Distance per impulse valid

%ELEMENT sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation
 %PLAUSIBILITY %FU.sv_MoldHeightPositions.rMinMoldHeightPosition..%FU.sv_MoldHeightPositions.rMaxMoldHeightPosition      %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Mold height calc. pos. Second mold height position for calculation
;
 sv_bMoldHeightAutoAdjFinished : BOOL
     %DISPLAY_LEVEL 1   %INPUT_LEVEL cLevelSuperUser

// Mold adjust finished Mold adjust finished
;
 sv_rSetClampPressure : REAL := 100.0
 %PLAUSIBILITY 0.0..Mold1.sv_rMaxPressureFwd    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Pressure  %ABSREL NoRelative 
// Clamp pressure Clamp pressure
;
 sv_dDelayBeforeNutsOpen : TIME := t#2s (* delaytime between mold nuts close and mold nuts open (used for 2 platen IMM) *)
 %PLAUSIBILITY t#0s..t#999.9s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Delay nuts open Delay before nuts open
;
 sv_bOpenMoldAfterAdjust : BOOL := TRUE
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

// Open mold after adjust Open mold after mold adjust
;
 sv_bTBFwdStandStillDuringAdjust : BOOL := FALSE (* TRUE: move tiebars forward until standstill during mold adjust procedure *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
;
%END

%SYSTEMEVENT_DECL
  evMoveTimeout : ALARM_EVENT (* Movement timeout reaction (erMoveTimeout) *)
;
 evMoveTimeoutReset : ALARM_EVENT (* Movement timeout  reset reaction (erMoveTimeout) *)
;
%END

%SYSTEM_ALARM
  erLimitSwitchCanceledAutoAdj
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Mold Height Limit Switch arrived{#]The mold height arrived at a minimum or \u000amaximum limit during automatic adjustment.{#]While performing a mold height movement for the auto adjustment a limitswitch \u000afor either minimum or maximum mold height position indicates the end position \u000ahas been reached. No \u000afurther movement in this direction possible! Automatic adjustment is stopped and \u000athis alarm is raised.{#]Make sure the installed mold fits the dimension limitations of the \u000amachine.<br>\u000aIf it fits make sure the mold adjust settings are set according to the \u000arequirements of the machine and the mold.<br>\u000aIf automatic mold height adjustment still doesn't work try to do a \u000amanual adjustment using the {MoldHeight1.sv_bMoldHeightAdjustByOneGear} or {MoldHeight1.sv_bMoldHeightAdjustByTime} \u000aoptions.
 ;
  erMoldHeightAdjustFinished
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Mold Height Auto Adjustment finished successfully{#]Mold height adjusted automatically to \u000aprovide the desired tonnage.{#]This is just a message.<br>\u000aThe selected automatic mold height adjustment process finished successfully.{#]This is just message, no action required!<br>\u000aOnce confirmed the message will disappear.
 ;
  erMoldHeightAdjustMoldNotOpen
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Mold not open{#]Mold height auto adjustment requires \u000athe mold to be in backward position.{#]While the mold has not reached its backward targetposition the automatic \u000amold height adjustment process cannot continue.{#]Restart the Mold height automatic adjustment process or move \u000athe mold backward manually before doing so.
 ;
  erDistPerImpNotValid
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Distance per Impulse Value not Valid - Please (re)-calibrate Position Measurement{#]Mold height distance per impulse \u000ainformation is not valid because mold \u000aheight position has not been calibrated.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine. If no calibration has been done \u000abefore, or a new calibration process has been started the distance per impulse\u000ainformation will be invalid and this alarm is raised.{#](Finish) calibrating the mold height position. This is the complete \u000aprocess:<br><br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition} position. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aAfter this auto mold height adjustment by position is possible.
 ;
  erMaxMoldHeightAdjTimeExc
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Maximum Mold Height Auto Adjust Time Exceeded{#]Mold height auto adjustment stopped \u000abecause the supervision time is exceeded.{#]For all automatic mold height adjustment processes the maximum time \u000asupervision applies. If the process takes longer than this user set time the \u000aprocess is stopped and this alarm is raised.{#]Make sure all mold height movements can be performed properly. \u000aOnce this is sure the setting for mold height auto adjust {MoldHeightAdjust1.sv_dMaxMoldHeightAdjustTime} \u000acan be increased to allow for a successful autoadjustment.
 ;
  erMoldHeightAdjustAborted
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Mold Height Auto Adjustment Aborted{#]Mold height automatic adjustment has \u000abeen aborted either by a user or the \u000aprocess itself.{#]One possible cause is the user cancelled the automatic mold height \u000aadjustment process. In this case this alarm is just a message.<br><br>\u000aIn case the process did stop itself the most likely cause is that a mold height \u000aforward or backward movement didn't reach to expected target position. \u000aThe cause could be inappropriate output settings or a problematic position \u000acalibration.{#]In case a user cancelled the automatic mold height adjustment \u000aprocess this is just a message, no action is required!<br><br>\u000aIn case the process stopped itself check the mold height \u000aoutput settings (fwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue:c:velocity}, bwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue:c:velocity} as well as the overall mold height adjustment \u000asettings.<br><br>\u000aIn case all settings are done properly and the {MoldHeightAdjust1.sv_MoldHeightAdjustMode} \u000ais 'position' a re-calibration of the mold height position can be tried.<br>\u000aThe process for position calibration works as follows:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.
 ;
  erEnterActualMoldHeightPos
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Enter actual Mold Height Position for Calculation{#]In the process of mold height position \u000acalibration the actual position needs to \u000abe entered before calibration is possible.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine.<br><br>\u000aThe process for position calibration is the following:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition} . Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aThis alarm is raised, if the field for actual mold height position still contains the \u000asame value as from setting the origin position before. Either the mold height \u000ahas not been moved since then and the new measured position has not been \u000aentered, or only the latter.{#]Make sure a mold height origin has been set, the mold height has \u000abeen moved since and the new position on the machine has been \u000amanually measured.<br><br>\u000aThen enter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation} \u000aand press {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.
 ;
  erMoveToDifferentMoldHeightPos
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Move to a different Mold Height Position{#]In the process of mold height position \u000acalibration mold height has not moved \u000asince setting the origin.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine.<br><br>\u000aThe process for position calibration is the following:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aThis alarm is raised, if no impulse activity has been measured since the origin \u000ahas been set. In order to be able to calculate a useful distance per impulse \u000atwo mold height positions are necessary.{#]Move the mold height to another position before continuing the \u000amold height position calibration.<br><br>\u000aThe next steps are:<br>\u000aMeasure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.
 ;
  erSetMoldHeightOriginFirst
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// First set Origin Position for Mold Height Adjustment{#]In the process of mold height position \u000acalibration the first step of setting a \u000amold height origin position is not done.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine.<br><br>\u000aThe process for position calibration is the following:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aThis alarm is raised if the very first step of setting the origin has not been \u000aperformed yet.{#]First measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}.<br><br>\u000aNow the cause for this alarm has been removed. The next steps for \u000amold height position calibration are:<br>\u000aMove the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
24 
@SysVar @RT(22)sv_MoldHeightEndpoints @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsEndpointMonitor @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(22)sv_MoldHeightPositions @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsMoldHeightPositions @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(92)(rMinMoldHeightPosition:=130.0,rMaxMoldHeightPosition:=360.0,rOriginMoldHeightPosition:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(22)sv_MoldHeightPositions @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(92)(rMinMoldHeightPosition:=130.0,rMaxMoldHeightPosition:=360.0,rOriginMoldHeightPosition:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldHeightPositions.rMaxMoldHeightPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)360.0 @RT(28)maximum mold height position 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. mold height @RT(19)Maximum mold height @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldHeightPositions.rMinMoldHeightPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)130.0 @RT(28)minimum mold height position 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Min. mold height @RT(19)Minimum mold height @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_MoldHeightPositions.rMoveToMoldHeightPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(77)move to position of mold height for mold height adjustment by position change 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(100)%FU.sv_MoldHeightPositions.rMinMoldHeightPosition..%FU.sv_MoldHeightPositions.rMaxMoldHeightPosition @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Mold height @RT(11)Mold height @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_MoldHeightPositions.rOriginMoldHeightPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(56)origin mold height position for calibrating the position 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(100)%FU.sv_MoldHeightPositions.rMinMoldHeightPosition..%FU.sv_MoldHeightPositions.rMaxMoldHeightPosition @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Mold height origin @RT(22)Set mold height origin @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_bStandStillDetectionArmed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)do standstill detection while mold height movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_bStandStillDetectionArmed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)do standstill detection while mold height movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_MoldHeightAdjustMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tnMoldHeightAdjustMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(14)nForceOpenLoop @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(14)VG_MachineData @RT(10)AdjustMode @RT(0) @RT(0) @RT(0) 
@RT(16)FPlausAdjustMode @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Adjust mode @RT(11)Adjust mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_MoldHeightAdjustMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(14)VG_MachineData @RT(10)AdjustMode @RT(0) @RT(0) @RT(0) 
@RT(16)FPlausAdjustMode @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Adjust mode @RT(11)Adjust mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bMoldHeightAutoAdjHMI @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)hmi can start/stop automh adjust with this SV 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Auto mold adjust @RT(16)Auto mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bMoldHeightAutoAdjHMI @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)hmi can start/stop automh adjust with this SV 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Auto mold adjust @RT(16)Auto mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_bAutoMoldHeightAdjustActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)is TRUE when auto mold height adjust is acitve 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Auto mold adjust @RT(16)Auto mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_bAutoMoldHeightAdjustActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)is TRUE when auto mold height adjust is acitve 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Auto mold adjust @RT(16)Auto mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bSetMoldHeightOrigin @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Set mold height origin @RT(22)Set mold height origin @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bSetMoldHeightOrigin @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Set mold height origin @RT(22)Set mold height origin @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rActMoldHeightPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActMold(1) @RT(0) 
@RT(11)Mold height @RT(11)Mold height @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rActMoldHeightPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActMold(1) @RT(0) 
@RT(11)Mold height @RT(11)Mold height @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rDistancePerImpulse @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt23 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Dist. per imp. @RT(31)Calculate dinstance per impulse @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rDistancePerImpulse @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt23 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Dist. per imp. @RT(31)Calculate dinstance per impulse @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_dSetStandstillDetectionTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#10s @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#1s..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Standstill @RT(25)Standstill detection time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_dSetStandstillDetectionTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#1s..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Standstill @RT(25)Standstill detection time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_dActMovementTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Act. mold height movement time @RT(30)Act. mold height movement time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dActMovementTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Act. mold height movement time @RT(30)Act. mold height movement time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_dMaxMovementTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#60s @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#0s..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold height movement time @RT(25)Mold height movement time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dMaxMovementTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#0s..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold height movement time @RT(25)Mold height movement time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_iAbsoluteImpulsesFromOrigin @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_iAbsoluteImpulsesFromOrigin @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_iThisStepsActImpulses @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(24)sv_iThisStepsSetImpulses @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(27)sv_dActMoldHeightAdjustTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)actual time for HMI to display 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_dActMoldHeightAdjustTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)actual time for HMI to display 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_dMaxMoldHeightAdjustTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#5m @RT(27)max time for HMI to display 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10m @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Monitor time @RT(24)Mold height monitor time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_dMaxMoldHeightAdjustTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)max time for HMI to display 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10m @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Monitor time @RT(24)Mold height monitor time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_bCalculateDistancePerImpulse @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Calculate distance/impulse @RT(30)Calculate distance per impulse @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_bCalculateDistancePerImpulse @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Calculate distance/impulse @RT(30)Calculate distance per impulse @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_MoldHeightSetPosMeasurement @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(31)tsMoldHeightSetupPosMeasurement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(30)sv_MoldHeightSetPosMeasurement @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(55)sv_MoldHeightSetPosMeasurement.bDistancePerImpulseValid @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(79)shows if a valid number has been entered for the Distance per Impulse variables 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Distance/impulse valid @RT(26)Distance per impulse valid @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(60)sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)second point after mold height origin has been set 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(100)%FU.sv_MoldHeightPositions.rMinMoldHeightPosition..%FU.sv_MoldHeightPositions.rMaxMoldHeightPosition @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Mold height calc. pos. @RT(43)Second mold height position for calculation @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_bMoldHeightAutoAdjFinished @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(2)1  @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Mold adjust finished @RT(20)Mold adjust finished @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_bMoldHeightAutoAdjFinished @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(2)1  @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Mold adjust finished @RT(20)Mold adjust finished @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rSetClampPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt40 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(29)0.0..Mold1.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Clamp pressure @RT(14)Clamp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rSetClampPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt40 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(29)0.0..Mold1.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Clamp pressure @RT(14)Clamp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dDelayBeforeNutsOpen @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#2s @RT(76)delaytime between mold nuts close and mold nuts open (used for 2 platen IMM) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Delay nuts open @RT(22)Delay before nuts open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dDelayBeforeNutsOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Delay nuts open @RT(22)Delay before nuts open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bOpenMoldAfterAdjust @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Open mold after adjust @RT(27)Open mold after mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bOpenMoldAfterAdjust @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Open mold after adjust @RT(27)Open mold after mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_bTBFwdStandStillDuringAdjust @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(72)TRUE: move tiebars forward until standstill during mold adjust procedure 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_bTBFwdStandStillDuringAdjust @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)TRUE: move TB forward until standstill during mold adjust procedure 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
2 
@SysEvent @RT(13)evMoveTimeout @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(41)Movement timeout reaction (erMoveTimeout) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(18)evMoveTimeoutReset @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(48)Movement timeout  reset reaction (erMoveTimeout) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
9 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erLimitSwitchCanceledAutoAdj @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(854)Mold Height Limit Switch arrived{#]The mold height arrived at a minimum or \u000amaximum limit during automatic adjustment.{#]While performing a mold height movement for the auto adjustment a limitswitch \u000afor either minimum or maximum mold height position indicates the end position \u000ahas been reached. No \u000afurther movement in this direction possible! Automatic adjustment is stopped and \u000athis alarm is raised.{#]Make sure the installed mold fits the dimension limitations of the \u000amachine.<br>\u000aIf it fits make sure the mold adjust settings are set according to the \u000arequirements of the machine and the mold.<br>\u000aIf automatic mold height adjustment still doesn't work try to do a \u000amanual adjustment using the {MoldHeight1.sv_bMoldHeightAdjustByOneGear} or {MoldHeight1.sv_bMoldHeightAdjustByTime} \u000aoptions. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erMoldHeightAdjustFinished @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(332)Mold Height Auto Adjustment finished successfully{#]Mold height adjusted automatically to \u000aprovide the desired tonnage.{#]This is just a message.<br>\u000aThe selected automatic mold height adjustment process finished successfully.{#]This is just message, no action required!<br>\u000aOnce confirmed the message will disappear. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erMoldHeightAdjustMoldNotOpen @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(337)Mold not open{#]Mold height auto adjustment requires \u000athe mold to be in backward position.{#]While the mold has not reached its backward targetposition the automatic \u000amold height adjustment process cannot continue.{#]Restart the Mold height automatic adjustment process or move \u000athe mold backward manually before doing so. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erDistPerImpNotValid @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(1398)Distance per Impulse Value not Valid - Please (re)-calibrate Position Measurement{#]Mold height distance per impulse \u000ainformation is not valid because mold \u000aheight position has not been calibrated.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine. If no calibration has been done \u000abefore, or a new calibration process has been started the distance per impulse\u000ainformation will be invalid and this alarm is raised.{#](Finish) calibrating the mold height position. This is the complete \u000aprocess:<br><br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition} position. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aAfter this auto mold height adjustment by position is possible. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erMaxMoldHeightAdjTimeExc @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(577)Maximum Mold Height Auto Adjust Time Exceeded{#]Mold height auto adjustment stopped \u000abecause the supervision time is exceeded.{#]For all automatic mold height adjustment processes the maximum time \u000asupervision applies. If the process takes longer than this user set time the \u000aprocess is stopped and this alarm is raised.{#]Make sure all mold height movements can be performed properly. \u000aOnce this is sure the setting for mold height auto adjust {MoldHeightAdjust1.sv_dMaxMoldHeightAdjustTime} \u000acan be increased to allow for a successful autoadjustment. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erMoldHeightAdjustAborted @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(1996)Mold Height Auto Adjustment Aborted{#]Mold height automatic adjustment has \u000abeen aborted either by a user or the \u000aprocess itself.{#]One possible cause is the user cancelled the automatic mold height \u000aadjustment process. In this case this alarm is just a message.<br><br>\u000aIn case the process did stop itself the most likely cause is that a mold height \u000aforward or backward movement didn't reach to expected target position. \u000aThe cause could be inappropriate output settings or a problematic position \u000acalibration.{#]In case a user cancelled the automatic mold height adjustment \u000aprocess this is just a message, no action is required!<br><br>\u000aIn case the process stopped itself check the mold height \u000aoutput settings (fwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue:c:velocity}, bwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue:c:velocity} as well as the overall mold height adjustment \u000asettings.<br><br>\u000aIn case all settings are done properly and the {MoldHeightAdjust1.sv_MoldHeightAdjustMode} \u000ais 'position' a re-calibration of the mold height position can be tried.<br>\u000aThe process for position calibration works as follows:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erEnterActualMoldHeightPos @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(1748)Enter actual Mold Height Position for Calculation{#]In the process of mold height position \u000acalibration the actual position needs to \u000abe entered before calibration is possible.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine.<br><br>\u000aThe process for position calibration is the following:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition} . Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aThis alarm is raised, if the field for actual mold height position still contains the \u000asame value as from setting the origin position before. Either the mold height \u000ahas not been moved since then and the new measured position has not been \u000aentered, or only the latter.{#]Make sure a mold height origin has been set, the mold height has \u000abeen moved since and the new position on the machine has been \u000amanually measured.<br><br>\u000aThen enter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation} \u000aand press {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erMoveToDifferentMoldHeightPos @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(1668)Move to a different Mold Height Position{#]In the process of mold height position \u000acalibration mold height has not moved \u000asince setting the origin.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine.<br><br>\u000aThe process for position calibration is the following:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aThis alarm is raised, if no impulse activity has been measured since the origin \u000ahas been set. In order to be able to calculate a useful distance per impulse \u000atwo mold height positions are necessary.{#]Move the mold height to another position before continuing the \u000amold height position calibration.<br><br>\u000aThe next steps are:<br>\u000aMeasure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erSetMoldHeightOriginFirst @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(1864)First set Origin Position for Mold Height Adjustment{#]In the process of mold height position \u000acalibration the first step of setting a \u000amold height origin position is not done.{#]When positioning by distance units is used mold height adjustment requires a \u000aposition calibration. The result of this calibration is a reference point for mold \u000aheight position as well as a valid number for distance per impulse. The impulses \u000aare the actual feedback from the machine.<br><br>\u000aThe process for position calibration is the following:<br>\u000aFirst measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}. Then move the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}.<br><br>\u000aThis alarm is raised if the very first step of setting the origin has not been \u000aperformed yet.{#]First measure the actual mold height position on the machine. Enter \u000athe measured value as {MoldHeightAdjust1.sv_MoldHeightPositions.rOriginMoldHeightPosition}. Next press \u000a{MoldHeightAdjust1.sv_bSetMoldHeightOrigin}.<br><br>\u000aNow the cause for this alarm has been removed. The next steps for \u000amold height position calibration are:<br>\u000aMove the mold height some distance \u000aforward or backward. Measure the actual mold height position again. \u000aEnter the measured value as {MoldHeightAdjust1.sv_MoldHeightSetPosMeasurement.rSecondPositionForCalculation}. Then \u000apress {MoldHeightAdjust1.sv_bCalculateDistancePerImpulse}. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
