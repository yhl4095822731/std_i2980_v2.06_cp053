(*
ComponentIDs:
100 - 199 reserved for KEBA
200 - 250 are free for use by customer
*)

IMPORT_OVER_LISTFILE
 cMinCompId
, cMaxCompId

END_IMPORT

CONSTANT
 cCompNone : DINT := cMinCompId (* None *);
 cCompAll : DINT := cMaxCompId (* to lock all components *);
 cCompMold : DINT := 101 (* Component Mold *);
 cCompEjector : DINT := 102 (* Component Ejector *);
 cCompNozzle : DINT := 103 (* Component Nozzle *);
 cCompInjection : DINT := 104 (* Component Injection *);
 cCompHeatingNozzle : DINT := 105 (* Component Heating Nozzle *);
 cCompCentralCoordination : DINT := 106 (* Component CentralCoordination *);
 cCompSafetyGateMold : DINT := 107 (* Component Safety Gate Mold *);
 cCompSafetyGateNozzle : DINT := 108 (* Component Safety Gate Nozzle *);
 cCompCore : DINT := 109 (* Component Core *);
 cCompCoolingTime : DINT := 110 (* Component Cooling Time *);
 cCompOperationMode : DINT := 111 (* Component Operation Mode *);
 cCompMotor : DINT := 112 (* Component Motor *);
 cCompPump : DINT := 113 (* Component Pump *);
 cCompValveBackP : DINT := 114 (* Component Backpressure Valve *);
 cCompValveServoInj : DINT := 115 (* Component Servovalve Inject *);
 cCompValveServoMold : DINT := 116 (* Component Servovalve Mold *);
 cCompOutputCoordination : DINT := 117 (* Component OutputCoordination *);
 cCompAirValve : DINT := 118 (* Component Air Valve *);
 cCompPDP : DINT := 119 (* Component Process Data Package *);
 cCompSafetyGateAuto : DINT := 120 (* Component Automatic Safetgate  *);
 cCompSafetyGateRear : DINT := 121 (* Component Safetgate Rear *);
 cCompLubrication : DINT := 122 (* Component Lubrication *);
 cCompOilMaintenance : DINT := 123 (* Component OilMaintenance *);
 cCompMoldHeight : DINT := 124 (* Component Mold Height *);
 cCompMoldHeightAuto : DINT := 125 (* Component Auto Mold Height *);
 cCompAutoPurge : DINT := 126 (* Component AutoPurge *);
 cCompPartDetection : DINT := 127 (* Component Part Detection *);
 cCompSimulation : DINT := 128 (* Component Simulation *);
 cCompEuromap : DINT := 129 (* Component Euromap *);
 cCompMotionProtectMold : DINT := 130 (* Component Motion Protect Mold *);
 cCompSafetyGateNozzleRear : DINT := 131 (* Component Safety Gate Nozzle Rear *);
 cCompServoDrives : DINT := 132 (* Component ServoDrives *);
 cCompTransmissionBelt : DINT := 133 (* Component Transmission Belt *);
 cCompOilPreHeating : DINT := 134 (* Component OilPreHeating *);
 cCompTest : DINT := 135 (* Component for Automatic Tests *);
 cCompODC : DINT := 136 (* Component ODC *);
 cCompAccumulator : DINT := 137 (* Component Accumulator *);
 cCompShutOffNozzle : DINT := 138 (* Component Shutter for Nozzle *);
 cCompHeatingMold : DINT := 140 (* Component Mold Heating *);
 cCompRotaryTable : DINT := 141 (* Component RotaryTable *);
 cCompEventIn : DINT := 142 (* Component Event In *);
 cCompEventOut : DINT := 143 (* Component Event Out *);
 cCompSafetyMat : DINT := 144 (* Component Safety Mat *);
 cCompValveGate : DINT := 145 (* Component Valve Gate *);
 cCompEcoRobot : DINT := 146 (* Component Eco Robot *);
 cCompLightCurtain : DINT := 147 (* Component LightCurtain *);
 cCompSlideTable : DINT := 148 (* Component Slide table *);
 cCompEasyNet : DINT := 155 (* Component EasyNet *);
 cCompDelayTime : DINT := 156 (* Component Delay time *);
 cCompEnergyMeter : DINT := 157 (* Component Energy meter *);
 cCompHostCommunication : DINT := 158 (* Component HostCommunication *);
 cCompMoldNuts : DINT := 159 (* Component MoldNuts (for 2 platten IMM큦) *);
 cCompTieBars : DINT := 160 (* Component TieBars (for 2 platten IMM큦) *);
 cCompSpringMold : DINT := 161 (* Component SpringMold *);
 cCompKEBALast : DINT := 199 (* ComponentIDs 100 - 199 reserved for KEBA, ComponentIDs 200 - 250 are free for use by customer *);
