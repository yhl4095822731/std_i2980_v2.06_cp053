%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, Voltage
, fmt22
, Stroke
, fmt41
, fmt30
, LG_ActPos
, Speed
, NoRelative
, Forward
, VG_MoldData
, Percent
, fmt31
, EjectorForce
, fmt40
, fmt10
, MaxRampForce
, MaxRampVelocity
, Backward
, fmt20
, LG_EjectorShake2
, EjectorMode
, Time
, VG_SequenceData
, VG_Eject
, VG_SPC_POST
, CalibGroup
, fmtCalibState
, OnOff
, UseNoUse
, Pressure

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData_2P
, KAPPL_VisProfile
, tnEjectorMode
, tsMinOutput
, tsVelPre
, tsSetTimes
, tsActTimes
, tsCalibMovement
, tsTransducerCalibData
, KCTRL_Lintab_Point
, tsCylinderData
, KAPPL_LintabData
, KAPPL_MeasureMonitoring
, tCalculatedProfiles
, tsRequiredPumps
, tsHydrMaxValues
, KCTRL_YXGen_RampType_Square
, KCTRL_YXGen_RampType_Linear
, nNormal
, tnCalibGroup_Transducer
, cMoveFwd
, cMoveBwd
, cLevelServiceEngineer
, cLevelSuperUser
, cLevelStartupTechnican
, cLevelProcessOperator
, cLevelProduction
, cLevelMoldPrepare
, cPlausMaxRampPressureMax
, cPlausMaxRampPressureMin
, cPlausMaxRampVelocityMax
, cPlausMaxRampVelocityMin

END_IMPORT

%SYSTEMVAR_DECL
  sv_bOutputActive : BOOL (* Output is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Ejector output active Ejector output active
;
 sv_bPreOutputReady : BOOL (* PreOutput is ready *)
     %INPUT_LEVEL 16

// Pre output ready Pre output ready
;
 sv_EjectorLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=50.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_EjectorLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_EjectorLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..%FU.sv_rEjectorStroke      %FORMAT fmt41  %UNIT Stroke 
// Position Position

%ELEMENT sv_EjectorLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// No. of points Number of points
;
 sv_rEjectorPosition : REAL
     %LIST_GROUP LG_ActPos(4)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Stroke 
// Ejector position Ejector position
 %UPDATE_CYCLE "Fast";
 sv_rEjectorVelocity : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Ejector Velocity Ejector Velocity
;
 sv_rEjectorPositionRel : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt41  %UNIT Stroke 
// Ejector position Ejector position
 %UPDATE_CYCLE "Fast";
 sv_rEjectorStroke : REAL := 50.0 (* Position when ejector is completely forward *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Stroke  %ABSREL NoRelative 
// Max. ejector stroke Max. ejector stroke
;
 sv_EjectorFwdVisShake : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=30.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rVelocity:=100.0,rStartPos:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear)
     %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_EjectorFwdVisShake.Profile
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_EjectorFwdVisShake.Profile.Points[0].rPressRamp
     %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVisShake.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Force Force

%ELEMENT sv_EjectorFwdVisShake.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_EjectorFwdVisShake.Profile.Points[0].rVelRamp
     %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVisShake.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Speed  %ABSREL Forward 
// Velocity Velocity

%ELEMENT sv_EjectorFwdVisShake.Profile.iNoOfPoints
 %PLAUSIBILITY 3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_EjectorFwdVisShake.rEndOutputPress
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Shake output Shake output

%ELEMENT sv_EjectorFwdVisShake.rEndOutputVel
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Shake output Shake output

%ELEMENT sv_EjectorFwdVisShake.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd

%ELEMENT sv_EjectorFwdVisShake.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd
;
 sv_EjectorFwdVis : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=30.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rVelocity:=100.0,rStartPos:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1.0e6,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_EjectorFwdVis.Profile
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_EjectorFwdVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Force Force

%ELEMENT sv_EjectorFwdVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_EjectorFwdVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Speed  %ABSREL Forward 
// Velocity Velocity

%ELEMENT sv_EjectorFwdVis.Profile.iNoOfPoints
 %PLAUSIBILITY 3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_EjectorFwdVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Forward 
// Max. ramp forward Max. ramp forward

%ELEMENT sv_EjectorFwdVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd

%ELEMENT sv_EjectorFwdVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_EjectorBwdVisShake : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressRamp:=100.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressRamp:=100.0,rVelRamp:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwdShake)
     %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_EjectorBwdVisShake.Profile
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_EjectorBwdVisShake.Profile.Points[0].rPressRamp
     %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVisShake.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Backward 
// Force Force

%ELEMENT sv_EjectorBwdVisShake.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_EjectorBwdVisShake.Profile.Points[0].rVelRamp
     %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVisShake.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Speed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_EjectorBwdVisShake.Profile.iNoOfPoints
 %PLAUSIBILITY 3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_EjectorBwdVisShake.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd

%ELEMENT sv_EjectorBwdVisShake.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd
;
 sv_EjectorBwdVis : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressRamp:=100.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressRamp:=100.0,rVelRamp:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1.0e6,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwd)
     %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_EjectorBwdVis.Profile
   RETAIN  %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_EjectorBwdVis.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVis.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Backward 
// Force Force

%ELEMENT sv_EjectorBwdVis.Profile.Points[0].rStartPos
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_EjectorBwdVis.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVis.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Speed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_EjectorBwdVis.Profile.iNoOfPoints
 %PLAUSIBILITY 3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_EjectorBwdVis.ProfileTypePress
   RETAIN 
%ELEMENT sv_EjectorBwdVis.ProfileTypeVel
   RETAIN 
%ELEMENT sv_EjectorBwdVis.RampTypePress
   RETAIN 
%ELEMENT sv_EjectorBwdVis.RampTypeVel
   RETAIN 
%ELEMENT sv_EjectorBwdVis.bLimitEveryPointToLastRamp
   RETAIN 
%ELEMENT sv_EjectorBwdVis.bOpenEndProfile
   RETAIN 
