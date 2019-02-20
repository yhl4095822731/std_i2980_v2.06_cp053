IMPORT_OVER_LISTFILE
 KCTRL_YXGen_RampType
, KAPPL_ProfileType
, KAPPL_ServoValveControllerMode
, tsVelPre
, tsControlParameters
, KCTRL_Lintab_Point_Light
, KCTRL_LintabPoints
, KCTRL_Lintab_Point
, KCTRL_Prof_Light

END_IMPORT

CONSTANT
 cPointsLastAIValue : DINT := 5 (* Number of Points for calculating mean value of the last analog inputs *);
 cBUFFER_MAX_SIZE : DINT := 40 (* Max Number of Elements in Stack *);
 cPlausMaxRampVelocityMin : REAL := 10.1;
 cPlausMaxRampVelocityMax : REAL := 40000.0 (* minimum 25 ms for 1000 mm/s *);
 cPlausMaxRampPressureMin : REAL := 10.1;
 cPlausMaxRampPressureMax : REAL := 9999.9;
 cPlausMaxRampInjectPressureMin : REAL := 100.0;
 cPlausMaxRampInjectPressureMax : REAL := 99999.9;
END_CONSTANT

TYPE
 tVisProfilePoint : 
   STRUCT 
    rPressure : REAL (* pressure at this point *);
    rPressRamp : REAL := 100.0 (* ramp at this point *);
    rVelocity : REAL (* flow at this point *);
    rVelRamp : REAL := 100.0 (* ramp for speed for this point *);
    rStartPos : REAL (* start position *);
   END_STRUCT;
 tVisProfileArray : ARRAY  [1..20] OF tVisProfilePoint;
 TVisProfile : 
   STRUCT 
    Points : tVisProfileArray;
    iNoOfPoints : UDINT := 3;
   END_STRUCT;
 tCalculatedSingleProfile : 
   STRUCT 
    iProfileChangedCounter : DINT;
    CalculatedProfile : KCTRL_Prof_Light;
   END_STRUCT;
 tCalculatedProfiles : 
   STRUCT 
    VelocityProfile : tCalculatedSingleProfile;
    PressureProfile : tCalculatedSingleProfile;
   END_STRUCT;
 KAPPL_VisProfile : 
   STRUCT 
    Profile : TVisProfile := (Points:=(rPressRamp:=100.0,rVelRamp:=100.0)) (* movement profile *);
    bOpenEndProfile : BOOL (* profile with open end *);
    bLimitEveryPointToLastRamp : BOOL := TRUE (* limitation of profiles is done with last ramp for velocity and pressure, standard case TRUE *);
    rMinOutputVel : REAL (* minimum vel output *);
    rMinOutputPress : REAL (* minimum pressure output *);
    rPreOutputVel : REAL (* preoutput value for vel *);
    rPreOutputPress : REAL (* preoutput value for pressure *);
    rPreOutputVelRamp : REAL (* ramp for preoutput vel *);
    rPreOutputPressRamp : REAL (* ramp for preoutput pressure *);
    rMaxRampPress : REAL;
    rMaxRampVel : REAL;
    RampTypeVel : KCTRL_YXGen_RampType;
    RampTypePress : KCTRL_YXGen_RampType;
    rStopRampVel : REAL := 100.0 (* Stop Ramp Velocity *);
    rStopRampPress : REAL := 100.0 (* Stop Ramp Pressure *);
    rEndOutputPress : REAL (* pressure between direction change *);
    rEndOutputVel : REAL (* velocity between direction change *);
    ProfileTypeVel : KAPPL_ProfileType;
    ProfileTypePress : KAPPL_ProfileType;
    rOffset : REAL (* actual offset for profile calculation *);
    bUseOffsetOptimizing : BOOL (* use offset for optimizing positioning *);
    piActStage : REFTO DINT (* reference to sysvar that contains the active profile stage *);
    pCalculatedProfile : REFTO tCalculatedProfiles (* reference to sysvar that contains the active profile stage *);
    bUsePressureRamp : BOOL;
   END_STRUCT;
 tVisProfilePointPlast : 
   STRUCT 
    rPressure : REAL (* pressure at this point *);
    rPressRamp : REAL := 100.0 (* ramp at this point *);
    rRotation : REAL (* rotation at this point *);
    rRotationRamp : REAL := 100.0 (* ramp for rotation for this point *);
    rBackPressure : REAL (* backpressure at this point *);
    rBackPressureRamp : REAL := 100.0 (* ramp for backpressure for this point *);
    rStartPos : REAL (* start position *);
   END_STRUCT (* special structure for plast profile *);
 tVisProfileArrayPlast : ARRAY  [1..20] OF tVisProfilePointPlast;
 TVisProfilePlast : 
   STRUCT 
    Points : tVisProfileArrayPlast;
    iNoOfPoints : UDINT;
   END_STRUCT;
 KAPPL_VisProfilePlast : 
   STRUCT 
    Profile : TVisProfilePlast := (Points:=(rPressRamp:=100.0,rRotationRamp:=100.0,rBackPressureRamp:=100.0)) (* movement profile *);
    bOpenEndProfile : BOOL (* profile with open end *);
    bLimitEveryPointToLastRamp : BOOL := TRUE;
    rMinOutputVel : REAL (* minimum vel output *);
    rMinOutputPress : REAL (* minimum pressure output *);
    rMinOutputBackPress : REAL (* minimum backpressure output *);
    rPreOutputVel : REAL (* preoutput value for vel *);
    rPreOutputPress : REAL (* preoutput value for pressure *);
    rPreOutputBackPress : REAL (* preoutput value for backpressure *);
    rPreOutputVelRamp : REAL (* ramp for preoutput vel *);
    rPreOutputPressRamp : REAL (* ramp for preoutput pressure *);
    rPreOutputBackPressRamp : REAL (* ramp for preoutput backpressure *);
    rMaxRampPress : REAL;
    rMaxRampVel : REAL;
    rMaxRampBackPress : REAL;
    RampTypeBackPress : KCTRL_YXGen_RampType;
    RampTypeVel : KCTRL_YXGen_RampType;
    RampTypePress : KCTRL_YXGen_RampType;
    rStopRampVel : REAL := 100.0 (* Stop Ramp Velocity *);
    rStopRampPress : REAL := 100.0 (* Stop Ramp Pressure *);
    rEndOutputPressure : REAL;
    rEndOutputBackPressure : REAL;
    ProfileTypeVel : KAPPL_ProfileType;
    ProfileTypePress : KAPPL_ProfileType;
    ProfileTypeBackPress : KAPPL_ProfileType;
    piActStage : REFTO DINT (* reference to sysvar that contains the active profile stage *);
    pCalculatedProfile : REFTO tCalculatedProfiles (* reference to sysvar that contains the active profile stage *);
    bUsePressureRamp : BOOL;
   END_STRUCT;
 tsCutOffCriterions : 
   STRUCT 
    bUseExtDigIn : BOOL;
    rMoldPressureThreshold : REAL;
    bUseMoldPressure : BOOL;
    rInjectPressureThreshold : REAL (* specific injection pressure *);
    bUseInjectPressure : BOOL;
    rPositionThreshold : REAL;
    bUsePosition : BOOL;
    dTimeThreshold : TIME;
    bUseTimer : BOOL;
    dDetectionDeadTime : TIME (* only used in combination with cut off detection by pressure *);
    rDetectionPositionLimit : REAL (* only used in combination with cut off detection by pressure *);
    bUseTorque : BOOL (* only used with EIMM *);
    rTorqueThreshold : REAL (* only used with EIMM *);
   END_STRUCT;
 tsEndPosData : 
   STRUCT 
    pProfile : REFTO KAPPL_VisProfile (* pointer to according standard profile *);
    pPlastProfile : REFTO KAPPL_VisProfilePlast (* pointer to plast profile (optional) *);
    rTolerance : REFTO REAL (* tolerance *);
    rActPos : REFTO REAL (* actual position *);
    pbDI : REFTO BOOL (* digital input (for exapmle limit switch) *);
    bInvertDI : BOOL (* limitswicht is inverted (DI is FALSE if limitswitch is reached) *);
    pbPosReached : REFTO BOOL (* TRUE if target position is reached *);
   END_STRUCT;
 tsTargetPosData : 
   STRUCT 
    rTargetPos : REFTO REAL (* pointer to target position *);
    rTolerance : REFTO REAL (* tolerance *);
    rActPos : REFTO REAL (* actual position *);
    bDirection : BOOL (* TRUE: Position is getting bigger *);
    pbPosReached : REFTO BOOL (* TRUE if target position is reached *);
   END_STRUCT;
 tsMinOutput : 
   STRUCT 
    rPressure : REAL;
    rVelocity : REAL;
   END_STRUCT;
 tsDeadTimeParameters : 
   STRUCT 
    bCompensationEnabled : BOOL;
    dDeadTime : TIME;
    dPT2T1 : TIME;
    dPT2T2 : TIME;
    rPT2K : REAL;
   END_STRUCT;
 tsCylinderData : 
   STRUCT 
    rCylinderDiameter : REAL;
    rPistonRodDiameter : REAL;
    iNumCylinders : DINT;
    bUseSmallSize : BOOL;
    rPlungerDiameter : REAL;
    bMoveWithPlunger : BOOL;
   END_STRUCT;
 KAPPL_ServoValveControlData : 
   STRUCT 
    pScrewDiameter : REFTO REAL;
    pCylinderData : REFTO tsCylinderData;
    pCylinderStroke : REFTO REAL;
    pActPressureA : REFTO REAL;
    pSetPressureA : REFTO REAL;
    pSysPressure : REFTO REAL;
    pActPosition : REFTO REAL;
    pActVelocity : REFTO REAL;
    pSetVelocity : REFTO REAL;
    pControllerMode : REFTO KAPPL_ServoValveControllerMode;
    pTransducerError : REFTO BOOL;
    pConstSetupFwd : REFTO tsVelPre;
    pConstSetupBwd : REFTO tsVelPre;
    pDeviceReady : REFTO BOOL;
    prMaxSpeedFwdMachLimit : REFTO REAL;
    pSetValueLimitActive : REFTO BOOL;
    pPressureControlParams : REFTO tsControlParameters;
    pBackPressureControlParams : REFTO tsControlParameters;
    pbMoveToServoCalibStartPos : REFTO BOOL;
   END_STRUCT;
 tsOutCal : 
   STRUCT 
    pLintab : REFTO KCTRL_Lintab_Point_Light;
    pMaxX : REFTO REAL;
   END_STRUCT;
 tnMeasureVIState : (MeasureVI_State_OK, MeasureVI_State_NOTOK, MeasureVI_State_InvalidParam);
 tyLastAIValueArray : ARRAY  [1..cPointsLastAIValue] OF REAL (* Saving the last points of AI measuring *);
 tsPredControlParameters : 
   STRUCT 
    rP : REAL;
    dTN : TIME;
    dTV : TIME;
    rKS : REAL;
    bUsePIDControl : BOOL;
    dTime : TIME;
    dRiseTime : TIME;
    dDeadTime : TIME;
    rKLoad : REAL;
    rKVelReduce : REAL;
    OutputLintab : KCTRL_LintabPoints;
   END_STRUCT;
 tLintabPoints : ARRAY  [1..100] OF KCTRL_Lintab_Point;
 tyStringBuffer : ARRAY  [1..cBUFFER_MAX_SIZE] OF STRING(255);
 tsClampForces : 
   STRUCT 
    rMaxClampForce : REAL (* maximum clamp force *);
    rSetClampForce : REAL (* desired clamp force *);
    rActualClampForce : REAL (* actual clamp force *);
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 120 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
8 
@Constant @RT(18)cPointsLastAIValue @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(69)Number of Points for calculating mean value of the last analog inputs 
@END_Attrib 


