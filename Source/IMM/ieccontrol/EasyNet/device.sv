%IMPORT_OVER_LISTFILE_OBJECT
 tsDeviceId

END_IMPORT

%SYSTEMVAR_DECL
  sv_DeviceId : tsDeviceId := (CompId:=155 (* cCompEasynet, we do not use the constant here in order to allow old versions to build without error*),IndexId:=1) (* unique Device Identifier *)
     %INPUT_LEVEL 16

 // Device Id

%ELEMENT sv_DeviceId.CompId
    
 // Component Id

%ELEMENT sv_DeviceId.IndexId
    
 // Device Index
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 143 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(11)sv_DeviceId @RT(0) @T @T @DERIVED 0 @F @RT(10)tsDeviceId @F 
@T 
@BEG_Attrib 
4 @RT(129)(CompId:=155 (* cCompEasynet, we do not use the constant here in order to allow old versions to build without error*),IndexId:=1) @RT(24)unique Device Identifier 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(9)Device Id @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(11)sv_DeviceId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(39)(CompId:=cCompHeatingNozzle,IndexId:=1) @RT(24)unique Device Identifier 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(9)Device Id @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(18)sv_DeviceId.CompId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(18)cCompHeatingNozzle @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(12)Component Id @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_DeviceId.IndexId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(12)Device Index @RT(0) @RT(0) @RT(0) 
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
