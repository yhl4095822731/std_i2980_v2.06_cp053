%IMPORT_OVER_LISTFILE_SOURCE
 Voltage

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KHW_Comp_Data
, KHW_Comp_Param

END_IMPORT

%SYSTEMVAR_DECL
  ai_Position : REAL
     %DISPLAY_LEVEL 1  %UNIT Voltage 
// AI screw pos AI screw position
;
 ai_Position_stat : BOOL
    
// AI screw pos state AI screw position state
;
 ai_Position_comp : KHW_Comp_Data
    ;
 ai_0 : REAL
    
// ai_0 ai_0
;
 ai_1 : REAL
    
// ai_1 ai_1
;
 ai_2 : REAL
    
// ai_2 ai_2
;
 ai_3 : REAL
    
// ai_3 ai_3
;
 ai_Position_parComp : KHW_Comp_Param
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
8 
@SysVar @RT(11)ai_Position @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)AI screw pos @RT(17)AI screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ai_Position @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)AI screw pos @RT(17)AI screw position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ai_Position_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)AI screw pos state @RT(23)AI screw position state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ai_Position_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)AI screw pos state @RT(23)AI screw position state @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(4)ai_0 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_0 @RT(4)ai_0 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(4)ai_0 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_0 @RT(4)ai_0 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(4)ai_1 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_1 @RT(4)ai_1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(4)ai_1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_1 @RT(4)ai_1 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(4)ai_2 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_2 @RT(4)ai_2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(4)ai_2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_2 @RT(4)ai_2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(4)ai_3 @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_3 @RT(4)ai_3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(4)ai_3 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)ai_3 @RT(4)ai_3 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


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