@Constant @RT(16)cBUFFER_MAX_SIZE @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)40 @RT(31)Max Number of Elements in Stack 
@END_Attrib 


@Constant @RT(24)cPlausMaxRampVelocityMin @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)10.1 @RT(0) 
@END_Attrib 


@Constant @RT(24)cPlausMaxRampVelocityMax @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(7)40000.0 @RT(27)minimum 25 ms for 1000 mm/s 
@END_Attrib 


@Constant @RT(24)cPlausMaxRampPressureMin @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)10.1 @RT(0) 
@END_Attrib 


@Constant @RT(24)cPlausMaxRampPressureMax @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)9999.9 @RT(0) 
@END_Attrib 


@Constant @RT(30)cPlausMaxRampInjectPressureMin @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)100.0 @RT(0) 
@END_Attrib 


@Constant @RT(30)cPlausMaxRampInjectPressureMax @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(7)99999.9 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
24 
@DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @STRUCT 0 24 

@StructElem @RT(7)Profile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)TVisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(45)(Points:=(rPressRamp:=100.0,rVelRamp:=100.0)) @RT(16)movement profile @RT(0) 
@END_Attrib 

@StructElem @RT(15)bOpenEndProfile @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)profile with open end @RT(0) 
@END_Attrib 

@StructElem @RT(26)bLimitEveryPointToLastRamp @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(4)TRUE @RT(91)limitation of profiles is done with last ramp for velocity and pressure, standard case TRUE @RT(0) 
@END_Attrib 

