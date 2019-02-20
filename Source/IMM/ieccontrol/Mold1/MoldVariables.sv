%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, OnOff
, fmt22
, fmt31
, Stroke
, fmt41
, Speed
, NoRelative
, ClampingForce
, Forward
, fmt40
, LG_ActPos
, VG_MoldData
, Percent
, Pressure
, fmt30
, MaxRampPressure
, MaxRampVelocity
, VG_Dummy
, Backward
, UseNoUse
, Voltage
, Time
, VG_Mold
, VG_SequenceData
, VG_SPC_POST
, CalibGroup
, fmtCalibState
, fmt10
, fmt23
, fmt50
, LG_ActMold
, TimeMs
, fmt20

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_MeasureMonitoring
, KAPPL_VisProfile
, KAPPL_LintabData_2P
, tsMinOutput
, tsVelPre
, tsSetTimes
, tsActTimes
, KCTRL_Lintab_Point
, tsCalibMovement
, tsTransducerCalibData
, tsCylinderData
, KAPPL_LintabData
, tsInterCondList
, tsDerivationEstimateParam
, tsClampForces
, tyInstanceListArray
, tCalculatedProfiles
, tsRequiredPumps
, tsHydrMaxValues
, KCTRL_YXGen_RampType_Square
, KCTRL_YXGen_RampType_Linear
, tnCalibGroup_Transducer
, cMoveFwd
, cMoveBwd
, tnCalibGroup_LintabOnly
, cLevelStartupTechnican
, cLevelProduction
, cLevelProcessOperator
, cLevelServiceEngineer
, cLevelSuperUser
, cPlausMaxRampPressureMax
, cPlausMaxRampPressureMin
, cPlausMaxRampVelocityMax
, cPlausMaxRampVelocityMin

END_IMPORT

%SYSTEMVAR_DECL
  sv_ToggleLeverMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ToggleLeverMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_ToggleLeverMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_ToggleLeverMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_ToggleLeverMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_ToggleLeverMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_MoldPosMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_MoldPosMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_MoldPosMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_MoldPosMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_MoldPosMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_MoldPosMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_rToggleLeverPosition : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Stroke 
// Toggle lever position Toggle lever position
;
 sv_rToggleLeverPositionAbs : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Stroke 
// Mold absolute position Mold absolute position
 %UPDATE_CYCLE "Fast";
 sv_rToggleLeverVelocity : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Toggle lever velocity Toggle lever velocity
;
 sv_rToggleLeverStroke : REAL := 600.0 (* Opening Stroke of toggle lever *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Max.toggle lever stroke Max. toggle lever stroke
;
 sv_rMoldStroke : REAL := 600.0 (* Opening Stroke of Mold *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Max. mold stroke Max. mold stroke
;
 sv_rMaxMoldStroke : REAL := 600.0 (* Maximum Stroke of Mold (without a mounted mold); relevant for direct lock and 2 platen IMM´s *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Max. mold stroke Max. mold stroke
;
 sv_rPressureAmpActivationForce : REAL (* Activation threshold for pressure amplifier *)
 %PLAUSIBILITY 0.0..%FU.sv_ClampForce.rMaxClampForce    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT ClampingForce  %ABSREL Forward 
// Amplifier activation force Amplifier activation force
;
 sv_rMoldPosition : REAL
     %LIST_GROUP LG_ActPos(1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Stroke 
// Mold position Mold position
 %UPDATE_CYCLE "Fast";
 sv_rPressureAbs : REAL
    ;
 sv_rVelocityAbs : REAL
    ;
 sv_rPressure : REAL
    ;
 sv_rVelocity : REAL
    ;
 sv_MoldFwdProfVisSrc : KAPPL_VisProfile := (Profile:=(Points:=17((rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=600.0)),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=100.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=50.0,rVelRamp:=100.0,rStartPos:=0.0),iNoOfPoints:=4),RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageFwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd)
   RETAIN  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_MoldFwdProfVisSrc.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS MoldGeneral.hmi.MoldCloseProgrammedVisControl 
%ELEMENT sv_MoldFwdProfVisSrc.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldFwdProfVisSrc.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_MoldFwdProfVisSrc.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_MoldFwdProfVisSrc.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldFwdProfVisSrc.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Velocity Velocity

%ELEMENT sv_MoldFwdProfVisSrc.Profile.iNoOfPoints
 %PLAUSIBILITY 3..5     
// Stages Stages

%ELEMENT sv_MoldFwdProfVisSrc.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Max. ramp close Max. pressure ramp close

%ELEMENT sv_MoldFwdProfVisSrc.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp close Max. velocity ramp close

%ELEMENT sv_MoldFwdProfVisSrc.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldFwdProfVisSrc.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_MoldFwdProfVis : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=600.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=100.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=50.0,rVelRamp:=100.0,rStartPos:=0.0),iNoOfPoints:=4),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputPress:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=1000.0,rMaxRampVel:=1000.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_MoldFwdProfVis.Profile
     %VARIABLE_GROUP VG_Dummy 
%ELEMENT sv_MoldFwdProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldFwdProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_MoldFwdProfVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_MoldFwdProfVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldFwdProfVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Velocity Velocity

%ELEMENT sv_MoldFwdProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 3..5     
// Stages Stages

%ELEMENT sv_MoldFwdProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Max. ramp close Max. pressure ramp close

%ELEMENT sv_MoldFwdProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp close Max. velocity ramp close

%ELEMENT sv_MoldFwdProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldFwdProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_iActiveStage : DINT
    ;
 sv_MoldBwdProfVis : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=300.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=400.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=500.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=600.0),iNoOfPoints:=4),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputPress:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=1000.0,rMaxRampVel:=1000.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageBwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwd)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_MoldBwdProfVis.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS MoldGeneral.hmi.MoldOpenProgrammedVisControl 
%ELEMENT sv_MoldBwdProfVis.Profile.Points
    
%ELEMENT sv_MoldBwdProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldBwdProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_MoldBwdProfVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_MoldBwdProfVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldBwdProfVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_MoldBwdProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 1..5     
// Stages Stages

%ELEMENT sv_MoldBwdProfVis.bUseOffsetOptimizing
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Use adaptive mold open Use adaptive mold open

%ELEMENT sv_MoldBwdProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Max. ramp open Max. pressure ramp open

%ELEMENT sv_MoldBwdProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Max. ramp open Max. velocity ramp open

%ELEMENT sv_MoldBwdProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_MoldBwdProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_MoldLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=700.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MoldLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_MoldLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..%FU.sv_rMoldStroke      %FORMAT fmt41  %UNIT Stroke 
// Position Position

%ELEMENT sv_MoldLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// No. of points Number of points
;
 sv_ToggleLeverPosLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=700.0)))
     %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_ToggleLeverPosLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_ToggleLeverPosLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..%FU.sv_rToggleLeverStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Position Position

%ELEMENT sv_ToggleLeverPosLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30 
// No. of points Number of points
;
 sv_dMoldProtectTimeSet : TIME := t#5s
 %PLAUSIBILITY t#0s..t#999.9s    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Mold protect time Mold protect time
;
 sv_dMoldProtectTimeAct : TIME
     %VARIABLE_GROUP VG_Mold  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. mold protect time Actual mold protect time
 %UPDATE_CYCLE "Fast";
 sv_bFastClose : BOOL
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Fast close Use fast close
;
 sv_bFastOpen : BOOL
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Fast open Use fast open
;
 sv_bDoTransducerCalib : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

