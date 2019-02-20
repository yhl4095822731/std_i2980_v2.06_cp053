%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, fmt32

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsVelPre
, KCTRL_Stable_Param
, cLevelServiceEngineer

END_IMPORT

%SYSTEMVAR_DECL
  sv_ConstPumpPressureVelocCalib : tsVelPre := (Velocity:=(Output:=(rRamp:=50.0)),Pressure:=(Output:=(rRamp:=50.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData ;
 sv_PressureStableParam : KCTRL_Stable_Param := (rRange:=0.01,dObservationTime:=T#1s,dTimeOut:=T#10s) (* Condition for stability during calibration *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Stab param press Stability params pressure
;
 sv_VelocityStableParam : KCTRL_Stable_Param := (rRange:=0.0,dObservationTime:=T#1s,dTimeOut:=T#10s) (* Condition for stability during calibration *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Stab param vel Stability params velocity
;
 sv_rMaxMeasurePositionRel : REAL := 0.5 (* maximum relative position of stroke for measuring: 1 .. 100% *)
 %PLAUSIBILITY 0.1..0.99    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer
 %FORMAT fmt32 
// Maximum measure position relative to mold stroke Maximum measure position relative to mold stroke
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 148 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(30)sv_ConstPumpPressureVelocCalib @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsVelPre @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(69)(Velocity:=(Output:=(rRamp:=50.0)),Pressure:=(Output:=(rRamp:=50.0))) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_ConstPumpPressureVelocCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)to be enabled later, copied from sv_ConstInjectSetup and modified 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_PressureStableParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Stable_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(53)(rRange:=0.01,dObservationTime:=T#1s,dTimeOut:=T#10s) @RT(42)Condition for stability during calibration 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Stab param press @RT(25)Stability params pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_PressureStableParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Stab param press @RT(25)Stability params pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_VelocityStableParam @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KCTRL_Stable_Param @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(52)(rRange:=0.0,dObservationTime:=T#1s,dTimeOut:=T#10s) @RT(42)Condition for stability during calibration 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Stab param vel @RT(25)Stability params velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_VelocityStableParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Stab param vel @RT(25)Stability params velocity @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_rMaxMeasurePositionRel @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.5 @RT(60)maximum relative position of stroke for measuring: 1 .. 100% 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(9)0.1..0.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(48)Maximum measure position relative to mold stroke @RT(48)Maximum measure position relative to mold stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_rMaxMeasurePositionRel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.9 @RT(60)maximum relative position of stroke for measuring: 1 .. 100% 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(14)VG_MachineData @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(9)0.1..0.99 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(48)Maximum measure position relative to mold stroke @RT(48)Maximum measure position relative to mold stroke @RT(0) @RT(0) @RT(0) 
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
