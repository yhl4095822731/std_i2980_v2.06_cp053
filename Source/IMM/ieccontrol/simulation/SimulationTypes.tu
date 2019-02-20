IMPORT_OVER_LISTFILE
 cMaxZones

END_IMPORT

CONSTANT
 cTimeNutsOpen : TIME := t#1s;
 cTimeNutsClose : TIME := t#1s;
 cTimeSGAutoClose : TIME := t#3s;
 cTimeSGAutoOpen : TIME := t#3s;
 cTimeSGAutoLock : TIME := t#1s;
 cTimeSGAutoUnlock : TIME := t#1s;
 cTimeSGAutoFast : TIME := t#2s;
 cInjectSimuReduction : DINT := 50 (* reduction factor for simulation of inject, plast decomp *);
END_CONSTANT

TYPE
 tyZoneLinkedArray : ARRAY  [1..cMaxZones] OF BOOL;
 tsZoneSimData : 
   STRUCT 
    sHWName : STRING(255);
   END_STRUCT;
 tyZoneSimArray : ARRAY  [1..cMaxZones] OF tsZoneSimData;
 tsCavityParam : 
   STRUCT 
    rVolume : REAL;
    rViscosity : REAL;
    rFriction : REAL;
    rShrinking : REAL;
    uBendPoints : USINT;
    rBend1 : REAL;
    rBend1RelViscosity : REAL;
    rBend2 : REAL;
    rBend2RelViscosity : REAL;
    rBend3 : REAL;
    rBend3RelViscosity : REAL;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
8 
@Constant @RT(13)cTimeNutsOpen @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#1s @RT(0) 
@END_Attrib 


@Constant @RT(14)cTimeNutsClose @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#1s @RT(0) 
@END_Attrib 


@Constant @RT(16)cTimeSGAutoClose @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#3s @RT(0) 
@END_Attrib 


@Constant @RT(15)cTimeSGAutoOpen @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#3s @RT(0) 
@END_Attrib 


@Constant @RT(15)cTimeSGAutoLock @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#1s @RT(0) 
@END_Attrib 


@Constant @RT(17)cTimeSGAutoUnlock @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#1s @RT(0) 
@END_Attrib 


@Constant @RT(15)cTimeSGAutoFast @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)t#2s @RT(0) 
@END_Attrib 


@Constant @RT(20)cInjectSimuReduction @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)50 @RT(55)reduction factor for simulation of inject, plast decomp 
@END_Attrib 


@RT(17)TypeTreeContainer 
4 
@DT @RT(17)tyZoneLinkedArray @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tyZoneSimArray @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsZoneSimData @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(9)cMaxZones 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsZoneSimData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(7)sHWName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
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


@DT @RT(13)tsCavityParam @RT(0) @T @T @STRUCT 0 11 

@StructElem @RT(7)rVolume @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rViscosity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)rFriction @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rShrinking @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)uBendPoints @RT(0) @T @F @DT @RT(5)USINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)rBend1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)rBend1RelViscosity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)rBend2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)rBend2RelViscosity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)rBend3 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)rBend3RelViscosity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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
