%SYSTEMVAR_DECL
  do_MotorOnMain : BOOL
     %DISPLAY_LEVEL 1 
// DO motor on DO motor on main
;
 do_MotorOnMain_stat : BOOL
    
// DO motor on state DO motor on main state
;
 do_MotorOnY : BOOL
     %DISPLAY_LEVEL 1 
// DO motor on Y DO motor on Y
;
 do_MotorOnY_stat : BOOL
    
// DO motor on Y state DO motor on Y state
;
 do_MotorOnDelta : BOOL
     %DISPLAY_LEVEL 1 
// DO motor delta DO motor delta
;
 do_MotorOnDelta_stat : BOOL
    
// DO motor delta state DO motor delta state
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
@SysVar @RT(14)do_MotorOnMain @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)DO motor on @RT(16)DO motor on main @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)do_MotorOnMain @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)DO motor on @RT(16)DO motor on main @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)do_MotorOnMain_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)DO motor on state @RT(22)DO motor on main state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)do_MotorOnMain_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)DO motor on state @RT(22)DO motor on main state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)do_MotorOnY @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)DO motor on Y @RT(13)DO motor on Y @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)do_MotorOnY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)DO motor on Y @RT(13)DO motor on Y @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)do_MotorOnY_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)DO motor on Y state @RT(19)DO motor on Y state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)do_MotorOnY_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)DO motor on Y state @RT(19)DO motor on Y state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)do_MotorOnDelta @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DO motor delta @RT(14)DO motor delta @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)do_MotorOnDelta @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)DO motor delta @RT(14)DO motor delta @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)do_MotorOnDelta_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DO motor delta state @RT(20)DO motor delta state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)do_MotorOnDelta_stat @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)DO motor delta state @RT(20)DO motor delta state @RT(0) @RT(0) @RT(0) 
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
