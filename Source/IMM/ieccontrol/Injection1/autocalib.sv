%IMPORT_OVER_LISTFILE_SOURCE
 CalibGroup
, fmtCalibState
, OnOff
, VG_MachineData
, fmt32

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData
, KCTRL_Lintab_Point
, tyHalfArray
, tsCalculatedInjectData2
, tsCalibMovement
, tsTransducerCalibData
, tsVelPre
, KCTRL_Stable_Param
, tnCalibState_None
, tnCalibGroup_Transducer
, tnCalibGroup_ClosedLoop
, tnCalibGroup_Velocity
, tnCalibGroup_LintabOnly
, cMoveFwd
, cMoveBwd
, cMoveInject
, cMoveDecompAftPlast
, cLevelStartupTechnican
, cLevelServiceEngineer
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_TmpRpmLintab : KAPPL_LintabData
    ;
 sv_TmpLintabPoint : KCTRL_Lintab_Point
    ;
 sv_bDoTransducerCalib : BOOL
     %INPUT_LEVEL 16
;
 sv_bDoInjectionCalib : BOOL
     %INPUT_LEVEL 16
;
 sv_bDoRPMCalib : BOOL
     %INPUT_LEVEL 16
;
 sv_IdentOutData : tyHalfArray (* temp array for ident block *)
    ;
 sv_IdentInData : tyHalfArray (* temp array for ident block *)
    ;
 sv_TmpInjectionData : tsCalculatedInjectData2 := (rPhasemargin:=80.0,rPhasemargin3dB:=70.0,rPhasemarginMin3dB:=62.0) (* temp for communicating with control block *)
    ;
 sv_bDoBackPressureCalib : BOOL
     %INPUT_LEVEL 16
;
 sv_CalibState : tsCalibMovement := (pLintabPoints:=@%FU.sv_ScrewLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_ScrewLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rScrewStroke,prInputSensor:=@%FU.ai_Position,Status:=tnCalibState_None,iOrder:=40,Group:=tnCalibGroup_Transducer)
    
%ELEMENT sv_CalibState.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibState.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibState.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Injection Injection transducer

%ELEMENT sv_CalibState.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_CalibStateInjection : tsCalibMovement := (prMaxValue:=@%FU.sv_rMaxSpeedFwd,Status:=tnCalibState_None,iOrder:=80,Group:=tnCalibGroup_ClosedLoop)
    
%ELEMENT sv_CalibStateInjection.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateInjection.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateInjection.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Injection Injection controller

%ELEMENT sv_CalibStateInjection.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_CalibStateBackPressure : tsCalibMovement := (Status:=tnCalibState_None,iOrder:=90,Group:=tnCalibGroup_ClosedLoop)
    
%ELEMENT sv_CalibStateBackPressure.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateBackPressure.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateBackPressure.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Hold Hold controller

%ELEMENT sv_CalibStateBackPressure.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_CalibStateRPM : tsCalibMovement := (pLintab:=@%FU.sv_ScrewRevVelLintab,prMaxValue:=@%FU.sv_rMaxRpm,Status:=tnCalibState_None,iOrder:=70,Group:=tnCalibGroup_Velocity)
    
%ELEMENT sv_CalibStateRPM.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateRPM.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateRPM.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// RPM RPM