END_CONSTANT



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Tou 25 
@@@BEG_Comment@@@
ComponentIDs:
100 - 199 reserved for KEBA
200 - 250 are free for use by customer
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
57 
@Constant @RT(9)cCompNone @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(10)cMinCompId @RT(4)None 
@END_Attrib 


@Constant @RT(8)cCompAll @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(10)cMaxCompId @RT(22)to lock all components 
@END_Attrib 


@Constant @RT(9)cCompMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)101 @RT(14)Component Mold 
@END_Attrib 


@Constant @RT(12)cCompEjector @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)102 @RT(17)Component Ejector 
@END_Attrib 


@Constant @RT(11)cCompNozzle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)103 @RT(16)Component Nozzle 
@END_Attrib 


@Constant @RT(14)cCompInjection @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)104 @RT(19)Component Injection 
@END_Attrib 


@Constant @RT(18)cCompHeatingNozzle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)105 @RT(24)Component Heating Nozzle 
@END_Attrib 


@Constant @RT(24)cCompCentralCoordination @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)106 @RT(29)Component CentralCoordination 
@END_Attrib 


@Constant @RT(19)cCompSafetyGateMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)107 @RT(26)Component Safety Gate Mold 
@END_Attrib 


@Constant @RT(21)cCompSafetyGateNozzle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)108 @RT(28)Component Safety Gate Nozzle 
@END_Attrib 


@Constant @RT(9)cCompCore @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)109 @RT(14)Component Core 
@END_Attrib 


@Constant @RT(16)cCompCoolingTime @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)110 @RT(22)Component Cooling Time 
@END_Attrib 


@Constant @RT(18)cCompOperationMode @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)111 @RT(24)Component Operation Mode 
@END_Attrib 


@Constant @RT(10)cCompMotor @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)112 @RT(15)Component Motor 
@END_Attrib 


@Constant @RT(9)cCompPump @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)113 @RT(14)Component Pump 
@END_Attrib 


@Constant @RT(15)cCompValveBackP @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)114 @RT(28)Component Backpressure Valve 
@END_Attrib 


@Constant @RT(18)cCompValveServoInj @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)115 @RT(27)Component Servovalve Inject 
@END_Attrib 


@Constant @RT(19)cCompValveServoMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)116 @RT(25)Component Servovalve Mold 
@END_Attrib 


@Constant @RT(23)cCompOutputCoordination @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)117 @RT(28)Component OutputCoordination 
@END_Attrib 


@Constant @RT(13)cCompAirValve @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)118 @RT(19)Component Air Valve 
@END_Attrib 


@Constant @RT(8)cCompPDP @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)119 @RT(30)Component Process Data Package 
@END_Attrib 


@Constant @RT(19)cCompSafetyGateAuto @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)120 @RT(30)Component Automatic Safetgate  
@END_Attrib 


@Constant @RT(19)cCompSafetyGateRear @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)121 @RT(24)Component Safetgate Rear 
@END_Attrib 


@Constant @RT(16)cCompLubrication @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)122 @RT(21)Component Lubrication 
@END_Attrib 


@Constant @RT(19)cCompOilMaintenance @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)123 @RT(24)Component OilMaintenance 
@END_Attrib 


@Constant @RT(15)cCompMoldHeight @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)124 @RT(21)Component Mold Height 
@END_Attrib 


