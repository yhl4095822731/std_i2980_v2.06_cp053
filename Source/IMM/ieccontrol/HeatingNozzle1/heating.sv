%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, fmt20
, fmt30
, Temperature
, fmt31
, HeatingModeVis
, HeatingDisplay
, Percent
, VG_MoldData
, Time
, TempSensorType
, Relative
, fmtOptimizeHeating
, OnOff
, UseNoUse
, fmt32
, HeatThroughTime
, fmt42
, fmt81
, TimeMinutesAbs
, fmt61
, PowerWatt
, YesNo

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsZoneData
, tsZoneDataRetain
, tyZoneArray
, tyAutoHeating
, tyPowerHeatingZones
, KAPPL_TempZoneUsedArr
, KAPPL_TempOpMode_Heating
, KHW_TempSensor_NiCrNi
, enZoneModePID2pt
, cLockGroupHeatingNozzle
, cLevelStartupTechnican
, cLevelProduction
, cLevelProcessOperator
, cLevelServiceEngineer
, cLevelMoldPrepare
, FBPlausSensorType
, FPlausPulseTime
, cMaxNoHeatingPower
, cMaxZones

END_IMPORT

%SYSTEMVAR_DECL
  sv_iMaxNumberOfZones : DINT := 12
 %PLAUSIBILITY 1..cMaxZones    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Max. number of heating zones Max. number of heating zones
;
 sv_iNumberOfZones : DINT := 99
 %PLAUSIBILITY 1..%FU.sv_iZonesAvailable    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt20 
// Number of heating zones Number of heating zones
;
 sv_iZonesAvailable : DINT
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Zones available Number of heating zones available
;
 sv_rTolBetweenZones : REAL := 5.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt30 
// Tolerance between zones Temperature tolerance between zones
;
 sv_TempDiff : REAL := 2.0 (* expected minimum temp.change at 100% heating output per minute; otherwise alarm *)
 %PLAUSIBILITY 0.0..999.9    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Temperature 
// Observation temp. diff. Observation temp. diff.
;
 sv_Zone1 : tsZoneData
    
%ELEMENT sv_Zone1.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone1.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone1.bIsOptimizing
    
// Optimizing 1 Optimizing 1

%ELEMENT sv_Zone1.rOutputValue
     %UNIT Percent 
// Output 1 Output value 1

%ELEMENT sv_Zone1.rSetVal
     %UNIT Temperature 
// Set temp 1 Set temperature 1

%ELEMENT sv_Zone1.rWAct
    
// rWAct 1 rWAct 1
;
 sv_Zone2 : tsZoneData
    
%ELEMENT sv_Zone2.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone2.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone2.bIsOptimizing
    
// Optimizing 2 Optimizing 2

%ELEMENT sv_Zone2.rOutputValue
     %UNIT Percent 
// Output 2 Output value 2

%ELEMENT sv_Zone2.rSetVal
     %UNIT Temperature 
// Set temp 2 Set temperature 2

%ELEMENT sv_Zone2.rWAct
    
// rWAct 2 rWAct 2
;
 sv_Zone3 : tsZoneData
    
%ELEMENT sv_Zone3.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone3.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone3.bIsOptimizing
    
// Optimizing 3 Optimizing 3

%ELEMENT sv_Zone3.rOutputValue
     %UNIT Percent 
// Output 3 Output value 3

%ELEMENT sv_Zone3.rSetVal
     %UNIT Temperature 
// Set temp 3 Set temperature 3

%ELEMENT sv_Zone3.rWAct
    
// rWAct 3 rWAct 3
;
 sv_Zone4 : tsZoneData
    
%ELEMENT sv_Zone4.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone4.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone4.bIsOptimizing
    
// Optimizing 4 Optimizing 4

%ELEMENT sv_Zone4.rOutputValue
     %UNIT Percent 
// Output 4 Output value 4

%ELEMENT sv_Zone4.rSetVal
     %UNIT Temperature 
// Set temp 4 Set temperature 4

%ELEMENT sv_Zone4.rWAct
    
// rWAct 4 rWAct 4
;
 sv_Zone5 : tsZoneData
    
%ELEMENT sv_Zone5.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone5.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone5.bIsOptimizing
    
// Optimizing 5 Optimizing 5

%ELEMENT sv_Zone5.rOutputValue
     %UNIT Percent 
// Output 5 Output value 5

%ELEMENT sv_Zone5.rSetVal
     %UNIT Temperature 
// Set temp 5 Set temperature 5

%ELEMENT sv_Zone5.rWAct
    
// rWAct 5 rWAct 5
;
 sv_Zone6 : tsZoneData
    
%ELEMENT sv_Zone6.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone6.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone6.bIsOptimizing
    
// Optimizing 6 Optimizing 6

%ELEMENT sv_Zone6.rOutputValue
     %UNIT Percent 
// Output 6 Output value 6

%ELEMENT sv_Zone6.rSetVal
     %UNIT Temperature 
// Set temp 6 Set temperature 6

%ELEMENT sv_Zone6.rWAct
    
// rWAct 6 rWAct 6
;
 sv_Zone7 : tsZoneData
    
%ELEMENT sv_Zone7.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone7.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone7.bIsOptimizing
    
// Optimizing 7 Optimizing 7

