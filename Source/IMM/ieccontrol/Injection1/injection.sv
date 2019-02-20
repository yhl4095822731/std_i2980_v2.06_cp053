%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, Voltage
, fmt32
, InjectStroke
, Forward
, fmt41
, fmt30
, InjectSpeed
, InjectVolume
, LG_ActPos
, InjectVolumeSpeed
, VG_MoldData
, Percent
, fmt31
, InjectPressure
, fmt40
, fmt20
, MaxRampInjPressureSpec
, fmt61
, MaxRampVelocity
, ForwardSpec
, TimeReal
, YesNo
, Time
, fmt23
, TimeAccurate
, fmt33
, fmt50
, Pressure
, NoRelative
, InjectBackpressureABS
, InjectPressureABS
, UseNoUse
, Stroke
, VG_Inject
, MaxPlastPressure
, Rotation
, Backward
, fmt10
, MaxRampInjBackpressureABS
, MaxBackPressure
, MaxRampPressure
, Plasticize
, RotationRPM
, LG_ActInject
, VG_SequenceData
, fmt22
, LG_CombinedPlast
, VG_SPC_POST
, DecompressionMode
, Speed
, IntrusionMode
, LG_InjectInterPos
, DecompInterPosMode
, LG_DecompInterPos
, fmt42
, MoldAdjustMotor
, OnOff

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData_2P
, KAPPL_VisProfile
, tsControlParameters
, tsDeadTimeParameters
, tsCutOffCriterions
, KAPPL_VisProfilePlast
, tsOutput
, KAPPL_LintabData
, tsSetTimes
, tsActTimes
, tsDecompParam
, tsIntrusionParam
, tyInstanceListArray
, tyInstanceListArrayDecomp
, tsMinOutput
, tsVelPre
, KCTRL_Impulse_Param
, tsCylinderData
, KAPPL_IMM_Type
, KAPPL_ServoValveControlData
, KAPPL_ServoValveControllerMode
, tnMotorType
, tsColdDropParams
, KAPPL_MeasureMonitoring
, tsDerivationEstimateParam
, tCalculatedProfiles
, tsRequiredPumps
, tsHydrMaxValues
, KCTRL_YXGen_RampType_Square
, KCTRL_YXGen_RampType_Linear
, nKAPPL_IMM_PQ
, nHydraulic
, cLevelServiceEngineer
, cLevelProcessOperator
, cLevelProduction
, cLevelStartupTechnican
, cLevelSuperUser
, FPlausRotationPlast
, MAX_NO_LINTAB_POINTS
, PDecAftPlast
, cPlausMaxRampInjectPressureMax
, cPlausMaxRampInjectPressureMin
, cPlausMaxRampPressureMax
, cPlausMaxRampPressureMin
, cPlausMaxRampVelocityMax
, cPlausMaxRampVelocityMin

END_IMPORT

%SYSTEMVAR_DECL
  sv_ScrewLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=300.0))) (* lintab for screw transducer *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_ScrewLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt32  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_ScrewLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..%FU.sv_rScrewStroke      %FORMAT fmt41  %UNIT InjectStroke  %ABSREL Forward 
// Position Position

%ELEMENT sv_ScrewLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// No. of points Number of points
;
 sv_rScrewPositionAbs : REAL (* screw position in mm *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectStroke 
// Screw position Screw position
;
 sv_rScrewVelocityAbs : REAL (* screw velocity in mm/s *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectSpeed 
// Screw velocity Screw velocity
;
 sv_rScrewPosition : REAL (* specific screw position im cm³ *)
     %LIST_GROUP LG_ActPos(2)
 %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectVolume 
// Screw position Screw position
 %UPDATE_CYCLE "Fast";
 sv_rScrewVelocity : REAL (* screw velocity in cm³/s *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Screw velocity Screw velocity
;
 sv_rScrewVelocityMean : REAL (* Mean screw velocity during inject movement in cm³/s *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Mean screw velocity Mean screw velocity
;
 sv_rScrewVelocityMin : REAL (* Minimum screw velocity during inject movement in cm³/s *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Minimum screw velocity Minimum screw velocity
;
 sv_rScrewVelocityMax : REAL (* Maximum screw velocity during inject movement in cm³/s *)
     %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Maximum screw velocity Maximum screw velocity
;
 sv_InjectProfVis : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=20.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=5.0),iNoOfPoints:=4),bOpenEndProfile:=TRUE,rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=9999.0,rMaxRampVel:=500.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageInject,pCalculatedProfile:=@%FU.sv_CalculatedProfileInject)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCDeviceActivatedController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_InjectProfVis.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS InjectionGeneral.hmi.InjectProgrammedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_InjectProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_InjectProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_InjectProfVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT InjectVolume 
// To To

%ELEMENT sv_InjectProfVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_InjectProfVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Velocity Velocity

%ELEMENT sv_InjectProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 1..10      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt20 
// Stages Stages

%ELEMENT sv_InjectProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt61  %UNIT MaxRampInjPressureSpec  %ABSREL Forward 
// Max. ramp Max. ramp pressure

%ELEMENT sv_InjectProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL ForwardSpec 
// Max. ramp Max. ramp velocity

%ELEMENT sv_InjectProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_InjectProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_HoldProfVis : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=0.0),2((rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=2.0)),(rStartPos:=2.0),iNoOfPoints:=3),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputPressRamp:=9999.9,rMaxRampPress:=9999.9,rMaxRampVel:=5000.0,RampTypeVel:=KCTRL_YXGen_RampType_Linear,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileHold)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_HoldProfVis.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCDeviceActivatedController 
%ELEMENT sv_HoldProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_HoldProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxHoldPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_HoldProfVis.Profile.Points[0].rStartPos
 %PLAUSIBILITY 0.0..60.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT TimeReal 
// To To

%ELEMENT sv_HoldProfVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_HoldProfVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Velocity Velocity

%ELEMENT sv_HoldProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 1..10      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt20 
// Stages Stages

%ELEMENT sv_HoldProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt61  %UNIT MaxRampInjPressureSpec  %ABSREL Forward 
// Max. ramp Max. ramp pressure

%ELEMENT sv_HoldProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL ForwardSpec 
// Max. ramp Max. ramp velocity

%ELEMENT sv_HoldProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_HoldProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_InjectControlParams : tsControlParameters := (rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=1.0,bUsePIDControl:=FALSE) (* parameters for inject PID *)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_InjectControlParams.bUsePIDControl
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT YesNo 
// Use PID Use PID

%ELEMENT sv_InjectControlParams.dActivationDelay
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Time 
// Activation Delay PID Activation Delay

%ELEMENT sv_InjectControlParams.dTN
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// I I parameter inject

%ELEMENT sv_InjectControlParams.dTV
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// D D parameter inject

%ELEMENT sv_InjectControlParams.rKS
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_InjectControlParams.rP
 %PLAUSIBILITY 0.0..999.99      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32 
