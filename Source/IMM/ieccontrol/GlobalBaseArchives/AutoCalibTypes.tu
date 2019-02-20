IMPORT_OVER_LISTFILE
 KCTRL_ZFunction_Data
, KAPPL_LintabData
, tyLintabPoints
, tMoveIdent
, KAPPL_CalibMeasArray
, KAPPL_CalibMeasArrayUDINT
, tsValveCharacteristic
, tsDeviceId
, tsMoveData
, tnCalibState_None
, tnCalibGroup_NoCalib

END_IMPORT

CONSTANT
 cMaxShiftData : DINT := 19 (* how often to shift the signal to the left for identifying the plant( 1 time shifting = x msec) *);
 cMaxHalfSize : DINT := 4000 (* size of array which holds one  falling/raising edge *);
 cMaxInjectionCount : DINT := 3 (* how often to do injection for calibration *);
 cMaxRecordedData : DINT := 16000 (* size of measurement array. minimum cycle time = 2ms -> 10 seconds *);
 cCalibMovements : DINT := 30;
 cCalibErrorInitFailure : DINT := 111 (* Failure at init  *);
 cCalibErrorParFailure : DINT := 112 (* Failure at par *);
 cCalibOK : DINT := 0;
 cCalibErrorWrongGain : DINT := 113 (* Gain is not possible => wrong calibration *);
 cCalibErrorWrongCoefficient : DINT := 114 (* Wrong coefficients => wrong calibration *);
 cCalibErrorQualityCriterion : DINT := 115 (* Wrong coefficients => wrong calibration *);
 cMaxCalibServoATData : DINT := 20;
 cCalibFilePres : STRING(255) := 'CalibPumpPres' (* Filename for Pump Pressure Calib Debug-Log *);
 cCalibFileVel : STRING(255) := 'CalibPumpVel' (* Filename for Pump Velocity Calib Debug-Log *);
 cCalibFileRpm : STRING(255) := 'CalibRpm' (* Filename for RPM Calib Debug-Log *);
 cCalibFileServoPres : STRING(255) := 'CalibServoPres' (* Filename for Servo Pressure Calib Debug-Log *);
 cCalibFileServoVel : STRING(255) := 'CalibServoVel' (* Filename for Servo Velocity Calib Debug-Log *);
 cCalibFileServoAT : STRING(255) := 'CalibServoAT' (* Filename for Servo AT Calib Debug-Log *);
 cMaxCalibDevices : DINT := 25 (* maximum number of devices which can be used for pump calibration *);
 cCalibShiftData : STRING(31) := 'ShiftData' (* name of dynamic array for Shift Data *);
 cCalibMeasuredOutput : STRING(31) := 'MeasuredOutput' (* name of dynamic array for measured output values (used during automatic detection of PID parameters) *);
 cCalibMeasuredVel : STRING(31) := 'MeasuredVel' (* name of dynamic array for measured velocities (used during automatic detection of PID parameters) *);
 cCalibMeasuredPos : STRING(31) := 'MeasuredPos' (* name of dynamic array for measured positions (used during automatic detection of PID parameters) *);
 cCalibMeasuredPres : STRING(31) := 'MeasuredPres' (* name of dynamic array for measured pressure (used during automatic detection of PID parameters) *);
 cCalibDifferenced : STRING(31) := 'Differenced' (* name of dynamic array wich is used during automatic detection of PID parameters *);
 cCalibSecondStage : STRING(31) := 'SecondStage' (* name of dynamic array wich is used during automatic detection of PID parameters *);
 cCalibThirdStage : STRING(31) := 'ThirdStage' (* name of dynamic array wich is used during automatic detection of PID parameters *);
 cCalibInvalidHandle : DINT := 116;
END_CONSTANT

