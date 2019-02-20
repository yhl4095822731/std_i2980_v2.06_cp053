%IMPORT_OVER_LISTFILE_SOURCE
 VG_MoldData
, CoreInMode
, CoreOutMode
, fmt20
, Percent
, fmt31
, Stroke
, fmt41
, CoreType
, UseNoUse

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tyCoreData
, tyCoreTypeArray
, tyDeviceAvailable
, nDuringMoldClose
, nDuringMoldOpen
, cLevelProcessOperator
, cCompCore
, cLevelProduction
, FPlausCoreInMode
, FPlausCoreOutMode

END_IMPORT

%SYSTEMVAR_DECL
  sv_CoreData : tyCoreData := (InMode:=nDuringMoldClose,rCoreInPosition:=150.0,iCoreInPriority:=1,OutMode:=nDuringMoldOpen,rCoreOutPosition:=150.0,iCoreOutPriority:=-1),(iCoreInPriority:=2,iCoreOutPriority:=-1),(iCoreInPriority:=3,iCoreOutPriority:=-1),(iCoreInPriority:=4,iCoreOutPriority:=-1),(iCoreInPriority:=5,iCoreOutPriority:=-1),(iCoreInPriority:=6,iCoreOutPriority:=-1),(iCoreInPriority:=7,iCoreOutPriority:=-1),(iCoreInPriority:=8,iCoreOutPriority:=-1),(iCoreInPriority:=9,iCoreOutPriority:=-1),(iCoreInPriority:=10,iCoreOutPriority:=-1)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

%ELEMENT sv_CoreData[0].InMode
 %PLAUSIBILITY FPlausCoreInMode      %VISI_CLASS Core.hmi.CoreActProgrammedVisControl  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT CoreInMode 
// In mode In mode

%ELEMENT sv_CoreData[0].OutMode
 %PLAUSIBILITY FPlausCoreOutMode      %VISI_CLASS Core.hmi.CoreActProgrammedVisControl  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT CoreOutMode 
// Out mode Out mode

%ELEMENT sv_CoreData[0].bAvailable
    
// Available Core available

%ELEMENT sv_CoreData[0].iCoreInPriority
 %PLAUSIBILITY 1..system.sv_NumberOfDevices[cCompCore]      %VISI_CLASS Core.hmi.CoreActProgrammedVisControl  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt20 
// Prio core in Priority core in

%ELEMENT sv_CoreData[0].iCoreOutPriority
 %PLAUSIBILITY 1..system.sv_NumberOfDevices[cCompCore]      %VISI_CLASS Core.hmi.CoreActProgrammedVisControl  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt20 
// Prio core out Priority core out

%ELEMENT sv_CoreData[0].rCoreInMoldAcc
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Mld Acc InPos Mold Accel. InPosition

%ELEMENT sv_CoreData[0].rCoreInMoldDeacc
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Mld Deacc InPos Mold DeAccel. InPosition

%ELEMENT sv_CoreData[0].rCoreInPosition
 %PLAUSIBILITY Mold1.sv_MoldFwdProfVisSrc.Profile.Points[19].rStartPos..Mold1.sv_rMoldOpenPosSet      %VISI_CLASS Core.hmi.CoreActProgrammedVisControl  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Position Position

%ELEMENT sv_CoreData[0].rCoreOutMoldAcc
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Mld Acc OutPos Mold Accel. OutPosition

%ELEMENT sv_CoreData[0].rCoreOutMoldDeacc
 %PLAUSIBILITY system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Percent 
// Mld DeAcc. OutPos Mold DeAccel.OutPosition

%ELEMENT sv_CoreData[0].rCoreOutPosition
 %PLAUSIBILITY 0.0..Mold1.sv_rMoldOpenPosSet      %VISI_CLASS Core.hmi.CoreActProgrammedVisControl  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Position Position
