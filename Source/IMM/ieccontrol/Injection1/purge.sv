%IMPORT_OVER_LISTFILE_SOURCE
 VG_MoldData
, Pressure
, Backward
, fmt30
, InjectSpeed
, InjectVolume
, fmt41
, InjectPressure
, Forward
, fmt40
, InjectVolumeSpeed
, MaxPlastPressure
, Rotation
, Time
, fmt31

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsPurgeSettings
, tsActPurgeTimes
, cLevelProduction
, cLevelProcessOperator
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_PurgeSettings : tsPurgeSettings := (iCount:=1,dMaxPurgeTime:=t#120s,InjectParams:=(ConstOutput:=(Velocity:=(Output:=(rRamp:=500.0)),Pressure:=(Output:=(rRamp:=100000000.0)))))
   RETAIN  %VARIABLE_GROUP VG_MoldData 
%ELEMENT sv_PurgeSettings.DecompParams.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressureBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Backward 
// Decompression Decompression pressure

%ELEMENT sv_PurgeSettings.DecompParams.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedBwd      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectSpeed  %ABSREL Backward 
// Decompression Decompression velocity

%ELEMENT sv_PurgeSettings.DecompParams.rEndPos
 %PLAUSIBILITY 0.0..%FU.sv_rScrewVolume      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT InjectVolume 
// Position Position

%ELEMENT sv_PurgeSettings.InjectParams.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxInjPresAllow      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt40  %UNIT InjectPressure  %ABSREL Forward 
// Injection Injection pressure

%ELEMENT sv_PurgeSettings.InjectParams.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxSpeedFwdSpec      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT InjectVolumeSpeed 
// Injection Injection

%ELEMENT sv_PurgeSettings.InjectParams.ConstOutput.Velocity.Output.rRamp
     %DISPLAY_LEVEL 1 
%ELEMENT sv_PurgeSettings.InjectParams.rEndPos
 %PLAUSIBILITY 0.0..%FU.sv_rScrewVolume      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt41  %UNIT InjectVolume 
// Position Position

%ELEMENT sv_PurgeSettings.PlastParams.ConstOutput.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressurePlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL MaxPlastPressure 
// Plasticize Plasticize pressure

%ELEMENT sv_PurgeSettings.PlastParams.ConstOutput.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_rMaxRotationPlast      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Rotation  %ABSREL Backward 
// Plasticize Plasticize verlocity

%ELEMENT sv_PurgeSettings.PlastParams.dSetPlastTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Time Plast time

%ELEMENT sv_PurgeSettings.dMaxPurgeTime
 %PLAUSIBILITY t#0s..t#999.9s      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Time 
// Max. purge time Max. purge time

%ELEMENT sv_PurgeSettings.iCount
 %PLAUSIBILITY 1..999      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30 
// Purge count Purge count
;
 sv_ActPurgeTimes : tsActPurgeTimes
    
%ELEMENT sv_ActPurgeTimes.dActPlastTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Act. time Act. plasticize time

%ELEMENT sv_ActPurgeTimes.dActPurgeTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Purge time Act. purge time
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
2 
@SysVar @RT(16)sv_PurgeSettings @RT(0) @T @T @DERIVED 0 @F @RT(15)tsPurgeSettings @F 
@T 
@BEG_Attrib 
4 @RT(140)(iCount:=1,dMaxPurgeTime:=t#120s,InjectParams:=(ConstOutput:=(Velocity:=(Output:=(rRamp:=500.0)),Pressure:=(Output:=(rRamp:=100000000.0))))) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
13 
@AttrSym @RT(16)sv_PurgeSettings @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_PurgeSettings.DecompParams.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Backward @RT(0) 
@RT(27)0.0..%FU.sv_rMaxPressureBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Decompression @RT(22)Decompression pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_PurgeSettings.DecompParams.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(11)InjectSpeed @RT(8)Backward @RT(0) 
@RT(24)0.0..%FU.sv_rMaxSpeedBwd @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Decompression @RT(22)Decompression velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_PurgeSettings.DecompParams.rEndPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_PurgeSettings.InjectParams.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt40 @RT(14)InjectPressure @RT(7)Forward @RT(0) 
@RT(28)0.0..%FU.sv_rMaxInjPresAllow @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Injection @RT(18)Injection pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(70)sv_PurgeSettings.InjectParams.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(17)InjectVolumeSpeed @RT(0) @RT(0) 
@RT(28)0.0..%FU.sv_rMaxSpeedFwdSpec @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Injection @RT(9)Injection @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(63)sv_PurgeSettings.InjectParams.ConstOutput.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_PurgeSettings.InjectParams.rEndPos @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt41 @RT(12)InjectVolume @RT(0) @RT(0) 
@RT(24)0.0..%FU.sv_rScrewVolume @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_PurgeSettings.PlastParams.ConstOutput.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(16)MaxPlastPressure @RT(0) 
@RT(29)0.0..%FU.sv_rMaxPressurePlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Plasticize @RT(19)Plasticize pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_PurgeSettings.PlastParams.ConstOutput.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Rotation @RT(8)Backward @RT(0) 
@RT(29)0.0..%FU.sv_rMaxRotationPlast @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Plasticize @RT(20)Plasticize verlocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_PurgeSettings.PlastParams.dSetPlastTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Time @RT(10)Plast time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_PurgeSettings.dMaxPurgeTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(14)t#0s..t#999.9s @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Max. purge time @RT(15)Max. purge time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_PurgeSettings.iCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(0) @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Purge count @RT(11)Purge count @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_ActPurgeTimes @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsActPurgeTimes @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(30)sv_ActPurgeTimes.dActPlastTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Act. time @RT(20)Act. plasticize time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ActPurgeTimes.dActPurgeTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Purge time @RT(15)Act. purge time @RT(0) @RT(0) @RT(0) 
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