TYPE
 tyCaptureArray : ARRAY  [1..cMaxRecordedData] OF REAL (* array for recording the whole injection process *);
 tyHalfArray : ARRAY  [1..cMaxHalfSize] OF REAL;
 tsCalibShiftData : 
   STRUCT 
    DebugZOutArray : tyHalfArray;
    ZFunctionData : KCTRL_ZFunction_Data;
    rQuadraticError : REAL;
   END_STRUCT;
 tsCalculatedInjectData : 
   STRUCT 
    rControllerKR : REAL;
    rControllerW : REAL;
    tControllerTN : TIME (* integral part *);
    rPlantK : REAL;
    tPlantT1 : TIME;
    tPlantT2 : TIME;
    tPlantDeadTime : TIME;
   END_STRUCT (* controller parameters for one edge (falling / raising) *);
 tnCalibMode : (tnCalibMode_Raising, tnCalibMode_Falling, tnCalibMode_Both);
 tsCalculatedInjectData2 : 
   STRUCT 
    bValid : BOOL;
    bInvalid : BOOL;
    CalibMode : tnCalibMode;
    Falling : tsCalculatedInjectData;
    Raising : tsCalculatedInjectData;
    rPhasemargin : REAL;
    rPhasemargin3dB : REAL;
    rPhasemarginMin3dB : REAL;
   END_STRUCT;
 tyCalculatedDataArray : ARRAY  [1..cMaxInjectionCount] OF tsCalculatedInjectData2 (* array of all calculated controller parameters *);
 tnForceDimension : (tnForceDimension_X, tnForceDimension_Y);
 tnCalibState : (tnCalibState_None, tnCalibState_Running, tnCalibState_Done, tnCalibState_Error, tnCalibState_Aborted, tnCalibState_Skipped);
 tnCalibGroup : (tnCalibGroup_NoCalib, tnCalibGroup_Transducer, tnCalibGroup_Pressure, tnCalibGroup_Velocity, tnCalibGroup_ClosedLoop, tnCalibGroup_Other, tnCalibGroup_LintabOnly);
 tsCalibMovement : 
   STRUCT 
    pLintab : REFTO KAPPL_LintabData;
    pLintabPoints : REFTO tyLintabPoints (* reference to lintab points (open array!) *);
    piUsedLintabPoints : REFTO UDINT (* reference to number of used lintab points *);
    pDisplayLintab : REFTO KAPPL_LintabData (* should be folded into one REFTO to tsGlobalCalibStatus, but compiler does not like it *);
    prMaxValue : REFTO REAL;
    prGlobalMaxX : REFTO REAL (* should be folded into one REFTO to tsGlobalCalibStatus, but compiler does not like it *);
    prGlobalMaxY : REFTO REAL (* should be folded into one REFTO to tsGlobalCalibStatus, but compiler does not like it *);
    prInputSensor : REFTO REAL (* input sensor (for transdusers e.g. Ejector1.ai_Position) *);
    prForceOutput : REFTO REAL (* output to force  (e.g. pump pressure, velocity) *);
    ForceDimension : tnForceDimension (* which dimension of the lintab to force *);
    bRedo : BOOL;
    Status : tnCalibState := tnCalibState_None;
    iOrder : DINT := 0;
    Group : tnCalibGroup := tnCalibGroup_NoCalib;
    bNameDummy : BOOL (* Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT *);
    bIgnoreMovement : BOOL (* Calibration should not start automatically *);
   END_STRUCT (* properties of one calibration step *);
 tnCalibCommand : (tnCalibCommand_None, tnCalibCommand_Start, tnCalibCommand_Stop);
 tpCalibMovement : REFTO tsCalibMovement;
 tyMovements : ARRAY  [1..cCalibMovements] OF tpCalibMovement;
 tsGlobalCalibStatus : 
   STRUCT 
    Command : tnCalibCommand (* command for starting / stopping calibration *);
    Status : tnCalibState (* status of overall calibration *);
    Lintab : KAPPL_LintabData (* lintab to display *);
    pUnitLintab : REFTO KAPPL_LintabData (* this lintab is only used to get the units for the diagram, unused from KePlast 2.00 on *);
    rMaxValX : REAL (* maximum value, to display in lintab graph *);
    rMaxValY : REAL;
    iCurrentMovement : DINT (* index of the current calibration movement in pMovements *);
    iCurrentStep : DINT;
    iMaxStep : DINT (* maximum number of automatic calibration, without tnCalibGroup_LintabOnly *);
    bInitDone : BOOL;
    pMovements : tyMovements;
   END_STRUCT;
 tyCalibShiftData : ARRAY  [1..cMaxShiftData] OF tsCalibShiftData;
 tevAutoCalibLogData : 
   STRUCT 
    name : STRING(255);
    string : STRING(255);
   END_STRUCT;
 tevAutoCalibLog : EVENT WITH tevAutoCalibLogData;
 tyOpenArray : ARRAY  [] OF REAL;
 tsTransducerCalibData : 
   STRUCT 
    Dir1 : tMoveIdent;
    Dir2 : tMoveIdent;
    Id1 : tMoveIdent;
    Id2 : tMoveIdent;
    bReverse : BOOL (* Write first calib result to second point in lintab *);
    prPos1 : REFTO REAL;
    prPos2 : REFTO REAL;
   END_STRUCT;
 tsCalibServoATData : 
   STRUCT 
    bValid : BOOL (* segment valid *);
    uSegmentNoAT : UDINT (* no of AT characterisitic segment *);
    rStepSize : REAL (* actual step size *);
    iCount : DINT;
    iDataLen : DINT;
    SetPressure : KAPPL_CalibMeasArray;
    ActPressure : KAPPL_CalibMeasArray;
    uActSegmentNoAT : KAPPL_CalibMeasArrayUDINT;
    ValveCharacteristicAT : tsValveCharacteristic;
   END_STRUCT;
 tsPumpCalibError : 
   STRUCT 
    bError : BOOL;
    iErrorInfo : DINT;
   END_STRUCT;
 tsCalibDeviceElement : 
   STRUCT 
    DeviceId : tsDeviceId;
    pVelCalibStartPosMovement : REFTO tsMoveData (* reference to movement to velocity calib start position *);
    pVelCalibMovement : REFTO tsMoveData (* reference to movement for pump velocity calib *);
    pPresCalibStartPosMovement : REFTO tsMoveData (* reference to movement to pressure calib start position *);
    pPresCalibMovement : REFTO tsMoveData (* reference to movement for pump pressure calib *);
    prActVelocity : REFTO REAL (* reference to actual velocity *);
    prActPressure : REFTO REAL (* reference to actual pressure *);
   END_STRUCT;
 tyCalibDevices : ARRAY  [1..cMaxCalibDevices] OF tsCalibDeviceElement;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 103 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