%ELEMENT sv_Zone7.rOutputValue
     %UNIT Percent 
// Output 7 Output value 7

%ELEMENT sv_Zone7.rSetVal
     %UNIT Temperature 
// Set temp 7 Set temperature 7

%ELEMENT sv_Zone7.rWAct
    
// rWAct 7 rWAct 7
;
 sv_Zone8 : tsZoneData
    
%ELEMENT sv_Zone8.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone8.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone8.bIsOptimizing
    
// Optimizing 8 Optimizing 8

%ELEMENT sv_Zone8.rOutputValue
     %UNIT Percent 
// Output 8 Output value 8

%ELEMENT sv_Zone8.rSetVal
     %UNIT Temperature 
// Set temp 8 Set temperature 8

%ELEMENT sv_Zone8.rWAct
    
// rWAct 8 rWAct 8
;
 sv_Zone9 : tsZoneData
    
%ELEMENT sv_Zone9.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone9.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone9.bIsOptimizing
    
// Optimizing 9 Optimizing 9

%ELEMENT sv_Zone9.rOutputValue
     %UNIT Percent 
// Output 9 Output value 9

%ELEMENT sv_Zone9.rSetVal
     %UNIT Temperature 
// Set temp 9 Set temperature 9

%ELEMENT sv_Zone9.rWAct
    
// rWAct 9 rWAct 9
;
 sv_Zone10 : tsZoneData
    
%ELEMENT sv_Zone10.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone10.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone10.bIsOptimizing
    
// Optimizing 10 Optimizing 10

%ELEMENT sv_Zone10.rOutputValue
     %UNIT Percent 
// Output 10 Output value 10

%ELEMENT sv_Zone10.rSetVal
     %UNIT Temperature 
// Set temp 10 Set temperature 10

%ELEMENT sv_Zone10.rWAct
    
// rWAct 10 rWAct 10
;
 sv_Zone11 : tsZoneData
    
%ELEMENT sv_Zone11.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone11.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone11.bIsOptimizing
    
// Optimizing 11 Optimizing 11

%ELEMENT sv_Zone11.rOutputValue
     %UNIT Percent 
// Output 11 Output value 11

%ELEMENT sv_Zone11.rSetVal
     %UNIT Temperature 
// Set temp 11 Set temperature 11

%ELEMENT sv_Zone11.rWAct
    
// rWAct 11 rWAct 11
;
 sv_Zone12 : tsZoneData
    
%ELEMENT sv_Zone12.ActModeDisp
     %FORMAT HeatingModeVis 
%ELEMENT sv_Zone12.ActStateDisp
     %FORMAT HeatingDisplay 
%ELEMENT sv_Zone12.bIsOptimizing
    
// Optimizing 12 Optimizing 12

%ELEMENT sv_Zone12.rOutputValue
     %UNIT Percent 
// Output 12 Output value 12

%ELEMENT sv_Zone12.rSetVal
     %UNIT Temperature 
// Set temp 12 Set temperature 12

%ELEMENT sv_Zone12.rWAct
    
// rWAct 12 rWAct 12
;
 sv_ZoneRetain1 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=10.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain1.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain1.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain1.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain1.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain1.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain1.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain1.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain1.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain1.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain1.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 1 Constant value 1

%ELEMENT sv_ZoneRetain1.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 1 Lower tolerance 1

%ELEMENT sv_ZoneRetain1.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 1 Set temperature vis 1

%ELEMENT sv_ZoneRetain1.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 1 Standby temperature 1

%ELEMENT sv_ZoneRetain1.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 1 Upper tolerance 1
;
 sv_ZoneRetain2 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain2.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain2.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain2.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain2.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain2.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain2.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain2.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain2.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain2.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain2.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 2 Constant value 2

%ELEMENT sv_ZoneRetain2.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 2 Lower tolerance 2

%ELEMENT sv_ZoneRetain2.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 2 Set temperature vis 2

%ELEMENT sv_ZoneRetain2.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 2 Standby temperature 2

%ELEMENT sv_ZoneRetain2.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 2 Upper tolerance 2
;
 sv_ZoneRetain3 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain3.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain3.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain3.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain3.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain3.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain3.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain3.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain3.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain3.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain3.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 3 Constant value 3

%ELEMENT sv_ZoneRetain3.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 3 Lower tolerance 3

%ELEMENT sv_ZoneRetain3.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 3 Set temperature vis 3

%ELEMENT sv_ZoneRetain3.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 3 Standby temperature 3

%ELEMENT sv_ZoneRetain3.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 3 Upper tolerance 3
;
 sv_ZoneRetain4 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain4.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain4.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain4.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain4.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain4.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain4.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain4.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain4.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain4.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain4.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 4 Constant value 4

%ELEMENT sv_ZoneRetain4.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 4 Lower tolerance 4

%ELEMENT sv_ZoneRetain4.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 4 Set temperature vis 4

%ELEMENT sv_ZoneRetain4.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 4 Standby temperature 4

%ELEMENT sv_ZoneRetain4.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 4 Upper tolerance 4
;
 sv_ZoneRetain5 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain5.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain5.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain5.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain5.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain5.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain5.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain5.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain5.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain5.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain5.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 5 Constant value 5