// P P parameter inject
;
 sv_InjectDeadTimeParams : tsDeadTimeParameters := (bCompensationEnabled:=FALSE,dDeadTime:=t#20ms,dPT2T1:=t#18ms,dPT2T2:=t#18ms,rPT2K:=1.0) (* dead time parameters for inject PID *)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_InjectDeadTimeParams.dPT2T1
     %FORMAT fmt33  %UNIT TimeAccurate 
%ELEMENT sv_InjectDeadTimeParams.dPT2T2
     %FORMAT fmt33  %UNIT TimeAccurate ;
 sv_HoldingControlParams : tsControlParameters := (rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=1.0,bUsePIDControl:=FALSE) (* parameters for holding PID *)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_HoldingControlParams.bUsePIDControl
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT YesNo 
// Use PID Use PID

%ELEMENT sv_HoldingControlParams.dActivationDelay
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Time 
// Activation Delay PID Activation Delay

%ELEMENT sv_HoldingControlParams.dTN
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// I I parameter hold

%ELEMENT sv_HoldingControlParams.dTV
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// D D parameter hold

%ELEMENT sv_HoldingControlParams.rKS
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_HoldingControlParams.rP
 %PLAUSIBILITY 0.0..999.99      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32 
// P P parameter hold
;
 sv_PlastControlParams : tsControlParameters := (rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=1.0,bUsePIDControl:=FALSE) (* parameters for inject PID *)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_PlastControlParams.bUsePIDControl
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT YesNo 
// Use PID Use PID

%ELEMENT sv_PlastControlParams.dActivationDelay
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Time 
// Activation Delay PID Activation Delay

%ELEMENT sv_PlastControlParams.dTN
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// I I parameter plast

%ELEMENT sv_PlastControlParams.dTV
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// D D parameter plast

%ELEMENT sv_PlastControlParams.rKS
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_PlastControlParams.rP
 %PLAUSIBILITY 0.0..999.99      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32 
// P P parameter plast
;
 sv_BackPressureControlParams : tsControlParameters := (rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,bUsePIDControl:=FALSE) (* parameters for holding PID *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_BackPressureControlParams.bUsePIDControl
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT YesNo 
// Use PID Use PID

%ELEMENT sv_BackPressureControlParams.dActivationDelay
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Time 
// Activation Delay PID Activation Delay

%ELEMENT sv_BackPressureControlParams.dTN
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// I I parameter backpressure

%ELEMENT sv_BackPressureControlParams.dTV
 %PLAUSIBILITY t#0.0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// D D parameter backpressure

%ELEMENT sv_BackPressureControlParams.rKS
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_BackPressureControlParams.rP
 %PLAUSIBILITY 0.0..999.99      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32 
// P P parameter backpressure
;
 sv_iSelCavityPressureSensor : DINT := 1 (* which cavity pressure sensor will be used for cut off *)
 %PLAUSIBILITY 1..8    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

// Selected cavity pressure sensor Selected cavity pressure sensor
;
 sv_rMaxPressureMoldCavity : REAL := 2000.0 (* maximum specific pressure for injection *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt50  %UNIT InjectPressure ;
 sv_rCavityPressure : REAL (* selected cavity pressure *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres Cavity pressure
;
 sv_rPressureSet : REAL (* value for pressure *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Inject pressure set Inject pressure set
;
 sv_rSetPressureAbs : REAL (* set value for pressure *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Inject pressure set Inject pressure set
;
 sv_rVelocitySet : REAL (* value for velocity *)
     %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Inject velocity set Inject velocity set
;
 sv_rSetVelocityAbs : REAL (* set value for velocity *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Inject velocity set Inject velocity set
;
 sv_rBackPressureSet : REAL (* set value for backpressure *)
     %FORMAT fmt31  %UNIT InjectBackpressureABS  %ABSREL Forward ;
 sv_rPressureAbs : REAL (* set value for pressure *)
     %UNIT InjectPressureABS ;
 sv_rVelocityAbs : REAL (* set value for velocity *)
    ;
 sv_rPressure : REAL (* set value for pressure *)
    ;
 sv_rVelocity : REAL (* set value for velocity *)
    ;
 sv_rBackPressure : REAL (* set value for backpressure *)
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT InjectBackpressureABS  %ABSREL Forward  %UPDATE_CYCLE "Fast";
 sv_CutOffParams : tsCutOffCriterions := (rPositionThreshold:=5.0,bUsePosition:=TRUE,rDetectionPositionLimit:=300.0)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCDeviceActivatedController  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_CutOffParams.bUseExtDigIn
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// External DI Use external DI

%ELEMENT sv_CutOffParams.bUseInjectPressure
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Inject pressure Use inject pressure

%ELEMENT sv_CutOffParams.bUseMoldPressure
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Mold pressure Use mold pressure

%ELEMENT sv_CutOffParams.bUsePosition
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Screw position Use screw position

%ELEMENT sv_CutOffParams.bUseTimer
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Time Use time

%ELEMENT sv_CutOffParams.dDetectionDeadTime
 %PLAUSIBILITY t#0s..t#10s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// detect dead time detection dead time

%ELEMENT sv_CutOffParams.dTimeThreshold
 %PLAUSIBILITY t#0.0s..t#1.0m      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Inject time Inject time threshold

%ELEMENT sv_CutOffParams.rDetectionPositionLimit
 %PLAUSIBILITY 0.0..%FU.sv_rMaxCutOffPos      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume 
// Cut off activation position Cut off activation position

%ELEMENT sv_CutOffParams.rInjectPressureThreshold
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Inject pressure Inject pressure threshold

%ELEMENT sv_CutOffParams.rMoldPressureThreshold
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureMoldCavity      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pressure Cavity pressure threshold

%ELEMENT sv_CutOffParams.rPositionThreshold
 %PLAUSIBILITY 0.0..%FU.sv_rMaxCutOffPos      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume 
// Screw position Screw position threshold
;
 sv_rScrewStroke : REAL := 300.0 (* stroke of screw in mm *)
 %PLAUSIBILITY 0.0..9999.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke  %ABSREL NoRelative 
// Max. screw stroke Max. screw stroke
;
 sv_rScrewVolume : REAL := 128.0 (* sv_rScrewStroke multiplied by screw size *)
 %PLAUSIBILITY 0.0..10000.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT InjectVolume 
// Max. screw volume Max. screw volume
;
 sv_dActHoldTime : TIME
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. hold time Actual hold time
 %UPDATE_CYCLE "Fast";
 sv_dLastHoldTime : TIME
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last hold time Last hold time
;
 sv_PlastProfVis : KAPPL_VisProfilePlast := (Profile:=(Points:=(rRotation:=15.0,rBackPressure:=40.0,rStartPos:=0.0),(rRotation:=10.0,rBackPressure:=40.0,rStartPos:=30.0),(rRotation:=5.0,rBackPressure:=40.0,rStartPos:=40.0),(rStartPos:=50.0),iNoOfPoints:=2),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputPress:=0.0,rPreOutputBackPress:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rPreOutputBackPressRamp:=100.0,rMaxRampPress:=500.0,rMaxRampVel:=500.0,rMaxRampBackPress:=500.0,RampTypeBackPress:=KCTRL_YXGen_RampType_Linear,RampTypeVel:=KCTRL_YXGen_RampType_Linear,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStagePlast,pCalculatedProfile:=@%FU.sv_CalculatedProfilePlast)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_PlastProfVis.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS InjectionGeneral.hmi.PlastProgrammedVisControl 
%ELEMENT sv_PlastProfVis.Profile.Points[0].rBackPressure
 %PLAUSIBILITY 0.0..system.sv_rMaxBackPressure      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT InjectBackpressureABS  %ABSREL Forward 
// Backpress Backpressure

%ELEMENT sv_PlastProfVis.Profile.Points[0].rBackPressureRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_PlastProfVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_PlastProfVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
// Pressure Pressure

%ELEMENT sv_PlastProfVis.Profile.Points[0].rRotation
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Rotation  %ABSREL Backward 
// Charge Charge

%ELEMENT sv_PlastProfVis.Profile.Points[0].rRotationRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_PlastProfVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT InjectVolume 
// To To

%ELEMENT sv_PlastProfVis.Profile.iNoOfPoints
 %PLAUSIBILITY 1..5      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_PlastProfVis.rMaxRampBackPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt61  %UNIT MaxRampInjBackpressureABS  %ABSREL MaxBackPressure 
// Max. ramp backpres. Max. ramp backpressure

%ELEMENT sv_PlastProfVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Max. ramp Max. ramp

%ELEMENT sv_PlastProfVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Plasticize 
// Max. ramp Max. ramp

%ELEMENT sv_PlastProfVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_PlastProfVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_rActScrewRpm : REAL (* screw rotation speed in RPM *)
     %LIST_GROUP LG_ActInject(3)
 %DISPLAY_LEVEL 1  %FORMAT fmt30  %UNIT RotationRPM 
// Screw revolution Screw revolution
;
 sv_rActScrewCircSpeed : REAL (* screw rotation speed in cm/s circumferential speed *)
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Rotation  %ABSREL Backward 
// Screw revolution Screw revolution
 %UPDATE_CYCLE "Fast";
 sv_rMaxRpm : REAL := 200.0
 %PLAUSIBILITY 1.0..999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT RotationRPM 
// Max. revolution Max. screw revolution
;
 sv_rMaxRpmProfile : REAL := 200.0 (* max. screw revolutions used for plast *)
 %PLAUSIBILITY 1.0..%FU.sv_rMaxRpm    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT RotationRPM 
// Max. plast revolution Max. plast revolution
;
 sv_ConstChargePressure : tsOutput := (Output:=(rOutputValue:=30.0,rRamp:=100.0),PreOutput:=(rOutputValue:=0.0,rRamp:=100.0),rMinOutput:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstChargePressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
// Pressure Charge pressure

%ELEMENT sv_ConstChargePressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT MaxRampPressure 
%ELEMENT sv_ConstChargePressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %FORMAT fmt31  %UNIT MaxRampPressure 
%ELEMENT sv_ConstChargePressure.rMinOutput
     %UNIT Pressure  %ABSREL Backward ;
 sv_bDecompAftPlastEnd : BOOL
    ;
 sv_bDecompBefPlastEnd : BOOL
    ;
 sv_bScrewBackEnd : BOOL
    ;
 sv_ScrewRevVelLintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=200.0,rY:=100.0))) (* lintab for converting cm/s to pump velocity % *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_ScrewRevVelLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRpm      %FORMAT fmt30  %UNIT RotationRPM 
// Revolution Revolution

%ELEMENT sv_ScrewRevVelLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..system.sv_rMaximumVelocity      %FORMAT fmt31  %UNIT Percent 
// Flow Flow

%ELEMENT sv_ScrewRevVelLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..MAX_NO_LINTAB_POINTS      %FORMAT fmt30 
// No. of points Number of points
;
 sv_iActiveStage : DINT
    ;
 sv_InjectTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s) (* set times of inject movement *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_InjectTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. inject time Max. inject time

%ELEMENT sv_InjectTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Inject delay

%ELEMENT sv_InjectTimesSet.dSetDelayTimePump
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Delay pump Inject delay pump

%ELEMENT sv_InjectTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Delay valve Inject delay valve
;
 sv_InjectTimesAct : tsActTimes (* act times of inject movement *)
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_InjectTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Delay Actual inject delay

%ELEMENT sv_InjectTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. inject time Actual inject time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_InjectTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last inject time Last inject time
;
 sv_PlastTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_PlastTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. plasticize time Max. plasticize time

%ELEMENT sv_PlastTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %LIST_GROUP LG_CombinedPlast(2,2)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Plast Plasticize delay

%ELEMENT sv_PlastTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Delay pump Plasticize delay pump

%ELEMENT sv_PlastTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Delay valve Plasticize delay valve
;
 sv_PlastTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_PlastTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Delay Act. plasticize delay

%ELEMENT sv_PlastTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Inject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. plast time Actual plast time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_PlastTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last plast time Last plast time
;
 sv_DecompTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_DecompTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. decomp. time Maximum decompression time

%ELEMENT sv_DecompTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %LIST_GROUP LG_CombinedPlast(1,1)
 %VISI_CLASS InjectionGeneral.hmi.DecompressionUsedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay decomp. before Delay decomp. before

%ELEMENT sv_DecompTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Delay pump Decomp delay pump

%ELEMENT sv_DecompTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Delay valve Decomp delay valve
;
 sv_DecompAfterTimesSet : tsSetTimes
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_DecompAfterTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_DecompAfterTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %LIST_GROUP LG_CombinedPlast(1,1)
 %VISI_CLASS InjectionGeneral.hmi.DecompressionUsedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay decomp. after Delay decomp. after

%ELEMENT sv_DecompAfterTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
%ELEMENT sv_DecompAfterTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY t#0s..t#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time ;
 sv_DecompTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_DecompTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Delay Act. decomp delay

%ELEMENT sv_DecompTimesAct.dActMoveTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. decomp. time Actual decompression time
 %UPDATE_CYCLE "Fast";
 sv_DecompAfterTimesAct : tsActTimes
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_DecompAfterTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_DecompAfterTimesAct.dActMoveTime
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time  %UPDATE_CYCLE "Fast";
 sv_bInjectActive : BOOL := FALSE (* Injection is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Inject active Injection active
;
 sv_rPlastStartPosition : REAL (* position at starting plasticizing *)
     %VARIABLE_GROUP VG_Inject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt32  %UNIT InjectVolume 
// Plast start position Plast start position
;
 sv_rPlastEndPosition : REAL (* position at end of plasticizing *)
     %VARIABLE_GROUP VG_Inject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt32  %UNIT InjectVolume 
// Plast end position Plast end position
;
 sv_iScrewGain : DINT := 1
 %PLAUSIBILITY 1..99    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt20 
// Screw gain Screw gain
;
 sv_rMaxSpeedFwdAccu : REAL := 100.0
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL NoRelative 
// With accumulator Max. inject speed with accumulator
;
 sv_PressureLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=250.0))) (* lintab for measuring with pressure sensor *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Pre.sens. Pressure sensor

%ELEMENT sv_PressureLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_PressureLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..999.0      %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Pressure

%ELEMENT sv_PressureLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Pre.sens. Pressure sensor
;
 sv_SysPressureLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=250.0))) (* lintab for measuring with system pressure sensor *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Sys.pre.sens. System pressure sensor

%ELEMENT sv_SysPressureLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_SysPressureLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..999.0      %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Pressure

%ELEMENT sv_SysPressureLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Sys.pre.sens. System pressure sensor
;
 sv_DecompBefPlastSettings : tsDecompParam := (ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0))))
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp before plasticize Ramp before plasticize

%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Pressure.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Pressure.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp before plasticize Ramp before plasticize

%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Velocity.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.ConstOutput.Velocity.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %UNIT InjectSpeed  %ABSREL Backward 
%ELEMENT sv_DecompBefPlastSettings.Mode
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT DecompressionMode 
// Mode Mode

%ELEMENT sv_DecompBefPlastSettings.dDecompTime
 %PLAUSIBILITY t#0.0s..t#1.0m      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Time Time

%ELEMENT sv_DecompBefPlastSettings.rDecompPos
 %PLAUSIBILITY 0.0..%FU.sv_rScrewVolume      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume  %ABSREL Backward 
// Position Position
;
 sv_DecompAftPlastSettings : tsDecompParam := (ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0))))
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp after plasticize Ramp after plasticize

%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Pressure.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Pressure.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp after plasticize Ramp after plasticize

%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Velocity.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.ConstOutput.Velocity.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %UNIT InjectSpeed  %ABSREL Backward 
%ELEMENT sv_DecompAftPlastSettings.Mode
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT DecompressionMode 
// Mode Mode

%ELEMENT sv_DecompAftPlastSettings.dDecompTime
 %PLAUSIBILITY t#0.0s..t#1.0m      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Time Time

%ELEMENT sv_DecompAftPlastSettings.rDecompPos
 %PLAUSIBILITY PDecAftPlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume  %ABSREL Backward 
// Position Position
;
 sv_DecompInterPosSettings : tsDecompParam := (ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0)))) (* data copied from sv_InstanceDataDecompInterPos *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_DecompInterPosSettings.ConstOutput.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp after plasticize Ramp after plasticize

%ELEMENT sv_DecompInterPosSettings.ConstOutput.Pressure.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.ConstOutput.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.ConstOutput.Pressure.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_DecompInterPosSettings.ConstOutput.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp after plasticize Ramp after plasticize

%ELEMENT sv_DecompInterPosSettings.ConstOutput.Velocity.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.ConstOutput.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.ConstOutput.Velocity.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %UNIT InjectSpeed  %ABSREL Backward 
%ELEMENT sv_DecompInterPosSettings.Mode
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT DecompressionMode 
// Mode Mode

%ELEMENT sv_DecompInterPosSettings.dDecompTime
 %PLAUSIBILITY t#0.0s..t#1.0m      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Time Time

%ELEMENT sv_DecompInterPosSettings.rDecompPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume  %ABSREL Backward 
// Position Position
;
 sv_IntrusionSettings : tsIntrusionParam := (ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0))))
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS InjectionGeneral.hmi.IntrusionProgrammedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %ABSREL Forward 
%ELEMENT sv_IntrusionSettings.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
// Pressure Pressure

%ELEMENT sv_IntrusionSettings.ConstOutput.Pressure.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
%ELEMENT sv_IntrusionSettings.ConstOutput.Pressure.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
%ELEMENT sv_IntrusionSettings.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast      %FORMAT fmt30  %UNIT Rotation  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_IntrusionSettings.ConstOutput.Velocity.PreOutput.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast      %FORMAT fmt30  %UNIT Speed 
%ELEMENT sv_IntrusionSettings.ConstOutput.Velocity.rMinOutput
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast     
%ELEMENT sv_IntrusionSettings.Mode
     %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT IntrusionMode 
// Mode Mode

%ELEMENT sv_IntrusionSettings.dIntrusionTime
 %PLAUSIBILITY t#0.0s..t#999.9s      %FORMAT fmt31  %UNIT Time 
// Time Time

%ELEMENT sv_IntrusionSettings.rBackPressure
 %PLAUSIBILITY 0.0..system.sv_rMaxBackPressure      %FORMAT fmt30  %UNIT InjectBackpressureABS  %ABSREL Forward 
