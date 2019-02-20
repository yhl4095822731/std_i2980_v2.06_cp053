%IMPORT_OVER_LISTFILE_SOURCE
 PowerWatt
, fmt50
, VG_MachineData
, YesNo
, kWh
, fmt43
, Energy
, EnergyPartMass
, EnergyShotVolume
, Mass
, fmt42
, Power
, fmt52
, VG_MoldData
, fmt14

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tyHeatingPower
, cLevelServiceEngineer
, cLevelProcessOperator
, cLevelProduction

END_IMPORT

%SYSTEMVAR_DECL
  sv_NozzleHeatingPower : tyHeatingPower (* heating power *)
 %PLAUSIBILITY 0.0..99999.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt50  %UNIT PowerWatt 
// Power Nozzle heating power
;
 sv_MoldHeatingPower : tyHeatingPower (* heating power *)
 %PLAUSIBILITY 0.0..99999.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt50  %UNIT PowerWatt 
// Power Mold heating power
;
 sv_bResetTotEnergy : BOOL (* reset energy *)
     %INPUT_LEVEL cLevelProduction
 %FORMAT YesNo 
// Reset Reset energy
;
 sv_rEnergyProduction : REAL (* energy per production *)
     %FORMAT fmt43  %UNIT kWh 
// Production Production
;
 sv_rEnergyPart : REAL (* energy per part *)
     %FORMAT fmt43  %UNIT Energy 
// Part Part
;
 sv_rEnergyPartMass : REAL (* energy in part mass *)
     %FORMAT fmt43  %UNIT EnergyPartMass 
// Part mass Part mass
;
 sv_rEnergyShot : REAL (* energy per shot *)
 %PLAUSIBILITY 0.0..70.0      %FORMAT fmt43  %UNIT Energy 
// Per shot Per shot
;
 sv_rEnergyShotVolume : REAL (* energy in shot volume *)
     %FORMAT fmt43  %UNIT EnergyShotVolume 
// Shot volume Shot volume
;
 sv_rPartMass : REAL (* part mass *)
 %PLAUSIBILITY 0.00..9999.99      %INPUT_LEVEL cLevelProduction
 %FORMAT fmt42  %UNIT Mass 
// Part mass Part mass
;
 sv_rHeatingPower : REAL (* heating power *)
 %PLAUSIBILITY 0.0..5000.0      %FORMAT fmt42  %UNIT PowerWatt 
// Heating Heating power
;
 sv_rMotorPower : REAL (* motor power *)
 %PLAUSIBILITY 0.0..5.0      %FORMAT fmt43  %UNIT Power 
// Motor Motor Power
;
 sv_rTotalPower : REAL (* total power *)
 %PLAUSIBILITY 0.00..5.0      %FORMAT fmt43  %UNIT Power 
// Sum Sum of power
;
 sv_rTotalEnergy : REAL (* total energy *)
 %PLAUSIBILITY 0.00..4000000000.00    %FAST_RETAIN  %FORMAT fmt52  %UNIT kWh 
// Sum Sum of energy
;
 sv_rIdlePower : REAL (* Power in idle state *)
 %PLAUSIBILITY 0.0..9999.99    RETAIN  %VARIABLE_GROUP VG_MoldData  %FORMAT fmt42  %UNIT PowerWatt 
// Idle Idle Power
;
 sv_rEfficiency : REAL := 0.81 (* efficiency of motor + drive *)
 %PLAUSIBILITY 0.0000..0.9999    RETAIN  %VARIABLE_GROUP VG_MachineData  %FORMAT fmt14 
