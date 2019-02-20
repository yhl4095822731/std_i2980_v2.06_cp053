%IMPORT_OVER_LISTFILE_SOURCE
 TimeReal
, fmt23

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KHW_Vel_Data

END_IMPORT

%SYSTEMVAR_DECL
  vi_ImpulseInput : KHW_Vel_Data
     %DISPLAY_LEVEL 1 
// VI screw impulse VI screw impulse input

%ELEMENT vi_ImpulseInput.periodTime
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt23  %UNIT TimeReal 
// VI screw imp. period time VI screw impulse period time
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 103 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(15)vi_ImpulseInput @RT(0) @T @T @DERIVED 0 @F @RT(12)KHW_Vel_Data @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)VI screw impulse @RT(22)VI screw impulse input @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(15)vi_ImpulseInput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)VI screw impulse @RT(22)VI screw impulse input @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)vi_ImpulseInput.periodTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt23 @RT(8)TimeReal @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)VI screw imp. period time @RT(28)VI screw impulse period time @RT(0) @RT(0) @RT(0) 
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