28 
@Constant @RT(13)cMaxShiftData @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)19 @RT(94)how often to shift the signal to the left for identifying the plant( 1 time shifting = x msec) 
@END_Attrib 


@Constant @RT(12)cMaxHalfSize @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)4000 @RT(51)size of array which holds one  falling/raising edge 
@END_Attrib 


@Constant @RT(18)cMaxInjectionCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(41)how often to do injection for calibration 
@END_Attrib 


@Constant @RT(16)cMaxRecordedData @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16000 @RT(65)size of measurement array. minimum cycle time = 2ms -> 10 seconds 
@END_Attrib 


@Constant @RT(15)cCalibMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)30 @RT(0) 
@END_Attrib 


@Constant @RT(22)cCalibErrorInitFailure @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)111 @RT(16)Failure at init  
@END_Attrib 


@Constant @RT(21)cCalibErrorParFailure @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)112 @RT(14)Failure at par 
@END_Attrib 


@Constant @RT(8)cCalibOK @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(20)cCalibErrorWrongGain @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)113 @RT(41)Gain is not possible => wrong calibration 
@END_Attrib 


@Constant @RT(27)cCalibErrorWrongCoefficient @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)114 @RT(39)Wrong coefficients => wrong calibration 
@END_Attrib 


@Constant @RT(27)cCalibErrorQualityCriterion @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)115 @RT(39)Wrong coefficients => wrong calibration 
@END_Attrib 


@Constant @RT(20)cMaxCalibServoATData @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(0) 
@END_Attrib 


@Constant @RT(14)cCalibFilePres @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(15)'CalibPumpPres' @RT(42)Filename for Pump Pressure Calib Debug-Log 
@END_Attrib 


@Constant @RT(13)cCalibFileVel @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(14)'CalibPumpVel' @RT(42)Filename for Pump Velocity Calib Debug-Log 
@END_Attrib 


@Constant @RT(13)cCalibFileRpm @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(10)'CalibRpm' @RT(32)Filename for RPM Calib Debug-Log 
@END_Attrib 


@Constant @RT(19)cCalibFileServoPres @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(16)'CalibServoPres' @RT(43)Filename for Servo Pressure Calib Debug-Log 
@END_Attrib 


@Constant @RT(18)cCalibFileServoVel @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(15)'CalibServoVel' @RT(43)Filename for Servo Velocity Calib Debug-Log 
@END_Attrib 


@Constant @RT(17)cCalibFileServoAT @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(14)'CalibServoAT' @RT(37)Filename for Servo AT Calib Debug-Log 
@END_Attrib 


