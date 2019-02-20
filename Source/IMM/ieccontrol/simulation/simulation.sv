%IMPORT_OVER_LISTFILE_SOURCE
 Percent
, fmt14
, InjectPressure
, fmt41
, OnOff
, fmt30
, YesNo

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData
, EasyMold_Cmd
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_PlastMotorDelintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.5),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=4.0),(rX:=4.0,rY:=6.0),(rX:=5.0,rY:=7.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=7.8),(rX:=8.0,rY:=8.2),(rX:=10.0,rY:=10.0)))
   RETAIN ;
 sv_PumpPDelintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.8),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=3.5),(rX:=4.0,rY:=5.0),(rX:=5.0,rY:=6.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=8.4),(rX:=8.0,rY:=9.2),(rX:=10.0,rY:=10.0)))
   RETAIN ;
 sv_PumpVDelintab : KAPPL_LintabData := (LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=2.0),(rX:=2.0,rY:=2.5),(rX:=3.0,rY:=3.0),(rX:=4.0,rY:=4.0),(rX:=5.0,rY:=5.0),(rX:=6.0,rY:=6.2),(rX:=7.0,rY:=7.4),(rX:=8.0,rY:=8.2),(rX:=10.0,rY:=10.0)))
   RETAIN 
%ELEMENT sv_PumpVDelintab.LintabPoints
   RETAIN ;
 sv_iMoldHeightPosActImpulses : DINT := 110 (* actual mold height position in impulses *)
   %FAST_RETAIN ;
 sv_bTriggerPMA : BOOL
    ;
 sv_KeyPMA : DINT := -1
   RETAIN ;
 sv_KVBUserLevel : DINT := 15
   RETAIN ;
 sv_KeySwitch : BOOL := TRUE
   RETAIN ;
 sv_bExhibitionMode : BOOL
   RETAIN ;
 sv_ipCmd : REFTO EasyMold_Cmd (* act easy mold cmd *)
    ;
 sv_bEasyMoldTest : BOOL := FALSE (* easy mold test active *)
    ;
 sv_MoldFullPosition : REAL := 0.0 (* mold full *)
 %PLAUSIBILITY 0.0..1.0      %FORMAT fmt14  %UNIT Percent 
// Min inject position Min inject position easyMold
;
 sv_KHW_Servo_state : DWORD
    ;
 sv_MaxPressureSimu : REAL := 1000.0 (* max pressure reachable *)
 %PLAUSIBILITY 0.0..2000.0      %FORMAT fmt41  %UNIT InjectPressure 
// Max inject pressure Max inject pressure
;
 sv_bNoiseAI : BOOL (* noise simulation for analog inputs *)
   RETAIN  %FORMAT OnOff 
// Noise AI Noise AI
;
 sv_rNoiseAmp : REAL (* amplitude of noise in % of AI range *)
 %PLAUSIBILITY 0.0..100.0    RETAIN  %FORMAT fmt30  %UNIT Percent 
// Noise Amp. Noise Amplitude
;
 sv_bRobotTurnedOn : BOOL := TRUE (* TRUE = turned on *)
   %FAST_RETAIN ;
 sv_bRobotEmergencyStop : BOOL := FALSE (* TRUE= emergency stop pressed *)
   %FAST_RETAIN ;
 sv_bSimuDeveloperMode : BOOL
   RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT YesNo 