// Do transducer calibration Do transducer calibration
;
 sv_MinOutputFwd : tsMinOutput (* minimum output for mold close *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MinOutputFwd.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Forward 
// Min. profile output close Min. profile output pressure close

%ELEMENT sv_MinOutputFwd.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL Forward 
// Min. profile output close Min. profile output velocity close
;
 sv_MinOutputBwd : tsMinOutput (* minimum output for mold open *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MinOutputBwd.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Min. profile output open Min. profile output pressure open

%ELEMENT sv_MinOutputBwd.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL Backward 
// Min. profile output open Min. profile output velocity open
;
 sv_rFwdInterruptPosition : REAL (* Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) *)
    ;
 sv_rFwdInterruptAccel : REAL (* Acceleration after Interrupt Position for Mold Fwd Movement reached *)
    ;
 sv_rBwdInterruptDeaccel : REAL (* Deaacceleration to reach Interrupt Position for Mold Bwd Movement  *)
    ;
 sv_rFwdInterruptDeaccel : REAL (* Deaacceleration to reach Interrupt Position for Mold Fwd Movement  *)
    ;
 sv_rBwdInterruptPosition : REAL (* Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) *)
    ;
 sv_rBwdInterruptAccel : REAL (* Acceleration after Interrupt Position for Mold Bwd Movement reached *)
    ;
 sv_bOutputActive : BOOL (* Output is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Mold output active Mold output active
;
 sv_bPreOutputReady : BOOL (* PreOutput is ready *)
     %INPUT_LEVEL 16

// Pre output ready Pre output ready
;
 sv_ConstBwdVis : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=5000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=5000.0))) (* const output for mold open movement *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_ConstBwdVis.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Backward pressure Backward pressure

%ELEMENT sv_ConstBwdVis.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp Ramp pressure

%ELEMENT sv_ConstBwdVis.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_ConstBwdVis.Pressure.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstBwdVis.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Backward velocity Backward velocity

%ELEMENT sv_ConstBwdVis.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp Ramp velocity

%ELEMENT sv_ConstBwdVis.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
%ELEMENT sv_ConstBwdVis.Velocity.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
;
 sv_ConstFwdVis : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0)),Pressure:=(Output:=(rOutputValue:=10.0))) (* const output for mold close movement *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdVis.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Forward 
// Forward pressure Forward pressure

%ELEMENT sv_ConstFwdVis.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Forward 
// Ramp Ramp pressure

%ELEMENT sv_ConstFwdVis.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstFwdVis.Pressure.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstFwdVis.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Forward velocity Forward velocity

%ELEMENT sv_ConstFwdVis.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Ramp Ramp velocity

%ELEMENT sv_ConstFwdVis.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
%ELEMENT sv_ConstFwdVis.Velocity.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
;
 sv_bTransducerError : BOOL
    
// Transducer error Transducer error
;
 sv_MoldCloseTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_MoldCloseTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. close time Max. mold close time

%ELEMENT sv_MoldCloseTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Close delay Mold close delay

%ELEMENT sv_MoldCloseTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Pump on delay Pump on delay mold close

%ELEMENT sv_MoldCloseTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Valve close delay Valve close delay mold close
;
 sv_MoldCloseTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_MoldCloseTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. close delay Act. mold close delay

%ELEMENT sv_MoldCloseTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Mold  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. close time Act. mold close time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_MoldCloseTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last close time Last mold close time
;
 sv_MoldOpenTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_MoldOpenTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. open time Max. mold open time

%ELEMENT sv_MoldOpenTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Open delay Mold open delay

%ELEMENT sv_MoldOpenTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Pump on delay Pump on delay mold open

%ELEMENT sv_MoldOpenTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Valve close delay Valve close delay mold open
;
 sv_MoldOpenTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_MoldOpenTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. open delay Act. mold open delay

%ELEMENT sv_MoldOpenTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Mold,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. open time Act. mold open time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_MoldOpenTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last open time Last mold open time
;
 sv_TmpLintabPoint : KCTRL_Lintab_Point
    ;
 sv_CalibState : tsCalibMovement := (pLintabPoints:=@%FU.sv_MoldLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_MoldLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rMoldStroke,prInputSensor:=@%FU.ai_Position,iOrder:=20,Group:=tnCalibGroup_Transducer)
    
%ELEMENT sv_CalibState.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibState.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibState.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

// Mold Mold transducer

%ELEMENT sv_CalibState.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_ClampForceBuildUpTimeAct : TIME (* act build up time for clamp pressure *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Force build up time Act clamp force build up time
 %UPDATE_CYCLE "Fast";
 sv_ClampForceBuildUpTimeSet : TIME := T#0s (* set build up time for clamp pressure *)
 %PLAUSIBILITY t#0s..t#999.9s    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Force build up time Set clamp force build up time
;
 sv_ClampPressLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) (* lintab for converting clamp force from V to kN *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Clamp Sens. Clamp Force Sensor

%ELEMENT sv_ClampPressLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
 // Input voltage

%ELEMENT sv_ClampPressLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
 // Clamp Force

%ELEMENT sv_ClampPressLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// No. of points Number of points
;
 sv_ConstHiPressVis : tsVelPre (* const output for mold close high pressure movement *)
   RETAIN  %ABSREL Forward 
// Const hi press Const values high pressure

%ELEMENT sv_ConstHiPressVis.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstHiPressVis.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Forward 
%ELEMENT sv_ConstHiPressVis.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Forward 
%ELEMENT sv_ConstHiPressVis.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Forward ;
 sv_MoldLockDecompTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_MoldLockDecompTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. lock decomp delay Act. mold lock decomp delay

%ELEMENT sv_MoldLockDecompTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Mold,VG_SPC_POST  %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. lock decomp time Act. mold lock decomp time
 %UPDATE_CYCLE "Fast";
 sv_MoldLockDecompTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s) (* steg: Direct hydraulic locking *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_MoldLockDecompTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. lock decomp time Max. mold lock decomp time

%ELEMENT sv_MoldLockDecompTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#10s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Close delay Mold close delay

%ELEMENT sv_MoldLockDecompTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#10s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt22  %UNIT Time 
// Close delay pump Mold close delay pump
;
 sv_MoldLockTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_MoldLockTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. lock delay Act. mold lock delay

%ELEMENT sv_MoldLockTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Mold  %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. lock time Act. mold lock time
 %UPDATE_CYCLE "Fast";
 sv_MoldLockTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s) (* steg: Direct hydraulic locking *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_MoldLockTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. lock time Max. mold lock time

%ELEMENT sv_MoldLockTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#10s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Close delay Mold close delay

%ELEMENT sv_MoldLockTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#10s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt22  %UNIT Time 
// Close delay pump Mold close delay pump
;
 sv_bActivateLockDecompAftPlast : BOOL (* Activate lock decompression after plasticise *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Lock decomp after plast Lock decomp after plast
;
 sv_bLockDecompOK : BOOL (* decomp of clamp pressure finished *)
    ;
 sv_bLockDecompTimeOut : BOOL (* steg: Mold lock decompression timeout *)
     %INPUT_LEVEL 16

// Mold lock decomp timeout Mold lock decomp timeout
;
 sv_bMoldLockStageActive : BOOL (* mold lock stage active *)
    
// Lock stage acive Lock stage active
;
 sv_bMonitorClampPress : BOOL := FALSE
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Monitor clamp press Monitor clamp pressure
;
 sv_bClampForceBuildUpWithTime : BOOL (* use time dependent clamp force build up *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
;
 sv_bClampForceReached : BOOL (* Clamp force reached *)
    ;
 sv_bClampPressSensorError : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Clamp pressure sensor error Clamp pressure sensor error
;
 sv_TransducerCalibData : tsTransducerCalibData := (Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveFwd,Id2:=cMoveBwd,bReverse:=TRUE,prPos2:=@%FU.sv_rToggleLeverStroke)
    ;
 sv_bMoveMoldUntilEnd : BOOL
    ;
 sv_CylinderData : tsCylinderData := (rCylinderDiameter:=70.0,rPistonRodDiameter:=30.0,iNumCylinders:=1,bUseSmallSize:=FALSE)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_CylinderData.bMoveWithPlunger
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Mold close with plunger Mold close with plunger

%ELEMENT sv_CylinderData.bUseSmallSize
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Mold close by ring area Mold close by ring area

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

%ELEMENT sv_CylinderData.rPlungerDiameter
 %PLAUSIBILITY 0.0..999.9      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Plunger diameter Plunger diameter
;
 sv_LintabOutFwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rX
     %UNIT Pressure  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutFwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=200.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rX
     %UNIT Speed  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutBwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rX
     %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutBwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=200.0,rY:=100.0)))
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
 sv_rMaxSpeedFwdCalc : REAL := 200.0 (* maximum speed for mold close (calculated) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed calc. fwd Max. speed calc. fwd
;
 sv_rMaxSpeedBwdCalc : REAL := 200.0 (* maximum speed for mold open (calculated) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed calc. bwd Max. speed calc. bwd
;
 sv_rMaxSpeedFwd : REAL := 200.0 (* maximum speed for mold close *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed fwd Max. speed fwd
;
 sv_rMaxSpeedBwd : REAL := 200.0 (* maximum speed for mold open *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed bwd Max. speed bwd
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
 sv_rMaxPressureFwd : REAL := 145.0 (* maximum pressure for mold close *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Pressure  %ABSREL NoRelative ;
 sv_rMaxPressureBwd : REAL := 145.0 (* maximum pressure for mold open *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Pressure  %ABSREL NoRelative ;
 sv_bOpenMHUntilMoldHeightCalib : BOOL (* open until value specified in sv_rOpenPosForMHAdjust *)
    ;
 sv_bOpenMHUntilProtectStep : BOOL (* open until protect step position in Forward profile *)
    ;
 sv_rOpenPosForMHAdjust : REAL (* open until this toggle lever pos for mold height adjust *)
    ;
 sv_ToggleLeverLintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10000.0,rY:=10000.0))) (* lintab for toggleleverpos(x) -> platenpos(y) *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_ToggleLeverLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..%FU.sv_rToggleLeverStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Toggle lever Position Toggle lever Position

%ELEMENT sv_ToggleLeverLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..%FU.sv_rMoldStroke      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke 
// Platen position Platen position

%ELEMENT sv_ToggleLeverLintab.LintabPoints.uNoOfPoints
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Number of points Number of points
;
 sv_rMoldPosOffset : REAL (* Added to the actual moldposition, calculated by the clamppressure setting *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %FORMAT fmt41  %UNIT Stroke 
// Moldposition offset Moldposition offset
;
 sv_bOpenAfterProtect : BOOL (* open mold after mold protect *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Open after protect Open after mold protect
;
 sv_rMaxPressureProtect : REAL := 210.0 (* maximum pressure for mold protect stage *)
 %PLAUSIBILITY 0.0..%FU.sv_HydrMaxValuesClose.rMaxPressure    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT Pressure  %ABSREL Forward 
// Max. pressure mold protect Max. pressure mold protect
;
 sv_ToggleLeverLintabDerive : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=1.0),(rX:=1000.0,rY:=1.0))) (* derivation calculated from sv_ToggleLeverLintab *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
;
 sv_OpenInterstopDeadTime : TIME := T#0s
 %PLAUSIBILITY T#0s..T#1s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt23  %UNIT Time 
// Dead time Mold Inter Bwd Interstop dead time
;
 sv_OpenManualDelayTime : TIME := T#0s
 %PLAUSIBILITY T#0s..T#1s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt23  %UNIT Time 
// Delay Time Man Mld Bwd Manual delay time
;
 sv_CloseInterstopDeadTime : TIME := T#0s
 %PLAUSIBILITY T#0s..T#1s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt23  %UNIT Time 
// Dead time Mold Inter Fwd Interstop dead time
;
 sv_CloseManualDelayTime : TIME := T#0s
 %PLAUSIBILITY T#0s..T#1s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt23  %UNIT Time 
// Delay Time Man Mld Fwd Manual delay time
;
 sv_FwdInterruptList : tsInterCondList (* list with interrupt positions for mold close *)
    ;
 sv_dClampPressureCheckTime : TIME := T#200ms (* Time delay for clamp pressure reached signal *)
     %UNIT Time 
// Clamp Pres Check Time Clamp Pres Reached Check Time
;
 sv_rClampForceTol : REAL := 5.0
 %PLAUSIBILITY 0.0..%FU.sv_ClampForce.rMaxClampForce    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT ClampingForce  %ABSREL Forward 
// Clamp force tolerance Clamp force tolerance
;
 sv_rClampForceStored : REAL
     %VARIABLE_GROUP VG_Mold  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt50  %UNIT ClampingForce  %ABSREL Forward 
// Clamp force Clamp force
;
 sv_rLockDecompLimit : REAL := 50.0 (* clamp force must be less than threshold to start open profile movement *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30  %UNIT ClampingForce  %ABSREL Forward 
// Decomp Limit Decomp Limt
;
 sv_BwdInterruptList : tsInterCondList (* list with interrupt positions for mold open *)
    ;
 sv_rIntermedMoldOpenPosRobot : REAL (* intermediate mold open position for robot *)
 %PLAUSIBILITY 0.0..%FU.sv_rMoldOpenPosSet    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// Interm. mold open pos. Interm. mold open position
;
 sv_bMoldOpenPosRobotReached : BOOL (* TRUE: actual mold position >= intermediate mold open position for robot *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_rMoldVelocity : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Mold velocity Mold lever velocity
;
 sv_rMoldVelEstimate : REAL
    ;
 sv_rToggleLeverVelEstimate : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Toggle lever Position Toggle lever Position
;
 sv_DerivationEstimateParam : tsDerivationEstimateParam := (bUseDerivationEstimator:=TRUE,iN:=1,dT:=T#30ms,dMeasCycleTime:=T#6ms,iNu:=1,estimatorName:='MoldVelocity')
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_DerivationEstimateParToggle : tsDerivationEstimateParam := (iN:=1,dT:=T#30ms,dMeasCycleTime:=T#6ms,iNu:=1,estimatorName:='ToggleVelocity')
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_rMoldClosePosition : REAL (* for sequencer to calculate right unit *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Stroke  %ABSREL Forward 
// Mold close position Mold close target position
;
 sv_rClampForceAct : REAL (* actual clamp force *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT ClampingForce 
// Actual clamp force Actual clamp force
;
 sv_CalibStateClampPres : tsCalibMovement := (pLintabPoints:=@%FU.sv_ClampPressLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_ClampPressLintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_ClampPress,iOrder:=250,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateClampPres.bNameDummy
    
// Clamp press sens Clamp pressure sensor
;
 sv_ClampForce : tsClampForces := (rMaxClampForce:=100.0,rSetClampForce:=50.0)
   RETAIN 
%ELEMENT sv_ClampForce.rActualClampForce
     %LIST_GROUP LG_ActMold(2)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT ClampingForce  %ABSREL Forward 
// Act Clamp Force Act Clamp Force

%ELEMENT sv_ClampForce.rMaxClampForce
 %PLAUSIBILITY 1.0..6000.0      %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt50  %UNIT ClampingForce  %ABSREL NoRelative 
// Max. clamp force mold adjust Max. clamp force mold adjust

%ELEMENT sv_ClampForce.rSetClampForce
 %PLAUSIBILITY 0.0..%FU.sv_ClampForce.rMaxClampForce      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt50  %UNIT ClampingForce  %ABSREL Forward 
// Clamp force Set clamp force
;
 sv_iActiveStageFwd : DINT (* active profile stage mold close (fwd) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iActiveStageBwd : DINT (* active profile stage mold open (bwd) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_ToggleBwdProfVis : KAPPL_VisProfile := (pCalculatedProfile:=@%FU.sv_CalculatedProfileBwdToggle)
   RETAIN ;
 sv_ToggleFwdProfVis : KAPPL_VisProfile := (pCalculatedProfile:=@%FU.sv_CalculatedProfileFwdToggle)
   RETAIN ;
 sv_InstanceDataCloseToggleInter : tyInstanceListArray (* array with target positions of mold close interpos movements *)
    
%ELEMENT sv_InstanceDataCloseToggleInter[0].dCalculatedDuration
 %PLAUSIBILITY t#0s..t#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration

%ELEMENT sv_InstanceDataCloseToggleInter[0].rAcceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp up Ramp up

%ELEMENT sv_InstanceDataCloseToggleInter[0].rDeceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp down Ramp down

%ELEMENT sv_InstanceDataCloseToggleInter[0].rTargetValue
 %PLAUSIBILITY 0.0..%FU.sv_rMoldOpenPosSet      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Position Target Position
;
 sv_InstanceDataOpenToggleInter : tyInstanceListArray (* array with target positions of mold open interpos movements *)
    
%ELEMENT sv_InstanceDataOpenToggleInter[0].dCalculatedDuration
 %PLAUSIBILITY t#0s..t#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration

%ELEMENT sv_InstanceDataOpenToggleInter[0].rAcceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp up Ramp up

%ELEMENT sv_InstanceDataOpenToggleInter[0].rDeceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp down Ramp down

%ELEMENT sv_InstanceDataOpenToggleInter[0].rTargetValue
 %PLAUSIBILITY 0.0..%FU.sv_rMoldOpenPosSet      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Position Target Position
;
 sv_rInterstopTolerance : REAL := 0.0
 %PLAUSIBILITY 0.0..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %FORMAT fmt22  %UNIT Stroke 
// Interstop tolerance Interstop tolerance
;
 sv_CalculatedProfileFwd : tCalculatedProfiles
     %ABSREL Forward 
%ELEMENT sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT Pressure 
%ELEMENT sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileBwd : tCalculatedProfiles
     %ABSREL Backward 
%ELEMENT sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT Pressure 
%ELEMENT sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileFwdToggle : tCalculatedProfiles
    ;
 sv_CalculatedProfileBwdToggle : tCalculatedProfiles
    ;
 sv_rOpenPosHighPre : REAL
 %PLAUSIBILITY 0.0..%FU.sv_rMoldOpenPosSet    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// Pressure release endpos High pressure release endposition
;
 sv_rMinAmplification : REAL := 0.5 (* minimum amplification *)
 %PLAUSIBILITY 0.0..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Min. amplification Min. amplification
;
 sv_rMaxAmplification : REAL := 1.25 (* maximum amplification *)
 %PLAUSIBILITY 0.0..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Max. amplification Max. amplification
;
 sv_rMoldOpenPosSet : REAL (* set mold open position (according to entered HMI profile) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Set mold open pos. Set mold open position
;
 sv_bClampPressSensorAvailable : BOOL (* clamp force sensor available *)
    
// Clamp press sensor available Clamp press sensor available
;
 sv_dHighPresKeepTime : TIME := t#0s (* additional time delay for highpressure stage finished *)
 %PLAUSIBILITY t#0ms..t#9999ms    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT TimeMs 
// High pressure keep time High pressure keep time
;
 sv_RequiredPumpsClose : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=1000)
    
%ELEMENT sv_RequiredPumpsClose.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Mold close Mold close
;
 sv_RequiredPumpsOpen : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=1001)
    
%ELEMENT sv_RequiredPumpsOpen.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Mold open Mold open
;
 sv_HydrMaxValuesClose : tsHydrMaxValues (* hydraulic max values for mold close *)
    ;
 sv_HydrMaxValuesOpen : tsHydrMaxValues (* hydraulic max values for mold open *)
    ;
 sv_rSmoothFactor : REAL := 0.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Smooth factor mold Smooth factor mold
;
 sv_dVelFilterTime : TIME := T#3ms
 %PLAUSIBILITY T#0s..T#50ms    RETAIN  %VARIABLE_GROUP VG_MachineData  %FORMAT fmt20  %UNIT TimeMs 
// Act velocity filter time Actual velocity filter time
;
 sv_rFastVelocityFactor : REAL := 1.0
 %PLAUSIBILITY 0.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT fmt23 
// Velocity factor fast close Velocity factor fast close
;
 sv_rReferencePosition : REAL := 4.0 (* mold reference position (= position where the locknuts could initially close) *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Mold ref. position Mold reference position
;
 sv_bStandStillDetected : BOOL
    ;
%END

%SYSTEM_ALARM
  erMoldNotOpen
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mold not open{#]The mold open movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause mold open has not reached its target endposition. This position is \u000aset in the last point of the mold open profile settings.{#]Move the mold into open position before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the {Mold1.sv_MoldBwdProfVis.Profile:c:Mold open profile} settings. Try to open\u000athe mold to its target position manually before retrying the desired operation.
 ;
  erMoldNotClosed
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mold not closed{#]The mold close movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause mold close has not reached its target endposition.{#]Move the mold into closed position before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the {Mold1.sv_MoldFwdProfVisSrc.Profile:c:Mold close profile} settings. Try to close \u000athe mold manually before retrying the desired operation.<br><br>\u000aIn case a sensor is involved indicating the mold closed status this \u000acan also be checked, including hardware, wiring and terminal.
 ;
  erMoldProtection
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mold protection!{#]The mold protection has been triggered.{#]To protect the mold, during the protect stage of the mold close profile lower \u000aoutputs for pressure and velocity are used. The active time of the protect\u000a stage is measured, in order to provide a quick timeout. If there is a part still \u000ain the mold the resistance of the part causes the mold to take longer than the \u000amold protection time to cross the distance set in the mold protect stage.<br>\u000aBeside the possibility of a part still in the mold, the protection move timeout can \u000aalso happen when the output settings are too low to overcome friction.{#]Remove the part from the mold area and retry the desired operation.\u000a<br><br>\u000aIf no part is inside the mold try adjusting the mold protect stage \u000aoutput and {Mold1.sv_dMoldProtectTimeSet} settings before retrying the desired operation.
 ;
  erMoldPosNotCorrect
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mold not in correct position{#]A mold movement doesn't reach its \u000atarget intermediate position. All depending \u000amovements cannot be performed.{#]For device movements like for example core movements which require the mold \u000ato move to an intermediate position before the device movement can be performed it is necessary the the mold reaches the exact intermediate position. This alarm is \u000araised when the mold doesn't reach the correct position. The reasons could be \u000aproblematic profile settings. Also the ramps for slowing down the mold before \u000astopping could be too steep or too flat.{#]Try adjusting the according mold profile settings (close: {Mold1.sv_MoldFwdProfVisSrc.Profile:c:close profile}, open: {Mold1.sv_MoldBwdProfVis.Profile:c:Mold open profile}) to allow the mold \u000ato reach the correct intermediate position.<br><br>\u000aIf no working setting can be found, try adjusting the mold ramps \u000asettings,
 ;
  erClampPressToHigh
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual 
// Clamp pressure too high{#]The measured clamp force is too high.{#]The measured clamp force exceeds the set clamp force. As a result the autocycle is stopped.{#]Switch to setup mode and adjust the mold height.
 ;
  erClampPressToLow
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual 
// Clamp pressure too low{#]The measured clamp force is too low.{#]The measured clamp force is lower than the set clamp force. As a result the autocycle is stopped.{#]Switch to setup mode and adjust the mold height.
 ;
  erMoldOpenNoMinOutput
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Use adaptive mold open: no min output velocity set{#]No minimum output velocity is set while \u000aadaptive mold open should be used.{#]In order to achieve a higher precision on the mold open targetposition the \u000aadaptive mold open feature can be used. In order to better reach the target \u000aposition a minimum velocity higher than 0 should be set.{#]In order to improve the performance of the adaptive mold open \u000amovement increase the {Mold1.sv_MinOutputBwd.rVelocity} setting to an \u000aappropriate value.
 ;
  erMoldControlSensorNotAvailable
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Mold control: pressure sensor not available!{#]Limited mold control possible because no \u000apressure sensor is available.{#]Without a pressure sensor mold control cannot do derivation estimations.{#]This is just a message, no action required.<br>\u000aOnce acknowledged the alarm will disappear.<br><br>\u000aIf a pressure sensor for the mold is available, but the alarm appears \u000aanyway, please contact the machine manufacturer.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
131 
@SysVar @RT(25)sv_ToggleLeverMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(77)(FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(25)sv_ToggleLeverMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_ToggleLeverMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ToggleLeverMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ToggleLeverMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ToggleLeverMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ToggleLeverMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MoldPosMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(77)(FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(21)sv_MoldPosMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldPosMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_MoldPosMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldPosMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldPosMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldPosMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rToggleLeverPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever position @RT(21)Toggle lever position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rToggleLeverPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever position @RT(21)Toggle lever position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_rToggleLeverPositionAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Mold absolute position @RT(22)Mold absolute position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rToggleLeverPositionAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Mold absolute position @RT(22)Mold absolute position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rToggleLeverVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever velocity @RT(21)Toggle lever velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rToggleLeverVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever velocity @RT(21)Toggle lever velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rToggleLeverStroke @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)600.0 @RT(30)Opening Stroke of toggle lever 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max.toggle lever stroke @RT(24)Max. toggle lever stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rToggleLeverStroke @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Opening Stroke of Mold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max.toggle lever stroke @RT(24)Max. toggle lever stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rMoldStroke @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)600.0 @RT(22)Opening Stroke of Mold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. mold stroke @RT(16)Max. mold stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_rMoldStroke @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Opening Stroke of Mold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. mold stroke @RT(16)Max. mold stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rMaxMoldStroke @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)600.0 @RT(92)Maximum Stroke of Mold (without a mounted mold); relevant for direct lock and 2 platen IMM´s 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. mold stroke @RT(16)Max. mold stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rMaxMoldStroke @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Opening Stroke of Mold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. mold stroke @RT(16)Max. mold stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_rPressureAmpActivationForce @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)Activation threshold for pressure amplifier 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt40 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(37)0.0..%FU.sv_ClampForce.rMaxClampForce @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Amplifier activation force @RT(26)Amplifier activation force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_rPressureAmpActivationForce @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)Activation threshold for pressure amplifier 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt40 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(37)0.0..%FU.sv_ClampForce.rMaxClampForce @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Amplifier activation force @RT(26)Amplifier activation force @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rMoldPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(1) @RT(0) 
@RT(13)Mold position @RT(13)Mold position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rMoldPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(1) @RT(0) 
@RT(13)Mold position @RT(13)Mold position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rPressureAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(15)sv_rVelocityAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(12)sv_rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(12)sv_rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(20)sv_MoldFwdProfVisSrc @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(545)(Profile:=(Points:=17((rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=600.0)),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=100.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=50.0,rVelRamp:=100.0,rStartPos:=0.0),iNoOfPoints:=4),RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageFwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(20)sv_MoldFwdProfVisSrc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MoldFwdProfVisSrc.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(194)(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=50.0,rVelRamp:=100.0,rStartPos:=600.0),(rPressure:=10.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=100.0),iNoOfPoints:=3) @RT(16)movement profile 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(45)MoldGeneral.hmi.MoldCloseProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_MoldFwdProfVisSrc.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(18)ramp at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_MoldFwdProfVisSrc.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(22)pressure at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_MoldFwdProfVisSrc.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)600.0 @RT(14)start position 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_MoldFwdProfVisSrc.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(29)ramp for speed for this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_MoldFwdProfVisSrc.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(18)flow at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_MoldFwdProfVisSrc.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)3 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)3..5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MoldFwdProfVisSrc.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. ramp close @RT(24)Max. pressure ramp close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldFwdProfVisSrc.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. ramp close @RT(24)Max. velocity ramp close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_MoldFwdProfVisSrc.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Pressure 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldFwdProfVisSrc.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Velocity 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_MoldFwdProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(679)(Profile:=(Points:=(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=600.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=25.0,rVelRamp:=100.0,rStartPos:=100.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=40.0,rPressRamp:=100.0,rVelocity:=50.0,rVelRamp:=100.0,rStartPos:=0.0),iNoOfPoints:=4),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputPress:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=1000.0,rMaxRampVel:=1000.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(17)sv_MoldFwdProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoldFwdProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(194)(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=50.0,rVelRamp:=100.0,rStartPos:=600.0),(rPressure:=10.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=100.0),iNoOfPoints:=3) @RT(16)movement profile 
@RT(0) @RT(0) @RT(8)VG_Dummy @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_MoldFwdProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)ramp at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldFwdProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(22)pressure at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldFwdProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)600.0 @RT(14)start position 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_MoldFwdProfVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)ramp for speed for this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldFwdProfVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(18)flow at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_MoldFwdProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)3 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)3..5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_MoldFwdProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. ramp close @RT(24)Max. pressure ramp close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_MoldFwdProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. ramp close @RT(24)Max. velocity ramp close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldFwdProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Pressure 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_MoldFwdProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Velocity 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_iActiveStage @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(17)sv_MoldBwdProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(801)(Profile:=(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=300.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=400.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=500.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=600.0),iNoOfPoints:=4),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputPress:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=1000.0,rMaxRampVel:=1000.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageBwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwd) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
14 
@AttrSym @RT(17)sv_MoldBwdProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoldBwdProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(192)(Points:=(rPressure:=33.0,rPressRamp:=100.0,rVelocity:=33.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=55.0,rPressRamp:=100.0,rVelocity:=55.0,rVelRamp:=100.0,rStartPos:=300.0),iNoOfPoints:=2) @RT(16)movement profile 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(44)MoldGeneral.hmi.MoldOpenProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldBwdProfVis.Profile.Points @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(422)(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=300.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=400.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=500.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=30.0,rVelRamp:=100.0,rStartPos:=600.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_MoldBwdProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(18)ramp at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldBwdProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)33.0 @RT(22)pressure at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldBwdProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(14)start position 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_MoldBwdProfVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(29)ramp for speed for this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_MoldBwdProfVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)33.0 @RT(18)flow at this point 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_MoldBwdProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)1..5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldBwdProfVis.bUseOffsetOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)use offset for optimizing positioning 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Use adaptive mold open @RT(22)Use adaptive mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_MoldBwdProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. ramp open @RT(23)Max. pressure ramp open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_MoldBwdProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. ramp open @RT(23)Max. velocity ramp open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldBwdProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Pressure 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_MoldBwdProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)Stop Ramp Velocity 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_MoldLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=700.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(13)sv_MoldLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(23)0.0..%FU.sv_rMoldStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_ToggleLeverPosLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=700.0))) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(23)sv_ToggleLeverPosLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ToggleLeverPosLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ToggleLeverPosLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(30)0.0..%FU.sv_rToggleLeverStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ToggleLeverPosLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dMoldProtectTimeSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#5s @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Mold protect time @RT(17)Mold protect time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dMoldProtectTimeSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Mold protect time @RT(17)Mold protect time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dMoldProtectTimeAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(7)VG_Mold @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. mold protect time @RT(24)Actual mold protect time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dMoldProtectTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(7)VG_Mold @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. mold protect time @RT(24)Actual mold protect time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bFastClose @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Fast close @RT(14)Use fast close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bFastClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Fast close @RT(14)Use fast close @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_bFastOpen @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Fast open @RT(13)Use fast open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_bFastOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Fast open @RT(13)Use fast open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bDoTransducerCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Do transducer calibration @RT(25)Do transducer calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bDoTransducerCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Do transducer calibration @RT(25)Do transducer calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MinOutputFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)minimum output for mold close 
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
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Min. profile output close @RT(34)Min. profile output pressure close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputFwd.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Min. profile output close @RT(34)Min. profile output velocity close @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MinOutputBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)minimum output for mold open 
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
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Min. profile output open @RT(33)Min. profile output pressure open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputBwd.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Min. profile output open @RT(33)Min. profile output velocity open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rFwdInterruptPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rFwdInterruptPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rFwdInterruptAccel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)Acceleration after Interrupt Position for Mold Fwd Movement reached 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rFwdInterruptAccel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rBwdInterruptDeaccel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)Deaacceleration to reach Interrupt Position for Mold Bwd Movement  
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rBwdInterruptDeaccel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Fwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rFwdInterruptDeaccel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)Deaacceleration to reach Interrupt Position for Mold Fwd Movement  
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rFwdInterruptDeaccel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Fwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rBwdInterruptPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rBwdInterruptPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Bwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rBwdInterruptAccel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(67)Acceleration after Interrupt Position for Mold Bwd Movement reached 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rBwdInterruptAccel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(97)Interrupt Position for Mold Fwd Movement (stop movement at this position so that a core can move) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bOutputActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Mold output active @RT(18)Mold output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bOutputActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Mold output active @RT(18)Mold output active @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(14)sv_ConstBwdVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(111)(Velocity:=(Output:=(rOutputValue:=10.0,rRamp:=5000.0)),Pressure:=(Output:=(rOutputValue:=10.0,rRamp:=5000.0))) @RT(35)const output for mold open movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
9 
@AttrSym @RT(14)sv_ConstBwdVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)const output for mold open movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstBwdVis.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Backward pressure @RT(17)Backward pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstBwdVis.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(13)Ramp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstBwdVis.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ConstBwdVis.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstBwdVis.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Backward velocity @RT(17)Backward velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstBwdVis.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(13)Ramp velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstBwdVis.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ConstBwdVis.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ConstFwdVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(83)(Velocity:=(Output:=(rOutputValue:=10.0)),Pressure:=(Output:=(rOutputValue:=10.0))) @RT(36)const output for mold close movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
9 
@AttrSym @RT(14)sv_ConstFwdVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)const output for mold close movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstFwdVis.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Forward pressure @RT(16)Forward pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstFwdVis.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(13)Ramp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdVis.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ConstFwdVis.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstFwdVis.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Forward velocity @RT(16)Forward velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstFwdVis.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(13)Ramp velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdVis.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ConstFwdVis.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(20)sv_MoldCloseTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(20)sv_MoldCloseTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldCloseTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. close time @RT(20)Max. mold close time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MoldCloseTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Close delay @RT(16)Mold close delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldCloseTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Pump on delay @RT(24)Pump on delay mold close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_MoldCloseTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)delay time before movement stop, between pump stop and valve close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Valve close delay @RT(28)Valve close delay mold close @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_MoldCloseTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_MoldCloseTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MoldCloseTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Act. close delay @RT(21)Act. mold close delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldCloseTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(7)VG_Mold @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. close time @RT(20)Act. mold close time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MoldCloseTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Last close time @RT(20)Last mold close time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoldOpenTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(19)sv_MoldOpenTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldOpenTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. open time @RT(19)Max. mold open time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldOpenTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Open delay @RT(15)Mold open delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_MoldOpenTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Pump on delay @RT(23)Pump on delay mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldOpenTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(66)delay time before movement stop, between pump stop and valve close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Valve close delay @RT(27)Valve close delay mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoldOpenTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(19)sv_MoldOpenTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldOpenTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. open delay @RT(20)Act. mold open delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldOpenTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(19)VG_Mold,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Act. open time @RT(19)Act. mold open time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldOpenTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Last open time @RT(19)Last mold open time @RT(0) @RT(0) @RT(0) 
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
4 @RT(224)(pLintabPoints:=@%FU.sv_MoldLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_MoldLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rMoldStroke,prInputSensor:=@%FU.ai_Position,iOrder:=20,Group:=tnCalibGroup_Transducer) @RT(0) 
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
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mold @RT(15)Mold transducer @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(27)sv_ClampForceBuildUpTimeAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)act build up time for clamp pressure 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Force build up time @RT(29)Act clamp force build up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_ClampForceBuildUpTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(32)Build up time for clamp pressure 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Force build up time @RT(29)Act clamp force build up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_ClampForceBuildUpTimeSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(36)set build up time for clamp pressure 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Force build up time @RT(29)Set clamp force build up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_ClampForceBuildUpTimeSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(32)Build up time for clamp pressure 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Force build up time @RT(29)Set clamp force build up time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ClampPressLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(46)lintab for converting clamp force from V to kN 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Clamp Sens. @RT(18)Clamp Force Sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(19)sv_ClampPressLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(46)lintab for converting clamp force from V to kN 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Clamp Sens. @RT(18)Clamp Force Sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampPressLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampPressLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(11)Clamp Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampPressLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_ConstHiPressVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)const output for mold close high pressure movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Const hi press @RT(26)Const values high pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(18)sv_ConstHiPressVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)const output for mold close movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Const hi press @RT(26)Const values high pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConstHiPressVis.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstHiPressVis.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConstHiPressVis.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstHiPressVis.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoldLockDecompTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(25)sv_MoldLockDecompTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_MoldLockDecompTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. lock decomp delay @RT(27)Act. mold lock decomp delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldLockDecompTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(19)VG_Mold,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Act. lock decomp time @RT(26)Act. mold lock decomp time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_MoldLockDecompTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(30)steg: Direct hydraulic locking 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(25)sv_MoldLockDecompTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldLockDecompTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. lock decomp time @RT(26)Max. mold lock decomp time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_MoldLockDecompTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Close delay @RT(16)Mold close delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_MoldLockDecompTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#10s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Close delay pump @RT(21)Mold close delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoldLockTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(19)sv_MoldLockTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldLockTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. lock delay @RT(20)Act. mold lock delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldLockTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(7)VG_Mold @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Act. lock time @RT(19)Act. mold lock time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoldLockTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(30)steg: Direct hydraulic locking 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(19)sv_MoldLockTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_MoldLockTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. lock time @RT(19)Max. mold lock time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MoldLockTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Close delay @RT(16)Mold close delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_MoldLockTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#10s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Close delay pump @RT(21)Mold close delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_bActivateLockDecompAftPlast @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)Activate lock decompression after plasticise 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Lock decomp after plast @RT(23)Lock decomp after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_bActivateLockDecompAftPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Lock decomp after plast @RT(23)Lock decomp after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bLockDecompOK @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)decomp of clamp pressure finished 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(21)sv_bLockDecompTimeOut @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)steg: Mold lock decompression timeout 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Mold lock decomp timeout @RT(24)Mold lock decomp timeout @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bLockDecompTimeOut @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Mold lock decomp timeout @RT(24)Mold lock decomp timeout @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bMoldLockStageActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)mold lock stage active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Lock stage acive @RT(17)Lock stage active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bMoldLockStageActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)mold lock stage active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Lock stage acive @RT(17)Lock stage active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bMonitorClampPress @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Monitor clamp press @RT(22)Monitor clamp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bMonitorClampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Monitor clamp press @RT(22)Monitor clamp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_bClampForceBuildUpWithTime @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)use time dependent clamp force build up 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_bClampForceBuildUpWithTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)use time dependent clamp force build up 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bClampForceReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)Clamp force reached 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(25)sv_bClampPressSensorError @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Clamp pressure sensor error @RT(27)Clamp pressure sensor error @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_bClampPressSensorError @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Clamp pressure sensor error @RT(27)Clamp pressure sensor error @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_TransducerCalibData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsTransducerCalibData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(109)(Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveFwd,Id2:=cMoveBwd,bReverse:=TRUE,prPos2:=@%FU.sv_rToggleLeverStroke) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(20)sv_bMoveMoldUntilEnd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(15)sv_CylinderData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsCylinderData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(88)(rCylinderDiameter:=70.0,rPistonRodDiameter:=30.0,iNumCylinders:=1,bUseSmallSize:=FALSE) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(15)sv_CylinderData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(67)(rCylinderDiameter:=70.0,rPistonRodDiameter:=30.0,iNumCylinders:=2) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_CylinderData.bMoveWithPlunger @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Mold close with plunger @RT(23)Mold close with plunger @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_CylinderData.bUseSmallSize @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Mold close by ring area @RT(23)Mold close by ring area @RT(0) @RT(0) @RT(0) 
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
@AttrSym @RT(32)sv_CylinderData.rPlungerDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Plunger diameter @RT(16)Plunger diameter @RT(0) @RT(0) @RT(0) 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutFwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=200.0,rY:=100.0))) @RT(0) 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutBwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=200.0,rY:=100.0))) @RT(0) 
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
4 @RT(5)200.0 @RT(41)maximum speed for mold close (calculated) 
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
4 @RT(5)200.0 @RT(40)maximum speed for mold open (calculated) 
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
4 @RT(5)200.0 @RT(28)maximum speed for mold close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. speed fwd @RT(14)Max. speed fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)maximum speed for mold close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. speed fwd @RT(14)Max. speed fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxSpeedBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(27)maximum speed for mold open 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. speed bwd @RT(14)Max. speed bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)maximum speed for mold open 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Max. speed bwd @RT(14)Max. speed bwd @RT(0) @RT(0) @RT(0) 
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
4 @RT(5)145.0 @RT(31)maximum pressure for mold close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)maximum pressure for mold close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxPressureBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)145.0 @RT(30)maximum pressure for mold open 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)maximum pressure for mold open 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_bOpenMHUntilMoldHeightCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)open until value specified in sv_rOpenPosForMHAdjust 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_bOpenMHUntilMoldHeightCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)open until value specified in sv_rOpenPosForMHAdjust 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_bOpenMHUntilProtectStep @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)open until protect step position in Forward profile 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_bOpenMHUntilProtectStep @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)open until protect step position in Forward profile 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rOpenPosForMHAdjust @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)open until this toggle lever pos for mold height adjust 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rOpenPosForMHAdjust @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)open until this toggle lever pos for mold height adjust 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_ToggleLeverLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(83)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10000.0,rY:=10000.0))) @RT(44)lintab for toggleleverpos(x) -> platenpos(y) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_ToggleLeverLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)lintab for toggleleverpos(x) -> platenpos(y) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ToggleLeverLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(30)0.0..%FU.sv_rToggleLeverStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever Position @RT(21)Toggle lever Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ToggleLeverLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(23)0.0..%FU.sv_rMoldStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Platen position @RT(15)Platen position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ToggleLeverLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Number of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rMoldPosOffset @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(73)Added to the actual moldposition, calculated by the clamppressure setting 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Moldposition offset @RT(19)Moldposition offset @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rMoldPosOffset @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(73)Added to the actual moldposition, calculated by the clamppressure setting 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Moldposition offset @RT(19)Moldposition offset @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bOpenAfterProtect @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)open mold after mold protect 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Open after protect @RT(23)Open after mold protect @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_bOpenAfterProtect @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)open mold after mold protect 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Open after protect @RT(23)Open after mold protect @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxPressureProtect @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)210.0 @RT(39)maximum pressure for mold protect stage 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(43)0.0..%FU.sv_HydrMaxValuesClose.rMaxPressure @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Max. pressure mold protect @RT(26)Max. pressure mold protect @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxPressureProtect @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)210.0 @RT(39)maximum pressure for mold protect stage 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(43)0.0..%FU.sv_HydrMaxValuesClose.rMaxPressure @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Max. pressure mold protect @RT(26)Max. pressure mold protect @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_ToggleLeverLintabDerive @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=1.0),(rX:=1000.0,rY:=1.0))) @RT(47)derivation calculated from sv_ToggleLeverLintab 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_ToggleLeverLintabDerive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)lintab for toggleleverpos(x) -> platenpos(y) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_OpenInterstopDeadTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Dead time Mold Inter Bwd @RT(19)Interstop dead time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_OpenInterstopDeadTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Dead time Mold Inter Bwd @RT(19)Interstop dead time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_OpenManualDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Delay Time Man Mld Bwd @RT(17)Manual delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_OpenManualDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Delay Time Man Mld Bwd @RT(17)Manual delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CloseInterstopDeadTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Dead time Mold Inter Fwd @RT(19)Interstop dead time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_CloseInterstopDeadTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Dead time Mold Inter Fwd @RT(19)Interstop dead time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_CloseManualDelayTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Delay Time Man Mld Fwd @RT(17)Manual delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_CloseManualDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Delay Time Man Mld Fwd @RT(17)Manual delay time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_FwdInterruptList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsInterCondList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)list with interrupt positions for mold close 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(26)sv_dClampPressureCheckTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)T#200ms @RT(44)Time delay for clamp pressure reached signal 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Clamp Pres Check Time @RT(29)Clamp Pres Reached Check Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_dClampPressureCheckTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)T#200ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Clamp Pres Check Time @RT(29)Clamp Pres Reached Check Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rClampForceTol @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)5.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt41 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(37)0.0..%FU.sv_ClampForce.rMaxClampForce @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Clamp force tolerance @RT(21)Clamp force tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rClampForceTol @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt41 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(37)0.0..%FU.sv_ClampForce.rMaxClampForce @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Clamp force tolerance @RT(21)Clamp force tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rClampForceStored @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(7)VG_Mold @RT(5)fmt50 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Clamp force @RT(11)Clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rClampForceStored @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(7)VG_Mold @RT(5)fmt50 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Clamp force @RT(11)Clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rLockDecompLimit @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(70)clamp force must be less than threshold to start open profile movement 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Decomp Limit @RT(11)Decomp Limt @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rLockDecompLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(70)clamp force must be less than threshold to start open profile movement 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt30 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Decomp Limit @RT(11)Decomp Limt @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_BwdInterruptList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsInterCondList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)list with interrupt positions for mold open 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(28)sv_rIntermedMoldOpenPosRobot @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)intermediate mold open position for robot 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Interm. mold open pos. @RT(26)Interm. mold open position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_rIntermedMoldOpenPosRobot @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Opening Stroke of Mold 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Interm. mold open pos. @RT(26)Interm. mold open position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_bMoldOpenPosRobotReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)TRUE: actual mold position >= intermediate mold open position for robot 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_bMoldOpenPosRobotReached @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)TRUE: actual mold position >= intermediate mold open position for robot 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rMoldVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Mold velocity @RT(19)Mold lever velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rMoldVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Mold velocity @RT(19)Mold lever velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMoldVelEstimate @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(26)sv_rToggleLeverVelEstimate @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever Position @RT(21)Toggle lever Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rToggleLeverVelEstimate @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Toggle lever Position @RT(21)Toggle lever Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_DerivationEstimateParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tsDerivationEstimateParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(107)(bUseDerivationEstimator:=TRUE,iN:=1,dT:=T#30ms,dMeasCycleTime:=T#6ms,iNu:=1,estimatorName:='MoldVelocity') @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_DerivationEstimateParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_DerivationEstimateParToggle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tsDerivationEstimateParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(iN:=1,dT:=T#30ms,dMeasCycleTime:=T#6ms,iNu:=1,estimatorName:='ToggleVelocity') @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_DerivationEstimateParToggle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rMoldClosePosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)for sequencer to calculate right unit 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold close position @RT(26)Mold close target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rMoldClosePosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)for sequencer to calculate right unit 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold close position @RT(26)Mold close target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rClampForceAct @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)actual clamp force 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(13)ClampingForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Actual clamp force @RT(18)Actual clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rClampForceAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(13)ClampingForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Actual clamp force @RT(18)Actual clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_CalibStateClampPres @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(207)(pLintabPoints:=@%FU.sv_ClampPressLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_ClampPressLintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_ClampPress,iOrder:=250,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(33)sv_CalibStateClampPres.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Clamp press sens @RT(21)Clamp pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_ClampForce @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsClampForces @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(44)(rMaxClampForce:=100.0,rSetClampForce:=50.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(13)sv_ClampForce @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(44)(rMaxClampForce:=100.0,rSetClampForce:=50.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ClampForce.rActualClampForce @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)actual clamp force 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActMold(2) @RT(0) 
@RT(15)Act Clamp Force @RT(15)Act Clamp Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ClampForce.rMaxClampForce @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)maximum clamp force 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt50 @RT(13)ClampingForce @RT(10)NoRelative @RT(0) 
@RT(11)1.0..6000.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max. clamp force mold adjust @RT(28)Max. clamp force mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ClampForce.rSetClampForce @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)desired clamp force 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt50 @RT(13)ClampingForce @RT(7)Forward @RT(0) 
@RT(37)0.0..%FU.sv_ClampForce.rMaxClampForce @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Clamp force @RT(15)Set clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iActiveStageFwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)active profile stage mold close (fwd) 
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
4 @RT(0) @RT(36)active profile stage mold open (bwd) 
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


