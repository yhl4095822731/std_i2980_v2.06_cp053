IMPORT_OVER_LISTFILE
 KHW_PWM_Param
, KHW_TempSensor
, KTEMP_Opt_State
, KCTRL_Stable_State
, KAPPL_TempControlParam
, KAPPL_TempStabilityParam
, cMaxZones

END_IMPORT

CONSTANT
 cMaxPowerZones : DINT := 9;
 cMaxNoHeatingPower : UDINT := 180;
 cMaxHeatUpObservationTime : TIME := T#180m;
 cHeatUpObservationTimeStep : TIME := T#1m;
 cMinPulseTimeLimitFactor : REAL := 0.05 (* 5%  of pwm cycle time *);
END_CONSTANT

TYPE
 tenZoneStateDisp : (enZoneStateOK, enZoneStateErrorSensor, enZoneStateError);
 tenZoneModeDisp : (enZoneModeOff, enZoneModeHeat, enZoneModeCool);
 tenOptimizationState : (enOptimizeWarmUp, enOptimizeOperPointEven, enOptimizeOperPointOdd, enOptimizeOff);
 tenZoneMode : (enZoneModeDisabled, enZoneModeMeasure, enZoneModeConstant, enZoneModePID2pt, enZoneModePID3pt, enZoneModePID2ptEM, enZoneModePID3ptEM);
 tsZonePowerGroup : 
   STRUCT 
    sDevice : STRING(32) (* Device name from config *);
    iDeviceType : DINT (* Device type (0 = unknown, 1 = IM032, 2 = IM232) *);
    bPWILinked : BOOL (* Power input linked *);
    prInGroupPWI : REFTO REAL (* Power input *);
    pbInGroupPWIStat : REFTO BOOL (* Power input stat *);
    bCUILinked : BOOL (* Current input linked *);
    prInGroupCUI : REFTO REAL (* Current input *);
    pbInGroupCUIStat : REFTO BOOL (* Current input stat *);
    bVOILinked : BOOL (* Volt input linked *);
    prInGroupVOI : REFTO REAL (* Volt input *);
    pbInGroupVOIStat : REFTO BOOL (* Volt input stat *);
    rCUIGainFactor : REAL (* gain factor to calculate [A] from SDO value *);
    dPowerImbaStartTime : TIME (* last start time where balance check succeeds *);
    bPowerImbaWarn : BOOL (* true, when power imbalance warning is detected (one zone is significantly lower powered than the others) *);
   END_STRUCT;
 tpZonePowerGroup : REFTO tsZonePowerGroup;
 tyZonePowerGroupArray : ARRAY  [1..cMaxPowerZones] OF tsZonePowerGroup;
 tsZoneData : 
   STRUCT 
    bOptiOperatingPoint : BOOL;
    bOutputNotAllowed : BOOL;
    PWMFactor : REAL;
    iIndex : DINT;
    bHWOK : BOOL;
    bSensorOK : BOOL;
    bOutputOK : BOOL;
    rWAct : REAL;
    rOutputValue : REAL;
    prOutHeatPO : REFTO REAL;
    pbOutHeatPOStat : REFTO BOOL;
    prOutHeatTO : REFTO REAL;
    pbOutHeatTOStat : REFTO BOOL;
    pbOutHeatTOPar : REFTO KHW_PWM_Param;
    prOutCoolTO : REFTO REAL;
    pbOutCoolTOStat : REFTO BOOL;
    pbOutCoolTOPar : REFTO KHW_PWM_Param;
    pbOutHeatDOStat : REFTO BOOL;
    pbOutHeatDO : REFTO BOOL;
    pbOutCoolDO : REFTO BOOL;
    pbOutCoolDOStat : REFTO BOOL;
    pPowerGroup : REFTO tsZonePowerGroup;
    prActTemp : REFTO REAL;
    pbActTempStat : REFTO BOOL;
    pHWSensorType : REFTO KHW_TempSensor;
    ActModeDisp : tenZoneModeDisp;
    ActStateDisp : tenZoneStateDisp;
    rSetVal : REAL;
    bOptimize : BOOL;
    bIsOptimizing : BOOL;
    bEmgOperation : BOOL;
    bToleranceError : BOOL;
    OptState : KTEMP_Opt_State;
    Stable : KCTRL_Stable_State;
    bIsHotrunner : BOOL;
    bUseIncTemperature : BOOL;
   END_STRUCT;
 tenZoneType : (enZoneTypeNozzle, enZoneTypeBlock, enZoneTypeHotrunner);
 tsZoneDataRetain : 
   STRUCT 
    Param : KAPPL_TempControlParam;
    StabParam : KAPPL_TempStabilityParam;
    SensorTypeVis : KHW_TempSensor;
    ModeVis : tenZoneMode;
    rSetValVis : REAL;
    rConstValVis : REAL;
    rUpperTolVis : REAL;
    rLowerTolVis : REAL;
    rStandbyTempVis : REAL;
    bIsHotrunner : BOOL;
    iName : DINT;
    ZoneType : tenZoneType;
    bUsed : BOOL;
    rSoftstartPower : REAL;
    bDoOptimizationNext : BOOL;
    rReferenceRamp : REAL (* internal ramp for rWAct *);
   END_STRUCT;
 tpZoneData : REFTO tsZoneData;
 tpZoneDataRetain : REFTO tsZoneDataRetain;
 tsZone : 
   STRUCT 
    bLinked : BOOL;
    Data : tpZoneData;
    DataRetain : tpZoneDataRetain;
   END_STRUCT;
 tyZoneArray : ARRAY  [1..cMaxZones] OF tsZone;
 tsAutoHeating : 
   STRUCT 
    bActivate : BOOL;
    dTimeToActivate : TIME_OF_DAY;
   END_STRUCT;
 tyAutoHeating : ARRAY  [1..7] OF tsAutoHeating;
 tyZoneBoolArray : ARRAY  [1..cMaxZones] OF BOOL;
 tySensorTypePlaus : ARRAY  [1..4] OF KHW_TempSensor;
 tenOperatingPointOptState : (enOPOState_None, enOPOState_StableFirst, enOPOState_RunFirst, enOPOState_StableSecond, enOPOState_RunSecond) (* States during operating poin temperature optimization *);
 tyPowerHeatingZones : ARRAY  [1..cMaxNoHeatingPower] OF REAL;
 tsTimePlausArray : 
   STRUCT 
    dLowerLimit : TIME;
    dUpperLimit : TIME;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 128 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
