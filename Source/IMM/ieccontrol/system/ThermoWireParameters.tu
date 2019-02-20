TYPE
 tsThermoWireData : 
   STRUCT 
    bIsUsed : BOOL (* is temperaturecompensation used? *);
    rCableLength : REAL (* Length of cable [m] *);
    rWireDiameter : REAL (* Diameter of cable [mm] *);
    rWireCrossSection : REAL (* Cross section of cable [mm²] *);
   END_STRUCT (* Data for temperaturecompensation *);
 tyThermoWireData : ARRAY  [0..7] OF tsThermoWireData;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 127 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
2 
@DT @RT(16)tsThermoWireData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)bIsUsed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)is temperaturecompensation used? @RT(0) 
@END_Attrib 

@StructElem @RT(12)rCableLength @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)Length of cable [m] @RT(0) 
@END_Attrib 

@StructElem @RT(13)rWireDiameter @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)Diameter of cable [mm] @RT(0) 
@END_Attrib 

@StructElem @RT(17)rWireCrossSection @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)Cross section of cable [mm²] @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)Data for temperaturecompensation @RT(0) 
@END_Attrib 


@DT @RT(16)tyThermoWireData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(16)tsThermoWireData 1 @RT(1)0 @RT(1)7 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
