IMPORT_OVER_LISTFILE
 tsVelPre

END_IMPORT

TYPE
 tsMoldHeightOutput : 
   STRUCT 
    rMaxAdjustPressure : REAL (* maximum value for pressure that can be set for the movements *);
    rMaxAdjustVelocity : REAL (* maximum value for velocity that can be set for the movements *);
    MoldHeightForward : tsVelPre (* output values for mold height forward movement *);
    MoldHeightBackward : tsVelPre (* output values for mold height backward movement *);
   END_STRUCT (* output values for mold height adjust movement *);
 tsEndpointMonitor : 
   STRUCT 
    bLimitSwitchArrivedMin : BOOL (* minimum limit switch arrived *);
    bLimitSwitchArrivedMax : BOOL (* maximum limit switch arrived *);
    bStandStillTimeReached : BOOL (* standstill time reached *);
    bPositionForStepReached : BOOL (* desired position for this step reached *);
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 60 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
2 
@DT @RT(18)tsMoldHeightOutput @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(18)rMaxAdjustPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(60)maximum value for pressure that can be set for the movements @RT(0) 
@END_Attrib 

@StructElem @RT(18)rMaxAdjustVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(60)maximum value for velocity that can be set for the movements @RT(0) 
@END_Attrib 

@StructElem @RT(17)MoldHeightForward @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)output values for mold height forward movement @RT(0) 
@END_Attrib 

@StructElem @RT(18)MoldHeightBackward @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)output values for mold height backward movement @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(45)output values for mold height adjust movement @RT(0) 
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


@END_Export 

@END_Contents 
