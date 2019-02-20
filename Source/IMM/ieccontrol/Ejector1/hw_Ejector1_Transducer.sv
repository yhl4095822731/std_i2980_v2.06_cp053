%IMPORT_OVER_LISTFILE_SOURCE
 Voltage
, fmt22

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KHW_Comp_Data
, KHW_Comp_Param

END_IMPORT

%SYSTEMVAR_DECL
  ai_Position : REAL
     %DISPLAY_LEVEL 1  %FORMAT fmt22  %UNIT Voltage 
// AI ejector pos AI ejector position
;
 ai_Position_stat : BOOL
    
// AI ejector pos state AI ejector position state
;
 ai_Position_comp : KHW_Comp_Data
     %DISPLAY_LEVEL 1 ;
 ai_Position_parComp : KHW_Comp_Param
    ;
 di_EjectorBwd : BOOL
     %DISPLAY_LEVEL 1 
// DI ejector bwd DI ejector backward
;
 di_EjectorBwd_stat : BOOL
    
// DI ejector bwd state DI ejector backward state
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 60 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
6 
@SysVar @RT(11)ai_Position @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)AI ejector pos @RT(19)AI ejector position @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)ai_Position @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt22 @RT(7)Voltage @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)AI ejector pos @RT(19)AI ejector position @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ai_Position_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)AI ejector pos state @RT(25)AI ejector position state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ai_Position_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)AI ejector pos state @RT(25)AI ejector position state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)ai_Position_comp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)KHW_Comp_Data @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)ai_Position_comp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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


@SysVar @RT(13)di_EjectorBwd @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DI ejector bwd @RT(19)DI ejector backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)di_EjectorBwd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DI ejector bwd @RT(19)DI ejector backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)di_EjectorBwd_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DI ejector bwd state @RT(25)DI ejector backward state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)di_EjectorBwd_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DI ejector bwd state @RT(25)DI ejector backward state @RT(0) @RT(0) @RT(0) 
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
