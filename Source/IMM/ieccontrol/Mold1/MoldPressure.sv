%IMPORT_OVER_LISTFILE_SOURCE
 Pressure
, fmt31
, VG_MachineData
, OnOff
, fmt22
, Voltage
, NoRelative
, fmt30

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_MeasureMonitoring
, KAPPL_LintabData_2P
, tsCalibMovement
, tnCalibGroup_LintabOnly
, cLevelStartupTechnican
, cLevelServiceEngineer

END_IMPORT

%SYSTEMVAR_DECL
  sv_rMoldPressure1 : REAL
 %PLAUSIBILITY 0.0..250.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt31  %UNIT Pressure 
// Mold pressure Close-Valve Mold pressure Close-Valve
;
 sv_rMoldPressure2 : REAL
 %PLAUSIBILITY 0.0..250.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt31  %UNIT Pressure 
// Mold pressure Open-Valve Mold pressure Open-Valve
;
 sv_Pres1MonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_Pres1MonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_Pres1MonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_Pres1MonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_Pres1MonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_Pres1MonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_Pres2MonitorMeas : KAPPL_MeasureMonitoring := (FailureFactor:=0.01,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_Pres2MonitorMeas.EnableMonitoring
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Do mon. Do monitoring

%ELEMENT sv_Pres2MonitorMeas.FailureFactor
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22 
// Failure fac. Failure factor

%ELEMENT sv_Pres2MonitorMeas.Limitation
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT OnOff 
// Use limit Use limitation

%ELEMENT sv_Pres2MonitorMeas.LowerLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Lower lim. Lower limit

%ELEMENT sv_Pres2MonitorMeas.UpperLimit
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31 
// Upper lim. Upper limit
;
 sv_Pressure1Lintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=210.0))) (* lintab for measuring with mold pressure sensor 1 *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Mold pre.sens. Close-Valve Mold pressure sensor Close-Valve

%ELEMENT sv_Pressure1Lintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_Pressure1Lintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..999.0      %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Pressure

%ELEMENT sv_Pressure1Lintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2     
// No. points No. points
;
 sv_Pressure2Lintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=210.0))) (* lintab for measuring with mold pressure sensor 2 *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Mold pre.sens. Open-Valve Mold pressure sensor Open-Valve

%ELEMENT sv_Pressure2Lintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_Pressure2Lintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..999.0      %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Pressure

%ELEMENT sv_Pressure2Lintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..2     
// No. points No. points
;
 sv_bPressureSensor1Error : BOOL
    ;
 sv_bPressureSensor2Error : BOOL
    ;
 sv_CalibStateMoldPressure1 : tsCalibMovement := (pLintabPoints:=@%FU.sv_Pressure1Lintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Pressure1Lintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_MoldPressure1,iOrder:=251,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateMoldPressure1.bNameDummy
    
// Mold press sens Close-Valve Mold pressure sensor Close-Valve
;
 sv_CalibStateMoldPressure2 : tsCalibMovement := (pLintabPoints:=@%FU.sv_Pressure2Lintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Pressure2Lintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_MoldPressure2,iOrder:=252,Group:=tnCalibGroup_LintabOnly)
    
%ELEMENT sv_CalibStateMoldPressure2.bNameDummy
    
// Mold press sens Open-Valve Mold pressure sensor Open-Valve
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
10 
@SysVar @RT(17)sv_rMoldPressure1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt31 @RT(8)Pressure @RT(0) @RT(0) 
@RT(10)0.0..250.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold pressure Close-Valve @RT(25)Mold pressure Close-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rMoldPressure1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt31 @RT(8)Pressure @RT(0) @RT(0) 
@RT(10)0.0..250.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold pressure Close-Valve @RT(25)Mold pressure Close-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rMoldPressure2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt31 @RT(8)Pressure @RT(0) @RT(0) 
@RT(10)0.0..250.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Mold pressure Open-Valve @RT(24)Mold pressure Open-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rMoldPressure2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt31 @RT(8)Pressure @RT(0) @RT(0) 
@RT(10)0.0..250.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Mold pressure Open-Valve @RT(24)Mold pressure Open-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_Pres1MonitorMeas @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)KAPPL_MeasureMonitoring @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(77)(FailureFactor:=0.01,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(19)sv_Pres1MonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_Pres1MonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_Pres1MonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Pres1MonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Pres1MonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Pres1MonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_Pres2MonitorMeas @RT(0) @T @T @DERIVED 0 @F @RT(23)KAPPL_MeasureMonitoring @F 
@T 
@BEG_Attrib 
4 @RT(77)(FailureFactor:=0.01,Limitation:=TRUE,EnableMonitoring:=TRUE,LowerLimit:=0.0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(19)sv_Pres2MonitorMeas @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_Pres2MonitorMeas.EnableMonitoring @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Do mon. @RT(13)Do monitoring @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_Pres2MonitorMeas.FailureFactor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Failure fac. @RT(14)Failure factor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Pres2MonitorMeas.Limitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Use limit @RT(14)Use limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Pres2MonitorMeas.LowerLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Lower lim. @RT(11)Lower limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_Pres2MonitorMeas.UpperLimit @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Upper lim. @RT(11)Upper limit @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_Pressure1Lintab @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=210.0))) @RT(48)lintab for measuring with mold pressure sensor 1 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Mold pre.sens. Close-Valve @RT(32)Mold pressure sensor Close-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(18)sv_Pressure1Lintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)lintab for measuring with backpressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Mold pre.sens. Close-Valve @RT(32)Mold pressure sensor Close-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_Pressure1Lintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_Pressure1Lintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_Pressure1Lintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)No. points @RT(10)No. points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_Pressure2Lintab @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=210.0))) @RT(48)lintab for measuring with mold pressure sensor 2 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold pre.sens. Open-Valve @RT(31)Mold pressure sensor Open-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(18)sv_Pressure2Lintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)lintab for measuring with backpressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold pre.sens. Open-Valve @RT(31)Mold pressure sensor Open-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_Pressure2Lintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_Pressure2Lintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(43)sv_Pressure2Lintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(4)2..2 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)No. points @RT(10)No. points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bPressureSensor1Error @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(24)sv_bPressureSensor2Error @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(26)sv_CalibStateMoldPressure1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(208)(pLintabPoints:=@%FU.sv_Pressure1Lintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Pressure1Lintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_MoldPressure1,iOrder:=251,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(37)sv_CalibStateMoldPressure1.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Mold press sens Close-Valve @RT(32)Mold pressure sensor Close-Valve @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_CalibStateMoldPressure2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(208)(pLintabPoints:=@%FU.sv_Pressure2Lintab.LintabPoints.Point,piUsedLintabPoints:=@%FU.sv_Pressure2Lintab.LintabPoints.uNoOfPoints,prInputSensor:=@%FU.ai_MoldPressure2,iOrder:=252,Group:=tnCalibGroup_LintabOnly) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(37)sv_CalibStateMoldPressure2.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Mold press sens Open-Valve @RT(31)Mold pressure sensor Open-Valve @RT(0) @RT(0) @RT(0) 
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