// Backpr. Backpressure
;
 sv_InstanceDataInjectInterPos : tyInstanceListArray := 10((dCalculatedDuration:=t#3s)) (* array with target positions of inject interpos movements *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData 
%ELEMENT sv_InstanceDataInjectInterPos[0].dCalculatedDuration
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration

%ELEMENT sv_InstanceDataInjectInterPos[0].dDelay
 %PLAUSIBILITY t#0s..t#60s      %LIST_GROUP LG_InjectInterPos(4,4)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Delay

%ELEMENT sv_InstanceDataInjectInterPos[0].rAcceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %LIST_GROUP LG_InjectInterPos(2,2)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp up Ramp up

%ELEMENT sv_InstanceDataInjectInterPos[0].rDeceleration
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %LIST_GROUP LG_InjectInterPos(3,3)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Ramp down Ramp down

%ELEMENT sv_InstanceDataInjectInterPos[0].rTargetValue
 %PLAUSIBILITY 0.0..%FU.sv_rScrewVolume      %LIST_GROUP LG_InjectInterPos(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume 
// Position Position
;
 sv_InstanceDataDecompInterPos : tyInstanceListArrayDecomp := 10((dCalculatedDuration:=t#3s)) (* array with target positions of decomp interpos movements *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData 
%ELEMENT sv_InstanceDataDecompInterPos[0].Mode
     %LIST_GROUP LG_DecompInterPos(1,1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT DecompInterPosMode 
// Mode Mode

%ELEMENT sv_InstanceDataDecompInterPos[0].dCalculatedDuration
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Duration Duration

%ELEMENT sv_InstanceDataDecompInterPos[0].dDelay
 %PLAUSIBILITY t#0s..t#60s      %LIST_GROUP LG_DecompInterPos(6,6)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Delay

%ELEMENT sv_InstanceDataDecompInterPos[0].dTime
 %PLAUSIBILITY t#0s..t#60s      %LIST_GROUP LG_DecompInterPos(3,3)
 %VISI_CLASS InjectionGeneral.hmi.DecompIntPosTimeVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Time Time

%ELEMENT sv_InstanceDataDecompInterPos[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %LIST_GROUP LG_DecompInterPos(4,4)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_InstanceDataDecompInterPos[0].rTargetValue
 %PLAUSIBILITY 0.0..%FU.sv_rScrewVolume      %LIST_GROUP LG_DecompInterPos(2,2)
 %VISI_CLASS InjectionGeneral.hmi.DecompIntPosPositionVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectVolume  %ABSREL Backward 
// Position Position

%ELEMENT sv_InstanceDataDecompInterPos[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %LIST_GROUP LG_DecompInterPos(5,5)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT InjectSpeed  %ABSREL Backward 
// Velocity Velocity
;
 sv_MinOutputInject : tsMinOutput
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_MinOutputInject.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Min. profile output Min. profile output

%ELEMENT sv_MinOutputInject.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Min. profile output Min. profile output
;
 sv_MinOutputPlast : tsMinOutput
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_MinOutputPlast.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
// Min. profile output Min. profile output

%ELEMENT sv_MinOutputPlast.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Rotation  %ABSREL Backward 
// Min. profile output
;
 sv_MinOutputDecomp : tsMinOutput
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_MinOutputDecomp.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Min. output Min. output

%ELEMENT sv_MinOutputDecomp.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectSpeed  %ABSREL Backward 
// Min. output Min. output
;
 sv_rActPressureHydr : REAL (* actual pressure in hydraulic cyinder(calculated from analog input of pressure sensor) *)
     %DISPLAY_LEVEL 1  %FORMAT fmt30  %UNIT InjectPressureABS  %ABSREL Forward 
// Inject pressure Actual inject pressure
;
 sv_rActSysPressure : REAL (* actual pressure in hydraulic cyinder(calculated from analog input of pressure sensor) *)
     %DISPLAY_LEVEL 1  %FORMAT fmt30  %UNIT InjectPressureABS  %ABSREL Forward 
// Inject pressure Actual inject pressure
;
 sv_rActPressure : REAL (* specific pressure at screw tip (calculated from sv_rActPressureHydr) *)
     %LIST_GROUP LG_ActInject(1)
 %DISPLAY_LEVEL 1  %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Inject pressure Actual inject pressure
 %UPDATE_CYCLE "Fast";
 sv_ConstDecompSetup : tsVelPre := (Velocity:=(Output:=(rOutputValue:=25.0)),Pressure:=(Output:=(rOutputValue:=50.0))) (* const output for decomp in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstDecompSetup.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_ConstDecompSetup.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstDecompSetup.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_ConstDecompSetup.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_ConstDecompSetup.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstDecompSetup.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward ;
 sv_ConstDecompSetupServo : tsVelPre := (Velocity:=(Output:=(rOutputValue:=-10.0),rMinOutput:=-10.0),Pressure:=(Output:=(rOutputValue:=50.0))) (* const output for decomp in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstDecompSetupServo.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Pressure Pressure

%ELEMENT sv_ConstDecompSetupServo.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstDecompSetupServo.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_ConstDecompSetupServo.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_ConstDecompSetupServo.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstDecompSetupServo.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward ;
 sv_ConstInjectSetup : tsVelPre := (Velocity:=(Output:=(rOutputValue:=25.0,rRamp:=500.0)),Pressure:=(Output:=(rOutputValue:=30.0,rRamp:=9999.9))) (* const output for inject in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstInjectSetup.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectPressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_ConstInjectSetup.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt61  %UNIT MaxRampInjPressureSpec  %ABSREL Forward 
// Ramp Ramp

%ELEMENT sv_ConstInjectSetup.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax      %UNIT MaxRampInjPressureSpec  %ABSREL Forward 
%ELEMENT sv_ConstInjectSetup.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Velocity Velocity

%ELEMENT sv_ConstInjectSetup.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL ForwardSpec 
// Ramp Ramp

%ELEMENT sv_ConstInjectSetup.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL ForwardSpec ;
 sv_ConstInjectSetupServo : tsVelPre := (Velocity:=(Output:=(rOutputValue:=10.0)),Pressure:=(Output:=(rOutputValue:=30.0))) (* const output for inject in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstInjectSetupServo.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT InjectPressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_ConstInjectSetupServo.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt61  %UNIT MaxRampInjPressureSpec  %ABSREL Forward 
// Ramp Ramp

%ELEMENT sv_ConstInjectSetupServo.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax      %UNIT MaxRampInjPressureSpec  %ABSREL Forward 
%ELEMENT sv_ConstInjectSetupServo.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Velocity Velocity

%ELEMENT sv_ConstInjectSetupServo.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL ForwardSpec 
// Ramp Ramp

%ELEMENT sv_ConstInjectSetupServo.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward ;
 sv_bOutputActive : BOOL (* Output is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Output active Output active
;
 sv_bPreOutputReady : BOOL (* PreOutput is ready *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Pre output ready Pre output ready
;
 sv_ConstPlastSetup : tsVelPre := (Velocity:=(Output:=(rOutputValue:=20.0)),Pressure:=(Output:=(rOutputValue:=40.0))) (* const output for plast in setup mode *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstPlastSetup.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
// Pressure Pressure

%ELEMENT sv_ConstPlastSetup.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstPlastSetup.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampPressure  %ABSREL Backward 
%ELEMENT sv_ConstPlastSetup.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Rotation  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_ConstPlastSetup.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Plasticize 
// Ramp Ramp

%ELEMENT sv_ConstPlastSetup.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Plasticize ;
 sv_bTransducerError : BOOL
    
// Transducer error Transducer error
;
 sv_bPressureSensorError : BOOL
    
// Pressure sensor error Pressure sensor error
;
 sv_bSysPressureSensorError : BOOL
    
// Pressure sensor error Pressure sensor error
;
 sv_ImpulseParam : KCTRL_Impulse_Param := (rImpVMin:=0.0,rTime:=60.0) (* parameters for rpm measurement *)
    ;
 sv_rCutOffPosition : REAL (* position where cut off was detected *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Cut off position Cut off position
;
 sv_rHoldPosition : REAL (* position at the end of hold phase *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Hold end position Hold end position
;
 sv_rCushion : REAL (* smallest screw position during hold phase *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Cushion Cushion
;
 sv_bPressureSensorAvailable : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Injection Pressure Sensor Available Injection Pressure Sensor Available
;
 sv_bSysPressureSensorAvailable : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Injection Pressure Sensor Available Injection Pressure Sensor Available
;
 sv_bCutOffDetected : BOOL (* cutoff was detected *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cut Off detected Cut Off detected
;
 sv_dActDecompAfterTime : TIME
     %VARIABLE_GROUP VG_Inject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. decomp. time after plast Actual decompression time after plast
 %UPDATE_CYCLE "Fast";
 sv_dActDecompBeforeTime : TIME
     %VARIABLE_GROUP VG_Inject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. decomp. time before plast Actual decompression time before plast
 %UPDATE_CYCLE "Fast";
 sv_dLastDecompAfterTime : TIME
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last decomp. time after plast Last decompression time after plast
;
 sv_dLastDecompBeforeTime : TIME
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last decomp. time before plast Last decompression time before plast
;
 sv_CylinderData : tsCylinderData := (rCylinderDiameter:=100.0,rPistonRodDiameter:=30.0,iNumCylinders:=2,bUseSmallSize:=TRUE) (* parameters of the cylinder *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_CylinderData.bUseSmallSize
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Do injection by ring area Do injection by ring area

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
 sv_LintabOutFwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=2000.0,rY:=145.0))) (* lintab for inject/hold  specific Pre -> Pump Pre *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rX
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Pressure  %ABSREL NoRelative 
%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rY
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent ;
 sv_LintabOutFwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rX
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT InjectVolumeSpeed 
%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rY
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent ;
 sv_LintabOutBwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rX
     %UNIT Pressure  %ABSREL NoRelative 
%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutBwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutBwdV.LintabPoints.Point[0].rX
     %UNIT InjectVolumeSpeed 
%ELEMENT sv_LintabOutBwdV.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutPlastP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0))) (* lintab for plasticizing in circumfence speed Pre -> Pre *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutPlastP.LintabPoints.Point[0].rX
     %UNIT Pressure  %ABSREL NoRelative 
%ELEMENT sv_LintabOutPlastP.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutPlastV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=35.0,rY:=100.0))) (* lintab for plasticizing in circumfence speed (cm/s) -> % *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutPlastV.LintabPoints.Point[0].rX
     %UNIT InjectVolumeSpeed  %ABSREL Backward 
%ELEMENT sv_LintabOutPlastV.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_rMaxSpeedReducePercent : REAL := 0.0 (* reduce calculated max speed with this percentage  *)
 %PLAUSIBILITY 0.0..100.0    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent 
// Max.speed reduce factor Max.speed reduce factor
;
 sv_rMaxSpeedBwdCalc : REAL := 40.0 (* maximum specific speed for injection in mm/s (calculated/autocalib) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectSpeed  %ABSREL NoRelative 
// Max. speed calc. bwd Max. speed calc. bwd
;
 sv_rMaxSpeedFwdCalc : REAL := 100.0 (* maximum speed for decompression (calculated/autocalib) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectSpeed  %ABSREL NoRelative 
// Max. speed calc. fwd Max. speed calc. fwd
;
 sv_rMaxRpmReducePercent : REAL := 0.0 (* reduce max. profile RPM with this percentage  *)
 %PLAUSIBILITY 0.0..100.0    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent 
// Max. RPM reduce factor Max. RPM reduce factor
;
 sv_rMaxSpeedBwd : REAL := 40.0 (* maximum speed for decompression (user) *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectSpeed  %ABSREL NoRelative 
// Max. speed backward Max. speed backward
;
 sv_rMaxSpeedFwd : REAL := 100.0 (* maximum specific speed for injection in mm/s (user) *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL NoRelative 
// Max. speed forward Max. speed forward
;
 sv_rMaxSpeedFwdCalib : REAL := 0.0
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdCalc    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectSpeed  %ABSREL NoRelative 
// Max. speed forward Max. inject speed
;
 sv_rMaxSpeedBwdCalib : REAL := 0.0
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwdCalc    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectSpeed  %ABSREL NoRelative 
// Max. speed backward Max. speed limit decompression
;
 sv_rMaxHoldPresAllow : REAL := 2000.0 (* maximum allowable specific pressure for hold *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL NoRelative 
// Allowable hold pressure Allowable hold pressure
;
 sv_rMaxInjPresAllow : REAL := 2000.0 (* maximum allowable specific pressure for injection *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL NoRelative 
// Allowable inject pressure Allowable inject pressure
;
 sv_rMaxPressureFwd : REAL := 2000.0 (* maximum specific pressure for injection *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL NoRelative ;
 sv_rMaxPressureBwd : REAL := 145.0 (* maximum pressure for decompression *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Pressure  %ABSREL NoRelative ;
 sv_rMaxRotationPlast : REAL := 35.0 (* maximum speed for plast *)
 %PLAUSIBILITY FPlausRotationPlast    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Rotation  %ABSREL NoRelative 
// Max. plast velocity Max. plast velocity
;
 sv_rMaxPressurePlast : REAL := 145.0 (* maximum pressure for plast *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Pressure  %ABSREL NoRelative ;
 sv_rScrewDiameter : REAL := 34.0 (* diameter of screw in mm *)
 %PLAUSIBILITY 0.1..999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Stroke 
// Screw Diameter Screw Diameter
;
 sv_rMaxCutOffPos : REAL (* max. for cutoff position (necessary for plausibility) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT InjectVolume 
// max. cutoff pos max. cutoff pos
;
 sv_rInjectTargetPosition : REAL (* Inject target position for sequenzer *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT InjectVolume 
// Inject position Inject target position
;
 sv_rInjPeakPressure : REAL (* measured inject peak pressure *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt40  %UNIT InjectPressure 
// Max. pressure Max. pressure
;
 sv_rInjPeakVelocity : REAL (* measured inject peak velocity *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT InjectVolumeSpeed 
// Max. velocity Max. velocity
;
 sv_rInjPeakPosition : REAL (* measured inject peak position *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt42  %UNIT InjectVolume 
// Min. position Min. position
;
 sv_rMaxPlastEnd : REAL (* max. for last point of plast profile (necessary for plausibility) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT InjectVolume 
// max. plast end max. plast end
;
 sv_IMM_Type : KAPPL_IMM_Type := nKAPPL_IMM_PQ (* type of mold machine *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Machine MoldMachineType
;
 sv_bDiExtCutOff : BOOL (* external cut off event *)
    ;
 sv_ServoValveControlData : KAPPL_ServoValveControlData
    ;
 sv_ServoValveControllerMode : KAPPL_ServoValveControllerMode
    ;
 sv_rServoOutput : REAL
    ;
 sv_rActScrewVelocity : REAL
    ;
 sv_PlastMotor : tnMotorType := nHydraulic (* type of plast motor *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT MoldAdjustMotor 
// Plasticize motor Plasticize motor
;
 sv_ColdDropSettings : tsColdDropParams := (dColdDropTime:=t#1s,ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0,rRamp:=500.0)),Pressure:=(Output:=(rOutputValue:=30.0,rRamp:=9999.9))))
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS InjectionGeneral.hmi.ColdDropProgrammedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_ColdDropSettings.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Pressure Pressure

%ELEMENT sv_ColdDropSettings.ConstOutput.Pressure.Output.rRamp
 %PLAUSIBILITY 0.0..9999.9      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41 
// Ramp Ramp

%ELEMENT sv_ColdDropSettings.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Velocity Velocity

%ELEMENT sv_ColdDropSettings.ConstOutput.Velocity.Output.rRamp
 %PLAUSIBILITY 0.0..9999.9      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41 
// Ramp Ramp

%ELEMENT sv_ColdDropSettings.bUse
     %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Cold slug eject Use cold slug eject

%ELEMENT sv_ColdDropSettings.dColdDropTime
 %PLAUSIBILITY t#0.0s..t#999.9s      %FORMAT fmt31  %UNIT Time 
// Time Time
;
 sv_bPlastParallel : BOOL
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT OnOff 
// Plast movement parallel Plast movement parallel
;
 sv_SysPresMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_SysPresMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_SysPresMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_SysPresMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_SysPresMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_SysPresMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_PresMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_PresMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_PresMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_PresMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_PresMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_PresMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_ScrewMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ScrewMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_ScrewMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_ScrewMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_ScrewMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_ScrewMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_rCutOffPressure : REAL (* spec Injectpressure at cut off *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT InjectPressure  %ABSREL Forward 
// Cut off pressure Cut off pressure
;
 sv_rMaxPressureEndHold : REAL := 10.0 (* 10.0 *)
 %PLAUSIBILITY 0.0..100.0    RETAIN  %FORMAT fmt41  %UNIT Pressure  %ABSREL Forward 
// Max pressure end hold Max pressure end hold
;
 sv_rImpulseFilterLimit : REAL := 0.0 (* Limit for filter of impulse measuring, if > 0.0 use filter *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

// Imp. filter limit Impulse filter limit
;
 sv_rCutOffCavityPressure : REAL (* spec Cavity pressure at cut off *)
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cut off mold pressure Cut off mold pressure
;
 sv_ColdDropTimesAct : tsActTimes
    
// Cold slug eject times act Cold slug eject times act

%ELEMENT sv_ColdDropTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Delay Actual cold slug eject delay

%ELEMENT sv_ColdDropTimesAct.dActMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. cold slug eject time Actual cold slug eject time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_ColdDropTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last cold slug eject time Last cold slug eject time
;
 sv_ColdDropTimesSet : tsSetTimes
   RETAIN  %VARIABLE_GROUP VG_MoldData 
// Cold slug eject times set Cold slug eject times set

%ELEMENT sv_ColdDropTimesSet.dMaxMoveTime
 %PLAUSIBILITY T#0s..T#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. cold slug eject time Max. cold slug eject time

%ELEMENT sv_ColdDropTimesSet.dSetDelayTime
     %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Cold slug eject delay

%ELEMENT sv_ColdDropTimesSet.dSetDelayTimePump
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt22  %UNIT Time 
// Delay pump Cold slug eject delay pump

%ELEMENT sv_ColdDropTimesSet.dSetDelayTimeValve
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt22  %UNIT Time 
// Delay valve Cold slug eject delay valve
;
 sv_IntrusionTimesAct : tsActTimes
    
// Intrusion times act

%ELEMENT sv_IntrusionTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Delay Actual intrusion delay

%ELEMENT sv_IntrusionTimesAct.dActMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. intrusion time Actual intrusion time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_IntrusionTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last intrusion time Last intrusion time
;
 sv_IntrusionTimesSet : tsSetTimes
   RETAIN  %VARIABLE_GROUP VG_MoldData 
// Intrusion times set Intrusion times set

%ELEMENT sv_IntrusionTimesSet.dMaxMoveTime
 %PLAUSIBILITY T#0s..T#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. intrusion time Max. intrusion time

%ELEMENT sv_IntrusionTimesSet.dSetDelayTime
 %PLAUSIBILITY T#0s..T#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Delay Intrusion delay

%ELEMENT sv_IntrusionTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt22  %UNIT Time 
// Delay pump Intrusion delay pump

%ELEMENT sv_IntrusionTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt22  %UNIT Time 
// Delay valve Intrusion delay valve
;
 sv_InstanceCounter : INT := 0
    ;
 sv_rMaxSpeedFwdSpec : REAL := 40.0 (* maximum specific speed for injection in cm³/s *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT InjectVolumeSpeed  %ABSREL NoRelative 
// Max. speed forward Max. speed forward
;
 sv_DerivationEstimateParam : tsDerivationEstimateParam := (bUseDerivationEstimator:=FALSE,iN:=1,dT:=T#20ms,dMeasCycleTime:=T#2ms,iNu:=0,estimatorName:='screwVelocityEstimator')
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_HoldingDeadTimeParams : tsDeadTimeParameters := (bCompensationEnabled:=FALSE,dDeadTime:=t#20ms,dPT2T1:=t#18ms,dPT2T2:=t#18ms,rPT2K:=1.0) (* dead time parameters for holding PID *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

// Hold set val Hold set value

%ELEMENT sv_HoldingDeadTimeParams.dPT2T1
 %PLAUSIBILITY t#0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// Filter time Filter time constant

%ELEMENT sv_HoldingDeadTimeParams.dPT2T2
     %FORMAT fmt33  %UNIT TimeAccurate ;
 sv_LintabOutFwdVServo : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdVServo.LintabPoints.Point[0].rX
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Speed  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdVServo.LintabPoints.Point[0].rY
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent ;
 sv_bServoValveLimitActive : BOOL (* servo valve set value limitation active *)
    ;
 sv_bValveServoInj1Ready : BOOL := TRUE
    ;
 sv_rScrewVelocityEstimateAbs : REAL
    ;
 sv_iActiveStageInject : DINT (* active profile stage inject *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iActiveStagePlast : DINT (* active profile stage plast *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_rMaxPlausFirstInjectStage : REAL (* max. plaus for first inject stage *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT InjectVolume ;
 sv_CalculatedProfileInject : tCalculatedProfiles
     %ABSREL Forward 
%ELEMENT sv_CalculatedProfileInject.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT InjectVolume 
%ELEMENT sv_CalculatedProfileInject.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT InjectPressure 
%ELEMENT sv_CalculatedProfileInject.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT InjectVolume 
%ELEMENT sv_CalculatedProfileInject.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT InjectVolumeSpeed ;
 sv_CalculatedProfileHold : tCalculatedProfiles
     %ABSREL Forward 
%ELEMENT sv_CalculatedProfileHold.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT TimeReal 
%ELEMENT sv_CalculatedProfileHold.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT InjectPressure 
%ELEMENT sv_CalculatedProfileHold.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT TimeReal 
%ELEMENT sv_CalculatedProfileHold.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT InjectVolumeSpeed ;
 sv_CalculatedProfilePlast : tCalculatedProfiles
    
%ELEMENT sv_CalculatedProfilePlast.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT InjectVolume  %ABSREL Backward 
%ELEMENT sv_CalculatedProfilePlast.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT InjectBackpressureABS  %ABSREL Forward 
%ELEMENT sv_CalculatedProfilePlast.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT InjectVolume  %ABSREL Backward 
%ELEMENT sv_CalculatedProfilePlast.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Rotation  %ABSREL Backward ;
 sv_PressureLimitControlParams : tsControlParameters := (rP:=1.0,dTN:=t#10.0s,dTV:=t#0.0s,rKS:=0.0,bUsePIDControl:=FALSE) (* parameter for pressure limit controler during precutoff *)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_PressureLimitControlParams.bUsePIDControl
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT YesNo 
// Use PID Use PID

%ELEMENT sv_PressureLimitControlParams.dActivationDelay
 %PLAUSIBILITY T#0s..T#60s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Time 
// Activation Delay PID Activation Delay

%ELEMENT sv_PressureLimitControlParams.dTN
 %PLAUSIBILITY t#0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// I I parameter press. limit

%ELEMENT sv_PressureLimitControlParams.dTV
 %PLAUSIBILITY t#0s..t#999.99s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt33  %UNIT TimeAccurate 
// D D parameter press. limit

%ELEMENT sv_PressureLimitControlParams.rKS
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_PressureLimitControlParams.rP
 %PLAUSIBILITY 0.0..999.99      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32 
// P P parameter press. limit
;
 sv_PressureLimitVelocityParams : tsControlParameters := (rP:=1.0,dTN:=t#10.0s,dTV:=t#0.0s,rKS:=0.0,bUsePIDControl:=FALSE) (* parameter for pressure limit controler during precutoff *)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_PressureLimitVelocityParams.bUsePIDControl
    
// Use Inject Pressure Limit Velocity Use Inject Pressure Limit Velocity

%ELEMENT sv_PressureLimitVelocityParams.dTN
     %FORMAT fmt32  %UNIT Time 
// I I parameter press. limit

%ELEMENT sv_PressureLimitVelocityParams.dTV
     %FORMAT fmt32  %UNIT Time 
// D D parameter press. limit

%ELEMENT sv_PressureLimitVelocityParams.rP
     %FORMAT fmt32 
// P P parameter press. limit
;
 sv_rScrewZeroPosition : REAL (* zero position of screw *)
    ;
 sv_RequiredPumpsInject : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=6000)
    
%ELEMENT sv_RequiredPumpsInject.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Injection Injection
;
 sv_RequiredPumpsDecomp : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=6002)
    
%ELEMENT sv_RequiredPumpsDecomp.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Decompression Decompression
;
 sv_RequiredPumpsPlast : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=6001)
    
%ELEMENT sv_RequiredPumpsPlast.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Plast Plast
;
 sv_HydrMaxValuesInject : tsHydrMaxValues (* hydraulic max values for inject *)
    ;
 sv_HydrMaxValuesDecomp : tsHydrMaxValues (* hydraulic max values for decompression *)
    ;
 sv_HydrMaxValuesPlast : tsHydrMaxValues (* hydraulic max values for plast *)
    ;
 sv_rSmoothFactor : REAL := 0.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Percent 
// Smooth factor inject Smooth factor inject
;
 sv_rScrewSizeFactor : REAL := 1.0
    ;
 sv_bUseCalcedPressureStartRamp : BOOL
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Use calced start  ramp Use calced start ramp for hold pressure profile
;
%END

%SYSTEM_ALARM
  erColdDropNotPossible
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Cold slug eject not possible because nozzle bwd not activated{#]Cold slug eject is only possible when the \u000anozzle doesn't touch the fixed plate.{#]Cold slug eject helps ejecting some material during a semi- or full-automatic \u000acycle. This can only be done if the nozzle moves backward during the cycle. \u000aIf the nozzle backward mode is set to "no" also the cold drop feature is not \u000apossible and this alarm is raised.{#]If cold slug eject should be used change the {Nozzle1.sv_NozzleBwdMode} to \u000asomething different than 'No'.<br>\u000aOr set the {Injection1.sv_ColdDropSettings.bUse:l} to FALSE.
 ;
  erAllowablePresTooHigh
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Allowable pressure is greater than max. possible pressure!{#]User setting for allowable pressure \u000aexceeds the maximum possible pressure.{#]For injection two allowable pressures can be set, one for injection and one \u000afor hold phase. If one of these two settings exceeds the basic limitation of \u000amaximum possible pressure this alarm is raised.{#]Adjust the setting for {Injection1.sv_rMaxInjPresAllow:l} and or the setting \u000afor {Injection1.sv_rMaxHoldPresAllow:l} in order to fit the limits of the maximum \u000apossible pressure.
 ;
  erSafetyGateOpenAndNozzleFwd
 %CLASS 5 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES

// Plasticize not allowed, SafetyGate open and Nozzle forward{#]Plasticizing cannot be executed while \u000anozzle is forward and mold safety gate is \u000aopen.{#]As long as mold safety gate is open and the nozzle is in its forward endposition \u000aplasticizing is not allowed.{#]Either close mold safety gate or move nozzle backward before \u000aretrying plasticizing.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
166 
@SysVar @RT(14)sv_ScrewLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=300.0))) @RT(27)lintab for screw transducer 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(14)sv_ScrewLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)lintab for screw transducer 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ScrewLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ScrewLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(12)InjectStroke @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rScrewStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ScrewLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rScrewPositionAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)screw position in mm 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw position @RT(14)Screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rScrewPositionAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)screw position in mm 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(12)InjectStroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw position @RT(14)Screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rScrewVelocityAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)screw velocity in mm/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw velocity @RT(14)Screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rScrewVelocityAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)screw velocity in mm/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw velocity @RT(14)Screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rScrewPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)specific screw position im cm³ 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(2) @RT(0) 
@RT(14)Screw position @RT(14)Screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rScrewPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)specific screw position im cm³ 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(2) @RT(0) 
@RT(14)Screw position @RT(14)Screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rScrewVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)screw velocity in cm³/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw velocity @RT(14)Screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rScrewVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)screw velocity in cm³/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw velocity @RT(14)Screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rScrewVelocityMean @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)Mean screw velocity during inject movement in cm³/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mean screw velocity @RT(19)Mean screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rScrewVelocityMean @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mean screw velocity @RT(19)Mean screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rScrewVelocityMin @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)Minimum screw velocity during inject movement in cm³/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Minimum screw velocity @RT(22)Minimum screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rScrewVelocityMin @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Minimum screw velocity @RT(22)Minimum screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rScrewVelocityMax @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(54)Maximum screw velocity during inject movement in cm³/s 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Maximum screw velocity @RT(22)Maximum screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rScrewVelocityMax @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Maximum screw velocity @RT(22)Maximum screw velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_InjectProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(719)(Profile:=(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=20.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=5.0),iNoOfPoints:=4),bOpenEndProfile:=TRUE,rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rMaxRampPress:=9999.0,rMaxRampVel:=500.0,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageInject,pCalculatedProfile:=@%FU.sv_CalculatedProfileInject) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCDeviceActivatedController 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(16)sv_InjectProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCDeviceActivatedController 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_InjectProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(47)InjectionGeneral.hmi.InjectProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_InjectProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_InjectProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_InjectProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_InjectProfVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_InjectProfVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_InjectProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..10 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_InjectProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt61 @RT(22)MaxRampInjPressureSpec @RT(7)Forward @RT(0) 
@RT(62)cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Max. ramp @RT(18)Max. ramp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_InjectProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(11)ForwardSpec @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Max. ramp @RT(18)Max. ramp velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_InjectProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_InjectProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_HoldProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(484)(Profile:=(Points:=(rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=0.0),2((rPressure:=50.0,rPressRamp:=100.0,rVelocity:=10.0,rVelRamp:=100.0,rStartPos:=2.0)),(rStartPos:=2.0),iNoOfPoints:=3),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputVel:=0.0,rPreOutputPressRamp:=9999.9,rMaxRampPress:=9999.9,rMaxRampVel:=5000.0,RampTypeVel:=KCTRL_YXGen_RampType_Linear,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileHold) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(14)sv_HoldProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_HoldProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCDeviceActivatedController 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_HoldProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_HoldProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(29)0.0..%FU.sv_rMaxHoldPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_HoldProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(8)TimeReal @RT(0) @RT(0) 
@RT(9)0.0..60.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_HoldProfVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_HoldProfVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_HoldProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..10 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_HoldProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt61 @RT(22)MaxRampInjPressureSpec @RT(7)Forward @RT(0) 
@RT(62)cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Max. ramp @RT(18)Max. ramp pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_HoldProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(11)ForwardSpec @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Max. ramp @RT(18)Max. ramp velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_HoldProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_HoldProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_InjectControlParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(64)(rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=1.0,bUsePIDControl:=FALSE) @RT(25)parameters for inject PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(22)sv_InjectControlParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)parameters for inject PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_InjectControlParams.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Use PID @RT(7)Use PID @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_InjectControlParams.dActivationDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Activation Delay @RT(20)PID Activation Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_InjectControlParams.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(18)I parameter inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_InjectControlParams.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(18)D parameter inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_InjectControlParams.rKS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_InjectControlParams.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)P @RT(18)P parameter inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_InjectDeadTimeParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tsDeadTimeParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(88)(bCompensationEnabled:=FALSE,dDeadTime:=t#20ms,dPT2T1:=t#18ms,dPT2T2:=t#18ms,rPT2K:=1.0) @RT(35)dead time parameters for inject PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(23)sv_InjectDeadTimeParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)dead time parameters for inject PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_InjectDeadTimeParams.dPT2T1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#18ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_InjectDeadTimeParams.dPT2T2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#18ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_HoldingControlParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(64)(rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=1.0,bUsePIDControl:=FALSE) @RT(26)parameters for holding PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(23)sv_HoldingControlParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)parameters for holding PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_HoldingControlParams.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Use PID @RT(7)Use PID @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_HoldingControlParams.dActivationDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Activation Delay @RT(20)PID Activation Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_HoldingControlParams.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(16)I parameter hold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_HoldingControlParams.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(16)D parameter hold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_HoldingControlParams.rKS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_HoldingControlParams.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)P @RT(16)P parameter hold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_PlastControlParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(64)(rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=1.0,bUsePIDControl:=FALSE) @RT(25)parameters for inject PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(21)sv_PlastControlParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)parameters for inject PID 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_PlastControlParams.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Use PID @RT(7)Use PID @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_PlastControlParams.dActivationDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Activation Delay @RT(20)PID Activation Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_PlastControlParams.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(17)I parameter plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_PlastControlParams.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(17)D parameter plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_PlastControlParams.rKS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_PlastControlParams.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)P @RT(17)P parameter plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_BackPressureControlParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(55)(rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,bUsePIDControl:=FALSE) @RT(26)parameters for holding PID 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(28)sv_BackPressureControlParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)parameters for holding PID 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_BackPressureControlParams.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Use PID @RT(7)Use PID @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_BackPressureControlParams.dActivationDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Activation Delay @RT(20)PID Activation Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_BackPressureControlParams.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(24)I parameter backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_BackPressureControlParams.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(17)t#0.0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(24)D parameter backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_BackPressureControlParams.rKS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_BackPressureControlParams.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)P @RT(24)P parameter backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_iSelCavityPressureSensor @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(53)which cavity pressure sensor will be used for cut off 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)1..8 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Selected cavity pressure sensor @RT(31)Selected cavity pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_iSelCavityPressureSensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)which cavity pressure sensor will be used for cut off 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)1..8 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Selected cavity pressure sensor @RT(31)Selected cavity pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rMaxPressureMoldCavity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)2000.0 @RT(39)maximum specific pressure for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(11)VG_MoldData @RT(5)fmt50 @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMaxPressureMoldCavity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)maximum specific pressure for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(11)VG_MoldData @RT(5)fmt50 @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rCavityPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)selected cavity pressure 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Cavity pres @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rCavityPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)selected cavity pressure 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Cavity pres @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rPressureSet @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)value for pressure 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject pressure set @RT(19)Inject pressure set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rPressureSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)value for pressure 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject pressure set @RT(19)Inject pressure set @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rSetPressureAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for pressure 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject pressure set @RT(19)Inject pressure set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rSetPressureAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for pressure 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject pressure set @RT(19)Inject pressure set @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rVelocitySet @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)value for velocity 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject velocity set @RT(19)Inject velocity set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rVelocitySet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)value for velocity 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject velocity set @RT(19)Inject velocity set @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rSetVelocityAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for velocity 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject velocity set @RT(19)Inject velocity set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rSetVelocityAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for velocity 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Inject velocity set @RT(19)Inject velocity set @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rBackPressureSet @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)set value for backpressure 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(21)InjectBackpressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rBackPressureSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)set value for backpressure 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(21)InjectBackpressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rPressureAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(17)InjectPressureABS @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rPressureAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(17)InjectPressureABS @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rVelocityAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rVelocityAbs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)set value for velocity 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rBackPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)set value for backpressure 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(21)InjectBackpressureABS @RT(7)Forward @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rBackPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)set value for backpressure 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(21)InjectBackpressureABS @RT(7)Forward @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_CutOffParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tsCutOffCriterions @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(75)(rPositionThreshold:=5.0,bUsePosition:=TRUE,rDetectionPositionLimit:=300.0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCDeviceActivatedController 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(15)sv_CutOffParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCDeviceActivatedController 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_CutOffParams.bUseExtDigIn @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)External DI @RT(15)Use external DI @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_CutOffParams.bUseInjectPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject pressure @RT(19)Use inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_CutOffParams.bUseMoldPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Mold pressure @RT(17)Use mold pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_CutOffParams.bUsePosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw position @RT(18)Use screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_CutOffParams.bUseTimer @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(8)Use time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_CutOffParams.dDetectionDeadTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#10s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)detect dead time @RT(19)detection dead time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CutOffParams.dTimeThreshold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0.0s..t#1.0m @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Inject time @RT(21)Inject time threshold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CutOffParams.rDetectionPositionLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMaxCutOffPos @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Cut off activation position @RT(27)Cut off activation position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_CutOffParams.rInjectPressureThreshold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject pressure @RT(25)Inject pressure threshold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_CutOffParams.rMoldPressureThreshold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(34)0.0..%FU.sv_rMaxPressureMoldCavity @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Cavity pressure @RT(25)Cavity pressure threshold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_CutOffParams.rPositionThreshold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(25)0.0..%FU.sv_rMaxCutOffPos @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw position @RT(24)Screw position threshold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rScrewStroke @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(21)stroke of screw in mm 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. screw stroke @RT(17)Max. screw stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rScrewStroke @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)stroke of screw in mm 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. screw stroke @RT(17)Max. screw stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rScrewVolume @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)128.0 @RT(40)sv_rScrewStroke multiplied by screw size 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(12)0.0..10000.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. screw volume @RT(17)Max. screw volume @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rScrewVolume @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(40)sv_rScrewStroke multiplied by screw size 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(12)0.0..10000.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. screw volume @RT(17)Max. screw volume @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_dActHoldTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Act. hold time @RT(16)Actual hold time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_dActHoldTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Act. hold time @RT(16)Actual hold time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_dLastHoldTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Last hold time @RT(14)Last hold time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_dLastHoldTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Last hold time @RT(14)Last hold time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_PlastProfVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)KAPPL_VisProfilePlast @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(667)(Profile:=(Points:=(rRotation:=15.0,rBackPressure:=40.0,rStartPos:=0.0),(rRotation:=10.0,rBackPressure:=40.0,rStartPos:=30.0),(rRotation:=5.0,rBackPressure:=40.0,rStartPos:=40.0),(rStartPos:=50.0),iNoOfPoints:=2),rMinOutputVel:=0.0,rMinOutputPress:=0.0,rPreOutputPress:=0.0,rPreOutputBackPress:=0.0,rPreOutputVelRamp:=100.0,rPreOutputPressRamp:=100.0,rPreOutputBackPressRamp:=100.0,rMaxRampPress:=500.0,rMaxRampVel:=500.0,rMaxRampBackPress:=500.0,RampTypeBackPress:=KCTRL_YXGen_RampType_Linear,RampTypeVel:=KCTRL_YXGen_RampType_Linear,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStagePlast,pCalculatedProfile:=@%FU.sv_CalculatedProfilePlast) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(15)sv_PlastProfVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_PlastProfVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(46)InjectionGeneral.hmi.PlastProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_PlastProfVis.Profile.Points[0].rBackPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(21)InjectBackpressureABS @RT(7)Forward @RT(0) 
@RT(31)0.0..system.sv_rMaxBackPressure @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Backpress @RT(12)Backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(51)sv_PlastProfVis.Profile.Points[0].rBackPressureRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_PlastProfVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_PlastProfVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_PlastProfVis.Profile.Points[0].rRotation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Rotation @RT(8)Backward @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Charge @RT(6)Charge @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_PlastProfVis.Profile.Points[0].rRotationRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_PlastProfVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_PlastProfVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..5 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_PlastProfVis.rMaxRampBackPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt61 @RT(25)MaxRampInjBackpressureABS @RT(15)MaxBackPressure @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. ramp backpres. @RT(22)Max. ramp backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PlastProfVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Max. ramp @RT(9)Max. ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_PlastProfVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(10)Plasticize @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Max. ramp @RT(9)Max. ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_PlastProfVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_PlastProfVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rActScrewRpm @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)screw rotation speed in RPM 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)LG_ActInject(3) @RT(0) 
@RT(16)Screw revolution @RT(16)Screw revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rActScrewRpm @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)screw rotation speed in RPM 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)LG_ActInject(3) @RT(0) 
@RT(16)Screw revolution @RT(16)Screw revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rActScrewCircSpeed @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)screw rotation speed in cm/s circumferential speed 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(8)Rotation @RT(8)Backward @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Screw revolution @RT(16)Screw revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rActScrewCircSpeed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)screw rotation speed in cm/s circumferential speed 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(8)Rotation @RT(8)Backward @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Screw revolution @RT(16)Screw revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_rMaxRpm @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(10)1.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. revolution @RT(21)Max. screw revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)sv_rMaxRpm @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(10)1.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. revolution @RT(21)Max. screw revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rMaxRpmProfile @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(37)max. screw revolutions used for plast 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(19)1.0..%FU.sv_rMaxRpm @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. plast revolution @RT(21)Max. plast revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rMaxRpmProfile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(19)1.0..%FU.sv_rMaxRpm @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. plast revolution @RT(21)Max. plast revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ConstChargePressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(103)(Output:=(rOutputValue:=30.0,rRamp:=100.0),PreOutput:=(rOutputValue:=0.0,rRamp:=100.0),rMinOutput:=0.0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(22)sv_ConstChargePressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_ConstChargePressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Charge pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_ConstChargePressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(15)MaxRampPressure @RT(0) @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstChargePressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(15)MaxRampPressure @RT(0) @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ConstChargePressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bDecompAftPlastEnd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(21)sv_bDecompBefPlastEnd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(16)sv_bScrewBackEnd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(20)sv_ScrewRevVelLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=200.0,rY:=100.0))) @RT(45)lintab for converting cm/s to pump velocity % 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_ScrewRevVelLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)lintab for converting cm/s to pump velocity % 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ScrewRevVelLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(11)RotationRPM @RT(0) @RT(0) 
@RT(19)0.0..%FU.sv_rMaxRpm @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Revolution @RT(10)Revolution @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ScrewRevVelLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(31)0.0..system.sv_rMaximumVelocity @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Flow @RT(4)Flow @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ScrewRevVelLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(23)2..MAX_NO_LINTAB_POINTS @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(17)sv_InjectTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(28)set times of inject movement 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(17)sv_InjectTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)set times of inject movement 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_InjectTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. inject time @RT(16)Max. inject time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_InjectTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(12)Inject delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_InjectTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Delay pump @RT(17)Inject delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_InjectTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Delay valve @RT(18)Inject delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_InjectTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)act times of inject movement 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(17)sv_InjectTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)act times of inject movement 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_InjectTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(19)Actual inject delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_InjectTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Act. inject time @RT(18)Actual inject time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_InjectTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Last inject time @RT(16)Last inject time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_PlastTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(16)sv_PlastTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PlastTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. plasticize time @RT(20)Max. plasticize time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_PlastTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(21)LG_CombinedPlast(2,2) @RT(0) 
@RT(11)Delay Plast @RT(16)Plasticize delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_PlastTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Delay pump @RT(21)Plasticize delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_PlastTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Delay valve @RT(22)Plasticize delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_PlastTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(16)sv_PlastTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_PlastTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(21)Act. plasticize delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PlastTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. plast time @RT(17)Actual plast time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_PlastTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Last plast time @RT(15)Last plast time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_DecompTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(21)(dMaxMoveTime:=t#60s) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(17)sv_DecompTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_DecompTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. decomp. time @RT(26)Maximum decompression time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_DecompTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(21)LG_CombinedPlast(1,1) @RT(48)InjectionGeneral.hmi.DecompressionUsedVisControl 
@RT(20)Delay decomp. before @RT(20)Delay decomp. before @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_DecompTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Delay pump @RT(17)Decomp delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_DecompTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Delay valve @RT(18)Decomp delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_DecompAfterTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(22)sv_DecompAfterTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_DecompAfterTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_DecompAfterTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(21)LG_CombinedPlast(1,1) @RT(48)InjectionGeneral.hmi.DecompressionUsedVisControl 
@RT(19)Delay decomp. after @RT(19)Delay decomp. after @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_DecompAfterTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_DecompAfterTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_DecompTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(17)sv_DecompTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_DecompTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(17)Act. decomp delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_DecompTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. decomp. time @RT(25)Actual decompression time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_DecompAfterTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(22)sv_DecompAfterTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_DecompAfterTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_DecompAfterTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bInjectActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(19)Injection is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Inject active @RT(16)Injection active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bInjectActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)Injection is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Inject active @RT(16)Injection active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rPlastStartPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)position at starting plasticizing 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt32 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Plast start position @RT(20)Plast start position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rPlastStartPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)position at starting plasticizing 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt32 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Plast start position @RT(20)Plast start position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rPlastEndPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)position at end of plasticizing 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt32 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Plast end position @RT(18)Plast end position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rPlastEndPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)position at end of plasticizing 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt32 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Plast end position @RT(18)Plast end position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_iScrewGain @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Screw gain @RT(10)Screw gain @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_iScrewGain @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Screw gain @RT(10)Screw gain @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaxSpeedFwdAccu @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)With accumulator @RT(34)Max. inject speed with accumulator @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxSpeedFwdAccu @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)With accumulator @RT(34)Max. inject speed with accumulator @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_PressureLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=250.0))) @RT(41)lintab for measuring with pressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Pre.sens. @RT(15)Pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(17)sv_PressureLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)lintab for measuring with backpressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Pre.sens. @RT(15)Pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PressureLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PressureLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PressureLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Pre.sens. @RT(15)Pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_SysPressureLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=250.0))) @RT(48)lintab for measuring with system pressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Sys.pre.sens. @RT(22)System pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_SysPressureLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)lintab for measuring with backpressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Sys.pre.sens. @RT(22)System pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_SysPressureLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_SysPressureLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_SysPressureLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Sys.pre.sens. @RT(22)System pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_DecompBefPlastSettings @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsDecompParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(98)(ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0)))) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
14 
@AttrSym @RT(25)sv_DecompBefPlastSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_DecompBefPlastSettings.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_DecompBefPlastSettings.ConstOutput.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Ramp before plasticize @RT(22)Ramp before plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_DecompBefPlastSettings.ConstOutput.Pressure.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_DecompBefPlastSettings.ConstOutput.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(57)sv_DecompBefPlastSettings.ConstOutput.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_DecompBefPlastSettings.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_DecompBefPlastSettings.ConstOutput.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Ramp before plasticize @RT(22)Ramp before plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_DecompBefPlastSettings.ConstOutput.Velocity.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_DecompBefPlastSettings.ConstOutput.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(57)sv_DecompBefPlastSettings.ConstOutput.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_DecompBefPlastSettings.Mode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(17)DecompressionMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_DecompBefPlastSettings.dDecompTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0.0s..t#1.0m @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_DecompBefPlastSettings.rDecompPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_DecompAftPlastSettings @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsDecompParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(98)(ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0)))) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
14 
@AttrSym @RT(25)sv_DecompAftPlastSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_DecompAftPlastSettings.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_DecompAftPlastSettings.ConstOutput.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ramp after plasticize @RT(21)Ramp after plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_DecompAftPlastSettings.ConstOutput.Pressure.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_DecompAftPlastSettings.ConstOutput.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(57)sv_DecompAftPlastSettings.ConstOutput.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_DecompAftPlastSettings.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_DecompAftPlastSettings.ConstOutput.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ramp after plasticize @RT(21)Ramp after plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_DecompAftPlastSettings.ConstOutput.Velocity.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_DecompAftPlastSettings.ConstOutput.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(57)sv_DecompAftPlastSettings.ConstOutput.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_DecompAftPlastSettings.Mode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(17)DecompressionMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_DecompAftPlastSettings.dDecompTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0.0s..t#1.0m @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_DecompAftPlastSettings.rDecompPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(8)Backward @RT(0) 
@RT(12)PDecAftPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_DecompInterPosSettings @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsDecompParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(98)(ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0)))) @RT(46)data copied from sv_InstanceDataDecompInterPos 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
14 
@AttrSym @RT(25)sv_DecompInterPosSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_DecompInterPosSettings.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_DecompInterPosSettings.ConstOutput.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ramp after plasticize @RT(21)Ramp after plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_DecompInterPosSettings.ConstOutput.Pressure.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_DecompInterPosSettings.ConstOutput.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(57)sv_DecompInterPosSettings.ConstOutput.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_DecompInterPosSettings.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_DecompInterPosSettings.ConstOutput.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ramp after plasticize @RT(21)Ramp after plasticize @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_DecompInterPosSettings.ConstOutput.Velocity.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_DecompInterPosSettings.ConstOutput.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(57)sv_DecompInterPosSettings.ConstOutput.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_DecompInterPosSettings.Mode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(17)DecompressionMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_DecompInterPosSettings.dDecompTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0.0s..t#1.0m @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_DecompInterPosSettings.rDecompPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_IntrusionSettings @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsIntrusionParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(98)(ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0)),Pressure:=(Output:=(rOutputValue:=30.0)))) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(50)InjectionGeneral.hmi.IntrusionProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
10 
@AttrSym @RT(20)sv_IntrusionSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(50)InjectionGeneral.hmi.IntrusionProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(61)sv_IntrusionSettings.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(64)sv_IntrusionSettings.ConstOutput.Pressure.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_IntrusionSettings.ConstOutput.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(61)sv_IntrusionSettings.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Rotation @RT(8)Backward @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(64)sv_IntrusionSettings.ConstOutput.Velocity.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(0) @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_IntrusionSettings.ConstOutput.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_IntrusionSettings.Mode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(13)IntrusionMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_IntrusionSettings.dIntrusionTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(16)t#0.0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_IntrusionSettings.rBackPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(21)InjectBackpressureABS @RT(7)Forward @RT(0) 
@RT(31)0.0..system.sv_rMaxBackPressure @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Backpr. @RT(12)Backpressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_InstanceDataInjectInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyInstanceListArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(31)10((dCalculatedDuration:=t#3s)) @RT(56)array with target positions of inject interpos movements 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(29)sv_InstanceDataInjectInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(47)(rTargetValue:=200.0,dCalculatedDuration:=t#3s) @RT(56)array with target positions of decomp interpos movements 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_InstanceDataInjectInterPos[0].dCalculatedDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#3s @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_InstanceDataInjectInterPos[0].dDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)set delaytime 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_InjectInterPos(4,4) @RT(0) 
@RT(5)Delay @RT(5)Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_InstanceDataInjectInterPos[0].rAcceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)acceleration from this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_InjectInterPos(2,2) @RT(0) 
@RT(7)Ramp up @RT(7)Ramp up @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_InstanceDataInjectInterPos[0].rDeceleration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)deceleration to reach this point 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_InjectInterPos(3,3) @RT(0) 
@RT(9)Ramp down @RT(9)Ramp down @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_InstanceDataInjectInterPos[0].rTargetValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_InjectInterPos(1,1) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_InstanceDataDecompInterPos @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tyInstanceListArrayDecomp @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(31)10((dCalculatedDuration:=t#3s)) @RT(56)array with target positions of decomp interpos movements 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
8 
@AttrSym @RT(29)sv_InstanceDataDecompInterPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(47)(rTargetValue:=200.0,dCalculatedDuration:=t#3s) @RT(56)array with target positions of decomp interpos movements 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_InstanceDataDecompInterPos[0].Mode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(18)DecompInterPosMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_DecompInterPos(1,1) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_InstanceDataDecompInterPos[0].dCalculatedDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#3s @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Duration @RT(8)Duration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_InstanceDataDecompInterPos[0].dDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_DecompInterPos(6,6) @RT(0) 
@RT(5)Delay @RT(5)Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_InstanceDataDecompInterPos[0].dTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_DecompInterPos(3,3) @RT(47)InjectionGeneral.hmi.DecompIntPosTimeVisControl 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_InstanceDataDecompInterPos[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_DecompInterPos(4,4) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_InstanceDataDecompInterPos[0].rTargetValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_DecompInterPos(2,2) @RT(51)InjectionGeneral.hmi.DecompIntPosPositionVisControl 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_InstanceDataDecompInterPos[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(22)LG_DecompInterPos(5,5) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MinOutputInject @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(18)sv_MinOutputInject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MinOutputInject.rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Min. profile output @RT(19)Min. profile output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MinOutputInject.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Min. profile output @RT(19)Min. profile output @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_MinOutputPlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(17)sv_MinOutputPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_MinOutputPlast.rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Min. profile output @RT(19)Min. profile output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_MinOutputPlast.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(8)Rotation @RT(8)Backward @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Min. profile output @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_MinOutputDecomp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(18)sv_MinOutputDecomp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MinOutputDecomp.rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Min. output @RT(11)Min. output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_MinOutputDecomp.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Min. output @RT(11)Min. output @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rActPressureHydr @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)actual pressure in hydraulic cyinder(calculated from analog input of pressure sensor) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(17)InjectPressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject pressure @RT(22)Actual inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rActPressureHydr @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)actual pressure in hydraulic cyinder(calculated from analog input of pressure sensor) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(17)InjectPressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject pressure @RT(22)Actual inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rActSysPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)actual pressure in hydraulic cyinder(calculated from analog input of pressure sensor) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(17)InjectPressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject pressure @RT(22)Actual inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rActSysPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(85)actual pressure in hydraulic cyinder(calculated from analog input of pressure sensor) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(17)InjectPressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject pressure @RT(22)Actual inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rActPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(68)specific pressure at screw tip (calculated from sv_rActPressureHydr) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)LG_ActInject(1) @RT(0) 
@RT(15)Inject pressure @RT(22)Actual inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rActPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(68)specific pressure at screw tip (calculated from sv_rActPressureHydr) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)LG_ActInject(1) @RT(0) 
@RT(15)Inject pressure @RT(22)Actual inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ConstDecompSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(83)(Velocity:=(Output:=(rOutputValue:=25.0)),Pressure:=(Output:=(rOutputValue:=50.0))) @RT(37)const output for decomp in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(19)sv_ConstDecompSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)const output for decomp in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ConstDecompSetup.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstDecompSetup.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ConstDecompSetup.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ConstDecompSetup.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstDecompSetup.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ConstDecompSetup.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_ConstDecompSetupServo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(102)(Velocity:=(Output:=(rOutputValue:=-10.0),rMinOutput:=-10.0),Pressure:=(Output:=(rOutputValue:=50.0))) @RT(37)const output for decomp in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(24)sv_ConstDecompSetupServo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)const output for decomp in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(53)sv_ConstDecompSetupServo.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstDecompSetupServo.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_ConstDecompSetupServo.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(53)sv_ConstDecompSetupServo.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstDecompSetupServo.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_ConstDecompSetupServo.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ConstInjectSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(110)(Velocity:=(Output:=(rOutputValue:=25.0,rRamp:=500.0)),Pressure:=(Output:=(rOutputValue:=30.0,rRamp:=9999.9))) @RT(37)const output for inject in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(19)sv_ConstInjectSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)const output for inject in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ConstInjectSetup.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstInjectSetup.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt61 @RT(22)MaxRampInjPressureSpec @RT(7)Forward @RT(0) 
@RT(62)cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ConstInjectSetup.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(22)MaxRampInjPressureSpec @RT(7)Forward @RT(0) 
@RT(62)cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_ConstInjectSetup.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstInjectSetup.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(11)ForwardSpec @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ConstInjectSetup.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(11)ForwardSpec @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_ConstInjectSetupServo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(83)(Velocity:=(Output:=(rOutputValue:=10.0)),Pressure:=(Output:=(rOutputValue:=30.0))) @RT(37)const output for inject in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(24)sv_ConstInjectSetupServo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)const output for inject in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(53)sv_ConstInjectSetupServo.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt30 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstInjectSetupServo.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt61 @RT(22)MaxRampInjPressureSpec @RT(7)Forward @RT(0) 
@RT(62)cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_ConstInjectSetupServo.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(22)MaxRampInjPressureSpec @RT(7)Forward @RT(0) 
@RT(62)cPlausMaxRampInjectPressureMin..cPlausMaxRampInjectPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(53)sv_ConstInjectSetupServo.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_ConstInjectSetupServo.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(11)ForwardSpec @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_ConstInjectSetupServo.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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
@RT(13)Output active @RT(13)Output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bOutputActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Output active @RT(13)Output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bPreOutputReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)PreOutput is ready 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Pre output ready @RT(16)Pre output ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bPreOutputReady @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)PreOutput is ready 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Pre output ready @RT(16)Pre output ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_ConstPlastSetup @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(83)(Velocity:=(Output:=(rOutputValue:=20.0)),Pressure:=(Output:=(rOutputValue:=40.0))) @RT(36)const output for plast in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(18)sv_ConstPlastSetup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)const output for plast in setup mode 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_ConstPlastSetup.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConstPlastSetup.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstPlastSetup.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampPressure @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_ConstPlastSetup.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Rotation @RT(8)Backward @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConstPlastSetup.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(10)Plasticize @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstPlastSetup.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(10)Plasticize @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(23)sv_bPressureSensorError @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Pressure sensor error @RT(21)Pressure sensor error @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bPressureSensorError @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Pressure sensor error @RT(21)Pressure sensor error @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_bSysPressureSensorError @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Pressure sensor error @RT(21)Pressure sensor error @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_bSysPressureSensorError @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Pressure sensor error @RT(21)Pressure sensor error @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ImpulseParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KCTRL_Impulse_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(27)(rImpVMin:=0.0,rTime:=60.0) @RT(30)parameters for rpm measurement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ImpulseParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)parameters for rpm measurement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rCutOffPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)position where cut off was detected 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cut off position @RT(16)Cut off position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rCutOffPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)position where cut off was detected 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cut off position @RT(16)Cut off position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rHoldPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)position at the end of hold phase 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Hold end position @RT(17)Hold end position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rHoldPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)position where hold was detected 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Hold end position @RT(17)Hold end position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_rCushion @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)smallest screw position during hold phase 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Cushion @RT(7)Cushion @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_rCushion @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)position where hold was detected 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Cushion @RT(7)Cushion @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_bPressureSensorAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Injection Pressure Sensor Available @RT(35)Injection Pressure Sensor Available @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_bPressureSensorAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Injection Pressure Sensor Available @RT(35)Injection Pressure Sensor Available @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_bSysPressureSensorAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Injection Pressure Sensor Available @RT(35)Injection Pressure Sensor Available @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_bSysPressureSensorAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Injection Pressure Sensor Available @RT(35)Injection Pressure Sensor Available @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bCutOffDetected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)cutoff was detected 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cut Off detected @RT(16)Cut Off detected @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bCutOffDetected @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)cutoff was detected 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cut Off detected @RT(16)Cut Off detected @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dActDecompAfterTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Act. decomp. time after plast @RT(37)Actual decompression time after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dActDecompAfterTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Act. decomp. time after plast @RT(37)Actual decompression time after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dActDecompBeforeTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Act. decomp. time before plast @RT(38)Actual decompression time before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dActDecompBeforeTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(21)VG_Inject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Act. decomp. time before plast @RT(38)Actual decompression time before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_dLastDecompAfterTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Last decomp. time after plast @RT(35)Last decompression time after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_dLastDecompAfterTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Last decomp. time after plast @RT(35)Last decompression time after plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_dLastDecompBeforeTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Last decomp. time before plast @RT(36)Last decompression time before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_dLastDecompBeforeTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)Last decomp. time before plast @RT(36)Last decompression time before plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


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
4 @RT(0) @RT(26)parameters of the cylinder 
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
@RT(25)Do injection by ring area @RT(25)Do injection by ring area @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_CylinderData.iNumCylinders @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Number of cylinders @RT(19)Number of cylinders @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_CylinderData.rCylinderDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cylinder diameter @RT(17)Cylinder diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_CylinderData.rPistonRodDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Piston rod diameter @RT(19)Piston rod diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutFwdP @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(80)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=2000.0,rY:=145.0))) @RT(48)lintab for inject/hold  specific Pre -> Pump Pre 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(16)sv_LintabOutFwdP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(48)lintab for inject/hold  specific Pre -> Pump Pre 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdP.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutFwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0))) @RT(0) 
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
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdV.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
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
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutBwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(16)sv_LintabOutBwdV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdV.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdV.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_LintabOutPlastP @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0))) @RT(55)lintab for plasticizing in circumfence speed Pre -> Pre 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(18)sv_LintabOutPlastP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)lintab for plasticizing in circumfence speed Pre -> Pre 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_LintabOutPlastP.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_LintabOutPlastP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_LintabOutPlastV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=35.0,rY:=100.0))) @RT(56)lintab for plasticizing in circumfence speed (cm/s) -> % 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(18)sv_LintabOutPlastV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(56)lintab for plasticizing in circumfence speed (cm/s) -> % 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_LintabOutPlastV.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(17)InjectVolumeSpeed @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_LintabOutPlastV.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
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


