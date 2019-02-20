%IMPORT_OVER_LISTFILE_SOURCE
 OnOff

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsDeviceId
, cCompSimulation
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_DeviceId : tsDeviceId := (CompId:=cCompSimulation,IndexId:=1) (* unique Device Identifier *)
     %INPUT_LEVEL 16

// Device Id Device Id

%ELEMENT sv_DeviceId.CompId
    
// Component Id Component Id

%ELEMENT sv_DeviceId.IndexId
    
// Device index Device index
;
 sv_bSimulate : BOOL
     %DISPLAY_LEVEL cLevelSuperUser  %INPUT_LEVEL cLevelSuperUser

// Simulation active Simulation is active
;
 sv_bStartSimulation : BOOL
   RETAIN  %DISPLAY_LEVEL cLevelSuperUser  %INPUT_LEVEL cLevelSuperUser
 %FORMAT OnOff 
// Start Simulation Start Simulation
;
 sv_ForceSGMoldClose : BOOL
    
// ForceSGMoldClose ForceSGClose
;
 sv_ForceSGNozzleClose : BOOL
    
// ForceSGNozzleClose ForceSGNozzleClose
;
 sv_ForceSGNozzleRearClose : BOOL
    
// ForceSGNozzleClose ForceSGNozzleClose
;
 sv_ForceSGRearClose : BOOL
    
// ForceSGRearClose ForceSGRearClose
;
 sv_ForceOilFilterOK : BOOL
    
// ForceOilFilterOk ForceOilFilterOk
;
 sv_ForceEmergencyStop1 : BOOL
    
// ForceEmergencyStop 1 ForceEmergencyStop 1
;
 sv_ForceEmergencyStop2 : BOOL
    
// ForceEmergencyStop 2 ForceEmergencyStop 2
;
 sv_ForceEmergencyStop3 : BOOL
    
// ForceEmergencyStop 3 ForceEmergencyStop 3
;
 sv_ForceEmergencyStop4 : BOOL
    
// forcestop 4 forceemergencystop 4
;
 sv_ForceLimitSwitchNozzleFwd : BOOL
    
// ForceLimitSwitchFwd ForceLimitSwitchFwd
;
 sv_ForceLimitSwitchNozzleFwd2 : BOOL
    
// ForceLimitSwitchFwd ForceLimitSwitchFwd
;
 sv_ForceLubPreAchieved : BOOL
    
// ForceLubPreAchieved ForceLubPreAchieved
;
 sv_ForceCore1Out : BOOL
    
// ForceCore1Out ForceCore1Out
;
 sv_ForceCore2Out : BOOL
    
// ForceCore2Out ForceCore2Out
;
 sv_ForceCore3Out : BOOL
    
// ForceCore3Out ForceCore3Out
;
 sv_ForceCore4Out : BOOL
    
// ForceCore4Out ForceCore4Out
;
 sv_ForceCore5Out : BOOL
    
// ForceCore5Out ForceCore5Out
;
 sv_ForceCore6Out : BOOL
    
// ForceCore6Out ForceCore6Out
;
 sv_ForceCore7Out : BOOL
    
// ForceCore7Out ForceCore7Out
;
 sv_ForceCore8Out : BOOL
    
// ForceCore8Out ForceCore8Out
;
 sv_ForceCore1In : BOOL
    
// ForceCore1In ForceCore1In
;
 sv_ForceCore2In : BOOL
    
// ForceCore2In ForceCore2In
;
 sv_ForceCore3In : BOOL
    
// ForceCore3In ForceCore3In
;
 sv_ForceCore4In : BOOL
    
// ForceCore4In ForceCore4In
;
 sv_ForceCore5In : BOOL
    
// ForceCore5In ForceCore5In
;
 sv_ForceCore6In : BOOL
    
// ForceCore6In ForceCore6In
;
 sv_ForceCore7In : BOOL
    
// ForceCore7In ForceCore7In
;
 sv_ForceCore8In : BOOL
    
// ForceCore8In ForceCore8In
;
 sv_ForceEjectorBack : BOOL
    
// ForceEjectorBack ForceEjectorBack
;
 sv_ForceMoldClosed : BOOL
    
// ForceMoldClosed ForceMoldClosed
;
 sv_ForceLightCurtainClose : BOOL
    
// ForceLightCurtainClose ForceLightCurtainClose
;
 sv_ForceSafetyMat : BOOL
    
