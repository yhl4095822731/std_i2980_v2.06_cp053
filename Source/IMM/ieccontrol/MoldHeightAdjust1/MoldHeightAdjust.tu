IMPORT_OVER_LISTFILE
 tnMoldHeightAdjustMode

END_IMPORT

TYPE
 tsMoldHeightPositions : 
   STRUCT 
    rMinMoldHeightPosition : REAL (* minimum mold height position *);
    rMaxMoldHeightPosition : REAL (* maximum mold height position *);
    rOriginMoldHeightPosition : REAL (* origin mold height position for calibrating the position *);
    rMoveToMoldHeightPosition : REAL (* move to position of mold height for mold height adjustment by position change *);
   END_STRUCT (* containing information about mold height position (if impulse measurement is available) *);
 tsMoldHeightSetupPosMeasurement : 
   STRUCT 
    rSecondPositionForCalculation : REAL (* second point after mold height origin has been set *);
    bDistancePerImpulseValid : BOOL (* shows if a valid number has been entered for the Distance per Impulse variables *);
   END_STRUCT (* for the setup of the position change per increment *);
 tsEndpointMonitor : 
   STRUCT 
    bLimitSwitchArrivedMin : BOOL (* minimum limit switch arrived *);
    bLimitSwitchArrivedMax : BOOL (* maximum limit switch arrived *);
    bStandStillTimeReached : BOOL (* standstill time reached *);
    bPositionForStepReached : BOOL (* desired position for this step reached *);
   END_STRUCT;
 tnMovementDirection : (nForward, nBackward) (* showing the current movement direction *);
 tyAdjustModePlaus : ARRAY  [1..6] OF tnMoldHeightAdjustMode;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 30 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
5 
@DT @RT(21)tsMoldHeightPositions @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(22)rMinMoldHeightPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)minimum mold height position @RT(0) 
@END_Attrib 

@StructElem @RT(22)rMaxMoldHeightPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)maximum mold height position @RT(0) 
@END_Attrib 

@StructElem @RT(25)rOriginMoldHeightPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(56)origin mold height position for calibrating the position @RT(0) 
@END_Attrib 

@StructElem @RT(25)rMoveToMoldHeightPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(77)move to position of mold height for mold height adjustment by position change @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(87)containing information about mold height position (if impulse measurement is available) @RT(0) 
@END_Attrib 


@DT @RT(31)tsMoldHeightSetupPosMeasurement @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(29)rSecondPositionForCalculation @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)second point after mold height origin has been set @RT(0) 
@END_Attrib 

@StructElem @RT(24)bDistancePerImpulseValid @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(79)shows if a valid number has been entered for the Distance per Impulse variables @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)for the setup of the position change per increment @RT(0) 
@END_Attrib 


@DT @RT(17)tsEndpointMonitor @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(22)bLimitSwitchArrivedMin @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)minimum limit switch arrived @RT(0) 
@END_Attrib 

@StructElem @RT(22)bLimitSwitchArrivedMax @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)maximum limit switch arrived @RT(0) 
@END_Attrib 

@StructElem @RT(22)bStandStillTimeReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)standstill time reached @RT(0) 
@END_Attrib 

@StructElem @RT(23)bPositionForStepReached @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)desired position for this step reached @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(19)tnMovementDirection @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(8)nForward @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nBackward @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)showing the current movement direction @RT(0) 
@END_Attrib 


@DT @RT(17)tyAdjustModePlaus @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(22)tnMoldHeightAdjustMode 1 @RT(1)1 @RT(1)6 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
