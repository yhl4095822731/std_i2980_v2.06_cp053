%IMPORT_OVER_LISTFILE_SOURCE
 Stroke
, fmt41
, VG_MachineData
, YesNo
, Time
, fmt32
, Percent
, fmt31
, fmt23

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsControlParameters
, tpMoveData
, KAPPL_LintabData
, cLevelProcessOperator
, cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_rToggleLeverSetPosition : REAL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt41  %UNIT Stroke 
// Set position end movement Set position end movement
;
 sv_MoldPosControlParam : tsControlParameters
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_MoldPosControlParam.bUsePIDControl
     %FORMAT YesNo 
// Use position control Use position control

%ELEMENT sv_MoldPosControlParam.dTN
     %FORMAT fmt32  %UNIT Time 
// I

%ELEMENT sv_MoldPosControlParam.dTV
     %FORMAT fmt32  %UNIT Time 
// D

%ELEMENT sv_MoldPosControlParam.rP
     %FORMAT fmt32 
// Gain P Gain P
;
 sv_rForcePositionControl : REAL := 20.0
 %PLAUSIBILITY 0.0..100.0    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt31  %UNIT Percent 
// Set force at position control Set force at position control
;
 sv_rPositionTolerance : REAL := 0.01
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt23  %UNIT Stroke 
// Position tolerance Position tolerance
;
 sv_rMaxPositionTolerance : REAL := 10.0
 %PLAUSIBILITY %FU.sv_rPositionTolerance    RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt23  %UNIT Stroke 
// Max. position tolerance Max. position tolerance
;
 sv_pMoveCtrlData : tpMoveData
    ;
 sv_dMaxPosCtrlTime : TIME := T#250ms
 %PLAUSIBILITY T#0s..T#1s    RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt23  %UNIT Time 
// Max control time Max control time
;
 sv_LintabOutMoldPosCtrl : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=4,Point:=(rX:=-10.0,rY:=-10.0),(rX:=0.0,rY:=-1.0),(rX:=0.0,rY:=1.0),(rX:=10.0,rY:=10.0)))
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 121 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
8 
@SysVar @RT(26)sv_rToggleLeverSetPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Set position end movement @RT(25)Set position end movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_rToggleLeverSetPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Set position end movement @RT(25)Set position end movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_MoldPosControlParam @RT(0) @T @T @DERIVED 0 @F @RT(19)tsControlParameters @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(22)sv_MoldPosControlParam @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_MoldPosControlParam.bUsePIDControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Use position control @RT(20)Use position control @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_MoldPosControlParam.dTN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)I @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_MoldPosControlParam.dTV @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(1)D @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_MoldPosControlParam.rP @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt32 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Gain P @RT(6)Gain P @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rForcePositionControl @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)20.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Set force at position control @RT(29)Set force at position control @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rForcePositionControl @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt31 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(29)Set force at position control @RT(29)Set force at position control @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_rPositionTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)0.01 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Position tolerance @RT(18)Position tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_rPositionTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(6)Stroke @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Position tolerance @RT(18)Position tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_rMaxPositionTolerance @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)10.0 @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)%FU.sv_rPositionTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max. position tolerance @RT(23)Max. position tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_rMaxPositionTolerance @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(14)VG_MachineData @RT(5)fmt23 @RT(6)Stroke @RT(0) @RT(0) 
@RT(25)%FU.sv_rPositionTolerance @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(23)Max. position tolerance @RT(23)Max. position tolerance @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_pMoveCtrlData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tpMoveData @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(18)sv_dMaxPosCtrlTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(7)T#250ms @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max control time @RT(16)Max control time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dMaxPosCtrlTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)T#250ms @RT(0) 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(5)fmt23 @RT(4)Time @RT(0) @RT(0) 
@RT(10)T#0s..T#1s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Max control time @RT(16)Max control time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_LintabOutMoldPosCtrl @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(118)(LintabPoints:=(uNoOfPoints:=4,Point:=(rX:=-10.0,rY:=-10.0),(rX:=0.0,rY:=-1.0),(rX:=0.0,rY:=1.0),(rX:=10.0,rY:=10.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


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