// ForceSafetyMat ForceSafetyMat
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 56 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
35 
@SysVar @RT(11)sv_DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(36)(CompId:=cCompSimulation,IndexId:=1) @RT(24)unique Device Identifier 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Device Id @RT(9)Device Id @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(11)sv_DeviceId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(CompId:=cCompHeatingNozzle,IndexId:=1) @RT(24)unique Device Identifier 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Device Id @RT(9)Device Id @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(18)sv_DeviceId.CompId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(18)cCompHeatingNozzle @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Component Id @RT(12)Component Id @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_DeviceId.IndexId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Device index @RT(12)Device index @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_bSimulate @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(15)cLevelSuperUser @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Simulation active @RT(20)Simulation is active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_bSimulate @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(15)cLevelSuperUser @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Simulation active @RT(20)Simulation is active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bStartSimulation @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(15)cLevelSuperUser @RT(15)cLevelSuperUser @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Start Simulation @RT(16)Start Simulation @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bStartSimulation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(15)cLevelSuperUser @RT(15)cLevelSuperUser @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Start Simulation @RT(16)Start Simulation @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ForceSGMoldClose @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceSGMoldClose @RT(12)ForceSGClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ForceSGMoldClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceSGMoldClose @RT(12)ForceSGClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_ForceSGNozzleClose @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)ForceSGNozzleClose @RT(18)ForceSGNozzleClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_ForceSGNozzleClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)ForceSGNozzleClose @RT(18)ForceSGNozzleClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_ForceSGNozzleRearClose @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)ForceSGNozzleClose @RT(18)ForceSGNozzleClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_ForceSGNozzleRearClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)ForceSGNozzleClose @RT(18)ForceSGNozzleClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ForceSGRearClose @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceSGRearClose @RT(16)ForceSGRearClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ForceSGRearClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceSGRearClose @RT(16)ForceSGRearClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ForceOilFilterOK @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceOilFilterOk @RT(16)ForceOilFilterOk @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ForceOilFilterOK @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceOilFilterOk @RT(16)ForceOilFilterOk @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ForceEmergencyStop1 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)ForceEmergencyStop 1 @RT(20)ForceEmergencyStop 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_ForceEmergencyStop1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)ForceEmergencyStop 1 @RT(20)ForceEmergencyStop 1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ForceEmergencyStop2 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)ForceEmergencyStop 2 @RT(20)ForceEmergencyStop 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_ForceEmergencyStop2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)ForceEmergencyStop 2 @RT(20)ForceEmergencyStop 2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ForceEmergencyStop3 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)ForceEmergencyStop 3 @RT(20)ForceEmergencyStop 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_ForceEmergencyStop3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)ForceEmergencyStop 3 @RT(20)ForceEmergencyStop 3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ForceEmergencyStop4 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)forcestop 4 @RT(20)forceemergencystop 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_ForceEmergencyStop4 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)forcestop 4 @RT(20)forceemergencystop 4 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_ForceLimitSwitchNozzleFwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)ForceLimitSwitchFwd @RT(19)ForceLimitSwitchFwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_ForceLimitSwitchNozzleFwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)ForceLimitSwitchFwd @RT(19)ForceLimitSwitchFwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_ForceLimitSwitchNozzleFwd2 @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)ForceLimitSwitchFwd @RT(19)ForceLimitSwitchFwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_ForceLimitSwitchNozzleFwd2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)ForceLimitSwitchFwd @RT(19)ForceLimitSwitchFwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ForceLubPreAchieved @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)ForceLubPreAchieved @RT(19)ForceLubPreAchieved @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_ForceLubPreAchieved @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)ForceLubPreAchieved @RT(19)ForceLubPreAchieved @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore1Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore1Out @RT(13)ForceCore1Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore1Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore1Out @RT(13)ForceCore1Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore2Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore2Out @RT(13)ForceCore2Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore2Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore2Out @RT(13)ForceCore2Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore3Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore3Out @RT(13)ForceCore3Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore3Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore3Out @RT(13)ForceCore3Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore4Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore4Out @RT(13)ForceCore4Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore4Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore4Out @RT(13)ForceCore4Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore5Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore5Out @RT(13)ForceCore5Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore5Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore5Out @RT(13)ForceCore5Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore6Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore6Out @RT(13)ForceCore6Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore6Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore6Out @RT(13)ForceCore6Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore7Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore7Out @RT(13)ForceCore7Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore7Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore7Out @RT(13)ForceCore7Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ForceCore8Out @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore8Out @RT(13)ForceCore8Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_ForceCore8Out @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)ForceCore8Out @RT(13)ForceCore8Out @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore1In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore1In @RT(12)ForceCore1In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore1In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore1In @RT(12)ForceCore1In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore2In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore2In @RT(12)ForceCore2In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore2In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore2In @RT(12)ForceCore2In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore3In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore3In @RT(12)ForceCore3In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore3In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore3In @RT(12)ForceCore3In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore4In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore4In @RT(12)ForceCore4In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore4In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore4In @RT(12)ForceCore4In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore5In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore5In @RT(12)ForceCore5In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore5In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore5In @RT(12)ForceCore5In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore6In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore6In @RT(12)ForceCore6In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore6In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore6In @RT(12)ForceCore6In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore7In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore7In @RT(12)ForceCore7In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore7In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore7In @RT(12)ForceCore7In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_ForceCore8In @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore8In @RT(12)ForceCore8In @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_ForceCore8In @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)ForceCore8In @RT(12)ForceCore8In @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ForceEjectorBack @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceEjectorBack @RT(16)ForceEjectorBack @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ForceEjectorBack @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)ForceEjectorBack @RT(16)ForceEjectorBack @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_ForceMoldClosed @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)ForceMoldClosed @RT(15)ForceMoldClosed @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_ForceMoldClosed @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)ForceMoldClosed @RT(15)ForceMoldClosed @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_ForceLightCurtainClose @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)ForceLightCurtainClose @RT(22)ForceLightCurtainClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_ForceLightCurtainClose @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)ForceLightCurtainClose @RT(22)ForceLightCurtainClose @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_ForceSafetyMat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)ForceSafetyMat @RT(14)ForceSafetyMat @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_ForceSafetyMat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)ForceSafetyMat @RT(14)ForceSafetyMat @RT(0) @RT(0) @RT(0) 
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
