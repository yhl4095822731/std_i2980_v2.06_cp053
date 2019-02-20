IMPORT_OVER_LISTFILE
 tsVelPre
, cMaxIntermediateConditions

END_IMPORT

TYPE
 tnDecompMode : (nNotUsed, nTimeDependent, nPosDependent);
 tsDecompParam : 
   STRUCT 
    Mode : tnDecompMode;
    dDecompTime : TIME;
    rDecompPos : REAL;
    ConstOutput : tsVelPre;
    rStopRampVel : REAL;
   END_STRUCT;
 tnIntrusionMode : (nNotUse, nTimeDep);
 tsIntrusionParam : 
   STRUCT 
    Mode : tnIntrusionMode;
    dIntrusionTime : TIME;
    rBackPressure : REAL;
    ConstOutput : tsVelPre;
   END_STRUCT;
 tsPurgeInjectParams : 
   STRUCT 
    rEndPos : REAL;
    ConstOutput : tsVelPre;
   END_STRUCT;
 tsPurgeDecompParams : 
   STRUCT 
    rEndPos : REAL;
    ConstOutput : tsVelPre;
   END_STRUCT;
 tsPurgePlastParams : 
   STRUCT 
    dSetPlastTime : TIME;
    ConstOutput : tsVelPre;
   END_STRUCT;
 tsPurgeSettings : 
   STRUCT 
    iCount : DINT;
    dMaxPurgeTime : TIME;
    InjectParams : tsPurgeInjectParams;
    DecompParams : tsPurgeDecompParams;
    PlastParams : tsPurgePlastParams;
   END_STRUCT;
 tsActPurgeTimes : 
   STRUCT 
    dActPurgeTime : TIME;
    dActPlastTime : TIME;
   END_STRUCT;
 tsColdDropParams : 
   STRUCT 
    bUse : BOOL;
    dColdDropTime : TIME;
    ConstOutput : tsVelPre;
   END_STRUCT;
 tnDecompInterPosMode : (nDecompTimeDependent, nDecompPosDependent) (* used in propertie dialog *);
 tsInstanceListElementDecomp : 
   STRUCT 
    Mode : tnDecompInterPosMode;
    rTargetValue : REAL;
    dTime : TIME;
    rPressure : REAL;
    rVelocity : REAL;
    dDelay : TIME;
    dCalculatedDuration : TIME;
   END_STRUCT;
 tyInstanceListArrayDecomp : ARRAY  [1..cMaxIntermediateConditions] OF tsInstanceListElementDecomp;
 tsCombinedPlastElementData : 
   STRUCT 
    prTargetValue : REFTO REAL (* target value *);
    pdDelayTime : REFTO TIME (* delay time *);
    pdDuration : REFTO TIME (* calculated duration *);
    sODCIcon : STRING(31);
   END_STRUCT;
 tsCombinedPlastData : 
   STRUCT 
    DecompBefore : tsCombinedPlastElementData;
    Plast : tsCombinedPlastElementData;
    DecompAfter : tsCombinedPlastElementData;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
15 
@DT @RT(13)tsDecompParam @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tnDecompMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)dDecompTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rDecompPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ConstOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rStopRampVel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tnIntrusionMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(7)nNotUse @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(8)nTimeDep @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsIntrusionParam @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tnIntrusionMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)dIntrusionTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)rBackPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ConstOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(19)tsPurgeInjectParams @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)rEndPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ConstOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(19)tsPurgeDecompParams @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)rEndPos @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ConstOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(18)tsPurgePlastParams @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)dSetPlastTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ConstOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(15)tsPurgeSettings @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)dMaxPurgeTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)InjectParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsPurgeInjectParams @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)DecompParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsPurgeDecompParams @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)PlastParams @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tsPurgePlastParams @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(15)tsActPurgeTimes @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(13)dActPurgeTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)dActPlastTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(12)tnDecompMode @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(8)nNotUsed @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nTimeDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(13)nPosDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsColdDropParams @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(4)bUse @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)dColdDropTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)ConstOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(27)tsInstanceListElementDecomp @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(4)Mode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tnDecompInterPosMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)rTargetValue @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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

@StructElem @RT(6)dDelay @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)dCalculatedDuration @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(25)tyInstanceListArrayDecomp @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(27)tsInstanceListElementDecomp @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(26)cMaxIntermediateConditions 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tnDecompInterPosMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(20)nDecompTimeDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nDecompPosDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)used in propertie dialog @RT(0) 
@END_Attrib 


@DT @RT(26)tsCombinedPlastElementData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(13)prTargetValue @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)target value @RT(0) 
@END_Attrib 

@StructElem @RT(11)pdDelayTime @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)delay time @RT(0) 
@END_Attrib 

@StructElem @RT(10)pdDuration @RT(0) @T @T @REFTO 0 @T @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)calculated duration @RT(0) 
@END_Attrib 

@StructElem @RT(8)sODCIcon @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
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


@DT @RT(19)tsCombinedPlastData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(12)DecompBefore @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(26)tsCombinedPlastElementData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Plast @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(26)tsCombinedPlastElementData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)DecompAfter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(26)tsCombinedPlastElementData @RT(0) @T @T @UNKNOWN 0 @F 
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
