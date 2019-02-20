%IMPORT_OVER_LISTFILE_SOURCE
 CalibGroup
, fmtCalibState
, OnOff
, PumpCalibDevice
, VG_MachineData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsCalibMovement
, tnForceDimension_Y
, tnCalibState_None
, tnCalibGroup_Velocity
, tnCalibGroup_Pressure
, cLevelStartupTechnican
, cLevelServiceEngineer

END_IMPORT

%SYSTEMVAR_DECL
  sv_CalibStatePumpVelocity : tsCalibMovement := (pLintab:=@%FU.sv_VelocityLintab,prForceOutput:=@%FU.ao_Velocity,ForceDimension:=tnForceDimension_Y,Status:=tnCalibState_None,iOrder:=60,Group:=tnCalibGroup_Velocity)
    
%ELEMENT sv_CalibStatePumpVelocity.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStatePumpVelocity.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStatePumpVelocity.bNameDummy
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Pump %f vel Pump %f velocity

%ELEMENT sv_CalibStatePumpVelocity.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_CalibStatePumpPressure : tsCalibMovement := (pLintab:=@%FU.sv_PressureLintab,prForceOutput:=@%FU.ao_Pressure,ForceDimension:=tnForceDimension_Y,Status:=tnCalibState_None,iOrder:=50,Group:=tnCalibGroup_Pressure)
    
%ELEMENT sv_CalibStatePumpPressure.Group
     %FORMAT CalibGroup 
%ELEMENT sv_CalibStatePumpPressure.Status
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmtCalibState 
%ELEMENT sv_CalibStatePumpPressure.bNameDummy
     %DISPLAY_LEVEL 1 
// Pump %f pre Pump %f pressure

%ELEMENT sv_CalibStatePumpPressure.bRedo
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT OnOff ;
 sv_iDeviceForCalib : DINT := 1 (* index in sv_PumpCalibDevices - list *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT PumpCalibDevice 
// Axis for pump %f calibration Axis for pump %f calibration
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 145 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
3 
@SysVar @RT(25)sv_CalibStatePumpVelocity @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(166)(pLintab:=@%FU.sv_VelocityLintab,prForceOutput:=@%FU.ao_Velocity,ForceDimension:=tnForceDimension_Y,Status:=tnCalibState_None,iOrder:=60,Group:=tnCalibGroup_Velocity) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(25)sv_CalibStatePumpVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(53)should be linked to sv_MoveInject.AnaOutData.pLintabV 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStatePumpVelocity.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_CalibStatePumpVelocity.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CalibStatePumpVelocity.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Pump %f vel @RT(16)Pump %f velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStatePumpVelocity.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_CalibStatePumpPressure @RT(0) @T @T @DERIVED 0 @F @RT(15)tsCalibMovement @F 
@T 
@BEG_Attrib 
4 @RT(166)(pLintab:=@%FU.sv_PressureLintab,prForceOutput:=@%FU.ao_Pressure,ForceDimension:=tnForceDimension_Y,Status:=tnCalibState_None,iOrder:=50,Group:=tnCalibGroup_Pressure) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(25)sv_CalibStatePumpPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(43)(iOrder:=15,Group:=tnCalibGroup_ClosedLoop) @RT(53)should be linked to sv_MoveInject.AnaOutData.pLintabP 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStatePumpPressure.Group @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)CalibGroup @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_CalibStatePumpPressure.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(13)fmtCalibState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_CalibStatePumpPressure.bNameDummy @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)Name for HMI. Is a Element, because it is not possible to get the short text of a STRUCT 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Pump %f pre @RT(16)Pump %f pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CalibStatePumpPressure.bRedo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iDeviceForCalib @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(35)index in sv_PumpCalibDevices - list 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)PumpCalibDevice @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Axis for pump %f calibration @RT(28)Axis for pump %f calibration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iDeviceForCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)index in sv_PumpCalibDevices - list 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)PumpCalibDevice @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(28)Axis for pump %f calibration @RT(28)Axis for pump %f calibration @RT(0) @RT(0) @RT(0) 
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
