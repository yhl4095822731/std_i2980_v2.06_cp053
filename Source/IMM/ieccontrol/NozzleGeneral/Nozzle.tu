TYPE
 tnNozzleBackMode : (nNoNozzleBack, nAfterPlast, nBeforeMoldOpen, nAfterInjection);
 tnNozzleMovementMode : (nNozzleMovementModePosition, nNozzleMovementModeTime) (* nozzle movement depending on AppCo settings (transducer or limit switch) or time dependent *);
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
@DT @RT(16)tnNozzleBackMode @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(13)nNoNozzleBack @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nAfterPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nBeforeMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nAfterInjection @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tnNozzleMovementMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(27)nNozzleMovementModePosition @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(69)nozzle moves according to Appco settings (transducer or limit switch) @RT(0) 
@END_Attrib 
@EnumConst @RT(23)nNozzleMovementModeTime @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)nozzle moves time depending @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(90)nozzle movement depending on AppCo settings (transducer or limit switch) or time dependent @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
