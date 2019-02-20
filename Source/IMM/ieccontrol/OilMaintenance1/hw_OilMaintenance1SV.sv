%IMPORT_OVER_LISTFILE_SOURCE
 TempSensorType
, Temperature
, fmt30
, LG_ActPump
, VG_Production

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KHW_TempSensor
, cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  di_OilLevelOk : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Oil level ok Oil level ok
;
 di_OilLevelOk_stat : BOOL
    ;
 di_OilFilterOk_stat : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Oil filter ok Oil filter ok
;
 di_OilFilterOk : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Oil filter ok Oil filter ok
;
 ti_OilTemp_stat : BOOL
    
// Oil temperature state TI Oil temperature state
;
 ti_OilTemp_sensor : KHW_TempSensor
     %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT TempSensorType 
// Sensor type Sensor type
;
 ti_OilTemp : REAL
     %VARIABLE_GROUP VG_Production  %LIST_GROUP LG_ActPump(3)
 %DISPLAY_LEVEL 1  %FORMAT fmt30  %UNIT Temperature 
// Oil Oil temperature
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
7 
@SysVar @RT(13)di_OilLevelOk @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Oil level ok @RT(12)Oil level ok @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)di_OilLevelOk @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Oil level ok @RT(12)Oil level ok @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)di_OilLevelOk_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)di_OilFilterOk_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Oil filter ok @RT(13)Oil filter ok @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)di_OilFilterOk_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Oil filter ok @RT(13)Oil filter ok @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)di_OilFilterOk @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Oil filter ok @RT(13)Oil filter ok @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)di_OilFilterOk @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Oil filter ok @RT(13)Oil filter ok @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)ti_OilTemp_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Oil temperature state @RT(24)TI Oil temperature state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)ti_OilTemp_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Oil temperature state @RT(24)TI Oil temperature state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)ti_OilTemp_sensor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_TempSensor @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)ti_OilTemp_sensor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(14)TempSensorType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Sensor type @RT(11)Sensor type @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)ti_OilTemp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(13)VG_Production @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActPump(3) @RT(0) 
@RT(3)Oil @RT(15)Oil temperature @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)ti_OilTemp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(13)VG_Production @RT(5)fmt30 @RT(11)Temperature @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(13)LG_ActPump(3) @RT(0) 
@RT(3)Oil @RT(15)Oil temperature @RT(0) @RT(0) @RT(0) 
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
