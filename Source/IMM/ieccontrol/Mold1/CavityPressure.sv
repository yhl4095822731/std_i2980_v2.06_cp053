%IMPORT_OVER_LISTFILE_SOURCE
 CalibGroup
, fmtCalibState
, OnOff
, VG_MachineData
, fmt22
, fmt31
, Pressure
, NoRelative
, fmt41
, LG_ActMold
, Voltage
, fmt30
, VG_MoldData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsCalibMovement
, KAPPL_MeasureMonitoring
, KAPPL_LintabData_2P
, tnCalibState_None
, tnCalibGroup_LintabOnly
, cLevelStartupTechnican
, cLevelServiceEngineer
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_CalibStateCavityPres1 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab1.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab1.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure1,Status:=tnCalibState_None,iOrder:=230,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres1.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres1.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres1.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 1 Cavity pressure 1

%ELEMENT sv_CalibStateCavityPres1.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres2 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab2.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab2.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure2,Status:=tnCalibState_None,iOrder:=232,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres2.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres2.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres2.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 2 Cavity pressure 2

%ELEMENT sv_CalibStateCavityPres2.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres3 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab3.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab3.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure3,Status:=tnCalibState_None,iOrder:=234,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres3.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres3.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres3.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 3 Cavity pressure 3

%ELEMENT sv_CalibStateCavityPres3.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres4 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab4.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab4.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure4,Status:=tnCalibState_None,iOrder:=236,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres4.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres4.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres4.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 4 Cavity pressure 4

%ELEMENT sv_CalibStateCavityPres4.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres5 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab5.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab5.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure5,Status:=tnCalibState_None,iOrder:=238,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres5.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres5.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres5.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 5 Cavity pressure 5

%ELEMENT sv_CalibStateCavityPres5.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres6 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab6.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab6.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure6,iOrder:=240,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres6.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres6.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres6.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 6 Cavity pressure 6

%ELEMENT sv_CalibStateCavityPres6.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres7 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab7.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab7.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure7,iOrder:=242,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres7.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres7.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres7.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 7 Cavity pressure 7

