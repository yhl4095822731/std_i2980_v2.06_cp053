%SYSTEMVAR_DECL
  do_Forward : BOOL
     %DISPLAY_LEVEL 1 
// DO ejector fwd DO ejector forward
;
 do_Forward_stat : BOOL
    
// DO ejector fwd state DO ejector forward state
;
 do_Backward : BOOL
     %DISPLAY_LEVEL 1 
// DO ejector bwd DO ejector backward
;
 do_Backward_stat : BOOL
    
// DO ejector bwd state DO ejector backward state
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
@SysVar @RT(10)do_Forward @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DO ejector fwd @RT(18)DO ejector forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)do_Forward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DO ejector fwd @RT(18)DO ejector forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)do_Forward_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DO ejector fwd state @RT(24)DO ejector forward state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)do_Forward_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DO ejector fwd state @RT(24)DO ejector forward state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)do_Backward @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DO ejector bwd @RT(19)DO ejector backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)do_Backward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DO ejector bwd @RT(19)DO ejector backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)do_Backward_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DO ejector bwd state @RT(25)DO ejector backward state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)do_Backward_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DO ejector bwd state @RT(25)DO ejector backward state @RT(0) @RT(0) @RT(0) 
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
