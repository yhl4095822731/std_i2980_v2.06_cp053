%IMPORT_OVER_LISTFILE_OBJECT
 tsDeviceId
, tyMoveDataArray
, tsAddDeviceInfo
, cCompCoolingTime
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_DeviceId : tsDeviceId := (CompId:=cCompCoolingTime,IndexId:=1) (* unique Device Identifier *)
     %INPUT_LEVEL 16

 // Device Id Device Id

%ELEMENT sv_DeviceId.CompId
    
 // Component Id Component Id

%ELEMENT sv_DeviceId.IndexId
    
 // Device index Device index
;
 sv_bDeviceReady : BOOL := TRUE (* Device is ready *)
     %INPUT_LEVEL 16

 // Device ready Device ready
;
 sv_bDeviceStart : BOOL (* Start Device *)
     %INPUT_LEVEL 16

 // Start device Start device
;
 sv_NumberOfMovements : DINT (* Number of linked sv_MoveXxx *)
     %INPUT_LEVEL 16

 // Number of movements Number of movements
;
 sv_Movements : tyMoveDataArray (* Refto-array of all sv_MoveXxx *)
     %INPUT_LEVEL 16
;
 sv_bDeviceActivated : BOOL := TRUE (* Device is activated *)
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator

// Activated Device activated
;
 sv_AddDeviceInfo : tsAddDeviceInfo := (prActValue:=@%FU.sv_rActCoolingTime)
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 22 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
7 
@SysVar @RT(11)sv_DeviceId @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsDeviceId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(37)(CompId:=cCompCoolingTime,IndexId:=1) @RT(24)unique Device Identifier 
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


@SysVar @RT(15)sv_bDeviceReady @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(15)Device is ready 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Device ready @RT(12)Device ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_bDeviceReady @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)Device is ready 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Device ready @RT(12)Device ready @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_bDeviceStart @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)Start Device 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Start device @RT(12)Start device @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_bDeviceStart @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(12)Start Device 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Start device @RT(12)Start device @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_NumberOfMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)Number of linked sv_MoveXxx 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Number of movements @RT(19)Number of movements @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_NumberOfMovements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(27)Number of linked sv_MoveXxx 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Number of movements @RT(19)Number of movements @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_Movements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyMoveDataArray @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)Refto-array of all sv_MoveXxx 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_Movements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)Refto-array of all sv_MoveXxx 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bDeviceActivated @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(19)Device is activated 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Activated @RT(16)Device activated @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bDeviceActivated @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)Device is ready 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Activated @RT(16)Device activated @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_AddDeviceInfo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsAddDeviceInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(37)(prActValue:=@%FU.sv_rActCoolingTime) @RT(0) 
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
