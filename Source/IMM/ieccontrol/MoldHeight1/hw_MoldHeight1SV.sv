%SYSTEMVAR_DECL
  di_LimitSwitchForward : BOOL
     %DISPLAY_LEVEL 1 
// DI mold height limit fwd DI mold height limit forward
;
 di_LimitSwitchForward_stat : BOOL
    ;
 di_LimitSwitchBackward : BOOL
     %DISPLAY_LEVEL 1 
// DI mold height limit bwd DI mold height limit backward
;
 di_LimitSwitchBackward_stat : BOOL
    ;
 di_MotorOverload : BOOL (* fatal motor overload, need to stop movement *)
     %DISPLAY_LEVEL 1 
// MH motor overload Mold height motor overload
;
 di_Overcurrent : BOOL (* overcurrent on MH motor means movement end position is reached *)
     %DISPLAY_LEVEL 1 
// MH motor overcurrent Mold height motor overcurrent
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
@SysVar @RT(21)di_LimitSwitchForward @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)DI mold height limit fwd @RT(28)DI mold height limit forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)di_LimitSwitchForward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)DI mold height limit fwd @RT(28)DI mold height limit forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)di_LimitSwitchForward_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(22)di_LimitSwitchBackward @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)DI mold height limit bwd @RT(29)DI mold height limit backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)di_LimitSwitchBackward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(24)DI mold height limit bwd @RT(29)DI mold height limit backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(27)di_LimitSwitchBackward_stat @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(16)di_MotorOverload @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)fatal motor overload, need to stop movement 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)MH motor overload @RT(26)Mold height motor overload @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)di_MotorOverload @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)fatal motor overload, need to stop movement 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)MH motor overload @RT(26)Mold height motor overload @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)di_Overcurrent @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(62)overcurrent on MH motor means movement end position is reached 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)MH motor overcurrent @RT(29)Mold height motor overcurrent @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)di_Overcurrent @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(62)overcurrent on MH motor means movement end position is reached 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)MH motor overcurrent @RT(29)Mold height motor overcurrent @RT(0) @RT(0) @RT(0) 
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
