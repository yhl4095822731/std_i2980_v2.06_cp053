%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData
, fmt20
, ClampingForce
, fmt41
//  Stroke
// , Force
, Stroke

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData
, cLevelStartupTechnican

END_IMPORT

%SYSTEMVAR_DECL
  sv_ClampForceLintabImpulses : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=500.0))) (* lintab for MoldHightImpulses -> ClampForce[kN] *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_ClampForceLintabImpulses.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt20 
 // Impulses

%ELEMENT sv_ClampForceLintabImpulses.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT ClampingForce 
 // Clamp force

%ELEMENT sv_ClampForceLintabImpulses.LintabPoints.uNoOfPoints
    ;
 // sv_ClampForceLintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=500.0))) (* dummy for HMI FIXME: remove/rename *)
   // RETAIN  %VARIABLE_GROUP VG_MachineData  %INPUT_LEVEL cLevelStartupTechnican

// %ELEMENT sv_ClampForceLintab.LintabPoints.Point[0].rX
 // %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Stroke 
 // Open stroke

// %ELEMENT sv_ClampForceLintab.LintabPoints.Point[0].rY
 // %PLAUSIBILITY 0.0..9999.0      %FORMAT fmt41  %UNIT Force 
 // Clamp force

// %ELEMENT sv_ClampForceLintab.LintabPoints.uNoOfPoints
    // ;
 sv_ClampForceLintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=6.0,rY:=150.0))) (* lintab for Mold open stroke -> ClampForce[kN] *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

%ELEMENT sv_ClampForceLintab.LintabPoints.Point
    
%ELEMENT sv_ClampForceLintab.LintabPoints.Point[0].rX
 %PLAUSIBILITY 0.0..9999.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt41  %UNIT Stroke 
// Open stroke Open stroke

%ELEMENT sv_ClampForceLintab.LintabPoints.Point[0].rY
 %PLAUSIBILITY 0.0..9999.0      %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmt41  %UNIT ClampingForce 
// Clamp force Clamp force

%ELEMENT sv_ClampForceLintab.LintabPoints.uNoOfPoints
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// Number of points Number of points
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
3 
@SysVar @RT(27)sv_ClampForceLintabImpulses @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @F 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=500.0))) @RT(46)lintab for MoldHightImpulses -> ClampForce[kN] 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(27)sv_ClampForceLintabImpulses @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(46)lintab for MoldHightImpulses -> ClampForce[kN] 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_ClampForceLintabImpulses.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(8)Impulses @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_ClampForceLintabImpulses.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(13)ClampingForce @RT(0) @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(11)Clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_ClampForceLintabImpulses.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ClampForceLintab @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @T 
@T 
@BEG_Attrib 
4 @RT(79)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=300.0,rY:=500.0))) @RT(34)dummy for HMI FIXME: remove/rename 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
4 
@AttrSym @RT(19)sv_ClampForceLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(34)dummy for HMI FIXME: remove/rename 
@RT(0) @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampForceLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(11)Open stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampForceLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(5)Force @RT(0) @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(11)Clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampForceLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Number of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ClampForceLintab @RT(0) @T @T @DERIVED 0 @F @RT(16)KAPPL_LintabData @F 
@T 
@BEG_Attrib 
4 @RT(77)(LintabPoints:=(uNoOfPoints:=2,Point:=(rX:=0.0,rY:=0.0),(rX:=6.0,rY:=150.0))) @RT(45)lintab for Mold open stroke -> ClampForce[kN] 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(19)sv_ClampForceLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(32)(LintabPoints:=(uNoOfPoints:=2)) @RT(45)lintab for Mold open length -> ClampForce[kN] 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_ClampForceLintab.LintabPoints.Point @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(37)(rX:=0.0,rY:=0.0),(rX:=6.0,rY:=150.0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampForceLintab.LintabPoints.Point[0].rX @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)x component 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(6)Stroke @RT(0) @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Open stroke @RT(11)Open stroke @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampForceLintab.LintabPoints.Point[0].rY @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(11)y component 
@RT(1)1 @RT(1)1 @RT(0) @RT(5)fmt41 @RT(13)ClampingForce @RT(0) @RT(0) 
@RT(11)0.0..9999.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Clamp force @RT(11)Clamp force @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_ClampForceLintab.LintabPoints.uNoOfPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)2 @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(16)Number of points @RT(16)Number of points @RT(0) @RT(0) @RT(0) 
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
