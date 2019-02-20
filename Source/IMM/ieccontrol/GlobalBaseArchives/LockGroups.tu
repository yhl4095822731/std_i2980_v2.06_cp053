(*
LockGroups:
60 - 89 are reserved for KEBA
90 - 99 are free for use by customer
*)

CONSTANT
 cLockGroupNone : DINT := 60 (* Members: None *);
 cLockGroupSafetyGateMold : DINT := 61 (* Members: Mold Close, Mold Hight Forward, Auto Mold Hight, Core In, Inject *);
 cLockGroupSafetyGateNozzle : DINT := 62 (* Members: Nozzle Forward, Injection, Plast, Intrusion, Purge *);
 cLockGroupHeatingNozzle : DINT := 63 (* Members: Injection, Plast, Suckback *);
 cLockGroupHeatingMold : DINT := 64 (* Members: Injection *);
 cLockGroupClampingUnit : DINT := 65 (* Members: Mold, Ejector, Cores *);
 cLockGroupMoldHeight : DINT := 66 (* Members: *);
 cLockGroupNozzleFwd : DINT := 68 (* Members: *);
 cLockGroupMotor : DINT := 69 (* Members: Mold, Ejector, Cores, Injection, Plast, Purge,  *);
 cLockGroupRotateInjectPos : DINT := 72 (* Members: *);
 cLockGroupRotateEjectPos : DINT := 73 (* Members: *);
 cLockGroupEjectorBwd : DINT := 74 (* Members: *);
 cLockGroupHighPressureReleased : DINT := 75 (* High pressure is released. Members:  Lock Nuts open, TieBars except release movement *);
 cLockGroupMoldNutOpen : DINT := 76 (* Lock Nuts are not opened. Members: Mold, TieBars *);
 cLockGroupTieBarTargetPos : DINT := 77 (* Tiebar target position not reached. Members: Lock Nuts close *);
 // cLockGroupKEBALast : DINT := 89 (* LockGroups 60 - 89 are reserved for KEBA, LockGroups 90 - 99 are free for use by customer *);
END_CONSTANT



#END_OF_IEC_PART

@Puma @IecEditor 6 103 @Tou 25 
@@@BEG_Comment@@@
LockGroups:
60 - 89 are reserved for KEBA
90 - 99 are free for use by customer
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
16 
@Constant @RT(14)cLockGroupNone @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)60 @RT(13)Members: None 
@END_Attrib 


@Constant @RT(24)cLockGroupSafetyGateMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)61 @RT(73)Members: Mold Close, Mold Hight Forward, Auto Mold Hight, Core In, Inject 
@END_Attrib 


@Constant @RT(26)cLockGroupSafetyGateNozzle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)62 @RT(59)Members: Nozzle Forward, Injection, Plast, Intrusion, Purge 
@END_Attrib 


@Constant @RT(23)cLockGroupHeatingNozzle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)63 @RT(35)Members: Injection, Plast, Suckback 
@END_Attrib 


@Constant @RT(21)cLockGroupHeatingMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)64 @RT(18)Members: Injection 
@END_Attrib 


@Constant @RT(22)cLockGroupClampingUnit @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)65 @RT(29)Members: Mold, Ejector, Cores 
@END_Attrib 


@Constant @RT(20)cLockGroupMoldHeight @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)66 @RT(8)Members: 
@END_Attrib 


@Constant @RT(19)cLockGroupNozzleFwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)68 @RT(8)Members: 
@END_Attrib 


@Constant @RT(15)cLockGroupMotor @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)69 @RT(56)Members: Mold, Ejector, Cores, Injection, Plast, Purge,  
@END_Attrib 


@Constant @RT(25)cLockGroupRotateInjectPos @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)72 @RT(8)Members: 
@END_Attrib 


@Constant @RT(24)cLockGroupRotateEjectPos @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)73 @RT(8)Members: 
@END_Attrib 


@Constant @RT(20)cLockGroupEjectorBwd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)74 @RT(8)Members: 
@END_Attrib 


@Constant @RT(30)cLockGroupHighPressureReleased @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)75 @RT(84)High pressure is released. Members:  Lock Nuts open, TieBars except release movement 
@END_Attrib 


@Constant @RT(21)cLockGroupMoldNutOpen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)76 @RT(48)Lock Nuts are not opened. Members: Mold, TieBars 
@END_Attrib 


@Constant @RT(25)cLockGroupTieBarTargetPos @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)77 @RT(60)Tiebar target position not reached. Members: Lock Nuts close 
@END_Attrib 


@Constant @RT(18)cLockGroupKEBALast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(2)89 @RT(89)LockGroups 60 - 89 are reserved for KEBA, LockGroups 90 - 99 are free for use by customer 
@END_Attrib 


@RT(17)TypeTreeContainer 
0 
@END_Export 

@END_Contents 
