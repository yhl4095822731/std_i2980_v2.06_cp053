%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, OnOff
, fmt22
, fmt31
, Stroke
, fmt41
, LG_ActPos
, Speed
, NoRelative
, Forward
, ContactForce
, fmt30
, MaxRampPressure
, MaxRampVelocity
, VG_MoldData
, Percent
, fmt10
, Time
, LG_NozzleFwd
, Backward
, Voltage
, UseNoUse
, VG_SequenceData
, VG_Nozzle
, NozzleMode
, NozzleMovementMode
, LG_NozzleBwd
, CalibGroup
, fmtCalibState
, Pressure
, fmtPosReached
, NozzleBackMode
, LG_NozzleForceBuildup
, fmt60

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_MeasureMonitoring
, tsVelPre
, KAPPL_VisProfile
, KAPPL_LintabData_2P
, tsSetTimes
, tsActTimes
, tnMovementMode
, tnNozzleMovementMode
, tsMinOutput
, KCTRL_Lintab_Point
, tsCalibMovement
, tsTransducerCalibData
, tsCylinderData
, KAPPL_LintabData
, tnNozzleBackMode
, tCalculatedProfiles
, tsRequiredPumps
, tsHydrMaxValues
, KCTRL_YXGen_RampType_Square
, KCTRL_YXGen_RampType_Linear
, nLimitSwitchDependent
, nNozzleMovementModePosition
, tnCalibGroup_Transducer
, cMoveFwd
, cMoveBwd
, nBeforeMoldOpen
, cLevelStartupTechnican
, cLevelSuperUser
, cLevelProcessOperator
, cLevelProduction
, cLevelServiceEngineer
, cPlausMaxRampPressureMax
, cPlausMaxRampPressureMin
, cPlausMaxRampVelocityMax
, cPlausMaxRampVelocityMin

END_IMPORT

%SYSTEMVAR_DECL
  sv_NozzlePosMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_NozzlePosMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_NozzlePosMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_NozzlePosMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_NozzlePosMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_NozzlePosMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_rNozzlePosition : REAL (* actual position of nozzle *)
     %LIST_GROUP LG_ActPos(3)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Stroke 
