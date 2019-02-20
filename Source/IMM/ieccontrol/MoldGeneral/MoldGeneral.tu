TYPE
 tnMoldHeightAdjustMode : (nPositionChange, nForceOpenLoop, nPositionSetTonnage, nForceClosedLoop, nElectricWithMoldPos, nDirectLock, nPressureOpenLoop) (* selected mode for mold height auto adjust *);
 tServoValveControlData : 
   STRUCT 
    bEnable : BOOL;
    rGainPFwd : REAL;
    rGainDFwd : REAL;
    rGainPBwd : REAL;
    rGainDBwd : REAL;
    bPositiveVoltageIncreasing : BOOL;
    bPositionIncreasing : BOOL;
    rGainOpenLoopFwd : REAL;
    rGainOpenLoopBwd : REAL;
   END_STRUCT;
 tServoValveControlSet : 
   STRUCT 
    rSetPos : REAL;
    rSetVel : REAL;
    rSetAccel : REAL;
    rSetJerk : REAL;
   END_STRUCT;
 tServoValveData : 
   STRUCT 
    rValveOffsetFwd : REAL;
    rValveOffsetBwd : REAL;
    rDeltaPNom : REAL;
    rQNom : REAL;
    rDeltaPNomPB : REAL;
    rQNomPB : REAL;
    bNominalAsysmmetric : BOOL;
   END_STRUCT;
 tServoValveConstructionData : 
   STRUCT 
    rPistonArea1 : REAL;
    rPistonArea2 : REAL;
    rVolume1 : REAL;
    rVolume2 : REAL;
    rMassMold : REAL;
    rMassPiston : REAL;
    rViscoseFrictonMold : REAL;
    rViscoseFrictonCylinder : REAL;
    rCoulombFrictonMold : REAL;
    rCoulombFrictonCylinder : REAL;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 112 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
5 
@DT @RT(22)tnMoldHeightAdjustMode @RT(0) @T @T @ENUM 0 7 
@EnumConst @RT(15)nPositionChange @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(61)position dependend adjustment (just move to another position) @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nForceOpenLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(85)pressure dependend adjustment (calculating a pressure value depending on force table) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nPositionSetTonnage @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(77)position dependend adjustment (known relation between increments and tonnage) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nForceClosedLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(65)pressure dependend adjustment (sensing the force inside the mold) @RT(0) 
@END_Attrib 
@EnumConst @RT(20)nElectricWithMoldPos @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)mold position dependent movement @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nDirectLock @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(58)mold position dependent movement with standstill detection @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nPressureOpenLoop @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(124)based on mode nForceOpenLoop; profile movement instead of constant movement for mold, clamp pressure value can be set in HMI @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)selected mode for mold height auto adjust @RT(0) 
@END_Attrib 


@DT @RT(22)tServoValveControlData @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(7)bEnable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rGainPFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rGainDFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rGainPBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rGainDBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(26)bPositiveVoltageIncreasing @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)bPositionIncreasing @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)rGainOpenLoopFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)rGainOpenLoopBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(21)tServoValveControlSet @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)rSetPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)rSetVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rSetAccel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)rSetJerk @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tServoValveData @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(15)rValveOffsetFwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)rValveOffsetBwd @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rDeltaPNom @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)rQNom @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rDeltaPNomPB @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)rQNomPB @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)bNominalAsysmmetric @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(27)tServoValveConstructionData @RT(0) @T @T @STRUCT 0 10 

@StructElem @RT(12)rPistonArea1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rPistonArea2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)rVolume1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)rVolume2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rMassMold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)rMassPiston @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)rViscoseFrictonMold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(23)rViscoseFrictonCylinder @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)rCoulombFrictonMold @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(23)rCoulombFrictonCylinder @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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