5 
@Constant @RT(14)cMaxPowerZones @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)9 @RT(0) 
@END_Attrib 


@Constant @RT(18)cMaxNoHeatingPower @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)180 @RT(0) 
@END_Attrib 


@Constant @RT(25)cMaxHeatUpObservationTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)T#180m @RT(0) 
@END_Attrib 


@Constant @RT(26)cHeatUpObservationTimeStep @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)T#1m @RT(0) 
@END_Attrib 


@Constant @RT(24)cMinPulseTimeLimitFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)0.05 @RT(21)5%  of pwm cycle time 
@END_Attrib 


@RT(17)TypeTreeContainer 
21 
@DT @RT(16)tenZoneStateDisp @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(13)enZoneStateOK @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)zone or whole heating is switched off @RT(0) 
@END_Attrib 
@EnumConst @RT(22)enZoneStateErrorSensor @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)zone is switched on and ok @RT(0) 
@END_Attrib 
@EnumConst @RT(16)enZoneStateError @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)error with this zone (e.g. broken sensorline) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tenZoneModeDisp @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(13)enZoneModeOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)zone or whole heating is switched off @RT(0) 
@END_Attrib 
@EnumConst @RT(14)enZoneModeHeat @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)zone is switched on and ok @RT(0) 
@END_Attrib 
@EnumConst @RT(14)enZoneModeCool @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)error with this zone (e.g. broken sensorline) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tenOptimizationState @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(16)enOptimizeWarmUp @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)Warmup optimization active @RT(0) 
@END_Attrib 
@EnumConst @RT(23)enOptimizeOperPointEven @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)operating point optimization for even zones @RT(0) 
@END_Attrib 
@EnumConst @RT(22)enOptimizeOperPointOdd @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)operating point optimization for odd zones @RT(0) 
@END_Attrib 
@EnumConst @RT(13)enOptimizeOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)no optimization active @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tenZoneMode @RT(0) @T @T @ENUM 0 7 
@EnumConst @RT(18)enZoneModeDisabled @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(17)enZoneModeMeasure @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)enZoneModeConstant @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)enZoneModePID2pt @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)enZoneModePID3pt @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)enZoneModePID2ptEM @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)enZoneModePID3ptEM @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsZonePowerGroup @RT(0) @T @T @STRUCT 0 14 

@StructElem @RT(7)sDevice @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)Device name from config @RT(0) 
@END_Attrib 

@StructElem @RT(11)iDeviceType @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)Device type (0 = unknown, 1 = IM032, 2 = IM232) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bPWILinked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)Power input linked @RT(0) 
@END_Attrib 