@StructElem @RT(13)rMinOutputVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)minimum vel output @RT(0) 
@END_Attrib 

@StructElem @RT(15)rMinOutputPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)minimum pressure output @RT(0) 
@END_Attrib 

@StructElem @RT(13)rPreOutputVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)preoutput value for vel @RT(0) 
@END_Attrib 

@StructElem @RT(15)rPreOutputPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)preoutput value for pressure @RT(0) 
@END_Attrib 

@StructElem @RT(17)rPreOutputVelRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)ramp for preoutput vel @RT(0) 
@END_Attrib 

@StructElem @RT(19)rPreOutputPressRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)ramp for preoutput pressure @RT(0) 
@END_Attrib 

@StructElem @RT(13)rMaxRampPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)rMaxRampVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)RampTypeVel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_YXGen_RampType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)RampTypePress @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_YXGen_RampType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rStopRampVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(18)Stop Ramp Velocity @RT(0) 
@END_Attrib 

@StructElem @RT(14)rStopRampPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(18)Stop Ramp Pressure @RT(0) 
@END_Attrib 

@StructElem @RT(15)rEndOutputPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)pressure between direction change @RT(0) 
@END_Attrib 

@StructElem @RT(13)rEndOutputVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)velocity between direction change @RT(0) 
@END_Attrib 

