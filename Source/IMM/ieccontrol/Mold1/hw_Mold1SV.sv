%IMPORT_OVER_LISTFILE_SOURCE
 Voltage
, fmt32

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KHW_Comp_Data
, KHW_Comp_Param

END_IMPORT

%SYSTEMVAR_DECL
  ai_Position : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmt32  %UNIT Voltage 
// AI mold pos AI mold position
;
 ai_Position_stat : BOOL
    
// AI mold pos state AI mold position state
;
 ai_Position_comp : KHW_Comp_Data
    ;
 ai_Position_parComp : KHW_Comp_Param
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 113 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(11)ai_Position @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt32 @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)AI mold pos @RT(16)AI mold position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ai_Position @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(5)fmt32 @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)AI mold pos @RT(16)AI mold position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ai_Position_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)AI mold pos state @RT(22)AI mold position state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ai_Position_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)AI mold pos state @RT(22)AI mold position state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ai_Position_comp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)KHW_Comp_Data @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(19)ai_Position_parComp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)KHW_Comp_Param @RT(0) @T @T @UNKNOWN 0 @F 
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