%ELEMENT sv_CalibStateCavityPres7.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CalibStateCavityPres8 : tsCalibMovement := (pLintabPoints:=@%FU.sv_CavityPressLintab8.LintabPointPoint,piUsedLintabPoints:=@%FU.sv_CavityPressLintab8.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure8,iOrder:=244,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateCavityPres8.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStateCavityPres8.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStateCavityPres8.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Cavity press 8 Cavity pressure 8

%ELEMENT sv_CalibStateCavityPres8.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff ;
 sv_CavityPresMonitorMeas1 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas1.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas1.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas1.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas1.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas1.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas2 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas2.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas2.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas2.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas2.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas2.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas3 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas3.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas3.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas3.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas3.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas3.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas4 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas4.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas4.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas4.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas4.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas4.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas5 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas5.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas5.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas5.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas5.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas5.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas6 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas6.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas6.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas6.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas6.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas6.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas7 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas7.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas7.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas7.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas7.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas7.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_CavityPresMonitorMeas8 : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=FALSE,EnableMonitoring:=FALSE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_CavityPresMonitorMeas8.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_CavityPresMonitorMeas8.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_CavityPresMonitorMeas8.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_CavityPresMonitorMeas8.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_CavityPresMonitorMeas8.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_rCavityPressure1 : REAL (* current pressure *)
     %LIST_GROUP LG_ActMold(10)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 1 Cavity pressure 1
;
 sv_rCavityPressure2 : REAL
     %LIST_GROUP LG_ActMold(11)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 2 Cavity pressure 2
;
 sv_rCavityPressure3 : REAL
     %LIST_GROUP LG_ActMold(12)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 3 Cavity pressure 3
;
 sv_rCavityPressure4 : REAL
     %LIST_GROUP LG_ActMold(13)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 4 Cavity pressure 4
;
 sv_rCavityPressure5 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 5 Cavity pressure 5
;
 sv_rCavityPressure6 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 6 Cavity pressure 6
;
 sv_rCavityPressure7 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 7 Cavity pressure 7
;
 sv_rCavityPressure8 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Cavity pres 8 Cavity pressure 8
;
 sv_rMaxCavityPressure1 : REAL (* max pressure in cycle *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 1 Max Cavity pressure 1
;
 sv_rMaxCavityPressure2 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 2 Max Cavity pressure 2
;
 sv_rMaxCavityPressure3 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 3 Max Cavity pressure 3
;
 sv_rMaxCavityPressure4 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 4 Max Cavity pressure 4
;
 sv_rMaxCavityPressure5 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 5 Max Cavity pressure 5
;
 sv_rMaxCavityPressure6 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 6 Max Cavity pressure 6
;
 sv_rMaxCavityPressure7 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 7 Max Cavity pressure 7
;
 sv_rMaxCavityPressure8 : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Max Cavity pres 8 Max Cavity pressure 8
;
 sv_bCavityPressureError1 : BOOL (* sensor error *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 1 Cavity pressure error 1
;
 sv_bCavityPressureError2 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 2 Cavity pressure error 2
;
 sv_bCavityPressureError3 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 3 Cavity pressure error 3
;
 sv_bCavityPressureError4 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 4 Cavity pressure error 4
;
 sv_bCavityPressureError5 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 5 Cavity pressure error 5
;
 sv_bCavityPressureError6 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 6 Cavity pressure error 6
;
 sv_bCavityPressureError7 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 7 Cavity pressure error 7
;
 sv_bCavityPressureError8 : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Cavity pres err 8 Cavity pressure error 8
;
 sv_CavityPressLintab1 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) (* lintab for converting cavity pressure from V to bar *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab1.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab1.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab1.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.1 Cavity pres. sensor 1
;
 sv_CavityPressLintab2 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab2.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab2.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab2.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.2 Cavity pres. sensor 2
;
 sv_CavityPressLintab3 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab3.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab3.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab3.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.3 Cavity pres. sensor 3
;
 sv_CavityPressLintab4 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab4.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab4.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab4.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.4 Cavity pres. sensor 4
;
 sv_CavityPressLintab5 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab5.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab5.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab5.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.5 Cavity pres. sensor 5
;
 sv_CavityPressLintab6 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab6.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab6.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab6.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.6 Cavity pres. sensor 6
;
 sv_CavityPressLintab7 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab7.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab7.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab7.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.7 Cavity pres. sensor 7
;
 sv_CavityPressLintab8 : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_CavityPressLintab8.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Input voltage

%ELEMENT sv_CavityPressLintab8.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Cavity pressure

%ELEMENT sv_CavityPressLintab8.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2      %FORMAT fmt30 
// Cav.p.sens.8 Cavity pres. sensor 8
;
 sv_bActivateCavityPressMeas : BOOL (* cavity pressure measuring on/off *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Measure cavity pressure Measure cavity pressure
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
49 
@SysVar @RT(24)sv_CalibStateCavityPres1 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(242)(pLintabPoints:=@%FU.sv_CavityPressLintab1.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab1.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure1,Status:=tnCalibState_None,iOrder:=230,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres1.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres1.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres1.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 1 @RT(17)Cavity pressure 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres1.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres2 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(242)(pLintabPoints:=@%FU.sv_CavityPressLintab2.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab2.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure2,Status:=tnCalibState_None,iOrder:=232,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres2.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres2.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres2.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 2 @RT(17)Cavity pressure 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres2.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres3 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(242)(pLintabPoints:=@%FU.sv_CavityPressLintab3.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab3.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure3,Status:=tnCalibState_None,iOrder:=234,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres3.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres3.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres3.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 3 @RT(17)Cavity pressure 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres3.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres4 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(242)(pLintabPoints:=@%FU.sv_CavityPressLintab4.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab4.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure4,Status:=tnCalibState_None,iOrder:=236,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres4.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres4.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres4.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 4 @RT(17)Cavity pressure 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres4.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres5 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(242)(pLintabPoints:=@%FU.sv_CavityPressLintab5.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab5.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure5,Status:=tnCalibState_None,iOrder:=238,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres5.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres5.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres5.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 5 @RT(17)Cavity pressure 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres5.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres6 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(216)(pLintabPoints:=@%FU.sv_CavityPressLintab6.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab6.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure6,iOrder:=240,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres6.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres6.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres6.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 6 @RT(17)Cavity pressure 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres6.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres7 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(216)(pLintabPoints:=@%FU.sv_CavityPressLintab7.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_CavityPressLintab7.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure7,iOrder:=242,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres7.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres7.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres7.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 7 @RT(17)Cavity pressure 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres7.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_CalibStateCavityPres8 @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(214)(pLintabPoints:=@%FU.sv_CavityPressLintab8.LintabPointPoint,piUsedLintabPoints:=@%FU.sv_CavityPressLintab8.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_CavityPressure8,iOrder:=244,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(24)sv_CalibStateCavityPres8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres8.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStateCavityPres8.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_CalibStateCavityPres8.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Cavity press 8 @RT(17)Cavity pressure 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CalibStateCavityPres8.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas1.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas1.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas1.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas1.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas1.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas2.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas2.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas2.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas2.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas2.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas3 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas3.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas3.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas3.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas3.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas3.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas4 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas4.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas4.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas4.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas4.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas4.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas5 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas5.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas5.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas5.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas5.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas5.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas6 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas6.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas6.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas6.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas6.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas6.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas7 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas7.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas7.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas7.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas7.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas7.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CavityPresMonitorMeas8 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(25)sv_CavityPresMonitorMeas8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_CavityPresMonitorMeas8.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use monitoring 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_CavityPresMonitorMeas8.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)To define lowest (highest) limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas8.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Use limitation 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas8.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given upper allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CavityPresMonitorMeas8.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Given lower allowed limit 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)current pressure 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(10) @RT(0) 
@RT(13)Cavity pres 1 @RT(17)Cavity pressure 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)current pressure 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(10) @RT(0) 
@RT(13)Cavity pres 1 @RT(17)Cavity pressure 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(11) @RT(0) 
@RT(13)Cavity pres 2 @RT(17)Cavity pressure 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(11) @RT(0) 
@RT(13)Cavity pres 2 @RT(17)Cavity pressure 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure3 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(12) @RT(0) 
@RT(13)Cavity pres 3 @RT(17)Cavity pressure 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(12) @RT(0) 
@RT(13)Cavity pres 3 @RT(17)Cavity pressure 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure4 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(13) @RT(0) 
@RT(13)Cavity pres 4 @RT(17)Cavity pressure 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)LG_ActMold(13) @RT(0) 
@RT(13)Cavity pres 4 @RT(17)Cavity pressure 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure5 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 5 @RT(17)Cavity pressure 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 5 @RT(17)Cavity pressure 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure6 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 6 @RT(17)Cavity pressure 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 6 @RT(17)Cavity pressure 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure7 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 7 @RT(17)Cavity pressure 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 7 @RT(17)Cavity pressure 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rCavityPressure8 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 8 @RT(17)Cavity pressure 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rCavityPressure8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cavity pres 8 @RT(17)Cavity pressure 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)max pressure in cycle 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 1 @RT(21)Max Cavity pressure 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)max pressure in cycle 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 1 @RT(21)Max Cavity pressure 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 2 @RT(21)Max Cavity pressure 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 2 @RT(21)Max Cavity pressure 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure3 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 3 @RT(21)Max Cavity pressure 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 3 @RT(21)Max Cavity pressure 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure4 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 4 @RT(21)Max Cavity pressure 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 4 @RT(21)Max Cavity pressure 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure5 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 5 @RT(21)Max Cavity pressure 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 5 @RT(21)Max Cavity pressure 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure6 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 6 @RT(21)Max Cavity pressure 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 6 @RT(21)Max Cavity pressure 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure7 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 7 @RT(21)Max Cavity pressure 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 7 @RT(21)Max Cavity pressure 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxCavityPressure8 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 8 @RT(21)Max Cavity pressure 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxCavityPressure8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max Cavity pres 8 @RT(21)Max Cavity pressure 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError1 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)sensor error 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 1 @RT(23)Cavity pressure error 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)sensor error 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 1 @RT(23)Cavity pressure error 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError2 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 2 @RT(23)Cavity pressure error 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 2 @RT(23)Cavity pressure error 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError3 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 3 @RT(23)Cavity pressure error 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 3 @RT(23)Cavity pressure error 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError4 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 4 @RT(23)Cavity pressure error 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 4 @RT(23)Cavity pressure error 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError5 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 5 @RT(23)Cavity pressure error 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 5 @RT(23)Cavity pressure error 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError6 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 6 @RT(23)Cavity pressure error 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 6 @RT(23)Cavity pressure error 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError7 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 7 @RT(23)Cavity pressure error 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 7 @RT(23)Cavity pressure error 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bCavityPressureError8 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 8 @RT(23)Cavity pressure error 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bCavityPressureError8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cavity pres err 8 @RT(23)Cavity pressure error 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab1 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(51)lintab for converting cavity pressure from V to bar 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(51)lintab for converting cavity pressure from V to bar 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab1.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab1.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab1.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.1 @RT(21)Cavity pres. sensor 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab2 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab2.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab2.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab2.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.2 @RT(21)Cavity pres. sensor 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab3 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab3.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab3.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab3.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.3 @RT(21)Cavity pres. sensor 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab4 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab4.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab4.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab4.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.4 @RT(21)Cavity pres. sensor 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab5 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab5.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab5.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab5.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.5 @RT(21)Cavity pres. sensor 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab6 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab6.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab6.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab6.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.6 @RT(21)Cavity pres. sensor 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab7 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab7.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab7.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab7.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.7 @RT(21)Cavity pres. sensor 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_CavityPressLintab8 @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=150.0))) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(21)sv_CavityPressLintab8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab8.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(13)Input voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab8.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(15)Cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_CavityPressLintab8.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Cav.p.sens.8 @RT(21)Cavity pres. sensor 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_bActivateCavityPressMeas @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)cavity pressure measuring on/off 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Measure cavity pressure @RT(23)Measure cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_bActivateCavityPressMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)cavity pressure measuring on/off 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Measure cavity pressure @RT(23)Measure cavity pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


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
