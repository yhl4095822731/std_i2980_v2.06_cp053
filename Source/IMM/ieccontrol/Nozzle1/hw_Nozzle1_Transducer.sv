%IMPORT_OVER_LISTFILE_SOURCE
 Voltage
, fmt22

END_IMPORT

%SYSTEMVAR_DECL
  ai_Position : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt22  %UNIT Voltage 
// AI nozzle pos AI nozzle position
;
 ai_Position_stat : BOOL
    
// AI nozzle pos state AI nozzle position state
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
@SysVar @RT(11)ai_Position @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)AI nozzle pos @RT(18)AI nozzle position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ai_Position @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)AI nozzle pos @RT(18)AI nozzle position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ai_Position_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)AI nozzle pos state @RT(24)AI nozzle position state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ai_Position_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)AI nozzle pos state @RT(24)AI nozzle position state @RT(0) @RT(0) @RT(0) 
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