%ELEMENT sv_ZoneRetain5.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 5 Lower tolerance 5

%ELEMENT sv_ZoneRetain5.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 5 Set temperature vis 5

%ELEMENT sv_ZoneRetain5.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 5 Standby temperature 5

%ELEMENT sv_ZoneRetain5.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 5 Upper tolerance 5
;
 sv_ZoneRetain6 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain6.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain6.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain6.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain6.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain6.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain6.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain6.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain6.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain6.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain6.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 6 Constant value 6

%ELEMENT sv_ZoneRetain6.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 6 Lower tolerance 6

%ELEMENT sv_ZoneRetain6.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 6 Set temperature vis 6

%ELEMENT sv_ZoneRetain6.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 6 Standby temperature 6

%ELEMENT sv_ZoneRetain6.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 6 Upper tolerance 6
;
 sv_ZoneRetain7 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain7.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain7.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain7.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain7.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain7.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain7.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain7.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain7.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain7.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain7.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 7 Constant value 7

%ELEMENT sv_ZoneRetain7.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 7 Lower tolerance 7

%ELEMENT sv_ZoneRetain7.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 7 Set temperature vis 7

%ELEMENT sv_ZoneRetain7.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 7 Standby temperature 7

%ELEMENT sv_ZoneRetain7.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 7 Upper tolerance 7
;
 sv_ZoneRetain8 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain8.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain8.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain8.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain8.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain8.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain8.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain8.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain8.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain8.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain8.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 8 Constant value 8

%ELEMENT sv_ZoneRetain8.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 8 Lower tolerance 8

%ELEMENT sv_ZoneRetain8.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 8 Set temperature vis 8

%ELEMENT sv_ZoneRetain8.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 8 Standby temperature 8

%ELEMENT sv_ZoneRetain8.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 8 Upper tolerance 8
;
 sv_ZoneRetain9 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain9.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain9.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain9.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain9.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain9.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain9.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain9.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain9.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain9.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain9.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 9 Constant value 9

%ELEMENT sv_ZoneRetain9.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 9 Lower tolerance 9

%ELEMENT sv_ZoneRetain9.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 9 Set temperature vis 9

%ELEMENT sv_ZoneRetain9.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 9 Standby temperature 9

%ELEMENT sv_ZoneRetain9.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 9 Upper tolerance 9
;
 sv_ZoneRetain10 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain10.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain10.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain10.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain10.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain10.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain10.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain10.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain10.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain10.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain10.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 10 Constant value 10

%ELEMENT sv_ZoneRetain10.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 10 Lower tolerance 10

%ELEMENT sv_ZoneRetain10.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 10 Set temperature vis 10

%ELEMENT sv_ZoneRetain10.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 10 Standby temperature 10

%ELEMENT sv_ZoneRetain10.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 10 Upper tolerance 10
;
 sv_ZoneRetain11 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain11.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain11.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain11.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain11.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain11.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain11.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain11.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain11.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain11.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain11.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 11 Constant value 11

%ELEMENT sv_ZoneRetain11.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 11 Lower tolerance 11

%ELEMENT sv_ZoneRetain11.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 11 Set temperature vis 11

%ELEMENT sv_ZoneRetain11.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 11 Standby temperature 11

%ELEMENT sv_ZoneRetain11.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 11 Upper tolerance 11
;
 sv_ZoneRetain12 : tsZoneDataRetain := (Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE)
   RETAIN 
%ELEMENT sv_ZoneRetain12.ModeVis
     %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT HeatingModeVis 
// Mode Mode

%ELEMENT sv_ZoneRetain12.Param
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain12.Param.bPidOPAvailable
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain12.Param.pidParam.dTN
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain12.Param.pidParam.dTV
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain12.Param.pidParamOP
     %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_ZoneRetain12.Param.sysParam.dT
     %FORMAT fmt31  %UNIT Time 
%ELEMENT sv_ZoneRetain12.SensorTypeVis
 %PLAUSIBILITY FBPlausSensorType      %VARIABLE_GROUP VG_MachineData,VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT TempSensorType 
// Sensor type Sensor type

%ELEMENT sv_ZoneRetain12.StabParam
     %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ZoneRetain12.rConstValVis
 %PLAUSIBILITY 0.0..100.0      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent 
// Const val 12 Constant value 12

%ELEMENT sv_ZoneRetain12.rLowerTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Lower tol 12 Lower tolerance 12

%ELEMENT sv_ZoneRetain12.rSetValVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature 
// Set temp vis 12 Set temperature vis 12

%ELEMENT sv_ZoneRetain12.rStandbyTempVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt30  %UNIT Temperature 
// Standby temp 12 Standby temperature 12

%ELEMENT sv_ZoneRetain12.rUpperTolVis
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature      %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Temperature  %ABSREL Relative 
// Upper tol 12 Upper tolerance 12
;
 sv_rMaxTemperature : REAL := 400.0
 %PLAUSIBILITY 0.0..600.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Temperature 