%ELEMENT sv_EjectorBwdVis.bUseOffsetOptimizing
   RETAIN 
%ELEMENT sv_EjectorBwdVis.bUsePressureRamp
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rEndOutputPress
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rEndOutputVel
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Backward 
// Max. ramp backward Max. ramp backward

%ELEMENT sv_EjectorBwdVis.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd

%ELEMENT sv_EjectorBwdVis.rMinOutputPress
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rMinOutputVel
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rOffset
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rPreOutputPressRamp
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rPreOutputVel
    
%ELEMENT sv_EjectorBwdVis.rPreOutputVelRamp
   RETAIN 
%ELEMENT sv_EjectorBwdVis.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVis.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_EjectorFwdVisRel : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=30.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rVelocity:=100.0,rStartPos:=100.0),iNoOfPoints:=2),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageFwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwdRel)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_EjectorFwdVisRel.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS EjectorGeneral.hmi.EjectorFwdProgrammedVisControl 
%ELEMENT sv_EjectorFwdVisRel.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVisRel.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Force Force

%ELEMENT sv_EjectorFwdVisRel.Profile.Points[0].rStartPos
     %VISI_CLASS EjectorGeneral.hmi.EjectorFwdProgSafetyVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_EjectorFwdVisRel.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVisRel.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Speed  %ABSREL Forward 
// Velocity Velocity

%ELEMENT sv_EjectorFwdVisRel.Profile.iNoOfPoints
 %PLAUSIBILITY 1..3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_EjectorFwdVisRel.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd

%ELEMENT sv_EjectorFwdVisRel.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd

%ELEMENT sv_EjectorFwdVisRel.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorFwdVisRel.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_EjectorBwdVisRel : KAPPL_VisProfile := (Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressRamp:=100.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressRamp:=100.0,rVelRamp:=100.0),iNoOfPoints:=2),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageBwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwdRel)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_EjectorBwdVisRel.Profile
     %VARIABLE_GROUP VG_MoldData  %VISI_CLASS EjectorGeneral.hmi.EjectorBwdProgrammedVisControl 
%ELEMENT sv_EjectorBwdVisRel.Profile.Points[0].rPressRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVisRel.Profile.Points[0].rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Backward 
// Force Force

%ELEMENT sv_EjectorBwdVisRel.Profile.Points[0].rStartPos
     %VISI_CLASS EjectorGeneral.hmi.EjectorBwdProgSafetyVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// To To

%ELEMENT sv_EjectorBwdVisRel.Profile.Points[0].rVelRamp
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVisRel.Profile.Points[0].rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT Speed  %ABSREL Backward 
// Velocity Velocity

%ELEMENT sv_EjectorBwdVisRel.Profile.iNoOfPoints
 %PLAUSIBILITY 1..3      %FORMAT fmt10 
// Stages Stages

%ELEMENT sv_EjectorBwdVisRel.rMaxRampPress
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd

%ELEMENT sv_EjectorBwdVisRel.rMaxRampVel
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd

%ELEMENT sv_EjectorBwdVisRel.rStopRampPress
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
%ELEMENT sv_EjectorBwdVisRel.rStopRampVel
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent ;
 sv_iShakeCounter : DINT := 1
 %PLAUSIBILITY 1..20    RETAIN  %VARIABLE_GROUP VG_MoldData  %LIST_GROUP LG_EjectorShake2(1,1)
 %VISI_CLASS EjectorGeneral.hmi.EjectShakeProgrammedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt20 
// Shake counter Ejector shake counter
;
 sv_EjectorMode : tnEjectorMode := nNormal
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT EjectorMode 
// Ejector mode Ejector mode
;
 sv_bDoTransducerCalib : BOOL
     %INPUT_LEVEL cLevelProcessOperator