%ELEMENT sv_CalibStateRPM.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_CalibStateSysPressure : tsCalibMovement := (pLintabPoints:=@%FU.sv_SysPressureLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_SysPressureLintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_SysPressure,Status:=tnCalibState_None,iOrder:=210,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateSysPressure.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateSysPressure.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateSysPressure.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Inject sys press Injection system pressure

%ELEMENT sv_CalibStateSysPressure.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateInjectPressure : tsCalibMovement := (pLintabPoints:=@%FU.sv_PressureLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_PressureLintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_Pressure,Status:=tnCalibState_None,iOrder:=200,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateInjectPressure.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateInjectPressure.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateInjectPressure.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Inject press Injection pressure

%ELEMENT sv_CalibStateInjectPressure.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_TransducerCalibData : tsTransducerCalibData := (Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveInject,Id2:=cMoveDecompAftPlast,bReverse:=TRUE,prPos2:=@%FU.sv_rScrewStroke)
    ;
 sv_ConstInjectionCalib : tsVelPre (* specified in %, not abs/rel switched !! *)
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_ConstBackPressureCalib : tsVelPre (* specified in %, not abs/rel switched !! *)
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_ConstPumpPressureVelocCalib : tsVelPre := (Velocity:=(Output:=(rRamp:=50.0)),Pressure:=(Output:=(rRamp:=50.0))) (* to be enabled later, copied from sv_ConstInjectSetup and modified *)
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_bStartBackPTest : BOOL
     %INPUT_LEVEL 16
;
 sv_PressureStableParam : KCTRL_Stable_Param := (rRange:=0.01,dObservationTime:=T#1s,dTimeOut:=T#10s) (* Condition for stability during calibration *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Stab param press Stability params pressure
;
 sv_VelocityStableParam : KCTRL_Stable_Param := (rRange:=0.0,dObservationTime:=T#1s,dTimeOut:=T#10s) (* Condition for stability during calibration *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Stab param vel Stability params velocity
;
 sv_RPMStableParam : KCTRL_Stable_Param := (rRange:=1.0,dObservationTime:=T#5s,dTimeOut:=T#30s) (* Condition for stability during calibration *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Stab param rpm Stability params screw rpm
;
 sv_ConstServoPressureVelocCalib : tsVelPre := (Velocity:=(Output:=(rRamp:=50.0)),Pressure:=(Output:=(rRamp:=50.0),PreOutput:=(rRamp:=1000.0))) (* to be enabled later, copied from sv_ConstInjectSetup and modified *)
   RETAIN ;
 sv_rMaxMeasurePositionRel : REAL := 0.9 (* maximum relative position of stroke for measuring: 1 .. 100% *)
 %PLAUSIBILITY 0.1..0.99    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt32 
// Maximum measure position relative to screw stroke Maximum measure position relative to screw stroke
;
 sv_speed1 : REAL
    
// speed1 speed1
;
 sv_speed2 : REAL
    
// speed2 speed2
;
 sv_speed3 : REAL
    
// speed3 speed3
;
 sv_speed4 : REAL
    
// speed4 speed4
;
 sv_Lintab1 : tsCalibMovement := (pLintab:=@%FU.sv_Lintab10,pLintabPoints:=@%FU.sv_Lintab10.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab10.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer)
    ;
 sv_Lintab2 : tsCalibMovement := (pLintab:=@%FU.sv_Lintab20,pLintabPoints:=@%FU.sv_Lintab20.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab20.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer)
    ;
 sv_Lintab3 : tsCalibMovement := (pLintab:=@%FU.sv_Lintab30,pLintabPoints:=@%FU.sv_Lintab30.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab30.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer)
    ;
 sv_Lintab4 : tsCalibMovement := (pLintab:=@%FU.sv_Lintab40,pLintabPoints:=@%FU.sv_Lintab40.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab40.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer)
    ;
 sv_Lintab10 : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0)))
   RETAIN ;
 sv_Lintab20 : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0)))
   RETAIN ;
 sv_Lintab30 : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0)))
   RETAIN ;
 sv_Lintab40 : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0)))
   RETAIN ;
 sv_bMoveToServoCalibStartPos : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_Max : REAL := 10000.0
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
39 
@SysVar @RT(15)sv_TmpRpmLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(21)sv_bDoTransducerCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bDoTransducerCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_bDoInjectionCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_bDoInjectionCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bDoRPMCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bDoRPMCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_IdentOutData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyHalfArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)temp array for ident block 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_IdentOutData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)temp array for ident block 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_IdentInData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyHalfArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)temp array for ident block 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_IdentInData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)temp array for ident block 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_TmpInjectionData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tsCalculatedInjectData2 @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(67)(rPhasemargin:=80.0,rPhasemargin3dB:=70.0,rPhasemarginMin3dB:=62.0) @RT(41)temp for communicating with control block 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_TmpInjectionData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)temp for communicating with control block 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bDoBackPressureCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bDoBackPressureCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_CalibState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(253)(pLintabPoints:=@%FU.sv_ScrewLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_ScrewLintab.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_rScrewStroke,prInputSensor:=@%FU.ai_Position,Status:=tnCalibState_None,iOrder:=40,Group:=tnCalibGroup_Transducer) @RT(0) 
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
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Injection @RT(20)Injection transducer @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(22)sv_CalibStateInjection @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(102)(prMaxValue:=@%FU.sv_rMaxSpeedFwd,Status:=tnCalibState_None,iOrder:=80,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(22)sv_CalibStateInjection @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_CalibStateInjection.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_CalibStateInjection.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_CalibStateInjection.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Injection @RT(20)Injection controller @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_CalibStateInjection.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CalibStateBackPressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(69)(Status:=tnCalibState_None,iOrder:=90,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(25)sv_CalibStateBackPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateBackPressure.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_CalibStateBackPressure.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CalibStateBackPressure.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Hold @RT(15)Hold controller @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateBackPressure.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_CalibStateRPM @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(130)(pLintab:=@%FU.sv_ScrewRevVelLintab,prMaxValue:=@%FU.sv_rMaxRpm,Status:=tnCalibState_None,iOrder:=70,Group:=tnCalibGroup_Velocity) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(16)sv_CalibStateRPM @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_CalibStateRPM.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_CalibStateRPM.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_CalibStateRPM.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)RPM @RT(3)RPM @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_CalibStateRPM.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateSysPressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(236)(pLintabPoints:=@%FU.sv_SysPressureLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_SysPressureLintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_SysPressure,Status:=tnCalibState_None,iOrder:=210,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateSysPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateSysPressure.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateSysPressure.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateSysPressure.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Inject sys press @RT(25)Injection system pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateSysPressure.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_CalibStateInjectPressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(227)(pLintabPoints:=@%FU.sv_PressureLintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_PressureLintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_Pressure,Status:=tnCalibState_None,iOrder:=200,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(27)sv_CalibStateInjectPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_CalibStateInjectPressure.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_CalibStateInjectPressure.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_CalibStateInjectPressure.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Inject press @RT(18)Injection pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_CalibStateInjectPressure.bRedo @RT(0) @F @F 
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
4 @RT(117)(Dir1:=cMoveFwd,Dir2:=cMoveBwd,Id1:=cMoveInject,Id2:=cMoveDecompAftPlast,bReverse:=TRUE,prPos2:=@%FU.sv_rScrewStroke) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(22)sv_ConstInjectionCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)specified in %, not abs/rel switched !! 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_ConstInjectionCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)specified in %, not abs/rel switched !! 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_ConstBackPressureCalib @RT(0) @T @T @DERIVED 0 @F @RT(8)tsVelPre @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)specified in %, not abs/rel switched !! 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_ConstBackPressureCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)specified in %, not abs/rel switched !! 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(30)sv_ConstPumpPressureVelocCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(69)(Velocity:=(Output:=(rRamp:=50.0)),Pressure:=(Output:=(rRamp:=50.0))) @RT(65)to be enabled later, copied from sv_ConstInjectSetup and modified 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_ConstPumpPressureVelocCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)to be enabled later, copied from sv_ConstInjectSetup and modified 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bStartBackPTest @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bStartBackPTest @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_PressureStableParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Stable_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(53)(rRange:=0.01,dObservationTime:=T#1s,dTimeOut:=T#10s) @RT(42)Condition for stability during calibration 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Stab param press @RT(25)Stability params pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_PressureStableParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Stab param press @RT(25)Stability params pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_VelocityStableParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Stable_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(52)(rRange:=0.0,dObservationTime:=T#1s,dTimeOut:=T#10s) @RT(42)Condition for stability during calibration 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Stab param vel @RT(25)Stability params velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_VelocityStableParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Stab param vel @RT(25)Stability params velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_RPMStableParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Stable_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(52)(rRange:=1.0,dObservationTime:=T#5s,dTimeOut:=T#30s) @RT(42)Condition for stability during calibration 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Stab param rpm @RT(26)Stability params screw rpm @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_RPMStableParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Stab param rpm @RT(26)Stability params screw rpm @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_ConstServoPressureVelocCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(96)(Velocity:=(Output:=(rRamp:=50.0)),Pressure:=(Output:=(rRamp:=50.0),PreOutput:=(rRamp:=1000.0))) @RT(65)to be enabled later, copied from sv_ConstInjectSetup and modified 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_ConstServoPressureVelocCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)to be enabled later, copied from sv_ConstInjectSetup and modified 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rMaxMeasurePositionRel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.9 @RT(60)maximum relative position of stroke for measuring: 1 .. 100% 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(9)0.1..0.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(49)Maximum measure position relative to screw stroke @RT(49)Maximum measure position relative to screw stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMaxMeasurePositionRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.9 @RT(60)maximum relative position of stroke for measuring: 1 .. 100% 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(9)0.1..0.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(49)Maximum measure position relative to screw stroke @RT(49)Maximum measure position relative to screw stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_speed1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed1 @RT(6)speed1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_speed1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed1 @RT(6)speed1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_speed2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed2 @RT(6)speed2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_speed2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed2 @RT(6)speed2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_speed3 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed3 @RT(6)speed3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_speed3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed3 @RT(6)speed3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_speed4 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed4 @RT(6)speed4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_speed4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)speed4 @RT(6)speed4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_Lintab1 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(195)(pLintab:=@%FU.sv_Lintab10,pLintabPoints:=@%FU.sv_Lintab10.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab10.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(10)sv_Lintab2 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(195)(pLintab:=@%FU.sv_Lintab20,pLintabPoints:=@%FU.sv_Lintab20.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab20.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(10)sv_Lintab3 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(195)(pLintab:=@%FU.sv_Lintab30,pLintabPoints:=@%FU.sv_Lintab30.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab30.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(10)sv_Lintab4 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(195)(pLintab:=@%FU.sv_Lintab40,pLintabPoints:=@%FU.sv_Lintab40.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Lintab40.LintabPoints.uNoOfPoints,prMaxValue:=@%FU.sv_Max,Group:=tnCalibGroup_Transducer) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(11)sv_Lintab10 @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_Lintab10 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_Lintab20 @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_Lintab20 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_Lintab30 @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_Lintab30 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_Lintab40 @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_Lintab40 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(75)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=1.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_bMoveToServoCalibStartPos @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_bMoveToServoCalibStartPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(6)sv_Max @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)10000.0 @RT(0) 
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
0 

@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