// Max. temperature Maximum temperature
;
 sv_bOptimizationActive : BOOL (* Optimization is running *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Optimize running Optimisation is active
;
 sv_bGroupReady : BOOL (* Optimization is running *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Group ready Heating group ready
;
 sv_ZoneArray : tyZoneArray
    ;
 sv_bRunOptimization : BOOL (* Run Optimization *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmtOptimizeHeating 
// Optimize nozzle heating Optimize nozzle heating
;
 sv_bUsePidOP : BOOL (* Run closed loop control with operating point parameters *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff 
// Use op. point pid param. Control with oerating point pid parameters
;
 sv_bHeatingOn : BOOL
     %INPUT_LEVEL 16
 %FORMAT HeatingDisplay 
// Heating on Heating on
;
 sv_bKeepWarmActive : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT UseNoUse 
// Keep warm Keep warm
;
 sv_bGroupHeating : BOOL
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT OnOff 
// Group heating Group heating
;
 sv_PWMCycleTime : TIME := t#20s
 %PLAUSIBILITY t#100ms..t#20s    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT Time 
// Cycle time Cycle time
;
 sv_PWMMinPulseTime : TIME := t#1s (* max. 5% of sv_PWMCycleTime *)
 %PLAUSIBILITY FPlausPulseTime    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt32  %UNIT Time 
// Minimal pulse time Minimal pulse time
;
 sv_bReParamGroup : BOOL (* By this var each zone can reparam the groupblock *)
     %INPUT_LEVEL 16

// Reparam group Reparametrize group
;
 sv_AutoHeatingSettings : tyAutoHeating
   RETAIN 
%ELEMENT sv_AutoHeatingSettings[0].bActivate
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT UseNoUse 
// Activate Activate auto heating

%ELEMENT sv_AutoHeatingSettings[0].dTimeToActivate
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction

// Time to activate Time to activate auto heating
;
 sv_LockGroup : DINT := cLockGroupHeatingNozzle
    ;
 sv_dTempOkTimeSet : TIME := t#10s
 %PLAUSIBILITY t#0.0m..t#999m    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT Time 
// Cool prevent time Cool prevent time
;
 sv_dTempOkTimeAct : TIME
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt31  %UNIT Time 
// Act. cool prevent time Act. cool prevent time
;
 sv_rTempOkTimeAct : REAL
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt31  %UNIT HeatThroughTime 
// Act. cool prevent time Act. cool prevent time
;
 sv_rTempOkTimeSet : REAL := 1.0
 %PLAUSIBILITY 0.0..999.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt31  %UNIT HeatThroughTime 
// Cool prevent time Cool prevent time
;
 sv_rTemperatureRamp : REAL
 %PLAUSIBILITY 0.0..100.0      %FORMAT fmt32  %UNIT Temperature 
// Temp. ramp Temperature ramp
;
 sv_rEvaporationTemp : REAL := 90.0
 %PLAUSIBILITY 80.0..120.0    RETAIN  %FORMAT fmt32  %UNIT Temperature 
// Evaporation temp Evaporation temperature
;
 sv_dEvaporationTime : TIME := T#0s
 %PLAUSIBILITY T#0s..T#300s    RETAIN  %FORMAT fmt32  %UNIT Time 
// Evaporation time Evaporation time
;
 sv_rStandbyTempVis : REAL := 100.0
 %PLAUSIBILITY 0.0..%FU.sv_rMaxTemperature    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT fmt30  %UNIT Temperature 
// Standby temperature Standby temperature
;
 sv_rIncTemperature : REAL := 0.0
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Temperature 
// Increase temperature Increase temperature difference
;
 sv_bUndoChangeHeatingParams : BOOL := FALSE
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Undo change pid param Undo change pid param
;
 sv_dEvaporationTimeBlock : TIME := T#0s
 %PLAUSIBILITY T#0s..T#300s    RETAIN  %FORMAT fmt32  %UNIT Time 
// Evaporation time block Evaporation time block
;
 sv_dSoftstartAlarmTime : TIME := T#0s
 %PLAUSIBILITY T#0s..T#3600s    RETAIN  %FORMAT fmt42  %UNIT Time 
// Softstart alarm time Softstart alarm time
;
 sv_iZonesAboveMaxTemp : DINT (* number of heating zones which exceeded the maximum temperature *)
    ;
 sv_ActPowerHeatUp : tyPowerHeatingZones
   RETAIN  %DISPLAY_LEVEL 1 
// Act. power heat up Act. power heat up
;
 sv_iActPowerHeatUpIndex : UDINT
 %PLAUSIBILITY 0..cMaxNoHeatingPower    RETAIN  %DISPLAY_LEVEL 1 
// Power index nozzle Power index nozzle
;
 sv_dHeatUpDuration : TIME
   RETAIN  %DISPLAY_LEVEL 1  %FORMAT fmt81  %UNIT Time 
// Heat up duration nozzle Heat up duration nozzle
;
 sv_dMaxStandByTime : TIME := T#24h
 %PLAUSIBILITY T#0s..T#24h    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt61  %UNIT TimeMinutesAbs 
// Max. preheat time Max. preheat time nozzle
;
 sv_rActHeatingPower : REAL
     %DISPLAY_LEVEL 1  %FORMAT fmt81  %UNIT PowerWatt 
// Heating power nozzle Heating power nozzle
;
 sv_iAutoHeatingChangeCounter : UDINT
    
// Auto heating change counter Auto heating change counter
;
 sv_dObservationTimeHeating : TIME := T#3m
 %PLAUSIBILITY T#0s..T#24h    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt61  %UNIT Time 
// Observation time heating Observation time heating
;
 sv_rMaxTempHeatUpOpt : REAL := 80.0
 %PLAUSIBILITY 20.0..%FU.sv_rMaxTemperature    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Temperature 
// Max. temperature optimization Max. temperature heat up optimization
;
 sv_bUseOutputLimitation : BOOL
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT YesNo 
// Use output limitation Use output limitation
;
 sv_UseOutputLimitation : KAPPL_TempZoneUsedArr := FALSE,11(TRUE) (* activate output limitation *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

// Use output limitation at zone Use output limitation at zone
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 120 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
66 
@SysVar @RT(20)sv_iMaxNumberOfZones @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(2)12 @RT(0) 
@RT(1)1 @RT(2)16 @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)1..cMaxZones @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max. number of heating zones @RT(28)Max. number of heating zones @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_iMaxNumberOfZones @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)1..cMaxZones @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Max. number of heating zones @RT(28)Max. number of heating zones @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_iNumberOfZones @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(2)99 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(25)1..%FU.sv_iZonesAvailable @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Number of heating zones @RT(23)Number of heating zones @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_iNumberOfZones @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(25)1..%FU.sv_iZonesAvailable @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Number of heating zones @RT(23)Number of heating zones @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iZonesAvailable @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Zones available @RT(33)Number of heating zones available @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iZonesAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Zones available @RT(33)Number of heating zones available @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rTolBetweenZones @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)5.0 @RT(0) 
@RT(1)1 @RT(1)1 @RT(14)VG_MachineData @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Tolerance between zones @RT(35)Temperature tolerance between zones @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rTolBetweenZones @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(14)VG_MachineData @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Tolerance between zones @RT(35)Temperature tolerance between zones @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_TempDiff @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)2.0 @RT(79)expected minimum temp.change at 100% heating output per minute; otherwise alarm 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(11)Temperature @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Observation temp. diff. @RT(23)Observation temp. diff. @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_TempDiff @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(79)expected minimum temp.change at 100% heating output per minute; otherwise alarm 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(11)Temperature @RT(0) @RT(0) 
@RT(10)0.0..999.9 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Observation temp. diff. @RT(23)Observation temp. diff. @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone1.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone1.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone1.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 1 @RT(12)Optimizing 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone1.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 1 @RT(14)Output value 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone1.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 1 @RT(17)Set temperature 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone1.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 1 @RT(7)rWAct 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone2.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone2.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone2.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 2 @RT(12)Optimizing 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone2.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 2 @RT(14)Output value 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone2.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 2 @RT(17)Set temperature 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone2.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 2 @RT(7)rWAct 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone3 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone3.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone3.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone3.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 3 @RT(12)Optimizing 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone3.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 3 @RT(14)Output value 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone3.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 3 @RT(17)Set temperature 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone3.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 3 @RT(7)rWAct 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone4 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone4.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone4.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone4.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 4 @RT(12)Optimizing 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone4.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 4 @RT(14)Output value 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone4.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 4 @RT(17)Set temperature 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone4.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 4 @RT(7)rWAct 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone5 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone5.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone5.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone5.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 5 @RT(12)Optimizing 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone5.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 5 @RT(14)Output value 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone5.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 5 @RT(17)Set temperature 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone5.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 5 @RT(7)rWAct 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone6 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone6.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone6.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone6.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 6 @RT(12)Optimizing 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone6.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 6 @RT(14)Output value 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone6.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 6 @RT(17)Set temperature 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone6.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 6 @RT(7)rWAct 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone7 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone7.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone7.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone7.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 7 @RT(12)Optimizing 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone7.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 7 @RT(14)Output value 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone7.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 7 @RT(17)Set temperature 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone7.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 7 @RT(7)rWAct 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone8 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone8.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone8.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone8.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 8 @RT(12)Optimizing 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone8.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 8 @RT(14)Output value 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone8.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 8 @RT(17)Set temperature 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone8.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 8 @RT(7)rWAct 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_Zone9 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(20)sv_Zone9.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone9.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone9.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Optimizing 9 @RT(12)Optimizing 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_Zone9.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Output 9 @RT(14)Output value 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(16)sv_Zone9.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Set temp 9 @RT(17)Set temperature 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(14)sv_Zone9.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)rWAct 9 @RT(7)rWAct 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_Zone10 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(21)sv_Zone10.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone10.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_Zone10.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Optimizing 10 @RT(13)Optimizing 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone10.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Output 10 @RT(15)Output value 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(17)sv_Zone10.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Set temp 10 @RT(18)Set temperature 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(15)sv_Zone10.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)rWAct 10 @RT(8)rWAct 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_Zone11 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(21)sv_Zone11.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone11.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_Zone11.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Optimizing 11 @RT(13)Optimizing 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone11.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Output 11 @RT(15)Output value 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(17)sv_Zone11.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Set temp 11 @RT(18)Set temperature 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(15)sv_Zone11.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)rWAct 11 @RT(8)rWAct 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_Zone12 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(21)sv_Zone12.ActModeDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone12.ActStateDisp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_Zone12.bIsOptimizing @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Optimizing 12 @RT(13)Optimizing 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_Zone12.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(7)Percent @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Output 12 @RT(15)Output value 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(17)sv_Zone12.rSetVal @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Set temp 12 @RT(18)Set temperature 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(15)sv_Zone12.rWAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)rWAct 12 @RT(8)rWAct 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(419)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=10.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain1.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain1.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain1.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain1.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain1.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain1.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain1.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain1.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain1.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain1.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 1 @RT(16)Constant value 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain1.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 1 @RT(17)Lower tolerance 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain1.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 1 @RT(21)Set temperature vis 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain1.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 1 @RT(21)Standby temperature 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain1.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 1 @RT(17)Upper tolerance 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain2.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain2.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain2.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain2.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain2.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain2.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain2.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain2.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain2.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain2.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 2 @RT(16)Constant value 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain2.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 2 @RT(17)Lower tolerance 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain2.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 2 @RT(21)Set temperature vis 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain2.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 2 @RT(21)Standby temperature 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain2.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 2 @RT(17)Upper tolerance 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain3 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain3.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain3.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain3.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain3.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain3.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain3.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain3.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain3.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain3.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain3.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 3 @RT(16)Constant value 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain3.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 3 @RT(17)Lower tolerance 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain3.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 3 @RT(21)Set temperature vis 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain3.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 3 @RT(21)Standby temperature 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain3.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 3 @RT(17)Upper tolerance 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain4 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain4.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain4.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain4.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain4.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain4.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain4.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain4.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain4.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain4.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain4.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 4 @RT(16)Constant value 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain4.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 4 @RT(17)Lower tolerance 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain4.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 4 @RT(21)Set temperature vis 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain4.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 4 @RT(21)Standby temperature 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain4.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 4 @RT(17)Upper tolerance 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain5 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain5.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain5.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain5.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain5.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain5.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain5.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain5.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain5.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain5.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain5.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 5 @RT(16)Constant value 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain5.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 5 @RT(17)Lower tolerance 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain5.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 5 @RT(21)Set temperature vis 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain5.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 5 @RT(21)Standby temperature 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain5.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 5 @RT(17)Upper tolerance 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain6 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain6.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain6.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain6.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain6.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain6.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain6.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain6.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain6.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain6.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain6.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 6 @RT(16)Constant value 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain6.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 6 @RT(17)Lower tolerance 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain6.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 6 @RT(21)Set temperature vis 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain6.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 6 @RT(21)Standby temperature 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain6.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 6 @RT(17)Upper tolerance 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain7 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain7.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain7.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain7.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain7.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain7.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain7.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain7.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain7.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain7.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain7.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 7 @RT(16)Constant value 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain7.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 7 @RT(17)Lower tolerance 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain7.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 7 @RT(21)Set temperature vis 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain7.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 7 @RT(21)Standby temperature 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain7.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 7 @RT(17)Upper tolerance 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain8 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain8.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain8.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain8.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain8.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain8.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain8.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain8.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain8.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain8.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain8.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 8 @RT(16)Constant value 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain8.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 8 @RT(17)Lower tolerance 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain8.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 8 @RT(21)Set temperature vis 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain8.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 8 @RT(21)Standby temperature 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain8.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 8 @RT(17)Upper tolerance 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_ZoneRetain9 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(14)sv_ZoneRetain9 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_ZoneRetain9.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_ZoneRetain9.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_ZoneRetain9.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain9.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain9.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain9.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain9.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain9.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ZoneRetain9.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain9.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Const val 9 @RT(16)Constant value 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain9.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Lower tol 9 @RT(17)Lower tolerance 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain9.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Set temp vis 9 @RT(21)Set temperature vis 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ZoneRetain9.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Standby temp 9 @RT(21)Standby temperature 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_ZoneRetain9.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Upper tol 9 @RT(17)Upper tolerance 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ZoneRetain10 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(15)sv_ZoneRetain10 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_ZoneRetain10.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_ZoneRetain10.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_ZoneRetain10.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ZoneRetain10.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ZoneRetain10.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain10.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain10.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_ZoneRetain10.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain10.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain10.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Const val 10 @RT(17)Constant value 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain10.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Lower tol 10 @RT(18)Lower tolerance 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_ZoneRetain10.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Set temp vis 10 @RT(22)Set temperature vis 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain10.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Standby temp 10 @RT(22)Standby temperature 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain10.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Upper tol 10 @RT(18)Upper tolerance 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ZoneRetain11 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(15)sv_ZoneRetain11 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_ZoneRetain11.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_ZoneRetain11.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_ZoneRetain11.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ZoneRetain11.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ZoneRetain11.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain11.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain11.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_ZoneRetain11.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain11.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain11.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Const val 11 @RT(17)Constant value 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain11.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Lower tol 11 @RT(18)Lower tolerance 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_ZoneRetain11.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Set temp vis 11 @RT(22)Set temperature vis 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain11.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Standby temp 11 @RT(22)Standby temperature 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain11.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Upper tol 11 @RT(18)Upper tolerance 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ZoneRetain12 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(421)(Param:=(sysParam:=(rK:=1.0,dT:=t#1s,rN:=3.0,rFehler:=1000.0),pidParam:=(rKR:=3.0,rKK:=30.0,dTN:=t#400s,dTV:=t#100s,rCB:=30.0),opMode:=KAPPL_TempOpMode_Heating,rMinY:=0.0,rMaxY:=100.0,rDeadBand:=0.0),StabParam:=(dObservationTime:=T#2m,rRange:=1.0),SensorTypeVis:=KHW_TempSensor_NiCrNi,ModeVis:=enZoneModePID2pt,rSetValVis:=250.0,rConstValVis:=50.0,rUpperTolVis:=10.0,rLowerTolVis:=10.0,rStandbyTempVis:=100.0,bUsed:=TRUE) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
15 
@AttrSym @RT(15)sv_ZoneRetain12 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_ZoneRetain12.ModeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(14)HeatingModeVis @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Mode @RT(4)Mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_ZoneRetain12.Param @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_ZoneRetain12.Param.bPidOPAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ZoneRetain12.Param.pidParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ZoneRetain12.Param.pidParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_ZoneRetain12.Param.pidParamOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ZoneRetain12.Param.sysParam.dT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_ZoneRetain12.SensorTypeVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(26)VG_MachineData,VG_MoldData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(17)FBPlausSensorType @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_ZoneRetain12.StabParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain12.rConstValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Const val 12 @RT(17)Constant value 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain12.rLowerTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Lower tol 12 @RT(18)Lower tolerance 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_ZoneRetain12.rSetValVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Set temp vis 12 @RT(22)Set temperature vis 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ZoneRetain12.rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Standby temp 12 @RT(22)Standby temperature 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_ZoneRetain12.rUpperTolVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt30 @RT(11)Temperature @RT(8)Relative @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Upper tol 12 @RT(18)Upper tolerance 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rMaxTemperature @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)400.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(10)0.0..600.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. temperature @RT(19)Maximum temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rMaxTemperature @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(10)0.0..600.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max. temperature @RT(19)Maximum temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bOptimizationActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)Optimization is running 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Optimize running @RT(22)Optimisation is active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bOptimizationActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)Optimization is running 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Optimize running @RT(22)Optimisation is active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bGroupReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)Optimization is running 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Group ready @RT(19)Heating group ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bGroupReady @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)Optimization is running 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Group ready @RT(19)Heating group ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_ZoneArray @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyZoneArray @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(19)sv_bRunOptimization @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Run Optimization 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(18)fmtOptimizeHeating @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Optimize nozzle heating @RT(23)Optimize nozzle heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bRunOptimization @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Run Optimization 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(18)fmtOptimizeHeating @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Optimize nozzle heating @RT(23)Optimize nozzle heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_bUsePidOP @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)Run closed loop control with operating point parameters 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Use op. point pid param. @RT(42)Control with oerating point pid parameters @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_bUsePidOP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)Run closed loop control with operating point parameters 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Use op. point pid param. @RT(42)Control with oerating point pid parameters @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_bHeatingOn @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Heating on @RT(10)Heating on @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bHeatingOn @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(14)HeatingDisplay @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Heating on @RT(10)Heating on @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bKeepWarmActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Keep warm @RT(9)Keep warm @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bKeepWarmActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Keep warm @RT(9)Keep warm @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bGroupHeating @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Group heating @RT(13)Group heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bGroupHeating @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Group heating @RT(13)Group heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_PWMCycleTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#20s @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#100ms..t#20s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_PWMCycleTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#100ms..t#20s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Cycle time @RT(10)Cycle time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_PWMMinPulseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)t#1s @RT(26)max. 5% of sv_PWMCycleTime 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(15)FPlausPulseTime @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Minimal pulse time @RT(18)Minimal pulse time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_PWMMinPulseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(15)FPlausPulseTime @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Minimal pulse time @RT(18)Minimal pulse time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bReParamGroup @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(48)By this var each zone can reparam the groupblock 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Reparam group @RT(19)Reparametrize group @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bReParamGroup @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(48)By this var each zone can reparam the groupblock 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Reparam group @RT(19)Reparametrize group @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_AutoHeatingSettings @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyAutoHeating @RT(0) @T @T @UNKNOWN 0 @F 
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
@AttrSym @RT(22)sv_AutoHeatingSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_AutoHeatingSettings[0].bActivate @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Activate @RT(21)Activate auto heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(41)sv_AutoHeatingSettings[0].dTimeToActivate @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Time to activate @RT(29)Time to activate auto heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_LockGroup @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(23)cLockGroupHeatingNozzle @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_dTempOkTimeSet @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#10s @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0.0m..t#999m @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cool prevent time @RT(17)Cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_dTempOkTimeSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0.0m..t#999m @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cool prevent time @RT(17)Cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_dTempOkTimeAct @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. cool prevent time @RT(22)Act. cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_dTempOkTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(14)VG_MachineData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. cool prevent time @RT(22)Act. cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rTempOkTimeAct @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(14)VG_MachineData @RT(5)fmt31 @RT(15)HeatThroughTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. cool prevent time @RT(22)Act. cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rTempOkTimeAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(14)VG_MachineData @RT(5)fmt31 @RT(15)HeatThroughTime @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Act. cool prevent time @RT(22)Act. cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rTempOkTimeSet @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)1.0 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt31 @RT(15)HeatThroughTime @RT(0) @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cool prevent time @RT(17)Cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_rTempOkTimeSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt31 @RT(15)HeatThroughTime @RT(0) @RT(0) 
@RT(10)0.0..999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Cool prevent time @RT(17)Cool prevent time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rTemperatureRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(11)Temperature @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Temp. ramp @RT(16)Temperature ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rTemperatureRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(11)Temperature @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Temp. ramp @RT(16)Temperature ramp @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rEvaporationTemp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)90.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(11)Temperature @RT(0) @RT(0) 
@RT(11)80.0..120.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Evaporation temp @RT(23)Evaporation temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rEvaporationTemp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(11)Temperature @RT(0) @RT(0) 
@RT(11)80.0..120.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Evaporation temp @RT(23)Evaporation temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_dEvaporationTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#300s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Evaporation time @RT(16)Evaporation time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_dEvaporationTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#300s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Evaporation time @RT(16)Evaporation time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rStandbyTempVis @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Standby temperature @RT(19)Standby temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rStandbyTempVis @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(0) @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(27)0.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Standby temperature @RT(19)Standby temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rIncTemperature @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Increase temperature @RT(31)Increase temperature difference @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rIncTemperature @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Increase temperature @RT(31)Increase temperature difference @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_bUndoChangeHeatingParams @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Undo change pid param @RT(21)Undo change pid param @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_bUndoChangeHeatingParams @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Undo change pid param @RT(21)Undo change pid param @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_dEvaporationTimeBlock @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#300s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Evaporation time block @RT(22)Evaporation time block @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_dEvaporationTimeBlock @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#300s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Evaporation time block @RT(22)Evaporation time block @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_dSoftstartAlarmTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#0s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt42 @RT(4)Time @RT(0) @RT(0) 
@RT(13)T#0s..T#3600s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Softstart alarm time @RT(20)Softstart alarm time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_dSoftstartAlarmTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt42 @RT(4)Time @RT(0) @RT(0) 
@RT(13)T#0s..T#3600s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Softstart alarm time @RT(20)Softstart alarm time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_iZonesAboveMaxTemp @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(62)number of heating zones which exceeded the maximum temperature 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_ActPowerHeatUp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tyPowerHeatingZones @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Act. power heat up @RT(18)Act. power heat up @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_ActPowerHeatUp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Act. power heat up @RT(18)Act. power heat up @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_iActPowerHeatUpIndex @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(21)0..cMaxNoHeatingPower @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Power index nozzle @RT(18)Power index nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_iActPowerHeatUpIndex @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(21)0..cMaxNoHeatingPower @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Power index nozzle @RT(18)Power index nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dHeatUpDuration @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt81 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Heat up duration nozzle @RT(23)Heat up duration nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dHeatUpDuration @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt81 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Heat up duration nozzle @RT(23)Heat up duration nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dMaxStandByTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#24h @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt61 @RT(14)TimeMinutesAbs @RT(0) @RT(0) 
@RT(11)T#0s..T#24h @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. preheat time @RT(24)Max. preheat time nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dMaxStandByTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt61 @RT(14)TimeMinutesAbs @RT(0) @RT(0) 
@RT(11)T#0s..T#24h @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Max. preheat time @RT(24)Max. preheat time nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_rActHeatingPower @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt81 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Heating power nozzle @RT(20)Heating power nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_rActHeatingPower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt81 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Heating power nozzle @RT(20)Heating power nozzle @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_iAutoHeatingChangeCounter @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Auto heating change counter @RT(27)Auto heating change counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_iAutoHeatingChangeCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(27)Auto heating change counter @RT(27)Auto heating change counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_dObservationTimeHeating @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#3m @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt61 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#24h @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Observation time heating @RT(24)Observation time heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_dObservationTimeHeating @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#3m @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt61 @RT(4)Time @RT(0) @RT(0) 
@RT(11)T#0s..T#24h @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)Observation time heating @RT(24)Observation time heating @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rMaxTempHeatUpOpt @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)80.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(11)Temperature @RT(0) @RT(0) 
@RT(28)20.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Max. temperature optimization @RT(37)Max. temperature heat up optimization @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rMaxTempHeatUpOpt @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)80.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(11)Temperature @RT(0) @RT(0) 
@RT(28)20.0..%FU.sv_rMaxTemperature @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Max. temperature optimization @RT(37)Max. temperature heat up optimization @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bUseOutputLimitation @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Use output limitation @RT(21)Use output limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bUseOutputLimitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Use output limitation @RT(21)Use output limitation @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_UseOutputLimitation @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)KAPPL_TempZoneUsedArr @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(14)FALSE,11(TRUE) @RT(26)activate output limitation 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Use output limitation at zone @RT(29)Use output limitation at zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_UseOutputLimitation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(19)FALSE,4(TRUE),FALSE @RT(26)activate output limitation 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Use output limitation at zone @RT(29)Use output limitation at zone @RT(0) @RT(0) @RT(0) 
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