// Do transducer calibration Do transducer calibration
;
 sv_MinOutputFwd : tsMinOutput := (rPressure:=0.03,rVelocity:=30.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MinOutputFwd.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Min. profile output fwd Min. profile output fwd

%ELEMENT sv_MinOutputFwd.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT Speed  %ABSREL Forward 
// Min. profile output fwd Min. profile output fwd
;
 sv_MinOutputBwd : tsMinOutput := (rPressure:=0.03,rVelocity:=30.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MinOutputBwd.rPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Backward 
// Min. profile output bwd Min. profile output bwd

%ELEMENT sv_MinOutputBwd.rVelocity
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %FORMAT fmt41  %UNIT Speed  %ABSREL Backward 
// Min. profile output bwd Min. profile output bwd
;
 sv_rPressureAbs : REAL
    ;
 sv_rPressure : REAL
    ;
 sv_rVelocityAbs : REAL
    ;
 sv_rVelocity : REAL
    ;
 sv_iActiveStage : DINT
    ;
 sv_ConstBwdVis : tsVelPre := (Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0))) (* const output for ejector bwd movement *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_ConstBwdVis.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Backward 
// Backward force Backward force

%ELEMENT sv_ConstBwdVis.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstBwdVis.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampForce  %ABSREL Backward 
%ELEMENT sv_ConstBwdVis.Pressure.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstBwdVis.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Backward velocity Backward velocity

%ELEMENT sv_ConstBwdVis.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Ramp Ramp

%ELEMENT sv_ConstBwdVis.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
%ELEMENT sv_ConstBwdVis.Velocity.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
;
 sv_ConstFwdVis : tsVelPre := (Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0))) (* const output for ejector fwd movement *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdVis.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Forward force Forward force

%ELEMENT sv_ConstFwdVis.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Forward 
// Ramp Ramp

%ELEMENT sv_ConstFwdVis.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampForce  %ABSREL Forward 
%ELEMENT sv_ConstFwdVis.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Forward velocity Forward velocity

%ELEMENT sv_ConstFwdVis.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Ramp Ramp

%ELEMENT sv_ConstFwdVis.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
%ELEMENT sv_ConstFwdVis.Velocity.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
;
 sv_ConstBwdVisLS : tsVelPre := (Velocity:=(Output:=(rOutputValue:=40.0,rRamp:=9999.9),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0),PreOutput:=(rRamp:=1000.0))) (* chad(CR_0038565) *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Backward 
%ELEMENT sv_ConstBwdVisLS.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Backward 
// Backward force Backward force

%ELEMENT sv_ConstBwdVisLS.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd

%ELEMENT sv_ConstBwdVisLS.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %UNIT MaxRampForce  %ABSREL Backward 
%ELEMENT sv_ConstBwdVisLS.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Backward 
// Backward velocity Backward velocity

%ELEMENT sv_ConstBwdVisLS.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Backward 
// Max. ramp bwd Max. ramp bwd

%ELEMENT sv_ConstBwdVisLS.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %UNIT MaxRampVelocity  %ABSREL Backward ;
 sv_ConstFwdVisLS : tsVelPre := (Velocity:=(Output:=(rOutputValue:=40.0,rRamp:=9999.9),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0),PreOutput:=(rRamp:=1000.0))) (* chad(CR_0038565) *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %ABSREL Forward 
%ELEMENT sv_ConstFwdVisLS.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT EjectorForce  %ABSREL Forward 
// Forward force Forward force

%ELEMENT sv_ConstFwdVisLS.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd

%ELEMENT sv_ConstFwdVisLS.Pressure.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %FORMAT fmt41  %UNIT MaxRampForce  %ABSREL Forward 
%ELEMENT sv_ConstFwdVisLS.Pressure.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_ConstFwdVisLS.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Speed  %ABSREL Forward 
// Forward velocity Forward velocity

%ELEMENT sv_ConstFwdVisLS.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
// Max. ramp fwd Max. ramp fwd

%ELEMENT sv_ConstFwdVisLS.Velocity.PreOutput.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL Forward 
%ELEMENT sv_ConstFwdVisLS.Velocity.rMinOutput
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
;
 sv_rBwdInterruptPosition : REAL (* interrupt position for ejector bwd movement (needed for vibration mode) *)
    ;
 sv_bFwdActive : BOOL (* Ejector forward is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Ejector fwd active Ejector forward active
;
 sv_bBwdActive : BOOL (* Ejector backward is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Ejector bwd active Ejector backward active
;
 sv_bTransducerError : BOOL
    
// Transducer error Transducer error
;
 sv_EjectorFwdTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_EjectorFwdTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. forward time Max. ejector forward time

%ELEMENT sv_EjectorFwdTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Forward delay Ejector forward delay

%ELEMENT sv_EjectorFwdTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Forward delay pump Ejector forward delay pump

%ELEMENT sv_EjectorFwdTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Forward delay valve Ejector forward delay valve
;
 sv_EjectorFwdTimesAct : tsActTimes
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_EjectorFwdTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. forward delay Act. ejector foward delay

%ELEMENT sv_EjectorFwdTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Eject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. forward time Act. ejector forward time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_EjectorFwdTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last forward time Last ejector forward time
;
 sv_EjectorBwdTimesSet : tsSetTimes := (dMaxMoveTime:=t#60s)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction

%ELEMENT sv_EjectorBwdTimesSet.dMaxMoveTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. backward time Max. ejector backward time

%ELEMENT sv_EjectorBwdTimesSet.dSetDelayTime
 %PLAUSIBILITY t#0s..t#60s      %VARIABLE_GROUP VG_SequenceData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Backward delay Ejector backward delay

%ELEMENT sv_EjectorBwdTimesSet.dSetDelayTimePump
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Backward delay pump Ejector backward delay pump

%ELEMENT sv_EjectorBwdTimesSet.dSetDelayTimeValve
 %PLAUSIBILITY T#0s..T#5s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Time 
// Backward delay valve Ejector backward delay valve
;
 sv_EjectorBwdTimesAct : tsActTimes
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_EjectorBwdTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. backward delay Act. ejector backward delay

%ELEMENT sv_EjectorBwdTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Eject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. backward time Act. ejector backward time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_EjectorBwdTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last backward time Last ejector backward time
;
 sv_CalibState : tsCalibMovement := (pLintabPoints:=@%FU.sv_EjectorLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_EjectorLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rEjectorStroke,iOrder:=10,Group:=tnCalibGroup_Transducer)
    
%ELEMENT sv_CalibState.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibState.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibState.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Ejector Ejector transducer

%ELEMENT sv_CalibState.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_TransducerCalibData : tsTransducerCalibData := (Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveFwd,Id2:=cMoveBwd,bReverse:=FALSE,prPos1:=@%FU.sv_rEjectorStroke)
    ;
 sv_TmpLintabPoint : KCTRL_Lintab_Point
    ;
 sv_bMoveEjectorUntilEnd : BOOL
    ;
 sv_CylinderData : tsCylinderData := (rCylinderDiameter:=20.0,rPistonRodDiameter:=7.0,iNumCylinders:=1,bUseSmallSize:=FALSE)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_CylinderData.bUseSmallSize
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Move forward by ring area Move forward by ring area

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
     %UNIT EjectorForce  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdP.LintabPoints.Point[0].rY
     %UNIT Pressure  %ABSREL Forward ;
 sv_LintabOutFwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=100.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rX
     %UNIT Speed  %ABSREL Forward 
%ELEMENT sv_LintabOutFwdV.LintabPoints.Point[0].rY
     %UNIT Percent ;
 sv_LintabOutBwdP : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=145.0,rY:=145.0)))
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rX
     %UNIT EjectorForce  %ABSREL Backward 
%ELEMENT sv_LintabOutBwdP.LintabPoints.Point[0].rY
     %UNIT Pressure  %ABSREL Backward ;
 sv_LintabOutBwdV : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=100.0)))
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
 sv_rMaxSpeedFwdCalc : REAL := 300.0 (* maximum speed for mold close (calculated) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed calc. fwd Max. speed calc. fwd
;
 sv_rMaxSpeedBwdCalc : REAL := 300.0 (* maximum speed for mold open (calculated) *)
 %PLAUSIBILITY 0.0..9999.9    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed calc. bwd Max. speed calc. bwd
;
 sv_rMaxSpeedFwd : REAL := 300.0 (* maximum speed fwd (user) *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdCalib    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Speed  %ABSREL NoRelative 
// Max. speed forward Max. speed forward
;
 sv_rMaxSpeedBwd : REAL := 300.0 (* maximum speed bwd (user) *)
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
 sv_rMaxPressureFwd : REAL := 145.0 (* maximum force fwd *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT EjectorForce  %ABSREL NoRelative ;
 sv_rMaxPressureBwd : REAL := 145.0 (* maximum force bwd *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT EjectorForce  %ABSREL NoRelative ;
 sv_rEjectorLimDist : REAL := 50.0
 %PLAUSIBILITY 1.0..%FU.sv_rEjectorPlausDist    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Ejector stroke Ejector stroke
;
 sv_rEjectorLimOfs : REAL
 %PLAUSIBILITY 0.0..%FU.sv_rEjectorPlausOfs    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT fmt41  %UNIT Stroke 
// Ejector offset Ejector offset
;
 sv_rEjectorPlausOfs : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt20  %UNIT Stroke ;
 sv_rEjectorPlausDist : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt20  %UNIT Stroke ;
 sv_rEjectorMonitorPos : REAL (* ejector monitor position *)
 %PLAUSIBILITY 0.0..Mold1.sv_rMoldOpenPosSet    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT Stroke 
// Mold check position Mold check position
;
 sv_EjectorMonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.05,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_EjectorMonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_EjectorMonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_EjectorMonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_EjectorMonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_EjectorMonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_bSetEjectorZeroPos : BOOL (* hmi trigger to set actual ejector position as ejector offset *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT UseNoUse 
// Set ejector zero position Set ejector zero position
;
 sv_bEjectorMonitorPos : BOOL (* ejector monitor position reached *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Monitor pos. reached Ejector monitor position reached
;
 sv_EjectorShakeTimesAct : tsActTimes
     %INPUT_LEVEL cLevelSuperUser

%ELEMENT sv_EjectorShakeTimesAct.dActDelayTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. shake delay Act. ejector shake delay

%ELEMENT sv_EjectorShakeTimesAct.dActMoveTime
     %VARIABLE_GROUP VG_Eject,VG_SPC_POST  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. shake time Act. ejector shake time
 %UPDATE_CYCLE "Fast"
%ELEMENT sv_EjectorShakeTimesAct.dLastMoveTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Last shake time Last ejector shake time
;
 sv_bTransducerAvailable : BOOL (* chad(CR_0038565) *)
    ;
 sv_bLimitSwitchesAvailable : BOOL (* chad(CR_0038565) *)
    ;
 sv_dShakeBwdTime : TIME := t#0.1s (* chad(CR_0038565) *)
 %PLAUSIBILITY T#0.1s..T#99.9s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Shake bwd time Shake bwd time
;
 sv_dShakeBwdTimeAct : TIME (* chad(CR_0038565) *)
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. shake bwd time Act. shake bwd time
;
 sv_iActiveStageFwd : DINT (* active profile stage ejector fwd *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iActiveStageBwd : DINT (* active profile stage ejector bwd *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_CalculatedProfileFwd : tCalculatedProfiles
     %ABSREL Forward 
%ELEMENT sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwd.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT EjectorForce 
%ELEMENT sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwd.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileBwd : tCalculatedProfiles
     %ABSREL Backward 
%ELEMENT sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwd.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT EjectorForce 
%ELEMENT sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwd.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileBwdShake : tCalculatedProfiles
     %ABSREL Backward 
%ELEMENT sv_CalculatedProfileBwdShake.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwdShake.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT EjectorForce 
%ELEMENT sv_CalculatedProfileBwdShake.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwdShake.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileFwdRel : tCalculatedProfiles
     %ABSREL Forward 
%ELEMENT sv_CalculatedProfileFwdRel.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwdRel.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT EjectorForce 
%ELEMENT sv_CalculatedProfileFwdRel.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileFwdRel.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_CalculatedProfileBwdRel : tCalculatedProfiles
     %ABSREL Backward 
%ELEMENT sv_CalculatedProfileBwdRel.PressureProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwdRel.PressureProfile.CalculatedProfile.Point[0].rY
     %UNIT EjectorForce 
%ELEMENT sv_CalculatedProfileBwdRel.VelocityProfile.CalculatedProfile.Point[0].rX
     %UNIT Stroke 
%ELEMENT sv_CalculatedProfileBwdRel.VelocityProfile.CalculatedProfile.Point[0].rY
     %UNIT Speed ;
 sv_RequiredPumps : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=2000)
    
%ELEMENT sv_RequiredPumps.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Ejector Ejector
;
 sv_HydrMaxValues : tsHydrMaxValues (* hydraulic max values for ejector movements *)
    ;
 sv_rSmoothFactor : REAL := 0.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Smooth factor ejector Smooth factor ejector
;
%END

%SYSTEM_ALARM
  erEjectorHoldInFA
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Ejector mode "hold" not allowed in full automatic mode{#]Ejector mode and operation mode are incompatible.{#]Ejector mode "hold" will keep the ejector in forward position when removing produced parts at the end of a semi automatic cycle. Since there is no manual part removal in full automatic mode, the ejector mode "hold" is not allowed in this case.{#]Change the ejector mode to some other mode than "hold" according to the process requirements.\u000a<br><br>\u000aIf the ejector mode should be hold, the production mode should be the according half-automatic mode.
 ;
  erEjectorNotBackward
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Ejector not in backward position{#]Ejector is not in backward position.{#]A movement or functionality requires the ejector to be in backward position.\u000a Either the ejector is actually not in backward position, or the feedback from the machine is corrupt. \u000aIf the ejector cannot move to backward position, several causes are possible.<br>\u000aThe output values could be too low to overcome friction.<br>\u000aAnother possibility is a miscalibrated ejector regarding the settings\u000a "ejector stroke" and "set zero position".{#]Check on the hmi if the ejector is in backward position. Move the ejector \u000ato backward position. Then retry the previous desired movement or functionality.\u000a<br><br>\u000aIf the ejector doesn't reach the backward position check the output \u000asettings first. Ensure the output is high enough, to make a movement possible. \u000aRetry moving the ejector backward.\u000a<br><br>\u000aIf the ejector still doesn't reach the backward position go to operation mode \u000a"setup" and try to move it backward. If it moves the calibration of the stroke \u000aand or zero position could be problematic. In this case check the ejector stroke \u000asetting and reset the zero position correctly.\u000a<br><br>\u000aIf the ejector still doesn't reach the backward position check the sensor feedback \u000afrom the machine. Check on IO monitor mask if input signal is correct. If it is not there \u000ashould be a hardware problem.
 ;
  erEjectorNotForward
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Ejector not in forward position{#]Ejector is not in forward position.{#]A movement or functionality requires the ejector to be in forward position. Either the ejector is actually not in forward position, or the feedback from the machine is corrupt.{#]Check on the hmi if the ejector is in forward position. Move the ejector to forward position. Then retry the previous desired movement or functionality.\u000a<br><br>\u000aIf the ejector doesn't reach the forward position check the output settings first. Ensure the output is high enough, to make a movement possible. Retry moving the ejector forward.\u000a<br><br>\u000aIf the ejector still doesn't reach the forward position check the sensor feedback from the machine. Check on IO monitor mask if input signal is correct. If it is not there should be a hardware problem.
 ;
  erStrokeTooSmall
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Mechanical ejector stroke does not fit to used stroke and offset, check settings on ejector parameter mask{#]Ejector stroke setting doesn't fit to calibrated stroke and offset.{#]The previous ejector zero position setting produced an offset and a used stroke distance which doesn't fit the current ejector stroke setting.{#]If the ejector stroke was recently changed either change back to previous working setting. Or, if current ejector stroke setting is correct change to setup mode and use the set ejector zero position functionality.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
76 
@SysVar @RT(16)sv_bOutputActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ejector output active @RT(21)Ejector output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bOutputActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Ejector output active @RT(21)Ejector output active @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(16)sv_EjectorLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)KAPPL_LintabData_2P @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(77)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=50.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(16)sv_EjectorLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_EjectorLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_EjectorLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(26)0.0..%FU.sv_rEjectorStroke @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_EjectorLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rEjectorPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(4) @RT(0) 
@RT(16)Ejector position @RT(16)Ejector position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rEjectorPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)LG_ActPos(4) @RT(0) 
@RT(16)Ejector position @RT(16)Ejector position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rEjectorVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Ejector Velocity @RT(16)Ejector Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rEjectorVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Ejector Velocity @RT(16)Ejector Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rEjectorPositionRel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Ejector position @RT(16)Ejector position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rEjectorPositionRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Ejector position @RT(16)Ejector position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rEjectorStroke @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(43)Position when ejector is completely forward 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. ejector stroke @RT(19)Max. ejector stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rEjectorStroke @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)Position when ejector is completely forward 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(6)Stroke @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. ejector stroke @RT(19)Max. ejector stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_EjectorFwdVisShake @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(581)(Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=30.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rVelocity:=100.0,rStartPos:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(21)sv_EjectorFwdVisShake @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_EjectorFwdVisShake.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(50)sv_EjectorFwdVisShake.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_EjectorFwdVisShake.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_EjectorFwdVisShake.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_EjectorFwdVisShake.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_EjectorFwdVisShake.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_EjectorFwdVisShake.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(1)3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_EjectorFwdVisShake.rEndOutputPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Shake output @RT(12)Shake output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorFwdVisShake.rEndOutputVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Shake output @RT(12)Shake output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorFwdVisShake.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_EjectorFwdVisShake.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_EjectorFwdVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(629)(Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=30.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rVelocity:=100.0,rStartPos:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1.0e6,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwd) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(16)sv_EjectorFwdVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_EjectorFwdVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_EjectorFwdVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_EjectorFwdVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_EjectorFwdVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_EjectorFwdVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_EjectorFwdVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_EjectorFwdVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(1)3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_EjectorFwdVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. ramp forward @RT(17)Max. ramp forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_EjectorFwdVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_EjectorFwdVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_EjectorFwdVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_EjectorBwdVisShake @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(604)(Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressRamp:=100.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressRamp:=100.0,rVelRamp:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwdShake) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
10 
@AttrSym @RT(21)sv_EjectorBwdVisShake @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_EjectorBwdVisShake.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(50)sv_EjectorBwdVisShake.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_EjectorBwdVisShake.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_EjectorBwdVisShake.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_EjectorBwdVisShake.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_EjectorBwdVisShake.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_EjectorBwdVisShake.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(1)3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorBwdVisShake.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_EjectorBwdVisShake.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_EjectorBwdVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(598)(Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressRamp:=100.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressRamp:=100.0,rVelRamp:=100.0),iNoOfPoints:=3),rPreOutputVelRamp:=1.0e6,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwd) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
28 
@AttrSym @RT(16)sv_EjectorBwdVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_EjectorBwdVis.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_EjectorBwdVis.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_EjectorBwdVis.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_EjectorBwdVis.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_EjectorBwdVis.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_EjectorBwdVis.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_EjectorBwdVis.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(1)3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_EjectorBwdVis.ProfileTypePress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_EjectorBwdVis.ProfileTypeVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_EjectorBwdVis.RampTypePress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(27)KCTRL_YXGen_RampType_Linear @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_EjectorBwdVis.RampTypeVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(27)KCTRL_YXGen_RampType_Square @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_EjectorBwdVis.bLimitEveryPointToLastRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(91)limitation of profiles is done with last ramp for velocity and pressure, standard case TRUE 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorBwdVis.bOpenEndProfile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)profile with open end 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_EjectorBwdVis.bUseOffsetOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)use offset for optimizing positioning 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_EjectorBwdVis.bUsePressureRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorBwdVis.rEndOutputPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)pressure between direction change 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_EjectorBwdVis.rEndOutputVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)velocity between direction change 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_EjectorBwdVis.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. ramp backward @RT(18)Max. ramp backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_EjectorBwdVis.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorBwdVis.rMinOutputPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)minimum pressure output 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_EjectorBwdVis.rMinOutputVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(18)minimum vel output 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_EjectorBwdVis.rOffset @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)actual offset for profile calculation 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_EjectorBwdVis.rPreOutputPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(27)ramp for preoutput pressure 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_EjectorBwdVis.rPreOutputVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)preoutput value for vel 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorBwdVis.rPreOutputVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(22)ramp for preoutput vel 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_EjectorBwdVis.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_EjectorBwdVis.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_EjectorFwdVisRel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(669)(Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=30.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rVelocity:=100.0,rStartPos:=100.0),iNoOfPoints:=2),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageFwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileFwdRel) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(19)sv_EjectorFwdVisRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_EjectorFwdVisRel.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(49)EjectorGeneral.hmi.EjectorFwdProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_EjectorFwdVisRel.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_EjectorFwdVisRel.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_EjectorFwdVisRel.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(49)EjectorGeneral.hmi.EjectorFwdProgSafetyVisControl 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_EjectorFwdVisRel.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_EjectorFwdVisRel.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_EjectorFwdVisRel.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_EjectorFwdVisRel.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_EjectorFwdVisRel.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorFwdVisRel.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorFwdVisRel.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_EjectorBwdVisRel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(638)(Profile:=(Points:=(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=50.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=40.0),(rPressure:=1.0,rPressRamp:=100.0,rVelocity:=40.0,rVelRamp:=100.0,rStartPos:=10.0),(rPressRamp:=100.0,rVelRamp:=100.0,rStartPos:=0.0),(rPressRamp:=100.0,rVelRamp:=100.0),iNoOfPoints:=2),rPreOutputVelRamp:=1000.0,rPreOutputPressRamp:=1000.0,rMaxRampPress:=100.0,rMaxRampVel:=9999.9,RampTypeVel:=KCTRL_YXGen_RampType_Square,RampTypePress:=KCTRL_YXGen_RampType_Linear,piActStage:=@%FU.sv_iActiveStageBwd,pCalculatedProfile:=@%FU.sv_CalculatedProfileBwdRel) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(19)sv_EjectorBwdVisRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_EjectorBwdVisRel.Profile @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(49)EjectorGeneral.hmi.EjectorBwdProgrammedVisControl 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_EjectorBwdVisRel.Profile.Points[0].rPressRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_EjectorBwdVisRel.Profile.Points[0].rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Force @RT(5)Force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_EjectorBwdVisRel.Profile.Points[0].rStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(49)EjectorGeneral.hmi.EjectorBwdProgSafetyVisControl 
@RT(2)To @RT(2)To @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_EjectorBwdVisRel.Profile.Points[0].rVelRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_EjectorBwdVisRel.Profile.Points[0].rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_EjectorBwdVisRel.Profile.iNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt10 @RT(0) @RT(0) @RT(0) 
@RT(4)1..3 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Stages @RT(6)Stages @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_EjectorBwdVisRel.rMaxRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_EjectorBwdVisRel.rMaxRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorBwdVisRel.rStopRampPress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorBwdVisRel.rStopRampVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iShakeCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..20 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(21)LG_EjectorShake2(1,1) @RT(49)EjectorGeneral.hmi.EjectShakeProgrammedVisControl 
@RT(13)Shake counter @RT(21)Ejector shake counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iShakeCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..20 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(21)LG_EjectorShake2(1,1) @RT(49)EjectorGeneral.hmi.EjectShakeProgrammedVisControl 
@RT(13)Shake counter @RT(21)Ejector shake counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_EjectorMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tnEjectorMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)nNormal @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(11)EjectorMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(12)Ejector mode @RT(12)Ejector mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_EjectorMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(11)EjectorMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(12)Ejector mode @RT(12)Ejector mode @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(15)sv_MinOutputFwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(33)(rPressure:=0.03,rVelocity:=30.0) @RT(0) 
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
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output fwd @RT(23)Min. profile output fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputFwd.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output fwd @RT(23)Min. profile output fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_MinOutputBwd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsMinOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(33)(rPressure:=0.03,rVelocity:=30.0) @RT(0) 
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
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output bwd @RT(23)Min. profile output bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MinOutputBwd.rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt41 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Min. profile output bwd @RT(23)Min. profile output bwd @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(14)sv_ConstBwdVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(109)(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0))) @RT(37)const output for ejector bwd movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
9 
@AttrSym @RT(14)sv_ConstBwdVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)const output for ejector bwd movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstBwdVis.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Backward force @RT(14)Backward force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstBwdVis.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstBwdVis.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
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
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
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
4 @RT(109)(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0))) @RT(37)const output for ejector fwd movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
8 
@AttrSym @RT(14)sv_ConstFwdVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)const output for ejector fwd movement 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_ConstFwdVis.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Forward force @RT(13)Forward force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstFwdVis.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_ConstFwdVis.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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
@RT(4)Ramp @RT(4)Ramp @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(16)sv_ConstBwdVisLS @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(163)(Velocity:=(Output:=(rOutputValue:=40.0,rRamp:=9999.9),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0),PreOutput:=(rRamp:=1000.0))) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
7 
@AttrSym @RT(16)sv_ConstBwdVisLS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstBwdVisLS.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Backward force @RT(14)Backward force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstBwdVisLS.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstBwdVisLS.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)MaxRampForce @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstBwdVisLS.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Backward velocity @RT(17)Backward velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstBwdVisLS.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp bwd @RT(13)Max. ramp bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstBwdVisLS.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(15)MaxRampVelocity @RT(8)Backward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ConstFwdVisLS @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(163)(Velocity:=(Output:=(rOutputValue:=40.0,rRamp:=9999.9),PreOutput:=(rRamp:=1000.0)),Pressure:=(Output:=(rOutputValue:=1.0,rRamp:=100.0),PreOutput:=(rRamp:=1000.0))) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
9 
@AttrSym @RT(16)sv_ConstFwdVisLS @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstFwdVisLS.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Forward force @RT(13)Forward force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstFwdVisLS.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstFwdVisLS.Pressure.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(12)MaxRampForce @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstFwdVisLS.Pressure.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(45)sv_ConstFwdVisLS.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedFwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Forward velocity @RT(16)Forward velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ConstFwdVisLS.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Max. ramp fwd @RT(13)Max. ramp fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_ConstFwdVisLS.Velocity.PreOutput.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(7)Forward @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ConstFwdVisLS.Velocity.rMinOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rBwdInterruptPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)interrupt position for ejector bwd movement (needed for vibration mode) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rBwdInterruptPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(71)interrupt position for ejector bwd movement (needed for vibration mode) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bFwdActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Ejector forward is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Ejector fwd active @RT(22)Ejector forward active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bFwdActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Ejector forward is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Ejector fwd active @RT(22)Ejector forward active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bBwdActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)Ejector backward is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Ejector bwd active @RT(23)Ejector backward active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bBwdActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)Ejector backward is active 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Ejector bwd active @RT(23)Ejector backward active @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(21)sv_EjectorFwdTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(21)sv_EjectorFwdTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorFwdTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. forward time @RT(25)Max. ejector forward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorFwdTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Forward delay @RT(21)Ejector forward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_EjectorFwdTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Forward delay pump @RT(26)Ejector forward delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_EjectorFwdTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Forward delay valve @RT(27)Ejector forward delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_EjectorFwdTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_EjectorFwdTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorFwdTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Act. forward delay @RT(25)Act. ejector foward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorFwdTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(20)VG_Eject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. forward time @RT(25)Act. ejector forward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorFwdTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Last forward time @RT(25)Last ejector forward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_EjectorBwdTimesSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsSetTimes @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(21)sv_EjectorBwdTimesSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorBwdTimesSet.dMaxMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. backward time @RT(26)Max. ejector backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorBwdTimesSet.dSetDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_SequenceData,VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#0s..t#60s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Backward delay @RT(22)Ejector backward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_EjectorBwdTimesSet.dSetDelayTimePump @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Backward delay pump @RT(27)Ejector backward delay pump @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_EjectorBwdTimesSet.dSetDelayTimeValve @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#5s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Backward delay valve @RT(28)Ejector backward delay valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_EjectorBwdTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_EjectorBwdTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorBwdTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Act. backward delay @RT(27)Act. ejector backward delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_EjectorBwdTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(20)VG_Eject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Act. backward time @RT(26)Act. ejector backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorBwdTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Last backward time @RT(26)Last ejector backward time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_CalibState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(201)(pLintabPoints:=@%FU.sv_EjectorLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_EjectorLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rEjectorStroke,iOrder:=10,Group:=tnCalibGroup_Transducer) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
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
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Ejector @RT(18)Ejector transducer @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_CalibState.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_TransducerCalibData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsTransducerCalibData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(106)(Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveFwd,Id2:=cMoveBwd,bReverse:=FALSE,prPos1:=@%FU.sv_rEjectorStroke) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


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


