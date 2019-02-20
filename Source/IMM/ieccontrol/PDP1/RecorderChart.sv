%IMPORT_OVER_LISTFILE_SOURCE
 TriggerIdx

END_IMPORT

%SYSTEMVAR_DECL
  sv_TriggerIdxRecPQ : UDINT
     %FORMAT TriggerIdx 
// Trigger of movement Trigger of movement
;
 sv_bEnergyCycleHoldRun : BOOL (* Cyclic energy chart hold / run *)
    ;
 sv_bPQChartHoldRun : BOOL (* PQ chart hold / run *)
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 131 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
3 
@SysVar @RT(18)sv_TriggerIdxRecPQ @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)TriggerIdx @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Trigger of movement @RT(19)Trigger of movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_TriggerIdxRecPQ @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)TriggerIdx @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Trigger of movement @RT(19)Trigger of movement @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bEnergyCycleHoldRun @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)Cyclic energy chart hold / run 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bEnergyCycleHoldRun @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)Cyclic energy chart hold / run 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_bPQChartHoldRun @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)PQ chart hold / run 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_bPQChartHoldRun @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)PQ chart hold / run 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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
