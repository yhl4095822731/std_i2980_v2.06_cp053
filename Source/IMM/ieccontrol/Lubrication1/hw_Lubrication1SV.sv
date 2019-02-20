%IMPORT_OVER_LISTFILE_SOURCE
 fmtPosReached

END_IMPORT

%SYSTEMVAR_DECL
  di_LubLimitAchieved : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// DI lubrication level low DI lubrication level low
;
 di_LubLimitAchieved_stat : BOOL
    
// DI lubrication level low state DI lubrication level low state
;
 di_LubPressureAchieved : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16
 %FORMAT fmtPosReached 
// Lubrication pressure achieved DI lubrication pressure achieved
;
 di_LubPressureAchieved_stat : BOOL
    
// Lubrication pressure achieved state DI lubrication pressure achieved state
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 60 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(19)di_LubLimitAchieved @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)DI lubrication level low @RT(24)DI lubrication level low @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)di_LubLimitAchieved @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)DI lubrication level low @RT(24)DI lubrication level low @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)di_LubLimitAchieved_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)DI lubrication level low state @RT(30)DI lubrication level low state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)di_LubLimitAchieved_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(30)DI lubrication level low state @RT(30)DI lubrication level low state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)di_LubPressureAchieved @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Lubrication pressure achieved @RT(32)DI lubrication pressure achieved @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)di_LubPressureAchieved @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Lubrication pressure achieved @RT(32)DI lubrication pressure achieved @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)di_LubPressureAchieved_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Lubrication pressure achieved state @RT(38)DI lubrication pressure achieved state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(27)di_LubPressureAchieved_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(35)Lubrication pressure achieved state @RT(38)DI lubrication pressure achieved state @RT(0) @RT(0) @RT(0) 
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