@SysVar @RT(23)sv_bMoveEjectorUntilEnd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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
4 @RT(87)(rCylinderDiameter:=20.0,rPistonRodDiameter:=7.0,iNumCylinders:=1,bUseSmallSize:=FALSE) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(15)sv_CylinderData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
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
@RT(25)Move forward by ring area @RT(25)Move forward by ring area @RT(0) @RT(0) @RT(0) 
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
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutFwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=100.0))) @RT(0) 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutFwdV.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
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
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_LintabOutBwdP.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LintabOutBwdV @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=100.0))) @RT(0) 
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
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(8)Backward @RT(0) 
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
4 @RT(5)300.0 @RT(41)maximum speed for mold close (calculated) 
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
4 @RT(5)300.0 @RT(40)maximum speed for mold open (calculated) 
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
4 @RT(5)300.0 @RT(24)maximum speed fwd (user) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(17)maximum speed fwd 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedFwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Max. speed forward @RT(18)Max. speed forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rMaxSpeedBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(24)maximum speed bwd (user) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(5)Speed @RT(10)NoRelative @RT(0) 
@RT(29)0.0..%FU.sv_rMaxSpeedBwdCalib @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max. speed backward @RT(19)Max. speed backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxSpeedBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(17)maximum speed bwd 
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
4 @RT(5)145.0 @RT(17)maximum force fwd 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)EjectorForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(17)maximum force fwd 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)EjectorForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxPressureBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)145.0 @RT(17)maximum force bwd 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)EjectorForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxPressureBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(17)maximum force bwd 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(12)EjectorForce @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rEjectorLimDist @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)1.0..%FU.sv_rEjectorPlausDist @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Ejector stroke @RT(14)Ejector stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rEjectorLimDist @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)1.0..%FU.sv_rEjectorPlausDist @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Ejector stroke @RT(14)Ejector stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rEjectorLimOfs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rEjectorPlausOfs @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Ejector offset @RT(14)Ejector offset @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rEjectorLimOfs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rEjectorPlausOfs @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Ejector offset @RT(14)Ejector offset @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rEjectorPlausOfs @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt20 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rEjectorPlausOfs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt20 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rEjectorPlausDist @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt20 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rEjectorPlausDist @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt20 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rEjectorMonitorPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)ejector monitor position 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)0.0..Mold1.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold check position @RT(19)Mold check position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rEjectorMonitorPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)ejector monitor position 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)0.0..Mold1.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold check position @RT(19)Mold check position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_EjectorMonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(21)sv_EjectorMonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_EjectorMonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_EjectorMonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorMonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorMonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_EjectorMonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bSetEjectorZeroPos @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)hmi trigger to set actual ejector position as ejector offset 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Set ejector zero position @RT(25)Set ejector zero position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bSetEjectorZeroPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)hmi trigger to set actual ejector position as ejector offset 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Set ejector zero position @RT(25)Set ejector zero position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bEjectorMonitorPos @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)ejector monitor position reached 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Monitor pos. reached @RT(32)Ejector monitor position reached @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bEjectorMonitorPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)ejector monitor position reached 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Monitor pos. reached @RT(32)Ejector monitor position reached @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_EjectorShakeTimesAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsActTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(23)sv_EjectorShakeTimesAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_EjectorShakeTimesAct.dActDelayTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Act. shake delay @RT(24)Act. ejector shake delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_EjectorShakeTimesAct.dActMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(20)VG_Eject,VG_SPC_POST @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Act. shake time @RT(23)Act. ejector shake time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_EjectorShakeTimesAct.dLastMoveTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Last shake time @RT(23)Last ejector shake time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bTransducerAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bTransducerAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_bLimitSwitchesAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_bLimitSwitchesAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_dShakeBwdTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#0.1s @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(15)T#0.1s..T#99.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Shake bwd time @RT(14)Shake bwd time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_dShakeBwdTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(15)T#0.1s..T#99.9s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Shake bwd time @RT(14)Shake bwd time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_dShakeBwdTimeAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Act. shake bwd time @RT(19)Act. shake bwd time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dShakeBwdTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)chad(CR_0038565) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Act. shake bwd time @RT(19)Act. shake bwd time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iActiveStageFwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)active profile stage ejector fwd 
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
4 @RT(0) @RT(32)active profile stage ejector bwd 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(0) @RT(0) 
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
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(0) @RT(0) 
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


