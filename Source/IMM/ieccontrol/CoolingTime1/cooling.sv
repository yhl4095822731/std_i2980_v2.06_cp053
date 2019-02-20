%IMPORT_OVER_LISTFILE_SOURCE
 Time
, fmt31
, LG_ActInject
, LG_CoolingTime
, VG_MoldData
, VG_SequenceData
, VG_Inject
, TimeReal

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 cLevelProduction
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_dCoolingTime : TIME := t#10s
 %PLAUSIBILITY T#0s..T#800s    RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData  %LIST_GROUP LG_ActInject(2),LG_CoolingTime(1,1)
 %VISI_CLASS CoolingTime1.hmi.CoolingTimeProgrammedVisControl  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Cooling time Cooling time
;
 sv_dRemainTime : TIME
     %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Remaining cooling time Remaining cooling time
;
 sv_dActCoolingTime : TIME
     %VARIABLE_GROUP VG_Inject  %DISPLAY_LEVEL 1  %FORMAT fmt31  %UNIT Time 
// Act. cooling time Actual cooling time
 %UPDATE_CYCLE "Fast";
 sv_rActCoolingTime : REAL (* actual cooling time as real value (for displaying in odc editor) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT TimeReal 
// Act. cooling time Actual cooling time
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
4 
@SysVar @RT(15)sv_dCoolingTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)t#10s @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_MoldData,VG_SequenceData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#800s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(35)LG_ActInject(2),LG_CoolingTime(1,1) @RT(48)CoolingTime1.hmi.CoolingTimeProgrammedVisControl 
@RT(12)Cooling time @RT(12)Cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_dCoolingTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(27)VG_MoldData,VG_SequenceData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(12)T#0s..T#800s @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(35)LG_ActInject(2),LG_CoolingTime(1,1) @RT(48)CoolingTime1.hmi.CoolingTimeProgrammedVisControl 
@RT(12)Cooling time @RT(12)Cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_dRemainTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Remaining cooling time @RT(22)Remaining cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_dRemainTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Remaining cooling time @RT(22)Remaining cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dActCoolingTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. cooling time @RT(19)Actual cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dActCoolingTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(9)VG_Inject @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. cooling time @RT(19)Actual cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_rActCoolingTime @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(64)actual cooling time as real value (for displaying in odc editor) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(8)TimeReal @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. cooling time @RT(19)Actual cooling time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_rActCoolingTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(8)TimeReal @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Act. cooling time @RT(19)Actual cooling time @RT(0) @RT(0) @RT(0) 
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