@StructElem @RT(12)prInGroupPWI @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)Power input @RT(0) 
@END_Attrib 

@StructElem @RT(16)pbInGroupPWIStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)Power input stat @RT(0) 
@END_Attrib 

@StructElem @RT(10)bCUILinked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)Current input linked @RT(0) 
@END_Attrib 

@StructElem @RT(12)prInGroupCUI @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)Current input @RT(0) 
@END_Attrib 

@StructElem @RT(16)pbInGroupCUIStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)Current input stat @RT(0) 
@END_Attrib 

@StructElem @RT(10)bVOILinked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)Volt input linked @RT(0) 
@END_Attrib 

@StructElem @RT(12)prInGroupVOI @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)Volt input @RT(0) 
@END_Attrib 

@StructElem @RT(16)pbInGroupVOIStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)Volt input stat @RT(0) 
@END_Attrib 

@StructElem @RT(14)rCUIGainFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)gain factor to calculate [A] from SDO value @RT(0) 
@END_Attrib 

@StructElem @RT(19)dPowerImbaStartTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)last start time where balance check succeeds @RT(0) 
@END_Attrib 

@StructElem @RT(14)bPowerImbaWarn @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(104)true, when power imbalance warning is detected (one zone is significantly lower powered than the others) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tpZonePowerGroup @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)tsZonePowerGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tyZonePowerGroupArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tsZonePowerGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cMaxPowerZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsZoneData @RT(0) @T @T @STRUCT 0 36 

@StructElem @RT(19)bOptiOperatingPoint @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)bOutputNotAllowed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)PWMFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iIndex @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)bHWOK @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bSensorOK @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bOutputOK @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)rWAct @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rOutputValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prOutHeatPO @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pbOutHeatPOStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prOutHeatTO @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pbOutHeatTOStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)pbOutHeatTOPar @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(13)KHW_PWM_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)prOutCoolTO @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pbOutCoolTOStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)pbOutCoolTOPar @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(13)KHW_PWM_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pbOutHeatDOStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbOutHeatDO @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbOutCoolDO @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pbOutCoolDOStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pPowerGroup @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)tsZonePowerGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)prActTemp @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pbActTempStat @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pHWSensorType @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ActModeDisp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tenZoneModeDisp @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)ActStateDisp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tenZoneStateDisp @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)rSetVal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bOptimize @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bIsOptimizing @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bEmgOperation @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)bToleranceError @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)OptState @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)KTEMP_Opt_State @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)Stable @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Stable_State @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)bIsHotrunner @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)bUseIncTemperature @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsZoneDataRetain @RT(0) @T @T @STRUCT 0 16 

@StructElem @RT(5)Param @RT(0) @T @T @DERIVED 0 @F @RT(22)KAPPL_TempControlParam @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)StabParam @RT(0) @T @T @DERIVED 0 @F @RT(24)KAPPL_TempStabilityParam @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)SensorTypeVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)ModeVis @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tenZoneMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rSetValVis @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rConstValVis @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rUpperTolVis @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rLowerTolVis @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rStandbyTempVis @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)bIsHotrunner @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)iName @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)ZoneType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tenZoneType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)bUsed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rSoftstartPower @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)bDoOptimizationNext @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)rReferenceRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)internal ramp for rWAct @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tpZoneData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tpZoneDataRetain @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)tsZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tyZoneArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(6)tsZone @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(6)tsZone @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(7)bLinked @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Data @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tpZoneData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)DataRetain @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tpZoneDataRetain @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tyAutoHeating @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsAutoHeating @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)7 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsAutoHeating @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(9)bActivate @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)dTimeToActivate @RT(0) @T @F @DT @RT(11)TIME_OF_DAY @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tyZoneBoolArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tySensorTypePlaus @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)4 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tenZoneType @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(16)enZoneTypeNozzle @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)enZoneTypeBlock @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)enZoneTypeHotrunner @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(25)tenOperatingPointOptState @RT(0) @T @T @ENUM 0 5 
@EnumConst @RT(15)enOPOState_None @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(22)enOPOState_StableFirst @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)enOPOState_RunFirst @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)enOPOState_StableSecond @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(20)enOPOState_RunSecond @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)States during operating poin temperature optimization @RT(0) 
@END_Attrib 


@DT @RT(19)tyPowerHeatingZones @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(18)cMaxNoHeatingPower 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsTimePlausArray @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(11)dLowerLimit @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)dUpperLimit @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
