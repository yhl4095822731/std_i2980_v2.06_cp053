%IMPORT_OVER_LISTFILE_OBJECT
 tsLintabLoaderData

END_IMPORT

%SYSTEMVAR_DECL
  sv_LintabLoaderDataToggleLever : tsLintabLoaderData := (sName:='togglelever',pLintab:=@%FU.sv_ToggleLeverLintab)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

%ELEMENT sv_LintabLoaderDataToggleLever.HMIComm.sActFileName
   RETAIN 
%ELEMENT sv_LintabLoaderDataToggleLever.sName
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Toggle lever curve
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(30)sv_LintabLoaderDataToggleLever @RT(0) @T @T @DERIVED 0 @F @RT(18)tsLintabLoaderData @F 
@T 
@BEG_Attrib 
4 @RT(57)(sName:='togglelever',pLintab:=@%FU.sv_ToggleLeverLintab) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(30)sv_LintabLoaderDataToggleLever @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(57)(sName:='togglelever',pLintab:=@%FU.sv_ToggleLeverLintab) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(51)sv_LintabLoaderDataToggleLever.HMIComm.sActFileName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)loaded file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_LintabLoaderDataToggleLever.sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(13)'togglelever' @RT(71)instance name for lintabloader, used for debug output and for directory 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Toggle lever curve @RT(0) @RT(0) @RT(0) @RT(0) 
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
