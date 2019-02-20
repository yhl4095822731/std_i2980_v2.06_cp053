%IMPORT_OVER_LISTFILE_SOURCE
 UseNoUse

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tyPanelButton
, cLevelServiceEngineer
, tevPanelButtonRegister

END_IMPORT

%SYSTEMVAR_DECL
  sv_PanelButtons : tyPanelButton (* Registered soft-panel buttons *)
    ;
 sv_iPanelButtonCnt : DINT (* Number of movements in sv_PanelButtons *)
    ;
 sv_iPanelMovementSelector : DINT (* Currently selected movement index in sv_iPanelButtons *)
    ;
 sv_iPanelHeartbeat : DINT (* Panel heartbeat counter. Only active, when an output is set *)
    ;
 sv_iPanelHeartbeatInterval : DINT := 100 (* Interval (ms) where the heartbeat counter has to be changed *)
    ;
 sv_iPanelHeartbeatTolerance : DINT := 60 (* Tolerance (ms) where the HMI is detected as disconnected *)
    ;
 sv_bUsePanelHeartbeat : BOOL := TRUE (* Use the panel heartbeat supervision *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT UseNoUse 
// Use panel heartbeat Use panel heartbeat
;
%END

%SYSTEMEVENT_DECL
  evPanelButtonRegister : tevPanelButtonRegister
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 150 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
7 
@SysVar @RT(15)sv_PanelButtons @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyPanelButton @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)Registered soft-panel buttons 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_iPanelButtonCnt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(38)Number of movements in sv_PanelButtons 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(25)sv_iPanelMovementSelector @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(53)Currently selected movement index in sv_iPanelButtons 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_iPanelHeartbeat @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)Panel heartbeat counter. Only active, when an output is set 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(26)sv_iPanelHeartbeatInterval @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)100 @RT(59)Interval (ms) where the heartbeat counter has to be changed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_iPanelHeartbeatInterval @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)t#100ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)sv_iPanelHeartbeatTolerance @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(2)60 @RT(56)Tolerance (ms) where the HMI is detected as disconnected 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)sv_iPanelHeartbeatTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)t#50ms @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bUsePanelHeartbeat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(35)Use the panel heartbeat supervision 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Use panel heartbeat @RT(19)Use panel heartbeat @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bUsePanelHeartbeat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Use panel heartbeat @RT(19)Use panel heartbeat @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
1 
@SysEvent @RT(21)evPanelButtonRegister @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tevPanelButtonRegister @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
0 

@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