// Use developer mode Use developer mode
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
19 
@SysVar @RT(21)sv_PlastMotorDelintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(222)(LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.5),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=4.0),(rX:=4.0,rY:=6.0),(rX:=5.0,rY:=7.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=7.8),(rX:=8.0,rY:=8.2),(rX:=10.0,rY:=10.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_PlastMotorDelintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(220)(LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.5),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=4.0),(rX:=4.0,rY:=6.0),(rX:=5.0,rY:=7.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=7.8),(rX:=8.0,rY:=8.2),(rX:=9.0,rY:=8.3))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_PumpPDelintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(222)(LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.8),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=3.5),(rX:=4.0,rY:=5.0),(rX:=5.0,rY:=6.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=8.4),(rX:=8.0,rY:=9.2),(rX:=10.0,rY:=10.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_PumpPDelintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(220)(LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.5),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=4.0),(rX:=4.0,rY:=6.0),(rX:=5.0,rY:=7.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=7.8),(rX:=8.0,rY:=8.2),(rX:=9.0,rY:=8.3))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_PumpVDelintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(222)(LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=2.0),(rX:=2.0,rY:=2.5),(rX:=3.0,rY:=3.0),(rX:=4.0,rY:=4.0),(rX:=5.0,rY:=5.0),(rX:=6.0,rY:=6.2),(rX:=7.0,rY:=7.4),(rX:=8.0,rY:=8.2),(rX:=10.0,rY:=10.0))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(16)sv_PumpVDelintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(220)(LintabPoints:=(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=0.5),(rX:=2.0,rY:=1.5),(rX:=3.0,rY:=4.0),(rX:=4.0,rY:=6.0),(rX:=5.0,rY:=7.0),(rX:=6.0,rY:=7.5),(rX:=7.0,rY:=7.8),(rX:=8.0,rY:=8.2),(rX:=9.0,rY:=8.3))) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(29)sv_PumpVDelintab.LintabPoints @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(206)(uNoOfPoints:=10,Point:=(rX:=0.0,rY:=0.0),(rX:=1.0,rY:=2.0),(rX:=2.0,rY:=2.5),(rX:=3.0,rY:=3.0),(rX:=4.0,rY:=4.0),(rX:=5.0,rY:=5.0),(rX:=6.0,rY:=6.2),(rX:=7.0,rY:=7.4),(rX:=8.0,rY:=8.2),(rX:=10.0,rY:=10.0)) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_iMoldHeightPosActImpulses @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)110 @RT(39)actual mold height position in impulses 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_iMoldHeightPosActImpulses @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)actual mold height position in impulses 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bTriggerPMA @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(9)sv_KeyPMA @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(2)-1 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(9)sv_KeyPMA @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_KVBUserLevel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(2)15 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_KVBUserLevel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_KeySwitch @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_KeySwitch @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bExhibitionMode @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bExhibitionMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_ipCmd @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(12)EasyMold_Cmd @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(17)act easy mold cmd 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(16)sv_bEasyMoldTest @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(21)easy mold test active 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)sv_MoldFullPosition @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(9)mold full 
@RT(0) @RT(0) @RT(0) @RT(5)fmt14 @RT(7)Percent @RT(0) @RT(0) 
@RT(8)0.0..1.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Min inject position @RT(28)Min inject position easyMold @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_MoldFullPosition @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(9)mold full 
@RT(0) @RT(0) @RT(0) @RT(5)fmt14 @RT(7)Percent @RT(0) @RT(0) 
@RT(8)0.0..1.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Min inject position @RT(28)Min inject position easyMold @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_KHW_Servo_state @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(18)sv_MaxPressureSimu @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(22)max pressure reachable 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(11)0.0..2000.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max inject pressure @RT(19)Max inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_MaxPressureSimu @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(6)1000.0 @RT(22)max pressure reachable 
@RT(0) @RT(0) @RT(0) @RT(5)fmt41 @RT(14)InjectPressure @RT(0) @RT(0) 
@RT(11)0.0..2000.0 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Max inject pressure @RT(19)Max inject pressure @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_bNoiseAI @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(34)noise simulation for analog inputs 
@RT(0) @RT(0) @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Noise AI @RT(8)Noise AI @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_bNoiseAI @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Noise AI @RT(8)Noise AI @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rNoiseAmp @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)amplitude of noise in % of AI range 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Noise Amp. @RT(15)Noise Amplitude @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_rNoiseAmp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(0) @RT(0) 
@RT(10)0.0..100.0 @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Noise Amp. @RT(15)Noise Amplitude @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_bRobotTurnedOn @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(16)TRUE = turned on 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_bRobotTurnedOn @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bRobotEmergencyStop @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(28)TRUE= emergency stop pressed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bRobotEmergencyStop @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)FALSE @RT(28)TRUE= emergency stop pressed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_bSimuDeveloperMode @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Use developer mode @RT(18)Use developer mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(21)sv_bSimuDeveloperMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Use developer mode @RT(18)Use developer mode @RT(0) @RT(0) @RT(0) 
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