@Constant @RT(19)cCompMoldHeightAuto @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)125 @RT(26)Component Auto Mold Height 
@END_Attrib 


@Constant @RT(14)cCompAutoPurge @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)126 @RT(19)Component AutoPurge 
@END_Attrib 


@Constant @RT(18)cCompPartDetection @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)127 @RT(24)Component Part Detection 
@END_Attrib 


@Constant @RT(15)cCompSimulation @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)128 @RT(20)Component Simulation 
@END_Attrib 


@Constant @RT(12)cCompEuromap @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)129 @RT(17)Component Euromap 
@END_Attrib 


@Constant @RT(22)cCompMotionProtectMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)130 @RT(29)Component Motion Protect Mold 
@END_Attrib 


@Constant @RT(25)cCompSafetyGateNozzleRear @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)131 @RT(33)Component Safety Gate Nozzle Rear 
@END_Attrib 


@Constant @RT(16)cCompServoDrives @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)132 @RT(21)Component ServoDrives 
@END_Attrib 


@Constant @RT(21)cCompTransmissionBelt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)133 @RT(27)Component Transmission Belt 
@END_Attrib 


@Constant @RT(18)cCompOilPreHeating @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)134 @RT(23)Component OilPreHeating 
@END_Attrib 


@Constant @RT(9)cCompTest @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)135 @RT(29)Component for Automatic Tests 
@END_Attrib 


@Constant @RT(8)cCompODC @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)136 @RT(13)Component ODC 
@END_Attrib 


@Constant @RT(16)cCompAccumulator @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)137 @RT(21)Component Accumulator 
@END_Attrib 


@Constant @RT(18)cCompShutOffNozzle @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)138 @RT(28)Component Shutter for Nozzle 
@END_Attrib 


@Constant @RT(16)cCompHeatingMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)140 @RT(22)Component Mold Heating 
@END_Attrib 


@Constant @RT(16)cCompRotaryTable @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)141 @RT(21)Component RotaryTable 
@END_Attrib 


@Constant @RT(12)cCompEventIn @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)142 @RT(18)Component Event In 
@END_Attrib 


@Constant @RT(13)cCompEventOut @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)143 @RT(19)Component Event Out 
@END_Attrib 


@Constant @RT(14)cCompSafetyMat @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)144 @RT(20)Component Safety Mat 
@END_Attrib 


@Constant @RT(14)cCompValveGate @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)145 @RT(20)Component Valve Gate 
@END_Attrib 


@Constant @RT(13)cCompEcoRobot @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)146 @RT(19)Component Eco Robot 
@END_Attrib 


@Constant @RT(17)cCompLightCurtain @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)147 @RT(22)Component LightCurtain 
@END_Attrib 


@Constant @RT(15)cCompSlideTable @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)148 @RT(21)Component Slide table 
@END_Attrib 


@Constant @RT(12)cCompEasyNet @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)155 @RT(17)Component EasyNet 
@END_Attrib 


@Constant @RT(14)cCompDelayTime @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)156 @RT(20)Component Delay time 
@END_Attrib 


@Constant @RT(16)cCompEnergyMeter @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)157 @RT(22)Component Energy meter 
@END_Attrib 


@Constant @RT(22)cCompHostCommunication @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)158 @RT(27)Component HostCommunication 
@END_Attrib 


@Constant @RT(13)cCompMoldNuts @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)159 @RT(40)Component MoldNuts (for 2 platten IMM큦) 
@END_Attrib 


@Constant @RT(12)cCompTieBars @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)160 @RT(39)Component TieBars (for 2 platten IMM큦) 
@END_Attrib 


@Constant @RT(15)cCompSpringMold @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)161 @RT(20)Component SpringMold 
@END_Attrib 


@Constant @RT(13)cCompKEBALast @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)199 @RT(93)ComponentIDs 100 - 199 reserved for KEBA, ComponentIDs 200 - 250 are free for use by customer 
@END_Attrib 


@RT(17)TypeTreeContainer 
0 
@END_Export 

@END_Contents 
