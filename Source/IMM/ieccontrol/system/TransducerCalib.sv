%IMPORT_OVER_LISTFILE_SOURCE
 Time
, fmt20
, VG_MachineData
, Voltage
, fmt22
, fmt23

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 MAX_VOLTAGE
, cLevelStartupTechnican
, cLevelServiceEngineer
, tevAutoCalibLog

END_IMPORT

%SYSTEMVAR_DECL
  sv_dStandStillDetectTime : TIME := t#3s (* time for standstill detection *)
 %PLAUSIBILITY t#1s..t#10s    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt20  %UNIT Time 
// Stand still detection time Stand still detection time
;
 sv_rMaxVoltageDiff : REAL := 0.05 (* max. voltage difference to detect stand still *)
 %PLAUSIBILITY 0.01..10.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt22  %UNIT Voltage 
// Max. voltage difference Max. voltage difference
;
 sv_rMaxVoltagePressure : REAL := MAX_VOLTAGE
 %PLAUSIBILITY 0.0..MAX_VOLTAGE    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Max. voltage pressure Max. voltage pressure
;
 sv_rMaxVoltageVelocity : REAL := MAX_VOLTAGE
 %PLAUSIBILITY 0.0..MAX_VOLTAGE    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Max. voltage velocity Max. voltage velocity
;
 sv_dDelayTimeNextShot : TIME := T#0s
 %PLAUSIBILITY T#0s..T#60s    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt23  %UNIT Time 
// Delay between pump pressure calib steps Delay between pump pressure calib steps
;
 sv_rMaxVoltageVelocityPresCalib : REAL := MAX_VOLTAGE
 %PLAUSIBILITY 0.0..MAX_VOLTAGE    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt22  %UNIT Voltage 
// Max. velocity output during pressure calibration Max. velocity output during pressure calibration
;
%END

%SYSTEMEVENT_DECL
  evAutoCalibLog : tevAutoCalibLog
;
%END

%SYSTEM_ALARM
  erCalibCoresActive
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Failure at calibration, cores active.{#]Calibration is prevented by one or more \u000acores being active.{#]An available core can be set to be used, meaning its active. Calibration is only \u000aallowed if no cores are active.{#]Change the core activated setting(s) before retrying the desired \u000aoperation.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 30 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
6 
@SysVar @RT(24)sv_dStandStillDetectTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#3s @RT(29)time for standstill detection 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt20 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#1s..t#10s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Stand still detection time @RT(26)Stand still detection time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_dStandStillDetectTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#3s @RT(29)time for standstill detection 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt20 @RT(4)Time @RT(0) @RT(0) 
@RT(11)t#1s..t#10s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Stand still detection time @RT(26)Stand still detection time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxVoltageDiff @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)0.05 @RT(45)max. voltage difference to detect stand still 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(10)0.01..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max. voltage difference @RT(23)Max. voltage difference @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxVoltageDiff @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(45)max. voltage difference to detect stand still 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(10)0.01..10.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max. voltage difference @RT(23)Max. voltage difference @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxVoltagePressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(11)MAX_VOLTAGE @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. voltage pressure @RT(21)Max. voltage pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxVoltagePressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. voltage pressure @RT(21)Max. voltage pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_rMaxVoltageVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(11)MAX_VOLTAGE @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. voltage velocity @RT(21)Max. voltage velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_rMaxVoltageVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Max. voltage velocity @RT(21)Max. voltage velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_dDelayTimeNextShot @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(39)Delay between pump pressure calib steps @RT(39)Delay between pump pressure calib steps @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_dDelayTimeNextShot @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#60s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(39)Delay between pump pressure calib steps @RT(39)Delay between pump pressure calib steps @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_rMaxVoltageVelocityPresCalib @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(11)MAX_VOLTAGE @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(48)Max. velocity output during pressure calibration @RT(48)Max. velocity output during pressure calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_rMaxVoltageVelocityPresCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(16)0.0..MAX_VOLTAGE @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(48)Max. velocity output during pressure calibration @RT(48)Max. velocity output during pressure calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
1 
@SysEvent @RT(14)evAutoCalibLog @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tevAutoCalibLog @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erCalibCoresActive @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(310)Failure at calibration, cores active.{#]Calibration is prevented by one or more \u000acores being active.{#]An available core can be set to be used, meaning its active. Calibration is only \u000aallowed if no cores are active.{#]Change the core activated setting(s) before retrying the desired \u000aoperation. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
