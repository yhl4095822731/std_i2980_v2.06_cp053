%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, ThermoCompCableLength
, fmt41
, ThermoCompWireCrossSection
, fmt31
, ThermoCompWireDiameter

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tyThermoWireData
, cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_ThermoData : tyThermoWireData := (rCableLength:=1.0,rWireDiameter:=1.5,rWireCrossSection:=1.8)
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_ThermoData[0].bIsUsed
     %INPUT_LEVEL cLevelStartupTechnican

// Use Use

%ELEMENT sv_ThermoData[0].rCableLength
 %PLAUSIBILITY 0.5..100.0      %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT ThermoCompCableLength 
// Length Length

%ELEMENT sv_ThermoData[0].rWireCrossSection
 %PLAUSIBILITY 0.1..30.0      %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT ThermoCompWireCrossSection 
// Cross section Cross section

%ELEMENT sv_ThermoData[0].rWireDiameter
 %PLAUSIBILITY 0.1..100.0      %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt31  %UNIT ThermoCompWireDiameter 
// Wire diameter Wire diameter
;
 sv_bAnyTempSensorTypeChanged : BOOL
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 127 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
2 
@SysVar @RT(13)sv_ThermoData @RT(0) @T @T @DERIVED 0 @F @RT(16)tyThermoWireData @F 
@T 
@BEG_Attrib 
4 @RT(61)(rCableLength:=1.0,rWireDiameter:=1.5,rWireCrossSection:=1.8) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(13)sv_ThermoData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ThermoData[0].bIsUsed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)Temperaturkompensation berücksichtigen? 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)Use @RT(3)Use @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_ThermoData[0].rCableLength @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(14)Kabellänge [m] 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(21)ThermoCompCableLength @RT(0) @RT(0) 
@RT(10)0.5..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Length @RT(6)Length @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_ThermoData[0].rWireCrossSection @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Kabelquerschnitt [mm²] 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(26)ThermoCompWireCrossSection @RT(0) @RT(0) 
@RT(9)0.1..30.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Cross section @RT(13)Cross section @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ThermoData[0].rWireDiameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)Kabelduchmesser [mm] 
@RT(0) @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt31 @RT(22)ThermoCompWireDiameter @RT(0) @RT(0) 
@RT(10)0.1..100.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Wire diameter @RT(13)Wire diameter @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_bAnyTempSensorTypeChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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
