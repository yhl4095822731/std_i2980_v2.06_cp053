CONSTANT
 cCycleTimeError : DINT := 200 (* cycle time <= T#0s *);
 cNoValidParams : DINT := 201 (* calculation before parametrization *);
 cInvalidVelocityParams : DINT := 202 (* acceleration or velocity limit <= 0.0 *);
 cInvalidMovementLimits : DINT := 203 (* movement time <= T#0s, movemnt stroke < 0.0 *);
 cCyclicCalculationError : DINT := 204 (* cyclic calculation failed *);
END_CONSTANT



#END_OF_IEC_PART

@Puma @IecEditor 6 131 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
5 
@Constant @RT(15)cCycleTimeError @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)200 @RT(18)cycle time <= T#0s 
@END_Attrib 


@Constant @RT(14)cNoValidParams @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)201 @RT(34)calculation before parametrization 
@END_Attrib 


@Constant @RT(22)cInvalidVelocityParams @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)202 @RT(37)acceleration or velocity limit <= 0.0 
@END_Attrib 


@Constant @RT(22)cInvalidMovementLimits @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)203 @RT(43)movement time <= T#0s, movemnt stroke < 0.0 
@END_Attrib 


@Constant @RT(23)cCyclicCalculationError @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)204 @RT(25)cyclic calculation failed 
@END_Attrib 


@RT(17)TypeTreeContainer 
0 
@END_Export 

@END_Contents 