@StructElem @RT(14)ProfileTypeVel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)KAPPL_ProfileType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)ProfileTypePress @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)KAPPL_ProfileType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)rOffset @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)actual offset for profile calculation @RT(0) 
@END_Attrib 

@StructElem @RT(20)bUseOffsetOptimizing @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)use offset for optimizing positioning @RT(0) 
@END_Attrib 

@StructElem @RT(10)piActStage @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)reference to sysvar that contains the active profile stage @RT(0) 
@END_Attrib 

@StructElem @RT(18)pCalculatedProfile @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)reference to sysvar that contains the active profile stage @RT(0) 
@END_Attrib 

@StructElem @RT(16)bUsePressureRamp @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(131)(Profile:=(Points:=(rPressRamp:=100.0,rVelRamp:=100.0)),bLimitEveryPointToLastRamp:=TRUE,rStopRampVel:=100.0,rStopRampPress:=100.0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)KAPPL_VisProfilePlast @RT(0) @T @T @STRUCT 0 28 

@StructElem @RT(7)Profile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)TVisProfilePlast @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(75)(Points:=(rPressRamp:=100.0,rRotationRamp:=100.0,rBackPressureRamp:=100.0)) @RT(16)movement profile @RT(0) 
@END_Attrib 

@StructElem @RT(15)bOpenEndProfile @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)profile with open end @RT(0) 
@END_Attrib 

@StructElem @RT(26)bLimitEveryPointToLastRamp @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(4)TRUE @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)rMinOutputVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)minimum vel output @RT(0) 
@END_Attrib 

@StructElem @RT(15)rMinOutputPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)minimum pressure output @RT(0) 
@END_Attrib 

@StructElem @RT(19)rMinOutputBackPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)minimum backpressure output @RT(0) 
@END_Attrib 

@StructElem @RT(13)rPreOutputVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)preoutput value for vel @RT(0) 
@END_Attrib 

@StructElem @RT(15)rPreOutputPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)preoutput value for pressure @RT(0) 
@END_Attrib 

@StructElem @RT(19)rPreOutputBackPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)preoutput value for backpressure @RT(0) 
@END_Attrib 