@SysVar @RT(19)sv_rMaxSpeedBwdCalc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)40.0 @RT(67)maximum specific speed for injection in mm/s (calculated/autocalib) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. bwd @RT(20)Max. speed calc. bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxSpeedBwdCalc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)maximum speed for mold open 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. bwd @RT(20)Max. speed calc. bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaxSpeedFwdCalc @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(54)maximum speed for decompression (calculated/autocalib) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. fwd @RT(20)Max. speed calc. fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxSpeedFwdCalc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(28)maximum speed for mold close 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Max. speed calc. fwd @RT(20)Max. speed calc. fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rMaxRpmReducePercent @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(45)reduce max. profile RPM with this percentage  
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Max. RPM reduce factor @RT(22)Max. RPM reduce factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rMaxRpmReducePercent @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Max. RPM reduce factor @RT(22)Max. RPM reduce factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxSpeedBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)40.0 @RT(38)maximum speed for decompression (user) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)maximum speed for decompression 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxSpeedFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(51)maximum specific speed for injection in mm/s (user) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(76)maximum specific speed for injection in mm/s -> set by Autocalibration, User 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxSpeedFwdCalib @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(17)Max. inject speed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxSpeedFwdCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(17)Max. inject speed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxSpeedBwdCalib @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedBwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(30)Max. speed limit decompression @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxSpeedBwdCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(11)InjectSpeed @RT(10)NoRelative @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedBwdCalc @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(30)Max. speed limit decompression @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxHoldPresAllow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)2000.0 @RT(44)maximum allowable specific pressure for hold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(14)InjectPressure @RT(10)NoRelative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Allowable hold pressure @RT(23)Allowable hold pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxHoldPresAllow @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)maximum allowable specific pressure for hold 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(14)InjectPressure @RT(10)NoRelative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Allowable hold pressure @RT(23)Allowable hold pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rMaxInjPresAllow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)2000.0 @RT(49)maximum allowable specific pressure for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(14)InjectPressure @RT(10)NoRelative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Allowable inject pressure @RT(25)Allowable inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxInjPresAllow @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(49)maximum allowable specific pressure for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(14)InjectPressure @RT(10)NoRelative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Allowable inject pressure @RT(25)Allowable inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxPressureFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)2000.0 @RT(39)maximum specific pressure for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(14)InjectPressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)maximum specific pressure for injection 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(14)InjectPressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxPressureBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)145.0 @RT(34)maximum pressure for decompression 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)maximum pressure for decompression 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxRotationPlast @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)35.0 @RT(23)maximum speed for plast 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(8)Rotation @RT(10)NoRelative @RT(0) 
@RT(19)FPlausRotationPlast @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. plast velocity @RT(19)Max. plast velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxRotationPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)maximum speed for plast 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(8)Rotation @RT(10)NoRelative @RT(0) 
@RT(19)FPlausRotationPlast @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. plast velocity @RT(19)Max. plast velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxPressurePlast @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)145.0 @RT(26)maximum pressure for plast 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxPressurePlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)maximum pressure for plast 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rScrewDiameter @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)34.0 @RT(23)diameter of screw in mm 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.1..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw Diameter @RT(14)Screw Diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rScrewDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)diameter of screw in mm 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(6)Stroke @RT(0) @RT(0) 
@RT(10)0.1..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Screw Diameter @RT(14)Screw Diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rMaxCutOffPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)max. for cutoff position (necessary for plausibility) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)max. cutoff pos @RT(15)max. cutoff pos @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rMaxCutOffPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)max. for cutoff position (necessary for plausibility) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)max. cutoff pos @RT(15)max. cutoff pos @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rInjectTargetPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)Inject target position for sequenzer 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject position @RT(22)Inject target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rInjectTargetPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)Inject target position for sequenzer 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Inject position @RT(22)Inject target position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rInjPeakPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)measured inject peak pressure 
@RT(1)1 @RT(2)16 @RT(9)VG_Inject @RT(5)fmt40 @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. pressure @RT(13)Max. pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rInjPeakPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)measured inject peak pressure 
@RT(1)1 @RT(2)16 @RT(9)VG_Inject @RT(5)fmt40 @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. pressure @RT(13)Max. pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rInjPeakVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)measured inject peak velocity 
@RT(1)1 @RT(2)16 @RT(9)VG_Inject @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. velocity @RT(13)Max. velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rInjPeakVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)measured inject peak velocity 
@RT(1)1 @RT(2)16 @RT(9)VG_Inject @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. velocity @RT(13)Max. velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rInjPeakPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)measured inject peak position 
@RT(1)1 @RT(2)16 @RT(9)VG_Inject @RT(5)fmt42 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Min. position @RT(13)Min. position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rInjPeakPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)measured inject peak position 
@RT(1)1 @RT(2)16 @RT(9)VG_Inject @RT(5)fmt42 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Min. position @RT(13)Min. position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxPlastEnd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)max. for last point of plast profile (necessary for plausibility) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)max. plast end @RT(14)max. plast end @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxPlastEnd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)max. for last point of plast profile (necessary for plausibility) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)max. plast end @RT(14)max. plast end @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_IMM_Type @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KAPPL_IMM_Type @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(13)nKAPPL_IMM_PQ @RT(20)type of mold machine 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Machine @RT(15)MoldMachineType @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_IMM_Type @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)type of mold machine 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Machine @RT(15)MoldMachineType @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_bDiExtCutOff @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)external cut off event 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_bDiExtCutOff @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)external cut off event 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_ServoValveControlData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(27)KAPPL_ServoValveControlData @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(27)sv_ServoValveControllerMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(30)KAPPL_ServoValveControllerMode @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(15)sv_rServoOutput @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(20)sv_rActScrewVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(13)sv_PlastMotor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tnMotorType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(10)nHydraulic @RT(19)type of plast motor 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)MoldAdjustMotor @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Plasticize motor @RT(16)Plasticize motor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_PlastMotor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)type of plast motor 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)MoldAdjustMotor @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Plasticize motor @RT(16)Plasticize motor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ColdDropSettings @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsColdDropParams @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(145)(dColdDropTime:=t#1s,ConstOutput:=(Velocity:=(Output:=(rOutputValue:=15.0,rRamp:=500.0)),Pressure:=(Output:=(rOutputValue:=30.0,rRamp:=9999.9)))) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(49)InjectionGeneral.hmi.ColdDropProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(19)sv_ColdDropSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(49)InjectionGeneral.hmi.ColdDropProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(60)sv_ColdDropSettings.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(53)sv_ColdDropSettings.ConstOutput.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(60)sv_ColdDropSettings.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(53)sv_ColdDropSettings.ConstOutput.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ColdDropSettings.bUse @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(15)Cold slug eject @RT(19)Use cold slug eject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ColdDropSettings.dColdDropTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(16)t#0.0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(4)Time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_bPlastParallel @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Plast movement parallel @RT(23)Plast movement parallel @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_bPlastParallel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Plast movement parallel @RT(23)Plast movement parallel @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_SysPresMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(21)sv_SysPresMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_SysPresMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_SysPresMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_SysPresMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_SysPresMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_SysPresMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_PresMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(18)sv_PresMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_PresMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_PresMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PresMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PresMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PresMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ScrewMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(19)sv_ScrewMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ScrewMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ScrewMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ScrewMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ScrewMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ScrewMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rCutOffPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)spec Injectpressure at cut off 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt41 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cut off pressure @RT(16)Cut off pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rCutOffPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)spec Injectpressure at cut off 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt41 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Cut off pressure @RT(16)Cut off pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxPressureEndHold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)10.0 @RT(4)10.0 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max pressure end hold @RT(21)Max pressure end hold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxPressureEndHold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(4)10.0 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max pressure end hold @RT(21)Max pressure end hold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rImpulseFilterLimit @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(58)Limit for filter of impulse measuring, if > 0.0 use filter 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Imp. filter limit @RT(20)Impulse filter limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rImpulseFilterLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(58)Limit for filter of impulse measuring, if > 0.0 use filter 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Imp. filter limit @RT(20)Impulse filter limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rCutOffCavityPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)spec Cavity pressure at cut off 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Cut off mold pressure @RT(21)Cut off mold pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rCutOffCavityPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)spec Cavity pressure at cut off 
@RT(1)1 @RT(15)cLevelSuperUser @RT(9)VG_Inject @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Cut off mold pressure @RT(21)Cut off mold pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ColdDropTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Cold slug eject times act @RT(25)Cold slug eject times act @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(19)sv_ColdDropTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Cold slug eject times act @RT(25)Cold slug eject times act @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ColdDropTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(28)Actual cold slug eject delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ColdDropTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Act. cold slug eject time @RT(27)Actual cold slug eject time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ColdDropTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Last cold slug eject time @RT(25)Last cold slug eject time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ColdDropTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Cold slug eject times set @RT(25)Cold slug eject times set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(19)sv_ColdDropTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Cold slug eject times set @RT(25)Cold slug eject times set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ColdDropTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)T#0s..T#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Max. cold slug eject time @RT(25)Max. cold slug eject time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ColdDropTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(21)Cold slug eject delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_ColdDropTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Delay pump @RT(26)Cold slug eject delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ColdDropTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Delay valve @RT(27)Cold slug eject delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_IntrusionTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Intrusion times act @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_IntrusionTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Intrusion times act @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_IntrusionTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(22)Actual intrusion delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_IntrusionTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Act. intrusion time @RT(21)Actual intrusion time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_IntrusionTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Last intrusion time @RT(19)Last intrusion time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_IntrusionTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Intrusion times set @RT(19)Intrusion times set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(20)sv_IntrusionTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Intrusion times set @RT(19)Intrusion times set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_IntrusionTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)T#0s..T#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. intrusion time @RT(19)Max. intrusion time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_IntrusionTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Delay @RT(15)Intrusion delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_IntrusionTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Delay pump @RT(20)Intrusion delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_IntrusionTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Delay valve @RT(21)Intrusion delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_InstanceCounter @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)sv_rMaxSpeedFwdSpec @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)40.0 @RT(45)maximum specific speed for injection in cm³/s 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rMaxSpeedFwdSpec @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)maximum specific speed for injection in cm³/s 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(17)InjectVolumeSpeed @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_DerivationEstimateParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tsDerivationEstimateParam @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(118)(bUseDerivationEstimator:=FALSE,iN:=1,dT:=T#20ms,dMeasCycleTime:=T#2ms,iNu:=0,estimatorName:='screwVelocityEstimator') @RT(0) 
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