// Efficiency Efficiency
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 127 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
15 
@SysVar @RT(21)sv_NozzleHeatingPower @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tyHeatingPower @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)heating power 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt50 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(12)0.0..99999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Power @RT(20)Nozzle heating power @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_NozzleHeatingPower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt50 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(12)0.0..99999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Power @RT(20)Nozzle heating power @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoldHeatingPower @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tyHeatingPower @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)heating power 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt50 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(12)0.0..99999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Power @RT(18)Mold heating power @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_MoldHeatingPower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt50 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(12)0.0..99999.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Power @RT(18)Mold heating power @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bResetTotEnergy @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)reset energy 
@RT(0) @RT(16)cLevelProduction @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Reset @RT(12)Reset energy @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bResetTotEnergy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Reset @RT(12)Reset energy @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rEnergyProduction @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)energy per production 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(3)kWh @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Production @RT(10)Production @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rEnergyProduction @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(3)kWh @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Production @RT(10)Production @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rEnergyPart @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)energy per part 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(6)Energy @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Part @RT(4)Part @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_rEnergyPart @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(6)Energy @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Part @RT(4)Part @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rEnergyPartMass @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)energy in part mass 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(14)EnergyPartMass @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Part mass @RT(9)Part mass @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rEnergyPartMass @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)energy per part 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(14)EnergyPartMass @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Part mass @RT(9)Part mass @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rEnergyShot @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)energy per shot 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(6)Energy @RT(0) @RT(0) 
@RT(9)0.0..70.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Per shot @RT(8)Per shot @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_rEnergyShot @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(6)Energy @RT(0) @RT(0) 
@RT(9)0.0..70.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Per shot @RT(8)Per shot @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_rEnergyShotVolume @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)energy in shot volume 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(16)EnergyShotVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Shot volume @RT(11)Shot volume @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_rEnergyShotVolume @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(16)EnergyShotVolume @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Shot volume @RT(11)Shot volume @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rPartMass @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(9)part mass 
@RT(0) @RT(16)cLevelProduction @RT(0) @RT(5)fmt42 @RT(4)Mass @RT(0) @RT(0) 
@RT(13)0.00..9999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Part mass @RT(9)Part mass @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rPartMass @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(9)part mass 
@RT(0) @RT(16)cLevelProduction @RT(0) @RT(5)fmt42 @RT(4)Mass @RT(0) @RT(0) 
@RT(13)0.00..9999.99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Part mass @RT(9)Part mass @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_rHeatingPower @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)heating power 
@RT(0) @RT(0) @RT(0) @RT(5)fmt42 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(11)0.0..5000.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Heating @RT(13)Heating power @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_rHeatingPower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)heating power 
@RT(0) @RT(0) @RT(0) @RT(5)fmt42 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(11)0.0..5000.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Heating @RT(13)Heating power @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rMotorPower @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)motor power 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(5)Power @RT(0) @RT(0) 
@RT(8)0.0..5.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Motor @RT(11)Motor Power @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_rMotorPower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)motor power 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(5)Power @RT(0) @RT(0) 
@RT(8)0.0..5.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Motor @RT(11)Motor Power @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rTotalPower @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)total power 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(5)Power @RT(0) @RT(0) 
@RT(9)0.00..5.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Sum @RT(12)Sum of power @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_rTotalPower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)total power 
@RT(0) @RT(0) @RT(0) @RT(5)fmt43 @RT(5)Power @RT(0) @RT(0) 
@RT(9)0.00..5.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Sum @RT(12)Sum of power @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_rTotalEnergy @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)total energy 
@RT(0) @RT(0) @RT(0) @RT(5)fmt52 @RT(3)kWh @RT(0) @RT(0) 
@RT(19)0.00..4000000000.00 @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Sum @RT(13)Sum of energy @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_rTotalEnergy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)total energy 
@RT(0) @RT(0) @RT(0) @RT(5)fmt52 @RT(3)kWh @RT(0) @RT(0) 
@RT(19)0.00..4000000000.00 @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Sum @RT(13)Sum of energy @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_rIdlePower @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)Power in idle state 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(5)fmt42 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(12)0.0..9999.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Idle @RT(10)Idle Power @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_rIdlePower @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)Power in standstill state 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(5)fmt42 @RT(9)PowerWatt @RT(0) @RT(0) 
@RT(12)0.0..9999.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Idle @RT(10)Idle Power @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_rEfficiency @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)0.81 @RT(27)efficiency of motor + drive 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt14 @RT(0) @RT(0) @RT(0) 
@RT(14)0.0000..0.9999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Efficiency @RT(10)Efficiency @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_rEfficiency @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)efficiency of motor + drive 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(5)fmt14 @RT(0) @RT(0) @RT(0) 
@RT(14)0.0000..0.9999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Efficiency @RT(10)Efficiency @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
0 

@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