@StructElem @RT(17)rPreOutputVelRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)ramp for preoutput vel @RT(0) 
@END_Attrib 

@StructElem @RT(19)rPreOutputPressRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)ramp for preoutput pressure @RT(0) 
@END_Attrib 

@StructElem @RT(23)rPreOutputBackPressRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(31)ramp for preoutput backpressure @RT(0) 
@END_Attrib 

@StructElem @RT(13)rMaxRampPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)rMaxRampVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)rMaxRampBackPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)RampTypeBackPress @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_YXGen_RampType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)RampTypeVel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_YXGen_RampType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)RampTypePress @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_YXGen_RampType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rStopRampVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(18)Stop Ramp Velocity @RT(0) 
@END_Attrib 

@StructElem @RT(14)rStopRampPress @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(18)Stop Ramp Pressure @RT(0) 
@END_Attrib 

@StructElem @RT(18)rEndOutputPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(22)rEndOutputBackPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)ProfileTypeVel @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)KAPPL_ProfileType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)ProfileTypePress @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)KAPPL_ProfileType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)ProfileTypeBackPress @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)KAPPL_ProfileType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)piActStage @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)reference to sysvar that contains the active profile stage @RT(0) 
@END_Attrib 

@StructElem @RT(18)pCalculatedProfile @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(19)tCalculatedProfiles @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)reference to sysvar that contains the active profile stage @RT(0) 
@END_Attrib 

@StructElem @RT(16)bUsePressureRamp @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(161)(Profile:=(Points:=(rPressRamp:=100.0,rRotationRamp:=100.0,rBackPressureRamp:=100.0)),bLimitEveryPointToLastRamp:=TRUE,rStopRampVel:=100.0,rStopRampPress:=100.0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tVisProfilePoint @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(9)rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)pressure at this point @RT(0) 
@END_Attrib 

@StructElem @RT(10)rPressRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(18)ramp at this point @RT(0) 
@END_Attrib 

@StructElem @RT(9)rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)flow at this point @RT(0) 
@END_Attrib 

@StructElem @RT(8)rVelRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(29)ramp for speed for this point @RT(0) 
@END_Attrib 

@StructElem @RT(9)rStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)start position @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(35)(rPressRamp:=100.0,rVelRamp:=100.0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tVisProfilePointPlast @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(9)rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)pressure at this point @RT(0) 
@END_Attrib 

@StructElem @RT(10)rPressRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(18)ramp at this point @RT(0) 
@END_Attrib 

@StructElem @RT(9)rRotation @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)rotation at this point @RT(0) 
@END_Attrib 

@StructElem @RT(13)rRotationRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(32)ramp for rotation for this point @RT(0) 
@END_Attrib 

@StructElem @RT(13)rBackPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)backpressure at this point @RT(0) 
@END_Attrib 

@StructElem @RT(17)rBackPressureRamp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(5)100.0 @RT(36)ramp for backpressure for this point @RT(0) 
@END_Attrib 

@StructElem @RT(9)rStartPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)start position @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(65)(rPressRamp:=100.0,rRotationRamp:=100.0,rBackPressureRamp:=100.0) @RT(35)special structure for plast profile @RT(0) 
@END_Attrib 


@DT @RT(11)TVisProfile @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)Points @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tVisProfileArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iNoOfPoints @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(1)3 @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(16)(iNoOfPoints:=3) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)TVisProfilePlast @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)Points @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tVisProfileArrayPlast @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iNoOfPoints @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tVisProfileArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tVisProfilePoint @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(2)20 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tVisProfileArrayPlast @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(21)tVisProfilePointPlast @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(2)20 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tsCutOffCriterions @RT(0) @T @T @STRUCT 0 13 

@StructElem @RT(12)bUseExtDigIn @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(22)rMoldPressureThreshold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bUseMoldPressure @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(24)rInjectPressureThreshold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)specific injection pressure @RT(0) 
@END_Attrib 

@StructElem @RT(18)bUseInjectPressure @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)rPositionThreshold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)bUsePosition @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)dTimeThreshold @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bUseTimer @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)dDetectionDeadTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)only used in combination with cut off detection by pressure @RT(0) 
@END_Attrib 

