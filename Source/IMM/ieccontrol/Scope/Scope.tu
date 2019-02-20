IMPORT_OVER_LISTFILE
 tsSetActUDint

END_IMPORT

CONSTANT
 cMaxScopeConfigFileCount : DINT := 20 (* max. nr. of config files *);
 cMaxScopeSamplerCount : UDINT := 5 (* max. number of samplers *);
 cScopeCmdLoad : DINT := 0 (* load command *);
 cScopeCmdListFiles : DINT := 1 (* update file list command *);
END_CONSTANT

TYPE
 tnScopeGroupAction : (nGroupActionActivate, nGroupActionDeactivate, nGroupActionAdd, nGroupActionRemove);
 tsScopeHmiCmd : 
   STRUCT 
    iCmdCtrl : DINT (* i MOD 2 = 1 starts command, i MOD 2 = 0 command done *);
    iCmdSel : DINT (* select command to run *);
    iCmdOpt : DINT (* command option *);
    iCmdRet : DINT (* return code 0 no error *);
   END_STRUCT;
 tsScopeConfigFile : 
   STRUCT 
    sName : STRING(255);
    sDevice : STRING(255);
   END_STRUCT;
 tyScopeConfigFileList : ARRAY  [1..cMaxScopeConfigFileCount] OF tsScopeConfigFile;
 tsScopeConfigFileList : 
   STRUCT 
    iFileCount : DINT;
    yFile : tyScopeConfigFileList;
   END_STRUCT;
 tsTriggerData : 
   STRUCT 
    iState : UDINT (* trigger state (0 = idle, 1 = waiting, 2 = triggered) *);
    bTriggered : BOOL (* trigger fired *);
    bPreTriggered : BOOL (* pretrigger fired *);
    iTriggerIdx : UDINT (* type of trigger to use *);
    bFallingEdge : BOOL (* true, to trigger at movement stop or custom var falling edge *);
    bVarTrigger : BOOL (* boolean variable trigger, used with iTriggerIdx = 5 *);
    pbCustomVarTrigger : REFTO BOOL (* reference to a custom boolean variable trigger *);
    dTriggerDelay : TIME (* pretrigger delay time *);
    Reduction : tsSetActUDint (* trigger occurence reduction *);
   END_STRUCT;
 tpTriggerData : REFTO tsTriggerData;
 tsSamplerData : 
   STRUCT 
    Task : TASK (* task/sampler reference *);
    sTaskName : STRING(32) (* task/sampler name *);
    iActiveVarCnt : UDINT (* number of activated variables for this sampler *);
   END_STRUCT;
 tySamplerData : ARRAY  [1..cMaxScopeSamplerCount] OF tsSamplerData;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 150 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
4 
@Constant @RT(24)cMaxScopeConfigFileCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(24)max. nr. of config files 
@END_Attrib 


@Constant @RT(21)cMaxScopeSamplerCount @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(23)max. number of samplers 
@END_Attrib 


@Constant @RT(13)cScopeCmdLoad @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(12)load command 
@END_Attrib 


@Constant @RT(18)cScopeCmdListFiles @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(24)update file list command 
@END_Attrib 


@RT(17)TypeTreeContainer 
9 
@DT @RT(18)tnScopeGroupAction @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(20)nGroupActionActivate @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)activate sampler variable @RT(0) 
@END_Attrib 
@EnumConst @RT(22)nGroupActionDeactivate @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)deactivate sampler variable @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nGroupActionAdd @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)add variable to sampler @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nGroupActionRemove @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)remove sampler variable @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsScopeHmiCmd @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(8)iCmdCtrl @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)i MOD 2 = 1 starts command, i MOD 2 = 0 command done @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCmdSel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)select command to run @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCmdOpt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)command option @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCmdRet @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)return code 0 no error @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsScopeConfigFileList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(10)iFileCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)yFile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tyScopeConfigFileList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsScopeConfigFile @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)sDevice @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tyScopeConfigFileList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsScopeConfigFile @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(24)cMaxScopeConfigFileCount 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsTriggerData @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(6)iState @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)trigger state (0 = idle, 1 = waiting, 2 = triggered) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bTriggered @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)trigger fired @RT(0) 
@END_Attrib 

@StructElem @RT(13)bPreTriggered @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)pretrigger fired @RT(0) 
@END_Attrib 

@StructElem @RT(11)iTriggerIdx @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)type of trigger to use @RT(0) 
@END_Attrib 

@StructElem @RT(12)bFallingEdge @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(60)true, to trigger at movement stop or custom var falling edge @RT(0) 
@END_Attrib 

@StructElem @RT(11)bVarTrigger @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(51)boolean variable trigger, used with iTriggerIdx = 5 @RT(0) 
@END_Attrib 

@StructElem @RT(18)pbCustomVarTrigger @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)reference to a custom boolean variable trigger @RT(0) 
@END_Attrib 

@StructElem @RT(13)dTriggerDelay @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)pretrigger delay time @RT(0) 
@END_Attrib 

@StructElem @RT(9)Reduction @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsSetActUDint @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)trigger occurence reduction @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tpTriggerData @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(13)tsTriggerData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsSamplerData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(4)Task @RT(0) @T @F @DT @RT(4)TASK @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)task/sampler reference @RT(0) 
@END_Attrib 

@StructElem @RT(9)sTaskName @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)task/sampler name @RT(0) 
@END_Attrib 

@StructElem @RT(13)iActiveVarCnt @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(46)number of activated variables for this sampler @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tySamplerData @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @F @RT(13)tsSamplerData 1 @RT(1)1 @RT(21)cMaxScopeSamplerCount 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
