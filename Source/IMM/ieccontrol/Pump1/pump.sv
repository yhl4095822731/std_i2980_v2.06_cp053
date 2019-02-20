%IMPORT_OVER_LISTFILE_SOURCE
 PumpFlow
, NoRelative
, fmt41
, VG_MachineData
, Pressure
, Relative
, fmt30
, LG_ActPump
, Percent
, MaxSystemVelocity
, fmt31
, Voltage
, fmt22
, Frequency
, fmt40
, OnOff

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData
, KAPPL_LintabData_2P
, KAPPL_MeasureMonitoring
, MAX_VOLTAGE
, cLevelStartupTechnican
, cLevelServiceEngineer
, cLevelSuperUser
, MAX_NO_LINTAB_POINTS

END_IMPORT

%SYSTEMVAR_DECL
  sv_rAbsFlow : REAL := 50.0 (* absolute flow of pump in l/min *)
 %PLAUSIBILITY 0.1..9999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT PumpFlow  %ABSREL NoRelative 
// Abs flow pump %f Absolute flow pump %f
;
 sv_rPressure : REAL (* pressure output *)
     %LIST_GROUP LG_ActPump(1)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Relative 
// Pressure Pressure output
 %UPDATE_CYCLE "Fast";
 sv_rVelocity : REAL (* velocity output *)
     %LIST_GROUP LG_ActPump(2)
 %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Percent  %ABSREL MaxSystemVelocity 
// Velocity Velocity output
 %UPDATE_CYCLE "Fast";
 sv_VelocityLintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=100.0,rY:=10.0))) (* lintab for pump vel *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_VelocityLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..system.sv_rMaximumVelocity      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Percent 
// Velocity Velocity

%ELEMENT sv_VelocityLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..10.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_VelocityLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..MAX_NO_LINTAB_POINTS      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30 
// No. of points Number of points
;
 sv_PressureLintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=400.0,rY:=10.0))) (* lintab for pump1 pre *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_PressureLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressure      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Pressure  %ABSREL Relative 
// Pressure Pressure

%ELEMENT sv_PressureLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..10.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_PressureLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..MAX_NO_LINTAB_POINTS      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt30 
// No. of points Number of points
;
 sv_VelocityLintabPVCalib : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=10.0))) (* lintab for pump PV calib -> to directly output voltage *)
     %INPUT_LEVEL 16
;
 sv_PressureLintabPVCalib : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=10.0))) (* lintab for pump PV calib -> to directly output voltage *)
     %INPUT_LEVEL 16