@StructElem @RT(23)rDetectionPositionLimit @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)only used in combination with cut off detection by pressure @RT(0) 
@END_Attrib 

@StructElem @RT(10)bUseTorque @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)only used with EIMM @RT(0) 
@END_Attrib 

@StructElem @RT(16)rTorqueThreshold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)only used with EIMM @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tsEndPosData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(8)pProfile @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)KAPPL_VisProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)pointer to according standard profile @RT(0) 
@END_Attrib 

@StructElem @RT(13)pPlastProfile @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(21)KAPPL_VisProfilePlast @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)pointer to plast profile (optional) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rTolerance @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(9)tolerance @RT(0) 
@END_Attrib 

@StructElem @RT(7)rActPos @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)actual position @RT(0) 
@END_Attrib 

@StructElem @RT(4)pbDI @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)digital input (for exapmle limit switch) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bInvertDI @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(63)limitswicht is inverted (DI is FALSE if limitswitch is reached) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbPosReached @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)TRUE if target position is reached @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsTargetPosData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(10)rTargetPos @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)pointer to target position @RT(0) 
@END_Attrib 

@StructElem @RT(10)rTolerance @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(9)tolerance @RT(0) 
@END_Attrib 

@StructElem @RT(7)rActPos @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)actual position @RT(0) 
@END_Attrib 

@StructElem @RT(10)bDirection @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)TRUE: Position is getting bigger @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbPosReached @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)TRUE if target position is reached @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tsMinOutput @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(9)rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(20)tsDeadTimeParameters @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(20)bCompensationEnabled @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)dDeadTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)dPT2T1 @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)dPT2T2 @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)rPT2K @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(27)KAPPL_ServoValveControlData @RT(0) @T @T @STRUCT 0 19 

@StructElem @RT(14)pScrewDiameter @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pCylinderData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(14)tsCylinderData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pCylinderStroke @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pActPressureA @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pSetPressureA @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pSysPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pActPosition @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pActVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pSetVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)pControllerMode @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(30)KAPPL_ServoValveControllerMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)pTransducerError @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)pConstSetupFwd @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)pConstSetupBwd @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pDeviceReady @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(22)prMaxSpeedFwdMachLimit @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)pSetValueLimitActive @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(22)pPressureControlParams @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(26)pBackPressureControlParams @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(19)tsControlParameters @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(26)pbMoveToServoCalibStartPos @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tsCylinderData @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(17)rCylinderDiameter @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)rPistonRodDiameter @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)iNumCylinders @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)bUseSmallSize @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)rPlungerDiameter @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bMoveWithPlunger @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(8)tsOutCal @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)pLintab @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(24)KCTRL_Lintab_Point_Light @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)pMaxX @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(16)tnMeasureVIState @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(18)MeasureVI_State_OK @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)MeasureVI_State_NOTOK @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(28)MeasureVI_State_InvalidParam @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyLastAIValueArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(18)cPointsLastAIValue 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)Saving the last points of AI measuring @RT(0) 
@END_Attrib 


@DT @RT(23)tsPredControlParameters @RT(0) @T @T @STRUCT 0 11 

@StructElem @RT(2)rP @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)dTN @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)dTV @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)rKS @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)bUsePIDControl @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)dTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)dRiseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)dDeadTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)rKLoad @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)rKVelReduce @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)OutputLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_LintabPoints @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(13)tLintabPoints @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(18)KCTRL_Lintab_Point @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(3)100 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyStringBuffer @RT(0) @T @T @ARRAY 0 @T @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F 1 @RT(1)1 @RT(16)cBUFFER_MAX_SIZE 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsClampForces @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(14)rMaxClampForce @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)maximum clamp force @RT(0) 
@END_Attrib 

@StructElem @RT(14)rSetClampForce @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)desired clamp force @RT(0) 
@END_Attrib 

@StructElem @RT(17)rActualClampForce @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)actual clamp force @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tCalculatedSingleProfile @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(22)iProfileChangedCounter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)CalculatedProfile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KCTRL_Prof_Light @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(19)tCalculatedProfiles @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(15)VelocityProfile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tCalculatedSingleProfile @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)PressureProfile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tCalculatedSingleProfile @RT(0) @T @T @UNKNOWN 0 @F 
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
