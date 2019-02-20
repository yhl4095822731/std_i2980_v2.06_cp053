%IMPORT_OVER_LISTFILE_SOURCE
 Temperature
, fmt30
, VG_HeatingNozzle
, TempSensorType
, VG_MachineData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KHW_TempSensor

END_IMPORT

%SYSTEMVAR_DECL
  ti_InTemp1 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 1 Temperature Input Zone 1
;
 ti_InTemp1_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp1_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp2 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 2 Temperature Input Zone 2
;
 ti_InTemp2_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp2_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp3 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 3 Temperature Input Zone 3
;
 ti_InTemp3_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp3_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp4 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 4 Temperature Input Zone 4
;
 ti_InTemp4_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp4_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp5 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 5 Temperature Input Zone 5
;
 ti_InTemp5_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp5_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp6 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 6 Temperature Input Zone 6
;
 ti_InTemp6_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp6_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp7 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 7 Temperature Input Zone 7
;
 ti_InTemp7_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp7_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp8 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 8 Temperature Input Zone 8
;
 ti_InTemp8_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp8_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp9 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 9 Temperature Input Zone 9
;
 ti_InTemp9_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp9_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp10 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 10 Temperature Input Zone 10
;
 ti_InTemp10_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp10_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp11 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 11 Temperature Input Zone 11
;
 ti_InTemp11_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp11_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
 ti_InTemp12 : REAL (* Sensor Input of Zone x *)
     %VARIABLE_GROUP VG_HeatingNozzle  %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt30  %UNIT Temperature 
// Zone 12 Temperature Input Zone 12
;
 ti_InTemp12_stat : BOOL (* Sensor Input of Zone x *)
     %INPUT_LEVEL 16

// Status Status Temperature Input Zone
;
 ti_InTemp12_sensor : KHW_TempSensor (* Sensor type of Zone x *)
     %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %FORMAT TempSensorType 
// Sensor Type Sensor Type Zone
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
36 
@SysVar @RT(10)ti_InTemp1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 1 @RT(24)Temperature Input Zone 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 1 @RT(24)Temperature Input Zone 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp1_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp1_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp1_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp1_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 2 @RT(24)Temperature Input Zone 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 2 @RT(24)Temperature Input Zone 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp2_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp2_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp2_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp2_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp3 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 3 @RT(24)Temperature Input Zone 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 3 @RT(24)Temperature Input Zone 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp3_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp3_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp3_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp3_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp4 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 4 @RT(24)Temperature Input Zone 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 4 @RT(24)Temperature Input Zone 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp4_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp4_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp4_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp4_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp5 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 5 @RT(24)Temperature Input Zone 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp5 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 5 @RT(24)Temperature Input Zone 5 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp5_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp5_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp5_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp5_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp6 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 6 @RT(24)Temperature Input Zone 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp6 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 6 @RT(24)Temperature Input Zone 6 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp6_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp6_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp6_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp6_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp7 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 7 @RT(24)Temperature Input Zone 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp7 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 7 @RT(24)Temperature Input Zone 7 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp7_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp7_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp7_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp7_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp8 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 8 @RT(24)Temperature Input Zone 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp8 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 8 @RT(24)Temperature Input Zone 8 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp8_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp8_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp8_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp8_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_InTemp9 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 9 @RT(24)Temperature Input Zone 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_InTemp9 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Zone 9 @RT(24)Temperature Input Zone 9 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_InTemp9_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_InTemp9_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_InTemp9_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_InTemp9_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)ti_InTemp10 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Zone 10 @RT(25)Temperature Input Zone 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ti_InTemp10 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Zone 10 @RT(25)Temperature Input Zone 10 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ti_InTemp10_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ti_InTemp10_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)ti_InTemp10_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)ti_InTemp10_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)ti_InTemp11 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Zone 11 @RT(25)Temperature Input Zone 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ti_InTemp11 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Zone 11 @RT(25)Temperature Input Zone 11 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ti_InTemp11_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ti_InTemp11_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)ti_InTemp11_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)ti_InTemp11_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)ti_InTemp12 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Zone 12 @RT(25)Temperature Input Zone 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ti_InTemp12 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(1)1 @RT(2)16 @RT(16)VG_HeatingNozzle @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Zone 12 @RT(25)Temperature Input Zone 12 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ti_InTemp12_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ti_InTemp12_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Sensor Input of Zone x 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(29)Status Temperature Input Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)ti_InTemp12_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)ti_InTemp12_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)Sensor type of Zone x 
@RT(1)1 @RT(0) @RT(14)VG_MachineData @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor Type @RT(16)Sensor Type Zone @RT(0) @RT(0) @RT(0) 
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