// Nozzle position Nozzle position
 %UPDATE_CYCLE "Fast";
 sv_rNozzleVelocity : REAL (* actual speed of nozzle *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Nozzle velocity Nozzle velocity
;
 sv_rPressureAbs : REAL (* actual output pressure *)
    ;
 sv_rVelocityAbs : REAL (* actual output velocity *)
    ;
 sv_rPressure : REAL (* actual output pressure *)
    ;
 sv_rVelocity : REAL (* actual output velocity *)
    ;
 sv_iActiveStage : DINT (* actual active stage of profile output *)
    ;
 sv_ConstFwdSetup : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0))) (* constant output parameters of nozzle fwd movement in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdSetup.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Forward 
// Forward force Forward force

%ELEMENT sv_ConstFwdSetup.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Ramp Ramp

%ELEMENT sv_ConstFwdSetup.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstFwdSetup.Pressure.rMinOutput
     %DISPLAY_LEVEL 1 
%ELEMENT sv_ConstFwdSetup.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Forward velocity Fwd Velocity

%ELEMENT sv_ConstFwdSetup.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Ramp Ramp

%ELEMENT sv_ConstFwdSetup.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward ;
 sv_ConstFwdContactF : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=500.0),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=500.0),PreOutput:=(rRamp:=1000.0))) (* constant output parameters of nozzle fwd contact pressure build-up movement  *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdContactF.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Forward 
// Forward contact force Forward contact force

%ELEMENT sv_ConstFwdContactF.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Contact force ramp Contact force ramp

%ELEMENT sv_ConstFwdContactF.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstFwdContactF.Pressure.rMinOutput
     %DISPLAY_LEVEL 1 
%ELEMENT sv_ConstFwdContactF.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Forward contact velocity Fwd contact velocity

%ELEMENT sv_ConstFwdContactF.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Contact force ramp Contact force ramp

%ELEMENT sv_ConstFwdContactF.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Ramp contact pressure Ramp contact pressure setup
;
 sv_ConstFwdStage1 : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rOutputValue:=0.0,rRamp:=1000.0),rMinOutput:=5.0),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rOutputValue:=0.0,rRamp:=1000.0),rMinOutput:=5.0)) (* constant output parameters of nozzle fwd movement before limit switch is touched in manual mode *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdStage1.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Forward 
// Force before limit switch Force before limit switch

%ELEMENT sv_ConstFwdStage1.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Ramp fwd before limit switch Ramp fwd before limit switch

%ELEMENT sv_ConstFwdStage1.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstFwdStage1.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Velocity before limit switch Velocity before limit switch

%ELEMENT sv_ConstFwdStage1.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Ramp fwd before limit switch Ramp fwd before limit switch

%ELEMENT sv_ConstFwdStage1.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Forward ;
 sv_ConstFwdStage2 : tsVelPre := (Velocity:=(Output:=(rOutputValue:=7.0,rRamp:=1000.0),PreOutput:=(rOutputValue:=0.0,rRamp:=1000.0),rMinOutput:=5.0),Pressure:=(Output:=(rOutputValue:=7.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0))) (* constant output parameters of nozzle fwd movement after limit switch is touched in manual mode (must be FAST Retain bcause of cyclical change in AutoCycle) *)
   %FAST_RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdStage2.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Forward 
// Force after limit switch Force after limit switch

%ELEMENT sv_ConstFwdStage2.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Ramp fwd after limit switch Ramp fwd after limit switch

%ELEMENT sv_ConstFwdStage2.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstFwdStage2.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Velocity after limit switch Velocity after limit switch

%ELEMENT sv_ConstFwdStage2.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Ramp fwd after limit switch Ramp fwd after limit switch

%ELEMENT sv_ConstFwdStage2.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Forward ;
 sv_NozzleFwdProfVis : KAPPL_VisProfile := (Profile:=(Points:=(rStartPos:=300.0),iNoOfPoints:=2),rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=100.0,rMaxRampVel:=100.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageFwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd) (* profile of nozzle fwd movement *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_NozzleFwdProfVis.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS NozzleGeneral.hmi.NozzleFwdProgrammedVisControl 
%ELEMENT sv_NozzleFwdProfVis.Profile.Points
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_NozzleFwdProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_NozzleFwdProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Forward 
// Force Force

%ELEMENT sv_NozzleFwdProfVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_NozzleFwdProfVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_NozzleFwdProfVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Velocity Velocity

%ELEMENT sv_NozzleFwdProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 1..3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_NozzleFwdProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Max. ramp forward Max. ramp forward

%ELEMENT sv_NozzleFwdProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp forward Max. ramp forward

%ELEMENT sv_NozzleFwdProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_NozzleFwdProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_dNozzleFwdStage2Set : TIME := t#1s (* time for output of nozzle fwd movement after limitswitch is touched *)
 %PLAUSIBILITY t#0.0s..t#999.9s    RETAIN  %VARIABLE_GROUP VG_MoldData  %LIST_GROUP LG_NozzleFwd(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Time after limit switch Time after limit switch
;
 sv_dNozzleFwdStage2Act : TIME (* time for output of nozzle fwd movement after limitswitch is touched *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. time after limit switch Act. time after limit switch
 %UPDATE_CYCLE "Fast";
 sv_ConstBwd : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0),rMinOutput:=5.0),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0),rMinOutput:=5.0)) (* constant output parameters of nozzle bwd movement in manual mode *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_ConstBwd.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Backward 
// Force Force

%ELEMENT sv_ConstBwd.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Backward ramp Backward ramp

%ELEMENT sv_ConstBwd.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_ConstBwd.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_ConstBwd.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Backward ramp Backward ramp

%ELEMENT sv_ConstBwd.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Backward ;
 sv_ConstBwdSetup : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0))) (* constant output parameters of nozzle bwd movement in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_ConstBwdSetup.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Backward 
// Backward force Backward force

%ELEMENT sv_ConstBwdSetup.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstBwdSetup.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_ConstBwdSetup.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Backward velocity Backward velocity

%ELEMENT sv_ConstBwdSetup.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstBwdSetup.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward ;
 sv_NozzleBwdProfVis : KAPPL_VisProfile := (Profile:=(iNoOfPoints:=2),rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=100.0,rMaxRampVel:=100.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageBwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwd) (* profile of nozzle bwd movement *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_NozzleBwdProfVis.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS NozzleGeneral.hmi.NozzleBwdProgrammedVisControl 
%ELEMENT sv_NozzleBwdProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_NozzleBwdProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Backward 
// Force Force

%ELEMENT sv_NozzleBwdProfVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_NozzleBwdProfVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_NozzleBwdProfVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_NozzleBwdProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 1..3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_NozzleBwdProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Max. ramp backward Max. ramp backward

%ELEMENT sv_NozzleBwdProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Max. ramp backward Max. ramp backward

%ELEMENT sv_NozzleBwdProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_NozzleBwdProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_NozzleLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=300.0))) (* linearisation table for conversion of transducer voltage into position *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_NozzleLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_NozzleLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..%FU.sv_rNozzleStroke      %FORMAT fmt41  %UNIT Stroke 
// Position Position

%ELEMENT sv_NozzleLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// No. of points Number of points
;
 sv_rNozzleStroke : REAL := 300.0 (* stroke between fwd and bwd end position *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Max. nozzle stroke Max. nozzle stroke
;
 sv_bFwdDuringPlast : BOOL (* hold nozzle fwd during plasticizing *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Nozzle hold during plast Nozzle hold during plasticize
;
 sv_bFwdDuringInject : BOOL (* hold nozzle fwd during inject *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Nozzle hold during inject Nozzle hold during inject
;
 sv_NozzleBwdTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s) (* set times for nozzle bwd *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_NozzleBwdTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. backward time Max. nozzle backward time

%ELEMENT sv_NozzleBwdTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Backward delay Nozzle backward delay

%ELEMENT sv_NozzleBwdTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Backward delay pump Nozzle backward delay pump

%ELEMENT sv_NozzleBwdTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Backward delay valve Nozzle backward delay valve
;
 sv_NozzleBwdTimesAct : tsActTimes (* act times for nozzle bwd *)
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_NozzleBwdTimesAct.dActDelayTime
     %FORMAT fmt31  %UNIT Time 
// Act. backward delay Act. nozzle backward delay

%ELEMENT sv_NozzleBwdTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Nozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. backward time Act. nozzle backward time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_NozzleBwdTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last backward time Last nozzle backward time
;
 sv_NozzleFwdTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s) (* set times for nozzle fwd *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_NozzleFwdTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max.forward time Max. nozzle forward time

%ELEMENT sv_NozzleFwdTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Forward delay Nozzle forward delay

%ELEMENT sv_NozzleFwdTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Forward delay pump Nozzle forward delay pump

%ELEMENT sv_NozzleFwdTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Forward delay valve Nozzle forward delay valve
;
 sv_NozzleFwdTimesAct : tsActTimes (* act times for nozzle fwd *)
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_NozzleFwdTimesAct.dActDelayTime
     %FORMAT fmt31  %UNIT Time 
// Act. forward delay Act. nozzle forward delay

%ELEMENT sv_NozzleFwdTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Nozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. forward time Act. nozzle forward time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_NozzleFwdTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last forward time Last nozzle forward time
;
 sv_MovementMode : tnMovementMode := nLimitSwitchDependent (* Nozzle Movement with Limitswitch or with position measurement *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT NozzleMode 
// Nozzle movement mode Nozzle movement mode
;
 sv_NozzleMovementMode : tnNozzleMovementMode := nNozzleMovementModePosition (* nozzle movement depending on AppCo settings (transducer or limit switch) or time dependent *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT NozzleMovementMode 
// Nozzle movement Nozzle movement
;
 sv_dMoveBwdTimeSet : TIME := t#1s (* time of nozzle bwd movement in manual mode *)
 %PLAUSIBILITY t#0s..t#60s    RETAIN  %VARIABLE_GROUP VG_MoldData  %LIST_GROUP LG_NozzleBwd(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Backward time Backward time
;
 sv_MinOutputFwd : tsMinOutput
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MinOutputFwd.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Forward 
// Min. profile output fwd Min. profile output fwd

%ELEMENT sv_MinOutputFwd.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL Forward 
// Min. profile output fwd Min. profile output fwd
;
 sv_MinOutputBwd : tsMinOutput
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MinOutputBwd.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT ContactForce  %ABSREL Backward 
// Min. profile output bwd Min. profile output bwd

%ELEMENT sv_MinOutputBwd.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL Backward 
// Min. profile output bwd Min. profile output bwd
;
 sv_bOutputActive : BOOL (* Output is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Nozzle output active Nozzle output active
;
 sv_bPreOutputReady : BOOL (* PreOutput is ready *)
     %INPUT_LEVEL 16

// Pre output ready Pre output ready
;
 sv_bDoTransducerCalib : BOOL
     %INPUT_LEVEL cLevelProcessOperator

// Do transducer calibration Do transducer calibration
;
 sv_bTransducerError : BOOL
    
// Transducer error Transducer error
;
 sv_TmpLintabPoint : KCTRL_Lintab_Point
    ;
 sv_CalibState : tsCalibMovement := (pLintabPoints:=@%FU.sv_NozzleLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_NozzleLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rNozzleStroke,iOrder:=30,Group:=tnCalibGroup_Transducer)
    
%ELEMENT sv_CalibState.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibState.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibState.bNameDummy
     %DISPLAY_LEVEL 1 
// Nozzle Nozzle transducer

%ELEMENT sv_CalibState.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_TransducerCalibData : tsTransducerCalibData := (Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveFwd,Id2:=cMoveBwd,bReverse:=FALSE,prPos2:=@%FU.sv_rNozzleStroke)
    ;
 sv_CylinderData : tsCylinderData := (rCylinderDiameter:=100.0,rPistonRodDiameter:=30.0,iNumCylinders:=2,bUseSmallSize:=TRUE) (* parameters of the cylinder *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_CylinderData.bUseSmallSize
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Move forward by ring area Move forward by piston area

%ELEMENT sv_CylinderData.iNumCylinders
 %PLAUSIBILITY 1..9      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt10 
// Number of cylinders Number of cylinders

%ELEMENT sv_CylinderData.rCylinderDiameter
 %PLAUSIBILITY 0.0..999.9      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Cylinder diameter Cylinder diameter

%ELEMENT sv_CylinderData.rPistonRodDiameter
 %PLAUSIBILITY 0.0..999.9      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Piston rod diameter Piston rod diameter
;
 sv_LintabOutFwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rX
     %UNIT ContactForce  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rY
     %UNIT Pressure  %ABSREL Forward ;
 sv_LintabOutFwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=45.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rX
     %UNIT Speed  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutBwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rX
     %UNIT ContactForce  %ABSREL Backward 
%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rY
     %UNIT Pressure  %ABSREL Backward ;
 sv_LintabOutBwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=45.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutBwdV.LintabPoints.Point[0].rX
     %UNIT Speed  %ABSREL Backward 
%ELEMENT sv_LintabOutBwdV.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_rMaxSpeedReducePercent : REAL := 0.0 (* reduce calculated max speed with this percentage  *)
 %PLAUSIBILITY 0.0..100.0    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent 
// Max.speed reduce factor Max.speed reduce factor
;
 sv_rMaxSpeedFwdCalc : REAL := 45.0 (* maximum speed for nozzle fwd (calculated) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed calc. fwd Max. speed calc. fwd
;
 sv_rMaxSpeedBwdCalc : REAL := 45.0 (* maximum speed for nozzle bwd (calculated) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed calc. bwd Max. speed calc. bwd
;
 sv_rMaxSpeedFwd : REAL := 45.0 (* maximum speed for nozzle fwd (user) *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed forward Max. speed forward
;
 sv_rMaxSpeedBwd : REAL := 45.0 (* maximum speed for nozzle bwd (user) *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed backward Max. speed backward
;
 sv_rMaxSpeedFwdCalib : REAL := 0.0
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdCalc    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed forward Max. speed forward
;
 sv_rMaxSpeedBwdCalib : REAL := 0.0
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwdCalc    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed backward Max. speed backward
;
 sv_rMaxPressureFwd : REAL := 145.0 (* maximum force for injection *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT ContactForce  %ABSREL NoRelative ;
 sv_rMaxPressureBwd : REAL := 145.0 (* maximum force for decompression *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT ContactForce  %ABSREL NoRelative ;
 sv_bTransducerAvailable : BOOL
    ;
 sv_bNozzleFwd : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Nozzle fwd Nozzle fwd
;
 sv_bNozzleBwd : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Nozzle bwd Nozzle bwd
;
 sv_NozzleBwdMode : tnNozzleBackMode := nBeforeMoldOpen (* option of nozzle back movement in autocycle *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT NozzleBackMode 
// Nozzle back mode Nozzle back mode
;
 sv_bNozzleAdjHMI : BOOL (* hmi can start/stop auto nozzle adjust with this SV *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT OnOff 
// Auto nozzle adjust Auto nozzle adjust
;
 sv_dSetStandstillDetectionTime : TIME := t#5s (* standstill detection time *)
 %PLAUSIBILITY t#1s..t#999s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Standstill Standstill detection time
;
 sv_dMaxNozzleAdjustTime : TIME := t#5m (* Max nozzle adjusting monitor time *)
 %PLAUSIBILITY t#0s..t#10m    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Monitor time Nozzle adjusting monitor time
;
 sv_dActNozzleAdjustTime : TIME (* Act. nozzle adjusting time  *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_rNozzlePositionOffset : REAL (* Position offset *)
   RETAIN ;
 sv_bContactPointDetected : BOOL (* flag: nozzle zero position detected *)
   RETAIN ;
 sv_rPosOffsetTolerance : REAL := 1.0 (* Tolerance in mm for new position offset of contact point *)
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_dNozzleFwdContactFSet : TIME := t#1s (* set time for output of nozzle fwd pressure build up movement *)
 %PLAUSIBILITY t#0.0s..t#999.9s    RETAIN  %VARIABLE_GROUP VG_MoldData  %LIST_GROUP LG_NozzleForceBuildup(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Force build up time Contact force build up time
;
 sv_dNozzleFwdContactFAct : TIME (* act. set time for output of nozzle fwd pressure build up movement *)
     %VARIABLE_GROUP VG_Nozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. force build up time Act. contact force build-up time
;
 sv_rNozzleFwdPosition : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Stroke 
// Nozzle fwd position Nozzle fwd target position
;
 sv_rNozzleStrokePlaus : REAL (* Nozzle stroke - Nozzle Position offset  *)
    ;
 sv_dActPressureBuildUpTime : TIME (* actual time for nozzle fwd pressure build up *)
     %UPDATE_CYCLE "Fast";
 sv_dPreValveCloseTime : TIME := t#50ms (* depending on this time the do_NozzleFwd will close before sv_dNozzleFwdContactFSet is over *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %FORMAT fmt60 ;
 sv_bPressBuildUpActive : BOOL (* TRUE: pressure build up is active *)
    ;
 sv_iActiveStageFwd : DINT (* active profile stage nozzle fwd *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iActiveStageBwd : DINT (* active profile stage nozzle fwd *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_CalculatedProfileFwd : tCalculatedProfiles
     %ABSREL Forward 
%ELEMENT sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT ContactForce 
%ELEMENT sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileBwd : tCalculatedProfiles
     %ABSREL Backward 
%ELEMENT sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT ContactForce 
%ELEMENT sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_RequiredPumpsFwd : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=7000)
    
%ELEMENT sv_RequiredPumpsFwd.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Nozzle fwd Nozzle fwd
;
 sv_RequiredPumpsBwd : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=7001)
    
%ELEMENT sv_RequiredPumpsBwd.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Nozzle bwd Nozzle bwd
;
 sv_HydrMaxValuesFwd : tsHydrMaxValues (* hydraulic max values for nozzle fwd *)
    ;
 sv_HydrMaxValuesBwd : tsHydrMaxValues (* hydraulic max values for nozzle bwd *)
    ;
 sv_rSmoothFactor : REAL := 0.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Smooth factor nozzle Smooth factor nozzle
;
%END

%SYSTEM_ALARM
  erMaxNozzleAdjTimeExc
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Maximum Nozzle Adjust Time Exceeded{#]The maximum time supervision for nozzle \u000aadjustment has been exceeded.{#]For nozzle forward movement it is necessary to check the forward contact \u000apoint by position. In order to do so the zero position has to be detected first. \u000aThis is called auto nozzle adjust. In this process the nozzle is moving forward \u000awith its setup mode output settings until a standstill is detected. When the setting\u000afor maximum supervision time is too low, the movement might not finish the \u000aadjustment before exceeding the time limit.{#]Increase the {Nozzle1.sv_dMaxNozzleAdjustTime} before retrying the {Nozzle1.sv_bNozzleAdjHMI}.\u000a<br>Also check the setup mode output settings ({Nozzle1.sv_ConstFwdSetup.Pressure.Output.rOutputValue:c:contact force} / {Nozzle1.sv_ConstFwdSetup.Velocity.Output.rOutputValue:c:velocity}) for nozzle \u000aforward movement.
 ;
  erNozzleAdjustFinished
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Nozzle Adjustment finished successfully{#]Nozzle adjustment has finished successfully.{#]This is just a message.The process of automatic nozzle adjustment finished successfully. During a nozzle forward movement a timeout has been detected, representing the contact point where the nozzle position should be 0. The measured nozzle position is stored as an offset for future nozzle movements.{#]This is just a message, no action required.<br><br>\u000aOnce confirmed the alarm message will disappear.
 ;
  erNozzleAdjustAborted
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Nozzle Adjustment Aborted{#]Nozzle adjustment was aborted before a \u000astandstill could be detected.{#]This is just a message. When automatic nozzle adjustment is active the user \u000acan stop the adjustment. If this is the case this alarm is raised.{#]This is just a message, no action required.<br><br>\u000aOnce confirmed the alarm message will disappear.
 ;
  erContactPointOutOfTolerance
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Nozzle Zero-position out of tolerance - new adjustment necessary{#]The nozzle forward movement reached \u000aa timeout while the zero-position tolerance \u000arange couldn't be reached.{#]At the end of nozzle forward movement the criteria of reaching the target \u000azero-position is not met. Nozzle forward stopped, but the zero-position is not \u000areached within the tolerance. Most likely the zero-position is not calibrated \u000acorrectly (anymore).{#]Try to reach nozzle zero-position with a manual and or setup \u000aoperation mode nozzle forward movement.<br>\u000aIf the contact point cannot be reached go to operation mode \u000asetup and perform a {Nozzle1.sv_bNozzleAdjHMI}.
 ;
  erContactPointNotReached
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Nozzle Zero-position not reached{#]The nozzle cannot reach the zero \u000aposition.{#]At the end of nozzle forward movement the criteria of reaching the target \u000azero-position is not met. Nozzle forward stopped, but the zero-position is not \u000areached.{#]Check the nozzle forward output settings and make sure the \u000acontact point can be reached with these settings. \u000aTry to reach nozzle zero-position with a manual and or setup \u000aoperation mode nozzle forward movement.<br>\u000aIf the contact point cannot be reached go to operation mode \u000asetup and perform a {Nozzle1.sv_bNozzleAdjHMI}.
 ;
  erContactPointNotDetected
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Nozzle Zero-position not detected{#]One time detection of nozzle zero \u000aposition is required.{#]For nozzle forward movement it is necessary to check the forward contact \u000apoint by position. In order to do so the zero position has to be detected first. \u000aThis is called auto nozzle adjust. If no auto nozzle adjust has been performed \u000abefore and a nozzle forward profile movement is started, this alarm is raised.{#]Go to operation mode setup and perform a {Nozzle1.sv_bNozzleAdjHMI}.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
79 
@SysVar @RT(23)sv_NozzlePosMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(23)sv_NozzlePosMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_NozzlePosMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_NozzlePosMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzlePosMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzlePosMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzlePosMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rNozzlePosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)actual position of nozzle 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(3) @RT(0) 
@RT(15)Nozzle position @RT(15)Nozzle position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rNozzlePosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)actual position of nozzle 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(3) @RT(0) 
@RT(15)Nozzle position @RT(15)Nozzle position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rNozzleVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual speed of nozzle 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Nozzle velocity @RT(15)Nozzle velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rNozzleVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)actual position of nozzle 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Nozzle velocity @RT(15)Nozzle velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rPressureAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rPressureAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rVelocityAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rVelocityAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)actual output velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_iActiveStage @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)actual active stage of profile output 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_iActiveStage @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)actual active stage of profile output 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ConstFwdSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(165)(Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0))) @RT(63)constant output parameters of nozzle fwd movement in setup mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
8 
@AttrSym @RT(16)sv_ConstFwdSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(63)constant output parameters of nozzle fwd movement in setup mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstFwdSetup.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Forward force @RT(13)Forward force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstFwdSetup.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstFwdSetup.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstFwdSetup.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstFwdSetup.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Forward velocity @RT(12)Fwd Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstFwdSetup.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstFwdSetup.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ConstFwdContactF @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(163)(Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=500.0),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=500.0),PreOutput:=(rRamp:=1000.0))) @RT(76)constant output parameters of nozzle fwd contact pressure build-up movement  
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
8 
@AttrSym @RT(19)sv_ConstFwdContactF @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(63)constant output parameters of nozzle fwd movement in setup mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ConstFwdContactF.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Forward contact force @RT(21)Forward contact force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstFwdContactF.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Contact force ramp @RT(18)Contact force ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ConstFwdContactF.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdContactF.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ConstFwdContactF.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Forward contact velocity @RT(20)Fwd contact velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstFwdContactF.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Contact force ramp @RT(18)Contact force ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ConstFwdContactF.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ramp contact pressure @RT(27)Ramp contact pressure setup @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_ConstFwdStage1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(233)(Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rOutputValue:=0.0,rRamp:=1000.0),rMinOutput:=5.0),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rOutputValue:=0.0,rRamp:=1000.0),rMinOutput:=5.0)) @RT(95)constant output parameters of nozzle fwd movement before limit switch is touched in manual mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(17)sv_ConstFwdStage1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(95)constant output parameters of nozzle fwd movement before limit switch is touched in manual mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstFwdStage1.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)10.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Force before limit switch @RT(25)Force before limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdStage1.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Ramp fwd before limit switch @RT(28)Ramp fwd before limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_ConstFwdStage1.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstFwdStage1.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)10.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Velocity before limit switch @RT(28)Velocity before limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdStage1.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Ramp fwd before limit switch @RT(28)Ramp fwd before limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_ConstFwdStage1.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_ConstFwdStage2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(197)(Velocity:=(Output:=(rOutputValue:=7.0,rRamp:=1000.0),PreOutput:=(rOutputValue:=0.0,rRamp:=1000.0),rMinOutput:=5.0),Pressure:=(Output:=(rOutputValue:=7.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0))) @RT(155)constant output parameters of nozzle fwd movement after limit switch is touched in manual mode (must be FAST Retain bcause of cyclical change in AutoCycle) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(17)sv_ConstFwdStage2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(94)constant output parameters of nozzle fwd movement after limit switch is touched in manual mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstFwdStage2.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Force after limit switch @RT(24)Force after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdStage2.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Ramp fwd after limit switch @RT(27)Ramp fwd after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_ConstFwdStage2.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstFwdStage2.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Velocity after limit switch @RT(27)Velocity after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdStage2.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Ramp fwd after limit switch @RT(27)Ramp fwd after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_ConstFwdStage2.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_NozzleFwdProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(315)(Profile:=(Points:=(rStartPos:=300.0),iNoOfPoints:=2),rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=100.0,rMaxRampVel:=100.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageFwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd) @RT(30)profile of nozzle fwd movement 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
13 
@AttrSym @RT(19)sv_NozzleFwdProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)profile of nozzle fwd movement 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_NozzleFwdProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)(iNoOfPoints:=3) @RT(16)movement profile 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(47)NozzleGeneral.hmi.NozzleFwdProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleFwdProfVis.Profile.Points @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_NozzleFwdProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)ramp at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_NozzleFwdProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)pressure at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_NozzleFwdProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)start position 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_NozzleFwdProfVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ramp for speed for this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_NozzleFwdProfVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)flow at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_NozzleFwdProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)3 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_NozzleFwdProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. ramp forward @RT(17)Max. ramp forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_NozzleFwdProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. ramp forward @RT(17)Max. ramp forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleFwdProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Pressure 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_NozzleFwdProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Velocity 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dNozzleFwdStage2Set @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#1s @RT(67)time for output of nozzle fwd movement after limitswitch is touched 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(16)t#0.0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(17)LG_NozzleFwd(1,1) @RT(0) 
@RT(23)Time after limit switch @RT(23)Time after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dNozzleFwdStage2Set @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)time for output of nozzle fwd movement after limitswitch is touched 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(16)t#0.0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(17)LG_NozzleFwd(1,1) @RT(0) 
@RT(23)Time after limit switch @RT(23)Time after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dNozzleFwdStage2Act @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)time for output of nozzle fwd movement after limitswitch is touched 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Act. time after limit switch @RT(28)Act. time after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dNozzleFwdStage2Act @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)time for output of nozzle fwd movement after limitswitch is touched 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Act. time after limit switch @RT(28)Act. time after limit switch @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_ConstBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(197)(Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0),rMinOutput:=5.0),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0),rMinOutput:=5.0)) @RT(64)constant output parameters of nozzle bwd movement in manual mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(11)sv_ConstBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(64)constant output parameters of nozzle bwd movement in manual mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConstBwd.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ConstBwd.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Backward ramp @RT(13)Backward ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstBwd.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConstBwd.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ConstBwd.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Backward ramp @RT(13)Backward ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstBwd.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ConstBwdSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(165)(Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=1000.0),PreOutput:=(rRamp:=1000.0))) @RT(63)constant output parameters of nozzle bwd movement in setup mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(16)sv_ConstBwdSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(63)constant output parameters of nozzle bwd movement in setup mode 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstBwdSetup.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Backward force @RT(14)Backward force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstBwdSetup.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstBwdSetup.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstBwdSetup.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Backward velocity @RT(17)Backward velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstBwdSetup.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstBwdSetup.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_NozzleBwdProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(288)(Profile:=(iNoOfPoints:=2),rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=100.0,rMaxRampVel:=100.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageBwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwd) @RT(30)profile of nozzle bwd movement 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(19)sv_NozzleBwdProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)profile of nozzle bwd movement 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_NozzleBwdProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)(iNoOfPoints:=3) @RT(16)movement profile 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(47)NozzleGeneral.hmi.NozzleBwdProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_NozzleBwdProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)ramp at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_NozzleBwdProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)pressure at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_NozzleBwdProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)start position 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_NozzleBwdProfVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ramp for speed for this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_NozzleBwdProfVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)flow at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_NozzleBwdProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)3 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_NozzleBwdProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. ramp backward @RT(18)Max. ramp backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_NozzleBwdProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. ramp backward @RT(18)Max. ramp backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleBwdProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Pressure 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_NozzleBwdProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Velocity 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_NozzleLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=300.0))) @RT(70)linearisation table for conversion of transducer voltage into position 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(15)sv_NozzleLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(70)linearisation table for conversion of transducer voltage into position 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_NozzleLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_NozzleLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rNozzleStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_NozzleLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rNozzleStroke @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(39)stroke between fwd and bwd end position 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. nozzle stroke @RT(18)Max. nozzle stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rNozzleStroke @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(39)stroke between fwd and bwd end position 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. nozzle stroke @RT(18)Max. nozzle stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bFwdDuringPlast @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)hold nozzle fwd during plasticizing 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Nozzle hold during plast @RT(29)Nozzle hold during plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bFwdDuringPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)hold nozzle fwd during plasticizing 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Nozzle hold during plast @RT(29)Nozzle hold during plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bFwdDuringInject @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)hold nozzle fwd during inject 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Nozzle hold during inject @RT(25)Nozzle hold during inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bFwdDuringInject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)hold nozzle fwd during inject 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Nozzle hold during inject @RT(25)Nozzle hold during inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_NozzleBwdTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(24)set times for nozzle bwd 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(20)sv_NozzleBwdTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)set times for nozzle bwd 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_NozzleBwdTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. backward time @RT(25)Max. nozzle backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleBwdTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Backward delay @RT(21)Nozzle backward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_NozzleBwdTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Backward delay pump @RT(26)Nozzle backward delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_NozzleBwdTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)delay time before movement stop, between pump stop and valve close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Backward delay valve @RT(27)Nozzle backward delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_NozzleBwdTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)act times for nozzle bwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_NozzleBwdTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)act times for nozzle bwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleBwdTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Act. backward delay @RT(26)Act. nozzle backward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_NozzleBwdTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Nozzle @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Act. backward time @RT(25)Act. nozzle backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleBwdTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Last backward time @RT(25)Last nozzle backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_NozzleFwdTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(24)set times for nozzle fwd 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(20)sv_NozzleFwdTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)set times for nozzle fwd 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_NozzleFwdTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max.forward time @RT(24)Max. nozzle forward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleFwdTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Forward delay @RT(20)Nozzle forward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_NozzleFwdTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Forward delay pump @RT(25)Nozzle forward delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_NozzleFwdTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)delay time before movement stop, between pump stop and valve close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Forward delay valve @RT(26)Nozzle forward delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_NozzleFwdTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)act times for nozzle fwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_NozzleFwdTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)act times for nozzle fwd 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleFwdTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Act. forward delay @RT(25)Act. nozzle forward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_NozzleFwdTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Nozzle @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. forward time @RT(24)Act. nozzle forward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_NozzleFwdTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Last forward time @RT(24)Last nozzle forward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MovementMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnMovementMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)nLimitSwitchDependent @RT(61)Nozzle Movement with Limitswitch or with position measurement 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(10)NozzleMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Nozzle movement mode @RT(20)Nozzle movement mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_MovementMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)enPositionDependent @RT(61)Nozzle Movement with Limitswitch or with position measurement 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(10)NozzleMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Nozzle movement mode @RT(20)Nozzle movement mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_NozzleMovementMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tnNozzleMovementMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(27)nNozzleMovementModePosition @RT(90)nozzle movement depending on AppCo settings (transducer or limit switch) or time dependent 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(18)NozzleMovementMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Nozzle movement @RT(15)Nozzle movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_NozzleMovementMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)enPositionDependent @RT(61)Nozzle Movement with Limitswitch or with position measurement 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(18)NozzleMovementMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Nozzle movement @RT(15)Nozzle movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dMoveBwdTimeSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#1s @RT(42)time of nozzle bwd movement in manual mode 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(17)LG_NozzleBwd(1,1) @RT(0) 
@RT(13)Backward time @RT(13)Backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dMoveBwdTimeSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)time of nozzle bwd movement in manual mode 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(17)LG_NozzleBwd(1,1) @RT(0) 
@RT(13)Backward time @RT(13)Backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MinOutputFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(15)sv_MinOutputFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputFwd.rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output fwd @RT(23)Min. profile output fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputFwd.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output fwd @RT(23)Min. profile output fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MinOutputBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(15)sv_MinOutputBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputBwd.rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(12)ContactForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output bwd @RT(23)Min. profile output bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputBwd.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output bwd @RT(23)Min. profile output bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bOutputActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Nozzle output active @RT(20)Nozzle output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bOutputActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Nozzle output active @RT(20)Nozzle output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bPreOutputReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)PreOutput is ready 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Pre output ready @RT(16)Pre output ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bPreOutputReady @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)PreOutput is ready 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Pre output ready @RT(16)Pre output ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bDoTransducerCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Do transducer calibration @RT(25)Do transducer calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bDoTransducerCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Do transducer calibration @RT(25)Do transducer calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bTransducerError @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Transducer error @RT(16)Transducer error @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bTransducerError @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Transducer error @RT(16)Transducer error @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_TmpLintabPoint @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Lintab_Point @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(13)sv_CalibState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(198)(pLintabPoints:=@%FU.sv_NozzleLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_NozzleLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rNozzleStroke,iOrder:=30,Group:=tnCalibGroup_Transducer) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(13)sv_CalibState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_CalibState.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_CalibState.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_CalibState.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Nozzle @RT(17)Nozzle transducer @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_CalibState.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_TransducerCalibData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsTransducerCalibData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(105)(Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveFwd,Id2:=cMoveBwd,bReverse:=FALSE,prPos2:=@%FU.sv_rNozzleStroke) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(15)sv_CylinderData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsCylinderData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(88)(rCylinderDiameter:=100.0,rPistonRodDiameter:=30.0,iNumCylinders:=2,bUseSmallSize:=TRUE) @RT(26)parameters of the cylinder 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(15)sv_CylinderData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(68)(rCylinderDiameter:=100.0,rPistonRodDiameter:=30.0,iNumCylinders:=2) @RT(26)parameters of the cylinder 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_CylinderData.bUseSmallSize @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Move forward by ring area @RT(27)Move forward by piston area @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_CylinderData.iNumCylinders @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Number of cylinders @RT(19)Number of cylinders @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_CylinderData.rCylinderDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)10.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cylinder diameter @RT(17)Cylinder diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_CylinderData.rPistonRodDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)3.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Piston rod diameter @RT(19)Piston rod diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutFwdP @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(16)sv_LintabOutFwdP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdP.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)ContactForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutFwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=45.0,rY:=100.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(16)sv_LintabOutFwdV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdV.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdV.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutBwdP @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(16)sv_LintabOutBwdP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdP.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)ContactForce @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutBwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=45.0,rY:=100.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(16)sv_LintabOutBwdV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdV.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdV.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rMaxSpeedReducePercent @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(49)reduce calculated max speed with this percentage  
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max.speed reduce factor @RT(23)Max.speed reduce factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMaxSpeedReducePercent @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max.speed reduce factor @RT(23)Max.speed reduce factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaxSpeedFwdCalc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)45.0 @RT(41)maximum speed for nozzle fwd (calculated) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. fwd @RT(20)Max. speed calc. fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxSpeedFwdCalc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)maximum speed for mold close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. fwd @RT(20)Max. speed calc. fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaxSpeedBwdCalc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)45.0 @RT(41)maximum speed for nozzle bwd (calculated) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. bwd @RT(20)Max. speed calc. bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxSpeedBwdCalc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)maximum speed for mold open 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. bwd @RT(20)Max. speed calc. bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxSpeedFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)45.0 @RT(35)maximum speed for nozzle fwd (user) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)maximum speed for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxSpeedBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)45.0 @RT(35)maximum speed for nozzle bwd (user) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)maximum speed for decompression 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxSpeedFwdCalib @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxSpeedFwdCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxSpeedBwdCalib @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedBwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxSpeedBwdCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedBwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxPressureFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)145.0 @RT(27)maximum force for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)ContactForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)maximum force for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)ContactForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxPressureBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)145.0 @RT(31)maximum force for decompression 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)ContactForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)maximum force for decompression 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)ContactForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bTransducerAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(13)sv_bNozzleFwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Nozzle fwd @RT(10)Nozzle fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bNozzleFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Nozzle fwd @RT(10)Nozzle fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bNozzleBwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Nozzle bwd @RT(10)Nozzle bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bNozzleBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Nozzle bwd @RT(10)Nozzle bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_NozzleBwdMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tnNozzleBackMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(15)nBeforeMoldOpen @RT(43)option of nozzle back movement in autocycle 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(14)NozzleBackMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Nozzle back mode @RT(16)Nozzle back mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_NozzleBwdMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(8)enNormal @RT(43)option of nozzle back movement in autocycle 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(14)NozzleBackMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Nozzle back mode @RT(16)Nozzle back mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bNozzleAdjHMI @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)hmi can start/stop auto nozzle adjust with this SV 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Auto nozzle adjust @RT(18)Auto nozzle adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bNozzleAdjHMI @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)hmi can start/stop auto nozzle adjust with this SV 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Auto nozzle adjust @RT(18)Auto nozzle adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_dSetStandstillDetectionTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#5s @RT(25)standstill detection time 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#1s..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Standstill @RT(25)Standstill detection time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_dSetStandstillDetectionTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#10s @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)t#1s..t#999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Standstill @RT(25)Standstill detection time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dMaxNozzleAdjustTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#5m @RT(33)Max nozzle adjusting monitor time 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10m @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Monitor time @RT(29)Nozzle adjusting monitor time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dMaxNozzleAdjustTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#5m @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10m @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Monitor time @RT(29)Nozzle adjusting monitor time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dActNozzleAdjustTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)Act. nozzle adjusting time  
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dActNozzleAdjustTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rNozzlePositionOffset @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)Position offset 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rNozzlePositionOffset @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bContactPointDetected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)flag: nozzle zero position detected 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bContactPointDetected @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)flag: nozzle position adjusted 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rPosOffsetTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(56)Tolerance in mm for new position offset of contact point 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rPosOffsetTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)Tolerance for new position offset of J-Point 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_dNozzleFwdContactFSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#1s @RT(60)set time for output of nozzle fwd pressure build up movement 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(16)t#0.0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(26)LG_NozzleForceBuildup(1,1) @RT(0) 
@RT(19)Force build up time @RT(27)Contact force build up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_dNozzleFwdContactFSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)time for output of nozzle fwd movement after limitswitch is touched 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(16)t#0.0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(26)LG_NozzleForceBuildup(1,1) @RT(0) 
@RT(19)Force build up time @RT(27)Contact force build up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_dNozzleFwdContactFAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)act. set time for output of nozzle fwd pressure build up movement 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Nozzle @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Act. force build up time @RT(32)Act. contact force build-up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_dNozzleFwdContactFAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)time for output of nozzle fwd movement after limitswitch is touched 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Nozzle @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Act. force build up time @RT(32)Act. contact force build-up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rNozzleFwdPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Nozzle fwd position @RT(26)Nozzle fwd target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rNozzleFwdPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Nozzle fwd position @RT(26)Nozzle fwd target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rNozzleStrokePlaus @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)Nozzle stroke - Nozzle Position offset  
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(26)sv_dActPressureBuildUpTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)actual time for nozzle fwd pressure build up 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_dActPressureBuildUpTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)actual time for nozzle fwd pressure build up 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_dPreValveCloseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#50ms @RT(90)depending on this time the do_NozzleFwd will close before sv_dNozzleFwdContactFSet is over 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt60 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_dPreValveCloseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#50ms @RT(90)depending on this time the do_NozzleFwd will close before sv_dNozzleFwdContactFSet is over 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt60 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bPressBuildUpActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)TRUE: pressure build up is active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_iActiveStageFwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)active profile stage nozzle fwd 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iActiveStageFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)active profile stage mold close (fwd) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iActiveStageBwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)active profile stage nozzle fwd 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iActiveStageBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)active profile stage mold open (bwd) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_CalculatedProfileFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(23)sv_CalculatedProfileFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)ContactForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_CalculatedProfileBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(23)sv_CalculatedProfileBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)ContactForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_RequiredPumpsFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=7000) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(33)sv_RequiredPumpsFwd.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Nozzle fwd @RT(10)Nozzle fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_RequiredPumpsBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=7001) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(33)sv_RequiredPumpsBwd.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Nozzle bwd @RT(10)Nozzle bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_HydrMaxValuesFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)hydraulic max values for nozzle fwd 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)sv_HydrMaxValuesBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)hydraulic max values for nozzle bwd 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_rSmoothFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Smooth factor nozzle @RT(20)Smooth factor nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rSmoothFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Smooth factor nozzle @RT(20)Smooth factor nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
6 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erMaxNozzleAdjTimeExc @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(908)Maximum Nozzle Adjust Time Exceeded{#]The maximum time supervision for nozzle \u000aadjustment has been exceeded.{#]For nozzle forward movement it is necessary to check the forward contact \u000apoint by position. In order to do so the zero position has to be detected first. \u000aThis is called auto nozzle adjust. In this process the nozzle is moving forward \u000awith its setup mode output settings until a standstill is detected. When the setting\u000afor maximum supervision time is too low, the movement might not finish the \u000aadjustment before exceeding the time limit.{#]Increase the {Nozzle1.sv_dMaxNozzleAdjustTime} before retrying the {Nozzle1.sv_bNozzleAdjHMI}.\u000a<br>Also check the setup mode output settings ({Nozzle1.sv_ConstFwdSetup.Pressure.Output.rOutputValue:c:contact force} / {Nozzle1.sv_ConstFwdSetup.Velocity.Output.rOutputValue:c:velocity}) for nozzle \u000aforward movement. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erNozzleAdjustFinished @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(498)Nozzle Adjustment finished successfully{#]Nozzle adjustment has finished successfully.{#]This is just a message.The process of automatic nozzle adjustment finished successfully. During a nozzle forward movement a timeout has been detected, representing the contact point where the nozzle position should be 0. The measured nozzle position is stored as an offset for future nozzle movements.{#]This is just a message, no action required.<br><br>\u000aOnce confirmed the alarm message will disappear. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erNozzleAdjustAborted @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(361)Nozzle Adjustment Aborted{#]Nozzle adjustment was aborted before a \u000astandstill could be detected.{#]This is just a message. When automatic nozzle adjustment is active the user \u000acan stop the adjustment. If this is the case this alarm is raised.{#]This is just a message, no action required.<br><br>\u000aOnce confirmed the alarm message will disappear. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erContactPointOutOfTolerance @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(689)Nozzle Zero-position out of tolerance - new adjustment necessary{#]The nozzle forward movement reached \u000aa timeout while the zero-position tolerance \u000arange couldn't be reached.{#]At the end of nozzle forward movement the criteria of reaching the target \u000azero-position is not met. Nozzle forward stopped, but the zero-position is not \u000areached within the tolerance. Most likely the zero-position is not calibrated \u000acorrectly (anymore).{#]Try to reach nozzle zero-position with a manual and or setup \u000aoperation mode nozzle forward movement.<br>\u000aIf the contact point cannot be reached go to operation mode \u000asetup and perform a {Nozzle1.sv_bNozzleAdjHMI}. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erContactPointNotReached @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(612)Nozzle Zero-position not reached{#]The nozzle cannot reach the zero \u000aposition.{#]At the end of nozzle forward movement the criteria of reaching the target \u000azero-position is not met. Nozzle forward stopped, but the zero-position is not \u000areached.{#]Check the nozzle forward output settings and make sure the \u000acontact point can be reached with these settings. \u000aTry to reach nozzle zero-position with a manual and or setup \u000aoperation mode nozzle forward movement.<br>\u000aIf the contact point cannot be reached go to operation mode \u000asetup and perform a {Nozzle1.sv_bNozzleAdjHMI}. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erContactPointNotDetected @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(500)Nozzle Zero-position not detected{#]One time detection of nozzle zero \u000aposition is required.{#]For nozzle forward movement it is necessary to check the forward contact \u000apoint by position. In order to do so the zero position has to be detected first. \u000aThis is called auto nozzle adjust. If no auto nozzle adjust has been performed \u000abefore and a nozzle forward profile movement is started, this alarm is raised.{#]Go to operation mode setup and perform a {Nozzle1.sv_bNozzleAdjHMI}. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
