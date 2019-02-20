IMPORT_OVER_LISTFILE
 tnCalibState
, tnCalibGroup
, tnCalibCommand
, tsDeviceId
, tMoveIdent
, tsVelPre
, tnCalibState_None
, tnCalibGroup_NoCalib
, cCalibMovements

END_IMPORT

CONSTANT
 cAutoIdentNoCycles : UDINT := 10 (* number of cycles for auto identification of ramps *);
END_CONSTANT

TYPE
 tsIdentMovement : 
   STRUCT 
    bRedo : BOOL;
    prMaxRampFwd : REFTO REAL;
    prMaxRampBwd : REFTO REAL;
    pdDeadTimeFwd : REFTO TIME;
    pdDeadTimeBwd : REFTO TIME;
    Status : tnCalibState := tnCalibState_None;
    iOrder : DINT := 0;
    Group : tnCalibGroup := tnCalibGroup_NoCalib;
    bNameDummy : BOOL (* Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT *);
    bIgnoreMovement : BOOL (* Calibration should not start automatically *);
   END_STRUCT (* properties of one calibration step *);
 tpIdentMovement : REFTO tsIdentMovement;
 tyIdentMovements : ARRAY  [1..cCalibMovements] OF tpIdentMovement;
 tsGlobalIdentStatus : 
   STRUCT 
    Command : tnCalibCommand (* command for starting / stopping calibration *);
    Status : tnCalibState (* status of overall calibration *);
    rMaxValX : REAL (* maximum value, to display in lintab graph *);
    rMaxValY : REAL;
    iCurrentStep : DINT;
    iMaxStep : DINT (* maximum number of automatic calibration, without tnCalibGroup_LintabOnly *);
    bInitDone : BOOL;
    pMovements : tyIdentMovements;
    bStart : BOOL;
   END_STRUCT;
 tsIdentSpeedMovement : 
   STRUCT 
    bRedo : BOOL;
    prPosition : REFTO REAL;
    prVelocityFwd : REFTO REAL;
    prVelocityBwd : REFTO REAL;
    prVelocityLimitFwd : REFTO REAL;
    prVelocityLimitBwd : REFTO REAL;
    prActVelocity : REFTO REAL;
    prStroke : REFTO REAL;
    rMaxPositionLimitFactor : REAL;
    rMinPositionLimitFactor : REAL;
    prIdentPosition : REFTO REAL;
    pbStartIdent : REFTO BOOL;
    pbMoveIdent : REFTO BOOL;
    Status : tnCalibState;
    iOrder : DINT := 0;
    Group : tnCalibGroup := tnCalibGroup_NoCalib;
    bNameDummy : BOOL (* Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT *);
    bIgnoreMovement : BOOL (* Calibration should not start automatically *);
    DeviceId : tsDeviceId;
    MoveId : tMoveIdent;
    pConstFwdVis : REFTO tsVelPre;
    pConstBwdVis : REFTO tsVelPre;
    bPositionIncreasingFwd : BOOL;
    prStopRamp : REFTO REAL;
    pdMaxMoveTimeFwd : REFTO TIME;
    pdMaxMoveTimeBwd : REFTO TIME;
    sName : STRING(255);
    prMaxPressureFwd : REFTO REAL;
    prMaxPressureBwd : REFTO REAL;
    prMaxPressureFwdHydr : REFTO REAL;
    prMaxPressureBwdHydr : REFTO REAL;
    prIdentPressureFwd : REFTO REAL;
    prIdentPressureBwd : REFTO REAL;
    prSizeFactorFwd : REFTO REAL;
    prSizeFactorBwd : REFTO REAL;
    pdDelayTimeOffFwd : REFTO TIME;
    pdDelayTimeOffBwd : REFTO TIME;
   END_STRUCT (* properties of one calibration step *);
 tpIdentSpeedMovement : REFTO tsIdentSpeedMovement;
 tyIdentSpeedMovements : ARRAY  [1..cCalibMovements] OF tpIdentSpeedMovement;
 tsGlobalIdentSpeedStatus : 
   STRUCT 
    Command : tnCalibCommand (* command for starting / stopping calibration *);
    Status : tnCalibState (* status of overall calibration *);
    iCurrentStep : DINT;
    iMaxStep : DINT (* maximum number of automatic calibration, without tnCalibGroup_LintabOnly *);
    bInitDone : BOOL;
    pMovements : tyIdentSpeedMovements;
    bStart : BOOL;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 152 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
