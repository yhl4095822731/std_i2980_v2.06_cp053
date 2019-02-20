%IMPORT_OVER_LISTFILE_SOURCE
 fmtCalibState
, OnOff

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsGlobalIdentSpeedStatus
, cLevelStartupTechnican
, cLevelTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_GlobalIdentMaxSpeedStatus : tsGlobalIdentSpeedStatus
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

%ELEMENT sv_GlobalIdentMaxSpeedStatus.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_GlobalIdentMaxSpeedStatus.bStart
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelTechnican
 %FORMAT OnOff 
// Start auto identification Start auto identification
;
 sv_GlobalIdentMinSpeedStatus : tsGlobalIdentSpeedStatus
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

%ELEMENT sv_GlobalIdentMinSpeedStatus.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_GlobalIdentMinSpeedStatus.bStart
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelTechnican
 %FORMAT OnOff 
// Start auto identification Start auto identification
;
%END

%SYSTEM_ALARM
  erCalibDiametersFlowChanged
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Auto speed identification necessary{#]Pump flow or cylinder diameters are changed.{#]Maximum speed is calculated with maximum pump flow and cylinder diameters.<br>If one of these parameters is changed maximum speed identification has to be done again.{#]Restart auto speed identification.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 120 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
2 
@SysVar @RT(28)sv_GlobalIdentMaxSpeedStatus @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tsGlobalIdentSpeedStatus @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(28)sv_GlobalIdentMaxSpeedStatus @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_GlobalIdentMaxSpeedStatus.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)status of overall calibration 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_GlobalIdentMaxSpeedStatus.bStart @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Start auto identification @RT(25)Start auto identification @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_GlobalIdentMinSpeedStatus @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tsGlobalIdentSpeedStatus @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(28)sv_GlobalIdentMinSpeedStatus @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_GlobalIdentMinSpeedStatus.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)status of overall calibration 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_GlobalIdentMinSpeedStatus.bStart @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelTechnican @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Start auto identification @RT(25)Start auto identification @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erCalibDiametersFlowChanged @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(288)Auto speed identification necessary{#]Pump flow or cylinder diameters are changed.{#]Maximum speed is calculated with maximum pump flow and cylinder diameters.<br>If one of these parameters is changed maximum speed identification has to be done again.{#]Restart auto speed identification. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
