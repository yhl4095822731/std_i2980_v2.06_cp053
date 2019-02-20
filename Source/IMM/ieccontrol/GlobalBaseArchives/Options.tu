CONSTANT
 // cOption : BOOL (* global options start at 16#01 *);
 cOptionHydraulic : DWORD := 16#01 (* Hydraulic device, LSB is 1 *);
 cOptionElectric : DWORD := 16#02 (* Electric device *);
 cOptionNozzleASM : DWORD := 16#04 (* Nozzle with asynchronus motor *);
 // cSubOption : BOOL (* sub options start at 16#100 *);
 cSubOptionMoldHeightImpSensor : DWORD := 16#100 (* MoldHeight has impulse input *);
 cSubOptionMoldDirectLock : DWORD := 16#200 (* Mold is direct lock *);
 cSubOptionMold2Platen : DWORD := 16#400 (* 2 platen clamping system *);
 cSubOpNozzleTransducer : DWORD := 16#100 (* Nozzle has transducer *);
 cSubOpRotarySingleDual : DWORD := 16#100 (* Rotary table has 4 DIs and can move in Single/Dual Mode, when not present it can only move in Multi mode (2DIs) *);
 cSubOpRotaryTranslatory : DWORD := 16#200 (* Rotary table has a translatory movement *);
 cSubOpRotaryTransducer : DWORD := 16#400 (* Rotary/slide table uses transducer instead of DIs for slowing down *);
 cSubOpSpeedpumpMaster : DWORD := 16#100 (* Speed pump Master *);
 cSubOpSpeedpumpSlave1 : DWORD := 16#102 (* Speed pump Master + Slave1  *);
 cSubOpSpeedpumpSlave2 : DWORD := 16#104 (* Speed pump Master + Slave1 + Slave2 *);
 cSubOpPosBalance : DWORD := 16#100 (* Position Balance Control *);
 cSubOpTorqueFollower : DWORD := 16#200 (* Torque follower (Drive) *);
 cSubOpExtPressControl : DWORD := 16#400 (* Pressure control (Drive) *);
END_CONSTANT

TYPE
 tOptionId : DWORD;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
18 
@Constant @RT(7)cOption @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(0) @RT(29)global options start at 16#01 
@END_Attrib 


@Constant @RT(16)cOptionHydraulic @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#01 @RT(26)Hydraulic device, LSB is 1 
@END_Attrib 


@Constant @RT(15)cOptionElectric @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#02 @RT(15)Electric device 
@END_Attrib 


@Constant @RT(16)cOptionNozzleASM @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#04 @RT(29)Nozzle with asynchronus motor 
@END_Attrib 


@Constant @RT(10)cSubOption @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(0) @RT(27)sub options start at 16#100 
@END_Attrib 


@Constant @RT(29)cSubOptionMoldHeightImpSensor @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#100 @RT(28)MoldHeight has impulse input 
@END_Attrib 


@Constant @RT(24)cSubOptionMoldDirectLock @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#200 @RT(19)Mold is direct lock 
@END_Attrib 


@Constant @RT(21)cSubOptionMold2Platen @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#400 @RT(24)2 platen clamping system 
@END_Attrib 


@Constant @RT(22)cSubOpNozzleTransducer @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#100 @RT(21)Nozzle has transducer 
@END_Attrib 


@Constant @RT(22)cSubOpRotarySingleDual @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#100 @RT(111)Rotary table has 4 DIs and can move in Single/Dual Mode, when not present it can only move in Multi mode (2DIs) 
@END_Attrib 


@Constant @RT(23)cSubOpRotaryTranslatory @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#200 @RT(39)Rotary table has a translatory movement 
@END_Attrib 


@Constant @RT(22)cSubOpRotaryTransducer @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#400 @RT(66)Rotary/slide table uses transducer instead of DIs for slowing down 
@END_Attrib 


@Constant @RT(21)cSubOpSpeedpumpMaster @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#100 @RT(17)Speed pump Master 
@END_Attrib 


@Constant @RT(21)cSubOpSpeedpumpSlave1 @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#102 @RT(27)Speed pump Master + Slave1  
@END_Attrib 


@Constant @RT(21)cSubOpSpeedpumpSlave2 @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#104 @RT(35)Speed pump Master + Slave1 + Slave2 
@END_Attrib 


@Constant @RT(16)cSubOpPosBalance @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#100 @RT(24)Position Balance Control 
@END_Attrib 


@Constant @RT(20)cSubOpTorqueFollower @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#200 @RT(23)Torque follower (Drive) 
@END_Attrib 


@Constant @RT(21)cSubOpExtPressControl @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#400 @RT(24)Pressure control (Drive) 
@END_Attrib 


@RT(17)TypeTreeContainer 
1 
@DT @RT(9)tOptionId @RT(0) @T @T @RENAMED 0 @T @T @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
@@@BEG_Password@@@
MmhzZmgy
@@@END_Password@@@