@SysVar @RT(19)sv_ToggleBwdProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(56)(pCalculatedProfile:=@%FU.sv_CalculatedProfileBwdToggle) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ToggleBwdProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ToggleFwdProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(56)(pCalculatedProfile:=@%FU.sv_CalculatedProfileFwdToggle) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ToggleFwdProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_InstanceDataCloseToggleInter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyInstanceListArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)array with target positions of mold close interpos movements 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(54)sv_InstanceDataCloseToggleInter[0].dCalculatedDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_InstanceDataCloseToggleInter[0].rAcceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(28)acceleration from this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Ramp up @RT(7)Ramp up @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_InstanceDataCloseToggleInter[0].rDeceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(32)deceleration to reach this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Ramp down @RT(9)Ramp down @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_InstanceDataCloseToggleInter[0].rTargetValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(15)Target Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_InstanceDataOpenToggleInter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyInstanceListArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)array with target positions of mold open interpos movements 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(53)sv_InstanceDataOpenToggleInter[0].dCalculatedDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_InstanceDataOpenToggleInter[0].rAcceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)acceleration from this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Ramp up @RT(7)Ramp up @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_InstanceDataOpenToggleInter[0].rDeceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)deceleration to reach this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Ramp down @RT(9)Ramp down @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_InstanceDataOpenToggleInter[0].rTargetValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(15)Target Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rInterstopTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt22 @RT(6)Stroke @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Interstop tolerance @RT(19)Interstop tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rInterstopTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt22 @RT(6)Stroke @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Interstop tolerance @RT(19)Interstop tolerance @RT(0) @RT(0) @RT(0) 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(0) @RT(0) 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(0) @RT(0) 
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