@Constant @RT(16)cMaxCalibDevices @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)25 @RT(64)maximum number of devices which can be used for pump calibration 
@END_Attrib 


@Constant @RT(15)cCalibShiftData @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(11)'ShiftData' @RT(36)name of dynamic array for Shift Data 
@END_Attrib 


@Constant @RT(20)cCalibMeasuredOutput @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(16)'MeasuredOutput' @RT(100)name of dynamic array for measured output values (used during automatic detection of PID parameters) 
@END_Attrib 


@Constant @RT(17)cCalibMeasuredVel @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(13)'MeasuredVel' @RT(97)name of dynamic array for measured velocities (used during automatic detection of PID parameters) 
@END_Attrib 


@Constant @RT(17)cCalibMeasuredPos @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(13)'MeasuredPos' @RT(96)name of dynamic array for measured positions (used during automatic detection of PID parameters) 
@END_Attrib 


@Constant @RT(18)cCalibMeasuredPres @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(14)'MeasuredPres' @RT(95)name of dynamic array for measured pressure (used during automatic detection of PID parameters) 
@END_Attrib 


@Constant @RT(17)cCalibDifferenced @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(13)'Differenced' @RT(79)name of dynamic array wich is used during automatic detection of PID parameters 
@END_Attrib 


@Constant @RT(17)cCalibSecondStage @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(13)'SecondStage' @RT(79)name of dynamic array wich is used during automatic detection of PID parameters 
@END_Attrib 


@Constant @RT(16)cCalibThirdStage @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(12)'ThirdStage' @RT(79)name of dynamic array wich is used during automatic detection of PID parameters 
@END_Attrib 


@Constant @RT(19)cCalibInvalidHandle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)116 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
24 
@DT @RT(14)tyCaptureArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxRecordedData 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)array for recording the whole injection process @RT(0) 
@END_Attrib 


@DT @RT(16)tsCalibShiftData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(14)DebugZOutArray @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyHalfArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)ZFunctionData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KCTRL_ZFunction_Data @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rQuadraticError @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(11)tyHalfArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(12)cMaxHalfSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tsCalculatedInjectData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(13)rControllerKR @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rControllerW @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)tControllerTN @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)integral part @RT(0) 
@END_Attrib 

@StructElem @RT(7)rPlantK @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)tPlantT1 @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)tPlantT2 @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)tPlantDeadTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(54)controller parameters for one edge (falling / raising) @RT(0) 
@END_Attrib 


@DT @RT(23)tsCalculatedInjectData2 @RT(0) @T @T @STRUCT 0 8 

@StructElem @RT(6)bValid @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)bInvalid @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)CalibMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tnCalibMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)Falling @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsCalculatedInjectData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)Raising @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsCalculatedInjectData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rPhasemargin @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rPhasemargin3dB @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)rPhasemarginMin3dB @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(21)tyCalculatedDataArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(23)tsCalculatedInjectData2 @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cMaxInjectionCount 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)array of all calculated controller parameters @RT(0) 
@END_Attrib 


@DT @RT(11)tnCalibMode @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(19)tnCalibMode_Raising @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)tnCalibMode_Falling @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)tnCalibMode_Both @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tnForceDimension @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(18)tnForceDimension_X @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)tnForceDimension_Y @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsCalibMovement @RT(0) @T @T @STRUCT 0 16 

@StructElem @RT(7)pLintab @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)pLintabPoints @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(14)tyLintabPoints @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(40)reference to lintab points (open array!) @RT(0) 
@END_Attrib 

@StructElem @RT(18)piUsedLintabPoints @RT(0) @T @T @REFTO 0 @T @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)reference to number of used lintab points @RT(0) 
@END_Attrib 

@StructElem @RT(14)pDisplayLintab @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(85)should be folded into one REFTO to tsGlobalCalibStatus, but compiler does not like it @RT(0) 
@END_Attrib 

@StructElem @RT(10)prMaxValue @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)prGlobalMaxX @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(85)should be folded into one REFTO to tsGlobalCalibStatus, but compiler does not like it @RT(0) 
@END_Attrib 

@StructElem @RT(12)prGlobalMaxY @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(85)should be folded into one REFTO to tsGlobalCalibStatus, but compiler does not like it @RT(0) 
@END_Attrib 

@StructElem @RT(13)prInputSensor @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(56)input sensor (for transdusers e.g. Ejector1.ai_Position) @RT(0) 
@END_Attrib 

