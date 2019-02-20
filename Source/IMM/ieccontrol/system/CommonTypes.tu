TYPE
 tnMovementMode : (nPositionDependent, nLimitSwitchDependent, nMoveTimeDependent) (* nozzle movement mode *);
 tnMotorType : (nHydraulic, nElectric) (* mold adjust motor type *);
 tnCoreType : (nCoreOff, nCore) (* which type of core is used *);
 tnCoreInMode : (nBefMoldClose, nDuringMoldClose, nAfterMoldClose, nAfterMoldNutsClose, nAfterHighPress, nDuringInjection, nInBeforeRotation, nInAfterRotation, nInTP) (* when the core will move in *);
 tnCoreOutMode : (nBefMoldOpen, nDuringMoldOpen, nAfterMoldOpen, nBeforeHiPressRel, nAfterHiPressRel, nBeforeMoldNutsOpen, nOutBeforeRotation, nOutAfterRotation, nOutTP) (* when the core will move out *);
 tnValveGateMode : (nValveGatePos, nValveGateTime) (* valve gate modes (time oder pos. dependent) *);
 tnWorkPosMode : (nWorkPosSingle, nWorkPosDual, nWorkPosMulti) (* Rotary table mode *);
 tyWorkPosModePlaus : ARRAY  [1..2] OF tnWorkPosMode (* Rotary table mode plaus array *);
 tnTwoButtonOperationMode : (nPressButtonsToStartCylce, nPressButtonsTillHighPressure);
 tnICMActivateMode : (nDeactivate, nAfterInject, nInjectPosition, nInjectPressure);
 tnICMMode : (nParallelICM, nSequentialICM);
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
11 
@DT @RT(14)tnMovementMode @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(18)nPositionDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nLimitSwitchDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nMoveTimeDependent @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(20)nozzle movement mode @RT(0) 
@END_Attrib 


@DT @RT(11)tnMotorType @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(10)nHydraulic @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)hydraulic motor @RT(0) 
@END_Attrib 
@EnumConst @RT(9)nElectric @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)electric motor @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)mold adjust motor type @RT(0) 
@END_Attrib 


@DT @RT(10)tnCoreType @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(8)nCoreOff @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(19)do not use the core @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nCore @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)normal use of core, limit switch or time dependent @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)which type of core is used @RT(0) 
@END_Attrib 


@DT @RT(12)tnCoreInMode @RT(0) @T @T @ENUM 0 9 
@EnumConst @RT(13)nBefMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)before mold close @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nDuringMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)during mold close @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nAfterMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)after mold close @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nAfterMoldNutsClose @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)after mold nuts close (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nAfterHighPress @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)after high pressure build up (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nDuringInjection @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)during inject @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nInBeforeRotation @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)before rotation @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nInAfterRotation @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)after rotation @RT(0) 
@END_Attrib 
@EnumConst @RT(5)nInTP @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)in TP @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(26)when the core will move in @RT(0) 
@END_Attrib 


@DT @RT(13)tnCoreOutMode @RT(0) @T @T @ENUM 0 9 
@EnumConst @RT(12)nBefMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)before mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nDuringMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)during mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nAfterMoldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)after mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nBeforeHiPressRel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)before high pressure release (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nAfterHiPressRel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)after high pressure release (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(19)nBeforeMoldNutsOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)before mold nuts open (2 PL machines) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nOutBeforeRotation @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)before rotation @RT(0) 
@END_Attrib 
@EnumConst @RT(17)nOutAfterRotation @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)after rotation @RT(0) 
@END_Attrib 
@EnumConst @RT(6)nOutTP @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(6)out TP @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)when the core will move out @RT(0) 
@END_Attrib 


@DT @RT(15)tnValveGateMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(13)nValveGatePos @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nValveGateTime @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)valve gate modes (time oder pos. dependent) @RT(0) 
@END_Attrib 


@DT @RT(13)tnWorkPosMode @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(14)nWorkPosSingle @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(96)only close mold at one position, rotate before mold close and in other direction after mold open @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nWorkPosDual @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(69)close mold at each position, rotate in different direction each cycle @RT(0) 
@END_Attrib 
@EnumConst @RT(13)nWorkPosMulti @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(64)close mold at each position, rotate in same direction each cycle @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)Rotary table mode @RT(0) 
@END_Attrib 


@DT @RT(18)tyWorkPosModePlaus @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tnWorkPosMode @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(1)2 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)Rotary table mode plaus array @RT(0) 
@END_Attrib 


@DT @RT(24)tnTwoButtonOperationMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(25)nPressButtonsToStartCylce @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(38)press start buttons to start autocycle @RT(0) 
@END_Attrib 
@EnumConst @RT(29)nPressButtonsTillHighPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(72)keep start buttons pressed during mold close (until high pressure stage) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tnICMActivateMode @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(11)nDeactivate @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)deactivate @RT(0) 
@END_Attrib 
@EnumConst @RT(12)nAfterInject @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)start ICM movement after inject is done @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nInjectPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)start ICM movement after reaching the inject position @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nInjectPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)start ICM movement after reaching the inject pressure @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(9)tnICMMode @RT(0) @T @T @ENUM 0 2 
@EnumConst @RT(12)nParallelICM @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nSequentialICM @RT(0) @F @F 
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