;
 sv_CoreType : tyCoreTypeArray
   RETAIN  %VARIABLE_GROUP VG_MoldData  %INPUT_LEVEL cLevelProduction
 %FORMAT CoreType ;
 sv_CoreOff : tyDeviceAvailable
    ;
 sv_bCoresActive : BOOL
    ;
 sv_bEjectorFwdDuringMldOpen : BOOL (* Parallel movements for Ejector fwd and mold open possible *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Eject during mold open Eject during mold open
;
 sv_rEjectorFwdStartPosition : REAL (* Ejector fwd start position (for parallel movements) *)
 %PLAUSIBILITY 0.0..Mold1.sv_rMoldOpenPosSet    RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Ejector forward start position Ejector forward start position
;
 sv_bClampOpenDuringPlast : BOOL (* Parallel movements for plast and mold open *)
   RETAIN  %VARIABLE_GROUP VG_MoldData  %VISI_CLASS system.hmi.ODCEditDisabledController  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT UseNoUse 
// Mold open during plast Mold open during plast
;
%END

%SYSTEM_ALARM
  erAnyIoForced
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// I/O forced...!{#]Any kind of IO is forced.{#]In the IO monitor one or more IOs are forced, or the simulation is active.{#]Unforce the IOs in the IO monitor or deactivate simulation.
 ;
  erEqualCorePriority
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Priority of Core%1n %2t and Core%3n %4t are equal, adapt priority settings{#]Two or more core in or core out priorities are equal.{#]Two activated cores are having the same mode (In mode or Out mode) and the same priority. <br>This leads to an error during creating the machine sequence.{#]Adapt the core in / core out priority setting in the HMI.
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
@SysVar @RT(11)sv_CoreData @RT(0) @T @T @DERIVED 0 @F @RT(10)tyCoreData @F 
@T 
@BEG_Attrib 
4 @RT(517)(InMode:=nDuringMoldClose,rCoreInPosition:=150.0,iCoreInPriority:=1,OutMode:=nDuringMoldOpen,rCoreOutPosition:=150.0,iCoreOutPriority:=-1),(iCoreInPriority:=2,iCoreOutPriority:=-1),(iCoreInPriority:=3,iCoreOutPriority:=-1),(iCoreInPriority:=4,iCoreOutPriority:=-1),(iCoreInPriority:=5,iCoreOutPriority:=-1),(iCoreInPriority:=6,iCoreOutPriority:=-1),(iCoreInPriority:=7,iCoreOutPriority:=-1),(iCoreInPriority:=8,iCoreOutPriority:=-1),(iCoreInPriority:=9,iCoreOutPriority:=-1),(iCoreInPriority:=10,iCoreOutPriority:=-1) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
12 
@AttrSym @RT(11)sv_CoreData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(508)(InMode:=nDuringMoldClose,rCoreInPosition:=150.0,iCoreInPriority:=1,OutMode:=nDuringMoldOpen,rCoreOutPosition:=150.0,iCoreOutPriority:=10),(iCoreInPriority:=2,iCoreOutPriority:=9),(iCoreInPriority:=3,iCoreOutPriority:=8),(iCoreInPriority:=4,iCoreOutPriority:=7),(iCoreInPriority:=5,iCoreOutPriority:=6),(iCoreInPriority:=6,iCoreOutPriority:=5),(iCoreInPriority:=7,iCoreOutPriority:=4),(iCoreInPriority:=8,iCoreOutPriority:=3),(iCoreInPriority:=9,iCoreOutPriority:=2),(iCoreInPriority:=10,iCoreOutPriority:=1) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_CoreData[0].InMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(10)CoreInMode @RT(0) @RT(0) @RT(0) 
@RT(16)FPlausCoreInMode @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)Core.hmi.CoreActProgrammedVisControl 
@RT(7)In mode @RT(7)In mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_CoreData[0].OutMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(11)CoreOutMode @RT(0) @RT(0) @RT(0) 
@RT(17)FPlausCoreOutMode @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)Core.hmi.CoreActProgrammedVisControl 
@RT(8)Out mode @RT(8)Out mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_CoreData[0].bAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)Core is available on the machine 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Available @RT(14)Core available @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CoreData[0].iCoreInPriority @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(39)1..system.sv_NumberOfDevices[cCompCore] @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)Core.hmi.CoreActProgrammedVisControl 
@RT(12)Prio core in @RT(16)Priority core in @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CoreData[0].iCoreOutPriority @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(39)1..system.sv_NumberOfDevices[cCompCore] @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)Core.hmi.CoreActProgrammedVisControl 
@RT(13)Prio core out @RT(17)Priority core out @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_CoreData[0].rCoreInMoldAcc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(52)start acceleration mold after stopping at InPosition 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Mld Acc InPos @RT(22)Mold Accel. InPosition @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CoreData[0].rCoreInMoldDeacc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)stop acceleration mold at InPosition 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(15)Mld Deacc InPos @RT(24)Mold DeAccel. InPosition @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CoreData[0].rCoreInPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(81)Mold1.sv_MoldFwdProfVisSrc.Profile.Points[19].rStartPos..Mold1.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)Core.hmi.CoreActProgrammedVisControl 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_CoreData[0].rCoreOutMoldAcc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)start acceleration mold after stopping at OutPosition 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Mld Acc OutPos @RT(23)Mold Accel. OutPosition @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_CoreData[0].rCoreOutMoldDeacc @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)stop acceleration mold at OutPosition 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(52)system.sv_rMinPercentRamp..system.sv_rMaxPercentRamp @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Mld DeAcc. OutPos @RT(24)Mold DeAccel.OutPosition @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_CoreData[0].rCoreOutPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)0.0..Mold1.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(36)Core.hmi.CoreActProgrammedVisControl 
@RT(8)Position @RT(8)Position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_CoreType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyCoreTypeArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(8)CoreType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(11)sv_CoreType @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(8)CoreType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(12)sv_CoreType^ @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(16)cLevelProduction @RT(0) @RT(8)CoreType @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(1)y @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_CoreOff @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tyDeviceAvailable @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(15)sv_bCoresActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(27)sv_bEjectorFwdDuringMldOpen @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)Parallel movements for Ejector fwd and mold open possible 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Eject during mold open @RT(22)Eject during mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_bEjectorFwdDuringMldOpen @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)Parallel movements for Ejector fwd and mold open possible 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Eject during mold open @RT(22)Eject during mold open @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_rEjectorFwdStartPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)Ejector fwd start position (for parallel movements) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)0.0..Mold1.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(30)Ejector forward start position @RT(30)Ejector forward start position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_rEjectorFwdStartPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)Ejector fwd start position (for parallel movements) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(29)0.0..Mold1.sv_rMoldOpenPosSet @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(30)Ejector forward start position @RT(30)Ejector forward start position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bClampOpenDuringPlast @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)Parallel movements for plast and mold open 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Mold open during plast @RT(22)Mold open during plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bClampOpenDuringPlast @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)Parallel movements for plast and mold open 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(11)VG_MoldData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(22)Mold open during plast @RT(22)Mold open during plast @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
2 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erAnyIoForced @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(181)I/O forced...!{#]Any kind of IO is forced.{#]In the IO monitor one or more IOs are forced, or the simulation is active.{#]Unforce the IOs in the IO monitor or deactivate simulation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erEqualCorePriority @RT(1)2 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(347)Priority of Core%1n %2t and Core%3n %4t are equal, adapt priority settings{#]Two or more core in or core out priorities are equal.{#]Two activated cores are having the same mode (In mode or Out mode) and the same priority. <br>This leads to an error during creating the machine sequence.{#]Adapt the core in / core out priority setting in the HMI. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