@SysVar @RT(29)sv_CalculatedProfileFwdToggle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(29)sv_CalculatedProfileBwdToggle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(18)sv_rOpenPosHighPre @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Pressure release endpos @RT(33)High pressure release endposition @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rOpenPosHighPre @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Pressure release endpos @RT(33)High pressure release endposition @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMinAmplification @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(21)minimum amplification 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Min. amplification @RT(18)Min. amplification @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMinAmplification @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Min. amplification @RT(18)Min. amplification @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxAmplification @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)1.25 @RT(21)maximum amplification 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. amplification @RT(18)Max. amplification @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxAmplification @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. amplification @RT(18)Max. amplification @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMoldOpenPosSet @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)set mold open position (according to entered HMI profile) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Set mold open pos. @RT(22)Set mold open position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMoldOpenPosSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Set mold open pos. @RT(22)Set mold open position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_bClampPressSensorAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)clamp force sensor available 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Clamp press sensor available @RT(28)Clamp press sensor available @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_bClampPressSensorAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Clamp press sensor available @RT(28)Clamp press sensor available @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_dHighPresKeepTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#0s @RT(53)additional time delay for highpressure stage finished 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt40 @RT(6)TimeMs @RT(0) @RT(0) 
@RT(15)t#0ms..t#9999ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)High pressure keep time @RT(23)High pressure keep time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_dHighPresKeepTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#0s @RT(53)additional time delay for highpressure stage finished 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt40 @RT(6)TimeMs @RT(0) @RT(0) 
@RT(15)t#0ms..t#9999ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)High pressure keep time @RT(23)High pressure keep time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_RequiredPumpsClose @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=1000) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(35)sv_RequiredPumpsClose.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Mold close @RT(10)Mold close @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_RequiredPumpsOpen @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=1001) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(34)sv_RequiredPumpsOpen.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Mold open @RT(9)Mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_HydrMaxValuesClose @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)hydraulic max values for mold close 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(20)sv_HydrMaxValuesOpen @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)hydraulic max values for mold open 
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
@RT(18)Smooth factor mold @RT(18)Smooth factor mold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rSmoothFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Smooth factor mold @RT(18)Smooth factor mold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_dVelFilterTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#3ms @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt20 @RT(6)TimeMs @RT(0) @RT(0) 
@RT(12)T#0s..T#50ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Act velocity filter time @RT(27)Actual velocity filter time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_dVelFilterTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt20 @RT(6)TimeMs @RT(0) @RT(0) 
@RT(12)T#0s..T#50ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Act velocity filter time @RT(27)Actual velocity filter time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rFastVelocityFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(0) 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(5)fmt23 @RT(0) @RT(0) @RT(0) 
@RT(3)0.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Velocity factor fast close @RT(26)Velocity factor fast close @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rFastVelocityFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(5)fmt23 @RT(0) @RT(0) @RT(0) 
@RT(3)0.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Velocity factor fast close @RT(26)Velocity factor fast close @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rReferencePosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)4.0 @RT(77)mold reference position (= position where the locknuts could initially close) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Mold ref. position @RT(23)Mold reference position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rReferencePosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Nuts locking position 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Mold ref. position @RT(23)Mold reference position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bStandStillDetected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
8 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erMoldNotOpen @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(648)Mold not open{#]The mold open movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause mold open has not reached its target endposition. This position is \u000aset in the last point of the mold open profile settings.{#]Move the mold into open position before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the {Mold1.sv_MoldBwdProfVis.Profile:c:Mold open profile} settings. Try to open\u000athe mold to its target position manually before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erMoldNotClosed @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(706)Mold not closed{#]The mold close movement has not \u000areached its target endposition.{#]The operation desired by the user or cyclic-sequence cannot be performed \u000abecause mold close has not reached its target endposition.{#]Move the mold into closed position before \u000aretrying the desired operation.<br><br>\u000aIf this alarm occurs during semi- or full-autocycle check and \u000aif required adjust the {Mold1.sv_MoldFwdProfVisSrc.Profile:c:Mold close profile} settings. Try to close \u000athe mold manually before retrying the desired operation.<br><br>\u000aIn case a sensor is involved indicating the mold closed status this \u000acan also be checked, including hardware, wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erMoldProtection @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(893)Mold protection!{#]The mold protection has been triggered.{#]To protect the mold, during the protect stage of the mold close profile lower \u000aoutputs for pressure and velocity are used. The active time of the protect\u000a stage is measured, in order to provide a quick timeout. If there is a part still \u000ain the mold the resistance of the part causes the mold to take longer than the \u000amold protection time to cross the distance set in the mold protect stage.<br>\u000aBeside the possibility of a part still in the mold, the protection move timeout can \u000aalso happen when the output settings are too low to overcome friction.{#]Remove the part from the mold area and retry the desired operation.\u000a<br><br>\u000aIf no part is inside the mold try adjusting the mold protect stage \u000aoutput and {Mold1.sv_dMoldProtectTimeSet} settings before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erMoldPosNotCorrect @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(951)Mold not in correct position{#]A mold movement doesn't reach its \u000atarget intermediate position. All depending \u000amovements cannot be performed.{#]For device movements like for example core movements which require the mold \u000ato move to an intermediate position before the device movement can be performed it is necessary the the mold reaches the exact intermediate position. This alarm is \u000araised when the mold doesn't reach the correct position. The reasons could be \u000aproblematic profile settings. Also the ramps for slowing down the mold before \u000astopping could be too steep or too flat.{#]Try adjusting the according mold profile settings (close: {Mold1.sv_MoldFwdProfVisSrc.Profile:c:close profile}, open: {Mold1.sv_MoldBwdProfVis.Profile:c:Mold open profile}) to allow the mold \u000ato reach the correct intermediate position.<br><br>\u000aIf no working setting can be found, try adjusting the mold ramps \u000asettings, 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erClampPressToHigh @RT(1)3 @RT(1)y @RT(24)system.evAlarmAutoManual @RT(0) @RT(4)User @RT(208)Clamp pressure too high{#]The measured clamp force is too high.{#]The measured clamp force exceeds the set clamp force. As a result the autocycle is stopped.{#]Switch to setup mode and adjust the mold height. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erClampPressToLow @RT(1)3 @RT(1)y @RT(24)system.evAlarmAutoManual @RT(0) @RT(4)User @RT(212)Clamp pressure too low{#]The measured clamp force is too low.{#]The measured clamp force is lower than the set clamp force. As a result the autocycle is stopped.{#]Switch to setup mode and adjust the mold height. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erMoldOpenNoMinOutput @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(520)Use adaptive mold open: no min output velocity set{#]No minimum output velocity is set while \u000aadaptive mold open should be used.{#]In order to achieve a higher precision on the mold open targetposition the \u000aadaptive mold open feature can be used. In order to better reach the target \u000aposition a minimum velocity higher than 0 should be set.{#]In order to improve the performance of the adaptive mold open \u000amovement increase the {Mold1.sv_MinOutputBwd.rVelocity} setting to an \u000aappropriate value. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(31)erMoldControlSensorNotAvailable @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(435)Mold control: pressure sensor not available!{#]Limited mold control possible because no \u000apressure sensor is available.{#]Without a pressure sensor mold control cannot do derivation estimations.{#]This is just a message, no action required.<br>\u000aOnce acknowledged the alarm will disappear.<br><br>\u000aIf a pressure sensor for the mold is available, but the alarm appears \u000aanyway, please contact the machine manufacturer. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