@SysVar @RT(28)sv_CalculatedProfileBwdShake @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(28)sv_CalculatedProfileBwdShake @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(74)sv_CalculatedProfileBwdShake.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(74)sv_CalculatedProfileBwdShake.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(74)sv_CalculatedProfileBwdShake.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(74)sv_CalculatedProfileBwdShake.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_CalculatedProfileFwdRel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(26)sv_CalculatedProfileFwdRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Forward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileFwdRel.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileFwdRel.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileFwdRel.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileFwdRel.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_CalculatedProfileBwdRel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(26)sv_CalculatedProfileBwdRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(8)Backward @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileBwdRel.PressureProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileBwdRel.PressureProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(12)EjectorForce @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileBwdRel.VelocityProfile.CalculatedProfile.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)x value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(72)sv_CalculatedProfileBwdRel.VelocityProfile.CalculatedProfile.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(7)y value 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(5)Speed @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_RequiredPumps @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=2000) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_RequiredPumps.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Ejector @RT(7)Ejector @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_HydrMaxValues @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)hydraulic max values for ejector movements 
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
@RT(21)Smooth factor ejector @RT(21)Smooth factor ejector @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rSmoothFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(14)VG_MachineData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Smooth factor ejector @RT(21)Smooth factor ejector @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
4 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erEjectorHoldInFA @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(568)Ejector mode "hold" not allowed in full automatic mode{#]Ejector mode and operation mode are incompatible.{#]Ejector mode "hold" will keep the ejector in forward position when removing produced parts at the end of a semi automatic cycle. Since there is no manual part removal in full automatic mode, the ejector mode "hold" is not allowed in this case.{#]Change the ejector mode to some other mode than "hold" according to the process requirements.\u000a<br><br>\u000aIf the ejector mode should be hold, the production mode should be the according half-automatic mode. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erEjectorNotBackward @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(1467)Ejector not in backward position{#]Ejector is not in backward position.{#]A movement or functionality requires the ejector to be in backward position.\u000a Either the ejector is actually not in backward position, or the feedback from the machine is corrupt. \u000aIf the ejector cannot move to backward position, several causes are possible.<br>\u000aThe output values could be too low to overcome friction.<br>\u000aAnother possibility is a miscalibrated ejector regarding the settings\u000a "ejector stroke" and "set zero position".{#]Check on the hmi if the ejector is in backward position. Move the ejector \u000ato backward position. Then retry the previous desired movement or functionality.\u000a<br><br>\u000aIf the ejector doesn't reach the backward position check the output \u000asettings first. Ensure the output is high enough, to make a movement possible. \u000aRetry moving the ejector backward.\u000a<br><br>\u000aIf the ejector still doesn't reach the backward position go to operation mode \u000a"setup" and try to move it backward. If it moves the calibration of the stroke \u000aand or zero position could be problematic. In this case check the ejector stroke \u000asetting and reset the zero position correctly.\u000a<br><br>\u000aIf the ejector still doesn't reach the backward position check the sensor feedback \u000afrom the machine. Check on IO monitor mask if input signal is correct. If it is not there \u000ashould be a hardware problem. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erEjectorNotForward @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(823)Ejector not in forward position{#]Ejector is not in forward position.{#]A movement or functionality requires the ejector to be in forward position. Either the ejector is actually not in forward position, or the feedback from the machine is corrupt.{#]Check on the hmi if the ejector is in forward position. Move the ejector to forward position. Then retry the previous desired movement or functionality.\u000a<br><br>\u000aIf the ejector doesn't reach the forward position check the output settings first. Ensure the output is high enough, to make a movement possible. Retry moving the ejector forward.\u000a<br><br>\u000aIf the ejector still doesn't reach the forward position check the sensor feedback from the machine. Check on IO monitor mask if input signal is correct. If it is not there should be a hardware problem. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erStrokeTooSmall @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(537)Mechanical ejector stroke does not fit to used stroke and offset, check settings on ejector parameter mask{#]Ejector stroke setting doesn't fit to calibrated stroke and offset.{#]The previous ejector zero position setting produced an offset and a used stroke distance which doesn't fit the current ejector stroke setting.{#]If the ejector stroke was recently changed either change back to previous working setting. Or, if current ejector stroke setting is correct change to setup mode and use the set ejector zero position functionality. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