@StructElem @RT(13)prForceOutput @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)output to force  (e.g. pump pressure, velocity) @RT(0) 
@END_Attrib 

@StructElem @RT(14)ForceDimension @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tnForceDimension @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)which dimension of the lintab to force @RT(0) 
@END_Attrib 

@StructElem @RT(5)bRedo @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tnCalibCommand @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(19)tnCalibCommand_None @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(20)tnCalibCommand_Start @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)tnCalibCommand_Stop @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tnCalibState @RT(0) @T @T @ENUM 0 6 
@EnumConst @RT(17)tnCalibState_None @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(20)tnCalibState_Running @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)calibration in progress @RT(0) 
@END_Attrib 
@EnumConst @RT(17)tnCalibState_Done @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)calibration finished successfully @RT(0) 
@END_Attrib 
@EnumConst @RT(18)tnCalibState_Error @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)error occured during calibration @RT(0) 
@END_Attrib 
@EnumConst @RT(20)tnCalibState_Aborted @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)calibration aborted @RT(0) 
@END_Attrib 
@EnumConst @RT(20)tnCalibState_Skipped @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)movement not activated @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tsGlobalCalibStatus @RT(0) @T @T @STRUCT 0 11 

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

@StructElem @RT(6)Lintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)lintab to display @RT(0) 
@END_Attrib 

@StructElem @RT(11)pUnitLintab @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(86)this lintab is only used to get the units for the diagram, unused from KePlast 2.00 on @RT(0) 
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

@StructElem @RT(16)iCurrentMovement @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(55)index of the current calibration movement in pMovements @RT(0) 
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

@StructElem @RT(10)pMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tyMovements @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(16)tyCalibShiftData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tsCalibShiftData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(13)cMaxShiftData 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tevAutoCalibLog @RT(0) @T @T @EVENT 0 @RT(19)tevAutoCalibLogData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tevAutoCalibLogData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)name @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)string @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
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


@DT @RT(11)tyOpenArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)0 @RT(1)0 0 @T @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(11)tyMovements @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tpCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(15)cCalibMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tpCalibMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(15)tsCalibMovement @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tnCalibGroup @RT(0) @T @T @ENUM 0 7 
@EnumConst @RT(20)tnCalibGroup_NoCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)tnCalibGroup_Transducer @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)tnCalibGroup_Pressure @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)tnCalibGroup_Velocity @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)tnCalibGroup_ClosedLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)tnCalibGroup_Other @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)tnCalibGroup_LintabOnly @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsTransducerCalibData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(4)Dir1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Dir2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)Id1 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)Id2 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tMoveIdent @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)bReverse @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)Write first calib result to second point in lintab @RT(0) 
@END_Attrib 

@StructElem @RT(6)prPos1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)prPos2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(18)tsCalibServoATData @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(6)bValid @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)segment valid @RT(0) 
@END_Attrib 

@StructElem @RT(12)uSegmentNoAT @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)no of AT characterisitic segment @RT(0) 
@END_Attrib 

@StructElem @RT(9)rStepSize @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)actual step size @RT(0) 
@END_Attrib 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iDataLen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)SetPressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KAPPL_CalibMeasArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ActPressure @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)KAPPL_CalibMeasArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)uActSegmentNoAT @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)KAPPL_CalibMeasArrayUDINT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(21)ValveCharacteristicAT @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsValveCharacteristic @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(16)tsPumpCalibError @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(6)bError @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)iErrorInfo @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(20)tsCalibDeviceElement @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(8)DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(25)pVelCalibStartPosMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(54)reference to movement to velocity calib start position @RT(0) 
@END_Attrib 

@StructElem @RT(17)pVelCalibMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)reference to movement for pump velocity calib @RT(0) 
@END_Attrib 

@StructElem @RT(26)pPresCalibStartPosMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(54)reference to movement to pressure calib start position @RT(0) 
@END_Attrib 

@StructElem @RT(18)pPresCalibMovement @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)reference to movement for pump pressure calib @RT(0) 
@END_Attrib 

@StructElem @RT(13)prActVelocity @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)reference to actual velocity @RT(0) 
@END_Attrib 

@StructElem @RT(13)prActPressure @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)reference to actual pressure @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyCalibDevices @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(20)tsCalibDeviceElement @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxCalibDevices 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
