%IMPORT_OVER_LISTFILE_SOURCE
 YesNo
, TimeMs
, fmt50
, ScopeTriggerState
, ScopeTriggerIdx
, ScopeMeasureMode
, fmt61
, Time
, ScopeExportMode

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsScopeConfigFileList
, tsScopeHmiCmd
, tsTriggerData
, tsSetActTime
, tsSetActUDint
, cLevelServiceEngineer
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_ScopeConfigFileList : tsScopeConfigFileList (* list of scope configuration files *)
    ;
 sv_ScopeHmiCmd : tsScopeHmiCmd (* hmi command interface *)
    ;
 sv_StartTrigger : tsTriggerData := (pbCustomVarTrigger:=@%FU.sv_StartTrigger.bVarTrigger,Reduction:=(iSet:=1)) (* start trigger settings *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_StartTrigger.Reduction.iSet
 %PLAUSIBILITY 1..999    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Start counter Start counter

%ELEMENT sv_StartTrigger.bFallingEdge
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT YesNo 
// Use falling edge Use falling edge

%ELEMENT sv_StartTrigger.dTriggerDelay
 %PLAUSIBILITY t#0s..t#99.999s    RETAIN  %FORMAT fmt50  %UNIT TimeMs 
// Start trigger delay Start trigger delay

%ELEMENT sv_StartTrigger.iState
     %FORMAT ScopeTriggerState 
%ELEMENT sv_StartTrigger.iTriggerIdx
   RETAIN  %FORMAT ScopeTriggerIdx 
// Start trigger Start trigger
;
 sv_StopTrigger : tsTriggerData := (pbCustomVarTrigger:=@%FU.sv_StopTrigger.bVarTrigger,Reduction:=(iSet:=1)) (* stop trigger settings *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_StopTrigger.Reduction.iSet
 %PLAUSIBILITY 1..999    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Stop counter Stop counter

%ELEMENT sv_StopTrigger.bFallingEdge
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT YesNo 
// Use falling edge Use falling edge

%ELEMENT sv_StopTrigger.dTriggerDelay
 %PLAUSIBILITY t#0s..t#99.999s    RETAIN  %FORMAT fmt50  %UNIT TimeMs 
// Stop trigger delay Stop trigger delay

%ELEMENT sv_StopTrigger.iState
     %FORMAT ScopeTriggerState 
%ELEMENT sv_StopTrigger.iTriggerIdx
   RETAIN  %FORMAT ScopeTriggerIdx 
// Stop trigger Stop trigger
;
 sv_sConfigName : STRING(255) := '---' (* configuration name *)
    
// Active Configuration Active configuration
;
 sv_bMeasureTimeStop : BOOL (* stop the cycle when the measure time reached *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT YesNo 
// Stop at measure time Stop at measure time expire
;
 sv_iMeasureState : UDINT (* current measure state *)
     %FORMAT ScopeMeasureMode 
// Measurement state Measurement state
;
 sv_MeasureTime : tsSetActTime := (dSet:=t#20.0s) (* measure time *)
     %FORMAT fmt61 
%ELEMENT sv_MeasureTime.dAct
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt61  %UNIT Time 
// Act. measure time Act. measure time

%ELEMENT sv_MeasureTime.dSet
 %PLAUSIBILITY t#0.1s..t#99999.99s    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt61  %UNIT Time 
// Measurement time Measurement time
;
 sv_MeasureCycles : tsSetActUDint := (iSet:=1) (* number of save cycles before export *)
    
%ELEMENT sv_MeasureCycles.iSet
 %PLAUSIBILITY 1..999    RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Measure cycle count Measure cycle count
;
 sv_sExportDevice : STRING(255) (* export device name (USB) *)
    
// Export device Export device
;
 sv_iExportType : UDINT (* export type (0=off, 1=copy files to USB, 2=starep to USB) *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT ScopeExportMode 
// Export type Export type
;
 sv_bActivateMeasure : BOOL (* activate measurement *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT YesNo 
// Activate measurement Activate measurement
;
%END

%SYSTEM_ALARM
  erScopeRecording
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Scope recording is active{#]Simple scope measurement is currently running.\u000a{#]The variables in the activated scope groups are recorded in the given sampler tasks. The recordings are afterwards written on the compact flash and then optionally exported onto an USB stick.{#]The alarm disappears automatically when the recording is finished. The simple scope recording can be stopped manually on the scope mask.
 ;
  erScopeNoRecording
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Scope recording could not be started{#]Simple scope recording could not be activated.{#]The start trigger occured, but the scope recording could not be started.{#]Make sure that Kemro.Scope is not connected to the control.
 ;
  erScopeNoVariables
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Scope contains no variables! Select configuration before activation{#]Simple scope recording could not be activated because no variables or variables groups were added.{#]The scope measurement was not activated. The scope functionality requires at least one variable group or variable to be configured.{#]Load a configuration file which contains a list of variables and/or variable groups to record.
 ;
  erScopeNotActivated
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Scope task %1s could not be activated! Check number of variables and measure time{#]The scope measurement for the given sampler task could not be activated.{#]The scope measurement was not activated. The main reason is that the measurement buffer could not be allocated for the given sampler. This buffer depends on the number of activated variables in the sampler, the measurement duration and the cycletime of the sampler task.{#]Following measures should be considered:\u000a<ul>\u000a<li>Reduce the number of recorded variables</li>\u000a<li>Record the variables in a sampler with a slower cycle time </li>\u000a<li>Reduce the measurement duration</li>\u000a</ul>\u000a
 ;
  erScopeFileSave
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Scope recordings could not be saved{#]The recorded samples could not be saved to a file.{#]After the recording is finished (e.g. the user aborted or the stop trigger occured) the sampler recordings are written to a file for each activated sampler. The file writing fails if these files could not be saved to the the storage.{#]Make sure the target device exists and the target folder has write permissions.
 ;
  erScopeExport
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Scope recordings could not be exported to USB{#]The recorded sampler files could not be exported to the USB drive.{#]When exporting the recorded sampler files to an USB drive, the recordings are packed into a status report to have the full system configuration. This error occurs usually if either\u000a<ul>\u000a<li>The status report generation failed </li>\u000a<li>The status report could not be copied onto the USB stick </li>\u000a</ul>{#]Make sure the USB stick is still plugged in when the status report generation is finished.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 150 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
12 
@SysVar @RT(22)sv_ScopeConfigFileList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsScopeConfigFileList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)list of scope configuration files 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(14)sv_ScopeHmiCmd @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsScopeHmiCmd @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)hmi command interface 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(15)sv_StartTrigger @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsTriggerData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(75)(pbCustomVarTrigger:=@%FU.sv_StartTrigger.bVarTrigger,Reduction:=(iSet:=1)) @RT(22)start trigger settings 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(15)sv_StartTrigger @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_StartTrigger.Reduction.iSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Start counter @RT(13)Start counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_StartTrigger.bFallingEdge @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)true, to trigger at movement stop or custom var falling edge 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Use falling edge @RT(16)Use falling edge @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_StartTrigger.dTriggerDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt50 @RT(6)TimeMs @RT(0) @RT(0) 
@RT(15)t#0s..t#99.999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Start trigger delay @RT(19)Start trigger delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_StartTrigger.iState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)trigger state 
@RT(0) @RT(0) @RT(0) @RT(17)ScopeTriggerState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_StartTrigger.iTriggerIdx @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(15)ScopeTriggerIdx @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Start trigger @RT(13)Start trigger @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_StopTrigger @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsTriggerData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(74)(pbCustomVarTrigger:=@%FU.sv_StopTrigger.bVarTrigger,Reduction:=(iSet:=1)) @RT(21)stop trigger settings 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(14)sv_StopTrigger @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_StopTrigger.Reduction.iSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Stop counter @RT(12)Stop counter @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_StopTrigger.bFallingEdge @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)true, to trigger at movement stop or custom var falling edge 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Use falling edge @RT(16)Use falling edge @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_StopTrigger.dTriggerDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt50 @RT(6)TimeMs @RT(0) @RT(0) 
@RT(15)t#0s..t#99.999s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Stop trigger delay @RT(18)Stop trigger delay @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_StopTrigger.iState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(13)trigger state 
@RT(0) @RT(0) @RT(0) @RT(17)ScopeTriggerState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_StopTrigger.iTriggerIdx @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(15)ScopeTriggerIdx @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Stop trigger @RT(12)Stop trigger @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_sConfigName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)'---' @RT(18)configuration name 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Active Configuration @RT(20)Active configuration @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_sConfigName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)'---' @RT(18)configuration name 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Active Configuration @RT(20)Active configuration @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bMeasureTimeStop @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)stop the cycle when the measure time reached 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Stop at measure time @RT(27)Stop at measure time expire @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bMeasureTimeStop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Stop at measure time @RT(27)Stop at measure time expire @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iMeasureState @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(21)current measure state 
@RT(0) @RT(0) @RT(0) @RT(16)ScopeMeasureMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Measurement state @RT(17)Measurement state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iMeasureState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(16)ScopeMeasureMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Measurement state @RT(17)Measurement state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_MeasureTime @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsSetActTime @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(15)(dSet:=t#20.0s) @RT(12)measure time 
@RT(0) @RT(0) @RT(0) @RT(5)fmt61 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(14)sv_MeasureTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(15)(dSet:=t#20.0s) @RT(12)measure time 
@RT(0) @RT(0) @RT(0) @RT(5)fmt61 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_MeasureTime.dAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt61 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. measure time @RT(17)Act. measure time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_MeasureTime.dSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)t#20.0s @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)fmt61 @RT(4)Time @RT(0) @RT(0) 
@RT(19)t#0.1s..t#99999.99s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Measurement time @RT(16)Measurement time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_MeasureCycles @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsSetActUDint @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(9)(iSet:=1) @RT(35)number of save cycles before export 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_MeasureCycles.iSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(6)1..999 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Measure cycle count @RT(19)Measure cycle count @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_sExportDevice @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)export device name (USB) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Export device @RT(13)Export device @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_sExportDevice @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)export device name (USB) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Export device @RT(13)Export device @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_iExportType @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)export type (0=off, 1=copy files to USB, 2=starep to USB) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(15)ScopeExportMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Export type @RT(11)Export type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_iExportType @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(15)ScopeExportMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Export type @RT(11)Export type @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bActivateMeasure @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)activate measurement 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Activate measurement @RT(20)Activate measurement @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bActivateMeasure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Activate measurement @RT(20)Activate measurement @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
6 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erScopeRecording @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(413)Scope recording is active{#]Simple scope measurement is currently running.\u000a{#]The variables in the activated scope groups are recorded in the given sampler tasks. The recordings are afterwards written on the compact flash and then optionally exported onto an USB stick.{#]The alarm disappears automatically when the recording is finished. The simple scope recording can be stopped manually on the scope mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erScopeNoRecording @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(222)Scope recording could not be started{#]Simple scope recording could not be activated.{#]The start trigger occured, but the scope recording could not be started.{#]Make sure that Kemro.Scope is not connected to the control. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erScopeNoVariables @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(399)Scope contains no variables! Select configuration before activation{#]Simple scope recording could not be activated because no variables or variables groups were added.{#]The scope measurement was not activated. The scope functionality requires at least one variable group or variable to be configured.{#]Load a configuration file which contains a list of variables and/or variable groups to record. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erScopeNotActivated @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(673)Scope task %1s could not be activated! Check number of variables and measure time{#]The scope measurement for the given sampler task could not be activated.{#]The scope measurement was not activated. The main reason is that the measurement buffer could not be allocated for the given sampler. This buffer depends on the number of activated variables in the sampler, the measurement duration and the cycletime of the sampler task.{#]Following measures should be considered:\u000a<ul>\u000a<li>Reduce the number of recorded variables</li>\u000a<li>Record the variables in a sampler with a slower cycle time </li>\u000a<li>Reduce the measurement duration</li>\u000a</ul>\u000a 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erScopeFileSave @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(406)Scope recordings could not be saved{#]The recorded samples could not be saved to a file.{#]After the recording is finished (e.g. the user aborted or the stop trigger occured) the sampler recordings are written to a file for each activated sampler. The file writing fails if these files could not be saved to the the storage.{#]Make sure the target device exists and the target folder has write permissions. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erScopeExport @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(534)Scope recordings could not be exported to USB{#]The recorded sampler files could not be exported to the USB drive.{#]When exporting the recorded sampler files to an USB drive, the recordings are packed into a status report to have the full system configuration. This error occurs usually if either\u000a<ul>\u000a<li>The status report generation failed </li>\u000a<li>The status report could not be copied onto the USB stick </li>\u000a</ul>{#]Make sure the USB stick is still plugged in when the status report generation is finished. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