;
 sv_rMinVoltageVelOutput : REAL (* minimum output voltage of AO pump velocity *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxVoltageVelOutput    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Voltage 
// Min. voltage AO velocity Min. voltage AO velocity
;
 sv_rMinVoltagePressOutput : REAL (* minimum output voltage of AO pump pressure *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxVoltagePressOutput    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Voltage 
// Min. voltage AO pressure Min. voltage AO pressure
;
 sv_rValueMinVoltageVelDetect : REAL := 1.0 (* x - value [%] for detection of minimum output voltage of AO pump velocity *)
 %PLAUSIBILITY 0.0..system.sv_rMaximumVelocity    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Percent ;
 sv_rValueMinVoltagePresDetect : REAL := 1.0 (* x - value [bar] for detection of minimum output voltage of AO pump pressure *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressure    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Pressure ;
 sv_rDitherFrequencyVel : REAL := 50.0 (* dither frequency for velocity output *)
 %PLAUSIBILITY 0.0..999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Frequency 
// Dither frequency Dither frequency
;
 sv_rDitherAmplitudeVel : REAL := 0.0 (* dither amplitude for velocity output *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxVoltageVelOutput    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Voltage 
// Dither amplitude Dither amplitude
;
 sv_rDitherFrequencyPres : REAL := 50.0 (* dither frequency for pressure output *)
 %PLAUSIBILITY 0.0..999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Frequency 
// Dither frequency Dither frequency
;
 sv_rDitherAmplitudePres : REAL := 0.0 (* dither amplitude for pressure output *)
 %PLAUSIBILITY 0.0..%FU.sv_rMaxVoltagePressOutput    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Voltage 
// Dither amplitude Dither amplitude
;
 sv_rAOVelocity : REAL (* analogue output velocity for simulation *)
    ;
 sv_rMaxPressure : REAL := 210.0
 %PLAUSIBILITY 0.0..999.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt40  %UNIT Pressure  %ABSREL NoRelative 
// Max. system pressure pump %f Max. system pressure pump %f
;
 sv_rActPressureHydr : REAL (* actual pressure in bar (measured by pressure sensor) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// System pressure pump %f System pressure pump %f
;
 sv_SysPressureLintab : KAPPL_LintabData_2P := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=250.0))) (* lintab for measurement of system pressure sensor *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// System pressure sensor System pressure sensor

%ELEMENT sv_SysPressureLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..10.0      %FORMAT fmt22  %UNIT Voltage 
// Voltage Voltage

%ELEMENT sv_SysPressureLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..999.0      %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Pressure Pressure

%ELEMENT sv_SysPressureLintab.LintabPoints.uNoOfPoints
 %PLAUSIBILITY 2..100      %FORMAT fmt30 
// System pressure sensor System pressure sensor
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
 sv_rMaxVoltagePressOutput : REAL := MAX_VOLTAGE
 %PLAUSIBILITY 0.0..MAX_VOLTAGE    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Max voltage pump %f pressure Max voltage pump % f pressure
;
 sv_rMaxVoltageVelOutput : REAL := MAX_VOLTAGE
 %PLAUSIBILITY 0.0..MAX_VOLTAGE    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Max voltage pump %f velocity Max voltage pump %f velocity
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
22 
@SysVar @RT(11)sv_rAbsFlow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(30)absolute flow of pump in l/min 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(8)PumpFlow @RT(10)NoRelative @RT(0) 
@RT(11)0.1..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Abs flow pump %f @RT(21)Absolute flow pump %f @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_rAbsFlow @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)absolute flow of pump in l/min 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt41 @RT(8)PumpFlow @RT(10)NoRelative @RT(0) 
@RT(11)0.1..9999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Abs flow pump %f @RT(21)Absolute flow pump %f @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)pressure output 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Relative @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActPump(1) @RT(0) 
@RT(8)Pressure @RT(15)Pressure output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)pressure output 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Relative @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActPump(1) @RT(0) 
@RT(8)Pressure @RT(15)Pressure output @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)velocity output 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(17)MaxSystemVelocity @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActPump(2) @RT(0) 
@RT(8)Velocity @RT(15)Velocity output @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)velocity output 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(17)MaxSystemVelocity @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActPump(2) @RT(0) 
@RT(8)Velocity @RT(15)Velocity output @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_VelocityLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=100.0,rY:=10.0))) @RT(19)lintab for pump vel 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(17)sv_VelocityLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)lintab for pump vel 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_VelocityLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(31)0.0..system.sv_rMaximumVelocity @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Velocity @RT(8)Velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_VelocityLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_VelocityLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(23)2..MAX_NO_LINTAB_POINTS @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_PressureLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=400.0,rY:=10.0))) @RT(20)lintab for pump1 pre 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(17)sv_PressureLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)lintab for pump1 pre 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PressureLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt31 @RT(8)Pressure @RT(8)Relative @RT(0) 
@RT(24)0.0..%FU.sv_rMaxPressure @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Pressure @RT(8)Pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PressureLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(9)0.0..10.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Voltage @RT(7)Voltage @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PressureLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(23)2..MAX_NO_LINTAB_POINTS @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)No. of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_VelocityLintabPVCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(77)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=10.0))) @RT(54)lintab for pump PV calib -> to directly output voltage 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_VelocityLintabPVCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(77)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=10.0))) @RT(54)lintab for pump PV calib -> to directly output voltage 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_PressureLintabPVCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(77)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=10.0))) @RT(54)lintab for pump PV calib -> to directly output voltage 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_PressureLintabPVCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(77)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=10.0))) @RT(54)lintab for pump PV calib -> to directly output voltage 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rMinVoltageVelOutput @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)minimum output voltage of AO pump velocity 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(32)0.0..%FU.sv_rMaxVoltageVelOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Min. voltage AO velocity @RT(24)Min. voltage AO velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rMinVoltageVelOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(32)0.0..%FU.sv_rMaxVoltageVelOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Min. voltage AO velocity @RT(24)Min. voltage AO velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rMinVoltagePressOutput @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)minimum output voltage of AO pump pressure 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(34)0.0..%FU.sv_rMaxVoltagePressOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Min. voltage AO pressure @RT(24)Min. voltage AO pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMinVoltagePressOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(34)0.0..%FU.sv_rMaxVoltagePressOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Min. voltage AO pressure @RT(24)Min. voltage AO pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_rValueMinVoltageVelDetect @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(73)x - value [%] for detection of minimum output voltage of AO pump velocity 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(7)Percent @RT(0) @RT(0) 
@RT(31)0.0..system.sv_rMaximumVelocity @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_rValueMinVoltageVelDetect @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(51)x - value [%] for detection of pump velocity offset 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(7)Percent @RT(0) @RT(0) 
@RT(31)0.0..system.sv_rMaximumVelocity @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_rValueMinVoltagePresDetect @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(75)x - value [bar] for detection of minimum output voltage of AO pump pressure 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(8)Pressure @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rMaxPressure @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_rValueMinVoltagePresDetect @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(51)x - value [%] for detection of pump velocity offset 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt22 @RT(8)Pressure @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rMaxPressure @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rDitherFrequencyVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(36)dither frequency for velocity output 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(9)Frequency @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither frequency @RT(16)Dither frequency @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rDitherFrequencyVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(9)Frequency @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither frequency @RT(16)Dither frequency @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rDitherAmplitudeVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(36)dither amplitude for velocity output 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(32)0.0..%FU.sv_rMaxVoltageVelOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither amplitude @RT(16)Dither amplitude @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rDitherAmplitudeVel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(32)0.0..%FU.sv_rMaxVoltageVelOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither amplitude @RT(16)Dither amplitude @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rDitherFrequencyPres @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)50.0 @RT(36)dither frequency for pressure output 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(9)Frequency @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither frequency @RT(16)Dither frequency @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rDitherFrequencyPres @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(9)Frequency @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither frequency @RT(16)Dither frequency @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rDitherAmplitudePres @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(36)dither amplitude for pressure output 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(34)0.0..%FU.sv_rMaxVoltagePressOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither amplitude @RT(16)Dither amplitude @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rDitherAmplitudePres @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(34)0.0..%FU.sv_rMaxVoltagePressOutput @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Dither amplitude @RT(16)Dither amplitude @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rAOVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)analogue output velocity for simulation 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(15)sv_rMaxPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)210.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt40 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max. system pressure pump %f @RT(28)Max. system pressure pump %f @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rMaxPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)300.0 @RT(0) 
@RT(1)1 @RT(1)1 @RT(14)VG_MachineData @RT(5)fmt40 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max. system pressure pump %f @RT(28)Max. system pressure pump %f @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rActPressureHydr @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)actual pressure in bar (measured by pressure sensor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)System pressure pump %f @RT(23)System pressure pump %f @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rActPressureHydr @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(49)actual press in bar (measured by pressure sensor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)System pressure pump %f @RT(23)System pressure pump %f @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_SysPressureLintab @RT(0) @T @T @DERIVED 0 @F @RT(19)KAPPL_LintabData_2P @F 
@T 
@BEG_Attrib 
4 @RT(78)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=10.0,rY:=250.0))) @RT(48)lintab for measurement of system pressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)System pressure sensor @RT(22)System pressure sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(20)sv_SysPressureLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)lintab for measuring with backpressure sensor 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)System pressure sensor @RT(22)System pressure sensor @RT(0) @RT(0) @RT(0) 
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
@RT(6)2..100 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)System pressure sensor @RT(22)System pressure sensor @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(25)sv_rMaxVoltagePressOutput @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(11)MAX_VOLTAGE @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max voltage pump %f pressure @RT(29)Max voltage pump % f pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMaxVoltagePressOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max voltage pump %f pressure @RT(29)Max voltage pump % f pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_rMaxVoltageVelOutput @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(11)MAX_VOLTAGE @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max voltage pump %f velocity @RT(28)Max voltage pump %f velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_rMaxVoltageVelOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max voltage pump %f velocity @RT(28)Max voltage pump %f velocity @RT(0) @RT(0) @RT(0) 
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