@SysVar @RT(24)sv_HoldingDeadTimeParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tsDeadTimeParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(88)(bCompensationEnabled:=FALSE,dDeadTime:=t#20ms,dPT2T1:=t#18ms,dPT2T2:=t#18ms,rPT2K:=1.0) @RT(36)dead time parameters for holding PID 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Hold set val @RT(14)Hold set value @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(24)sv_HoldingDeadTimeParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)dead time parameters for holding PID 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Hold set val @RT(14)Hold set value @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_HoldingDeadTimeParams.dPT2T1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(15)t#0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Filter time @RT(20)Filter time constant @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_HoldingDeadTimeParams.dPT2T2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#18ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_LintabOutFwdVServo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=40.0,rY:=100.0))) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(21)sv_LintabOutFwdVServo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_LintabOutFwdVServo.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_LintabOutFwdVServo.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_bServoValveLimitActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)servo valve set value limitation active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_bServoValveLimitActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)servo valve set value limitation active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bValveServoInj1Ready @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(28)sv_rScrewVelocityEstimateAbs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(21)sv_iActiveStageInject @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)active profile stage inject 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_iActiveStageInject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)active profile stage mold close (fwd) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_iActiveStagePlast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)active profile stage plast 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_iActiveStagePlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)active profile stage mold open (bwd) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_rMaxPlausFirstInjectStage @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)max. plaus for first inject stage 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_rMaxPlausFirstInjectStage @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)max. plaus for first inject stage 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_CalculatedProfileInject @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(26)sv_CalculatedProfileInject @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileInject.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileInject.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileInject.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileInject.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalculatedProfileHold @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(24)sv_CalculatedProfileHold @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_CalculatedProfileHold.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)TimeReal @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_CalculatedProfileHold.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_CalculatedProfileHold.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)TimeReal @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_CalculatedProfileHold.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CalculatedProfilePlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(71)sv_CalculatedProfilePlast.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)InjectVolume @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(71)sv_CalculatedProfilePlast.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(21)InjectBackpressureABS @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(71)sv_CalculatedProfilePlast.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)InjectVolume @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(71)sv_CalculatedProfilePlast.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Rotation @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_PressureLimitControlParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(65)(rP:=1.0,dTN:=t#10.0s,dTV:=t#0.0s,rKS:=0.0,bUsePIDControl:=FALSE) @RT(55)parameter for pressure limit controler during precutoff 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(29)sv_PressureLimitControlParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)parameter for pressure limit controler during precutoff 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_PressureLimitControlParams.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Use PID @RT(7)Use PID @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_PressureLimitControlParams.dActivationDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Activation Delay @RT(20)PID Activation Delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_PressureLimitControlParams.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(15)t#0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(24)I parameter press. limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_PressureLimitControlParams.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt33 @RT(12)TimeAccurate @RT(0) @RT(0) 
@RT(15)t#0s..t#999.99s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(24)D parameter press. limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_PressureLimitControlParams.rKS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_PressureLimitControlParams.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)P @RT(24)P parameter press. limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_PressureLimitVelocityParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(65)(rP:=1.0,dTN:=t#10.0s,dTV:=t#0.0s,rKS:=0.0,bUsePIDControl:=FALSE) @RT(55)parameter for pressure limit controler during precutoff 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(30)sv_PressureLimitVelocityParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(64)(rP:=1.0,dTN:=t#0.0s,dTV:=t#0.0s,rKS:=0.0,bUsePIDControl:=FALSE) @RT(55)parameter for pressure limit controler during precutoff 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_PressureLimitVelocityParams.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(34)Use Inject Pressure Limit Velocity @RT(34)Use Inject Pressure Limit Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_PressureLimitVelocityParams.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)t#10.0s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(24)I parameter press. limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_PressureLimitVelocityParams.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#0.0s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(24)D parameter press. limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_PressureLimitVelocityParams.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)P @RT(24)P parameter press. limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rScrewZeroPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)zero position of screw 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(22)sv_RequiredPumpsInject @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=6000) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(36)sv_RequiredPumpsInject.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Injection @RT(9)Injection @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_RequiredPumpsDecomp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=6002) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(36)sv_RequiredPumpsDecomp.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Decompression @RT(13)Decompression @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_RequiredPumpsPlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=6001) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(35)sv_RequiredPumpsPlast.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Plast @RT(5)Plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_HydrMaxValuesInject @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)hydraulic max values for inject 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(22)sv_HydrMaxValuesDecomp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(38)hydraulic max values for decompression 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(21)sv_HydrMaxValuesPlast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)hydraulic max values for plast 
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
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(11)VG_MoldData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Smooth factor inject @RT(20)Smooth factor inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rSmoothFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(11)VG_MoldData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Smooth factor inject @RT(20)Smooth factor inject @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rScrewSizeFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(30)sv_bUseCalcedPressureStartRamp @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Use calced start  ramp @RT(47)Use calced start ramp for hold pressure profile @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_bUseCalcedPressureStartRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Use calced start  ramp @RT(47)Use calced start ramp for hold pressure profile @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
3 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erColdDropNotPossible @RT(1)3 @RT(1)y @RT(48)system.evAlarmAutoManual,system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(11)Application @RT(627)%1t%2n: Cold slug eject not possible because nozzle bwd not activated{#]Cold slug eject is only possible when the \u000anozzle doesn't touch the fixed plate.{#]Cold slug eject helps ejecting some material during a semi- or full-automatic \u000acycle. This can only be done if the nozzle moves backward during the cycle. \u000aIf the nozzle backward mode is set to "no" also the cold drop feature is not \u000apossible and this alarm is raised.{#]If cold slug eject should be used change the {Nozzle1.sv_NozzleBwdMode} to \u000asomething different than 'No'.<br>\u000aOr set the {Injection1.sv_ColdDropSettings.bUse:l} to FALSE. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erAllowablePresTooHigh @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(548)Allowable pressure is greater than max. possible pressure!{#]User setting for allowable pressure \u000aexceeds the maximum possible pressure.{#]For injection two allowable pressures can be set, one for injection and one \u000afor hold phase. If one of these two settings exceeds the basic limitation of \u000amaximum possible pressure this alarm is raised.{#]Adjust the setting for {Injection1.sv_rMaxInjPresAllow:l} and or the setting \u000afor {Injection1.sv_rMaxHoldPresAllow:l} in order to fit the limits of the maximum \u000apossible pressure. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erSafetyGateOpenAndNozzleFwd @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(20)User and Application @RT(368)Plasticize not allowed, SafetyGate open and Nozzle forward{#]Plasticizing cannot be executed while \u000anozzle is forward and mold safety gate is \u000aopen.{#]As long as mold safety gate is open and the nozzle is in its forward endposition \u000aplasticizing is not allowed.{#]Either close mold safety gate or move nozzle backward before \u000aretrying plasticizing. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