1 
@Constant @RT(18)cAutoIdentNoCycles @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)10 @RT(49)number of cycles for auto identification of ramps 
@END_Attrib 


@RT(17)TypeTreeContainer 
8 
@DT @RT(15)tsIdentMovement @RT(0) @T @T @STRUCT 0 10 

@StructElem @RT(5)bRedo @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)prMaxRampFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)prMaxRampBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pdDeadTimeFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pdDeadTimeBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)Status @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCalibState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(17)tnCalibState_None @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iOrder @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(1)0 @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Group @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCalibGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(20)tnCalibGroup_NoCalib @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bNameDummy @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT @RT(0) 
@END_Attrib 

@StructElem @RT(15)bIgnoreMovement @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)Calibration should not start automatically @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(65)(Status:=tnCalibState_None,iOrder:=0,Group:=tnCalibGroup_NoCalib) @RT(34)properties of one calibration step @RT(0) 
@END_Attrib 


@DT @RT(15)tpIdentMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(15)tsIdentMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyIdentMovements @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tpIdentMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cCalibMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsGlobalIdentStatus @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(7)Command @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnCalibCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)command for starting / stopping calibration @RT(0) 
@END_Attrib 

@StructElem @RT(6)Status @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCalibState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)status of overall calibration @RT(0) 
@END_Attrib 

@StructElem @RT(8)rMaxValX @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)maximum value, to display in lintab graph @RT(0) 
@END_Attrib 

@StructElem @RT(8)rMaxValY @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)iCurrentStep @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iMaxStep @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(72)maximum number of automatic calibration, without tnCalibGroup_LintabOnly @RT(0) 
@END_Attrib 

@StructElem @RT(9)bInitDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)pMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyIdentMovements @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)bStart @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(20)tsIdentSpeedMovement @RT(0) @T @T @STRUCT 0 37 

@StructElem @RT(5)bRedo @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)prPosition @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)prVelocityFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)prVelocityBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)prVelocityLimitFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)prVelocityLimitBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)prActVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)prStroke @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(23)rMaxPositionLimitFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(23)rMinPositionLimitFactor @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)prIdentPosition @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbStartIdent @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbMoveIdent @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)Status @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCalibState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iOrder @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(1)0 @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Group @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCalibGroup @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(20)tnCalibGroup_NoCalib @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bNameDummy @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT @RT(0) 
@END_Attrib 

@StructElem @RT(15)bIgnoreMovement @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)Calibration should not start automatically @RT(0) 
@END_Attrib 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)MoveId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pConstFwdVis @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pConstBwdVis @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(22)bPositionIncreasingFwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)prStopRamp @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)pdMaxMoveTimeFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)pdMaxMoveTimeBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)prMaxPressureFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)prMaxPressureBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)prMaxPressureFwdHydr @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)prMaxPressureBwdHydr @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)prIdentPressureFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)prIdentPressureBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)prSizeFactorFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)prSizeFactorBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)pdDelayTimeOffFwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)pdDelayTimeOffBwd @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(39)(iOrder:=0,Group:=tnCalibGroup_NoCalib) @RT(34)properties of one calibration step @RT(0) 
@END_Attrib 


@DT @RT(20)tpIdentSpeedMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(20)tsIdentSpeedMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tyIdentSpeedMovements @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(20)tpIdentSpeedMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cCalibMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tsGlobalIdentSpeedStatus @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(7)Command @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnCalibCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)command for starting / stopping calibration @RT(0) 
@END_Attrib 

@StructElem @RT(6)Status @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnCalibState @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)status of overall calibration @RT(0) 
@END_Attrib 

@StructElem @RT(12)iCurrentStep @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iMaxStep @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(72)maximum number of automatic calibration, without tnCalibGroup_LintabOnly @RT(0) 
@END_Attrib 

@StructElem @RT(9)bInitDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)pMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tyIdentSpeedMovements @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)bStart @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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
