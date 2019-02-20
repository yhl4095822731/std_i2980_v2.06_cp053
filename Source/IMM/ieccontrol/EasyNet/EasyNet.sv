%IMPORT_OVER_LISTFILE_SOURCE
 Time

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsENCom
, tsENHmi
, tsENEventData

END_IMPORT

%SYSTEMVAR_DECL
  sv_ENCom : tsENCom
    
%ELEMENT sv_ENCom.machineStatus.iStandstillReasonTextsChanged
     %UPDATE_CYCLE "Slow";
 sv_ENHmi : tsENHmi
    ;
 sv_EasyNetEventData : tsENEventData (* EasyNet Event data to be captured by datarecorder *)
    ;
 sv_dRTC : DT
   %FAST_RETAIN ;
 sv_EasyNetRTC : DATE_AND_TIME (* EasyNet Timestamp variable to be captured by datarecorder *)
    ;
 sv_bENAvailable : BOOL
 %READ  RETAIN  %UPDATE_CYCLE "Slow";
 sv_dProdStateProductionDelay : TIME := T#60s
 %PLAUSIBILITY t#0s..t#1h    RETAIN  %UNIT Time ;
 sv_bDummyForMs : BOOL (* This is a dummy var for CR_55500 - it is not possible for HMIServer to configure a cyclic measure on a MS Prof without using a trigger var even if  we want to use KMB_MeasureBlock::DoMeasure() for sampling *)
 %PLAUSIBILITY FALSE..FALSE  %NO_ACCESS    %DISPLAY_LEVEL 16  %INPUT_LEVEL 16
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
8 
@SysVar @RT(8)sv_ENCom @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsENCom @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(52)sv_ENCom.machineStatus.iStandstillReasonTextsChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(81)must be increased by EN to signal a new resourcefile with standstillreason texts  
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(8)sv_ENHmi @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(7)tsENHmi @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(19)sv_EasyNetEventData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsENEventData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(49)EasyNet Event data to be captured by datarecorder 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(7)sv_dRTC @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(7)sv_dRTC @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(13)sv_EasyNetRTC @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)EasyNet Timestamp variable to be captured by datarecorder 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(15)sv_bENAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(2)RO @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_bENAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(2)RO @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_dProdStateProductionDelay @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#60s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#1h @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_dProdStateProductionDelay @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)T#60s @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Time @RT(0) @RT(0) 
@RT(10)t#0s..t#1h @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_bDummyForMs @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(205)This is a dummy var for CR_55500 - it is not possible for HMIServer to configure a cyclic measure on a MS Prof without using a trigger var even if  we want to use KMB_MeasureBlock::DoMeasure() for sampling 
@RT(2)16 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)FALSE..FALSE @RT(0) @RT(2)No @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_bDummyForMs @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(205)This is a dummy var for CR_55500 - it is not possible for HMIServer to configure a cyclic measure on a MS Prof without using a trigger var even if  we want to use KMB_MeasureBlock::DoMeasure() for sampling 
@RT(2)16 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(12)FALSE..FALSE @RT(0) @RT(2)No @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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
