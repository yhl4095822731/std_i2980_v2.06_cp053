%IMPORT_OVER_LISTFILE_OBJECT
 tsLintabLoaderData

END_IMPORT

%SYSTEMVAR_DECL
  sv_LintabLoaderDataClampForce : tsLintabLoaderData := (sName:='moldheight',pLintab:=@%FU.sv_ClampForceLintab)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Mold height - clamp force curve

%ELEMENT sv_LintabLoaderDataClampForce.HMIComm
    
%ELEMENT sv_LintabLoaderDataClampForce.HMIComm.sActFileName
   RETAIN 
%ELEMENT sv_LintabLoaderDataClampForce.sName
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Mold height - clamp force curve
;
 sv_LintabLoaderDataClmpForceImp : tsLintabLoaderData := (sName:='moldheightimpulse',pLintab:=@%FU.sv_ClampForceLintabImpulses)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Mold height - clamp force curve

%ELEMENT sv_LintabLoaderDataClmpForceImp.HMIComm
    
%ELEMENT sv_LintabLoaderDataClmpForceImp.HMIComm.sActFileName
   RETAIN 
%ELEMENT sv_LintabLoaderDataClmpForceImp.sName
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Mold height - clamp force curve
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 93 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
2 
@SysVar @RT(29)sv_LintabLoaderDataClampForce @RT(0) @T @T @DERIVED 0 @F @RT(18)tsLintabLoaderData @F 
@T 
@BEG_Attrib 
4 @RT(55)(sName:='moldheight',pLintab:=@%FU.sv_ClampForceLintab) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Mold height - clamp force curve @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(29)sv_LintabLoaderDataClampForce @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(55)(sName:='moldheight',pLintab:=@%FU.sv_ClampForceLintab) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Mold height - clamp force curve @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_LintabLoaderDataClampForce.HMIComm @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)Interface for communication with HMI Mask 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(50)sv_LintabLoaderDataClampForce.HMIComm.sActFileName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)loaded file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_LintabLoaderDataClampForce.sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(12)'moldheight' @RT(71)instance name for lintabloader, used for debug output and for directory 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Mold height - clamp force curve @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_LintabLoaderDataClmpForceImp @RT(0) @T @T @DERIVED 0 @F @RT(18)tsLintabLoaderData @F 
@T 
@BEG_Attrib 
4 @RT(70)(sName:='moldheightimpulse',pLintab:=@%FU.sv_ClampForceLintabImpulses) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Mold height - clamp force curve @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(31)sv_LintabLoaderDataClmpForceImp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(55)(sName:='moldheight',pLintab:=@%FU.sv_ClampForceLintab) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Mold height - clamp force curve @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_LintabLoaderDataClmpForceImp.HMIComm @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(41)Interface for communication with HMI Mask 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_LintabLoaderDataClmpForceImp.HMIComm.sActFileName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(11)loaded file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_LintabLoaderDataClmpForceImp.sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(12)'moldheight' @RT(71)instance name for lintabloader, used for debug output and for directory 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(31)Mold height - clamp force curve @RT(0) @RT(0) @RT(0) @RT(0) 
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
