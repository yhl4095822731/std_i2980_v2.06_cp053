%IMPORT_OVER_LISTFILE_OBJECT
 tOptionId
, cOptionHydraulic
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_Options : tOptionId := cOptionHydraulic
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Options Device options
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 127 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(10)sv_Options @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)tOptionId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(16)cOptionHydraulic @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Options @RT(14)Device options @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)sv_Options @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cOptionHydraulic @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Options @RT(14)Device options @RT(0) @RT(0) @RT(0) 
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
