%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsMoveData
, cMoldHeightAutomatic
, cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_MoveMoldHeightAuto : tsMoveData := (MoveId:=cMoldHeightAutomatic,MoveDir:=cMoldHeightAutomatic,AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet))
    
%ELEMENT sv_MoveMoldHeightAuto.MoveId
    
// Auto Mold height auto
;
 sv_iCtrlParamSet : INT := 2 (* pid control set of speed pump  *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// Control Parameter Set Control Parameter Set
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
2 
@SysVar @RT(21)sv_MoveMoldHeightAuto @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tsMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(112)(MoveId:=cMoldHeightAutomatic,MoveDir:=cMoldHeightAutomatic,AnaOutData:=(piCtrlParamSet:=@%FU.sv_iCtrlParamSet)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_MoveMoldHeightAuto.MoveId @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(20)cMoldHeightAutomatic @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Auto @RT(16)Mold height auto @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iCtrlParamSet @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(30)pid control set of speed pump  
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Control Parameter Set @RT(21)Control Parameter Set @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iCtrlParamSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(21)Control Parameter Set @RT(21)Control Parameter Set @RT(0) @RT(0) @RT(0) 
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
