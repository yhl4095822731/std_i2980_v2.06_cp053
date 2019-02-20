(*
@h    ! WARNING !
@h    The Kemro K2 system (including software) only meets category B according to EN 954-1,
@h    thus it is not intended for usage in safety-relevant control applications in the field 
@h    of personal safety (e.g. emergency stop).
@h    To implement potentially necessary safety-relevant control tasks, always use additional 
@h    external safety devices that are intended for the particular purpose, and meet the necessary 
@h    functional safety.
@h    For further information see EN 954-1 (EN ISO 13849-1) and/or the K2-x00 user manual, chapter 
@h    "CE conformity, directives and standards".

*)

IMPORT_OVER_LISTFILE
 tyTIGScrap
, tyTIGPartsSet
, cNoMaxScrapClasses

END_IMPORT

TYPE
 tsTIGHmiUserChange : 
   STRUCT 
    iUserChange : DINT;
    iLanguageChange : DINT;
    sLanguage : STRING(8);
    sUser : STRING(20);
   END_STRUCT;
 tsTIGHmiMachineStatus : 
   STRUCT 
    bStandStillReasonTextsChanged : BOOL;
    iStandStillReasonTextsLength : DINT;
   END_STRUCT;
 tsTIGHmiJobData : 
   STRUCT 
    JobSetBegin : DT;
    JobSetEnd : DT;
    JobActBegin : DT;
    JobActEnd : DT;
    JobDelivery : DT;
    iNewPartListDataCnt : DINT (* new partlistdata from TIG system *);
    bPartListChanged : BOOL (* signal new partlistdata to hmi *);
    iPartListLength : DINT;
    iArticleListLength : DINT;
   END_STRUCT;
 tsTIGHmiCommand : 
   STRUCT 
    iStart : DINT (* cmd MOD 2 = 1 starts the command, 0 ... cmd  finished *);
    cmdID : DINT (* starts the command *);
    sName : STRING(255) (* starts the command *);
    Status : DWORD (* return status *);
    sText : STRING(255) (* return text *);
   END_STRUCT;
 tsTIGHmiJob : 
   STRUCT 
    jobData : tsTIGHmiJobData;
    cmdStartJob : tsTIGHmiCommand;
    cmdStartNextJob : tsTIGHmiCommand;
    cmdStopJob : tsTIGHmiCommand;
    cmdBreakJob : tsTIGHmiCommand;
    bJobListTextsChanged : BOOL;
    iJobListTextsLength : DINT;
   END_STRUCT;
 tsTIGHmiDialog : 
   STRUCT 
    iCmdHost : tsTIGHmiCommand;
    bCmdWorking : BOOL;
   END_STRUCT;
 tyTIGHmiCavities : ARRAY  [1..32] OF BOOL;
 tsTIGHMICavities : 
   STRUCT 
    iSetCavChanged : DINT;
    ActCavSelected : tyTIGHmiCavities;
   END_STRUCT;
 tyTIGHmiScrapCount : ARRAY  [1..cNoMaxScrapClasses] OF DINT;
 tsTIGHmiProductionNewScrap : 
   STRUCT 
    bAddScrap : BOOL (* hmi wants to add new scrap (yScrapCount) to act scrap *);
    yScrapCount : tyTIGHmiScrapCount;
    yArticleSelector : tyTIGHmiScrapCount (* defines to which article the new scrap should be added, zero means all articles *);
   END_STRUCT;
 tsTIGHmiProductionDataAct : 
   STRUCT 
    iPartsSum : DINT (* number of parts produced *);
    iPartsOK : DINT (* number of parts ok, sum of all articles *);
    iCavity : DINT;
    iPartsScrap : DINT (* number of parts not ok (all scrap classes), sum of all articles *);
    NewScrap : tsTIGHmiProductionNewScrap (* hmi scrap input (new scrap) *);
    yScrap : tyTIGScrap (* scrap per scrap class, sum of all articles *);
    yPartsSumPerArticle : tyTIGPartsSet (* number of parts produced per article *);
    yScrapPerArticleSum : tyTIGPartsSet (* scrap per article (all scrap classes) *);
   END_STRUCT;
 tsTIGHmiProductionDataSet : 
   STRUCT 
    iCavity : DINT;
    iPartsOK : DINT (* number of parts ok, sum of all articles *);
   END_STRUCT;
 tsTIGHmiProductionData : 
   STRUCT 
    bScrapClassTextListChanged : BOOL;
    iScrapClassTextListLength : DINT;
    cavities : tsTIGHMICavities;
    productionDataAct : tsTIGHmiProductionDataAct;
    productionDataSet : tsTIGHmiProductionDataSet;
   END_STRUCT;
 tsTIGHmiDS2Hmi : 
   STRUCT 
    iCmd : DINT;
    sParam : STRING(20);
   END_STRUCT;
 tsTIGHmiDataSet : 
   STRUCT 
    DSCmd2Hmi : tsTIGHmiDS2Hmi;
    iDataSetListLength : DINT;
    bDataSetListChanged : BOOL;
    cmdDataSetUpload2TIG : tsTIGHmiCommand;
    cmdDataSetDownload2Ctrl : tsTIGHmiCommand;
   END_STRUCT;
 tsTIGHmi : 
   STRUCT 
    bIsConnected : BOOL;
    userChange : tsTIGHmiUserChange;
    machineStatus : tsTIGHmiMachineStatus;
    job : tsTIGHmiJob;
    dialog : tsTIGHmiDialog;
    productionData : tsTIGHmiProductionData;
    dataSet : tsTIGHmiDataSet;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Tou 25 
@@@BEG_Comment@@@
@h    ! WARNING !
@h    The Kemro K2 system (including software) only meets category B according to EN 954-1,
@h    thus it is not intended for usage in safety-relevant control applications in the field 
@h    of personal safety (e.g. emergency stop).
@h    To implement potentially necessary safety-relevant control tasks, always use additional 
@h    external safety devices that are intended for the particular purpose, and meet the necessary 
@h    functional safety.
@h    For further information see EN 954-1 (EN ISO 13849-1) and/or the K2-x00 user manual, chapter 
@h    "CE conformity, directives and standards".

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
0 
@RT(17)TypeTreeContainer 
16 
@DT @RT(8)tsTIGHmi @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(12)bIsConnected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)userChange @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tsTIGHmiUserChange @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)machineStatus @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsTIGHmiMachineStatus @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)job @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsTIGHmiJob @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)dialog @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsTIGHmiDialog @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)productionData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsTIGHmiProductionData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)dataSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiDataSet @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(21)tsTIGHmiMachineStatus @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(29)bStandStillReasonTextsChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(28)iStandStillReasonTextsLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tsTIGHmiDataSet @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(9)DSCmd2Hmi @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsTIGHmiDS2Hmi @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)iDataSetListLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)bDataSetListChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)cmdDataSetUpload2TIG @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(23)cmdDataSetDownload2Ctrl @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(11)tsTIGHmiJob @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(7)jobData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiJobData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)cmdStartJob @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)cmdStartNextJob @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)cmdStopJob @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)cmdBreakJob @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)bJobListTextsChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)iJobListTextsLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(6)iStart @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)cmd MOD 2 = 1 starts the command, 0 ... cmd  finished @RT(0) 
@END_Attrib 

@StructElem @RT(5)cmdID @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)starts the command @RT(0) 
@END_Attrib 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(18)starts the command @RT(0) 
@END_Attrib 

@StructElem @RT(6)Status @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(13)return status @RT(0) 
@END_Attrib 

@StructElem @RT(5)sText @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)return text @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tsTIGHmiJobData @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(11)JobSetBegin @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)JobSetEnd @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)JobActBegin @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)JobActEnd @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)JobDelivery @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)iNewPartListDataCnt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)new partlistdata from TIG system @RT(0) 
@END_Attrib 

@StructElem @RT(16)bPartListChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)signal new partlistdata to hmi @RT(0) 
@END_Attrib 

@StructElem @RT(15)iPartListLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(18)iArticleListLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tsTIGHmiDialog @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)iCmdHost @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGHmiCommand @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)bCmdWorking @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(22)tsTIGHmiProductionData @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(26)bScrapClassTextListChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(25)iScrapClassTextListLength @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)cavities @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsTIGHMICavities @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)productionDataAct @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tsTIGHmiProductionDataAct @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(17)productionDataSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(25)tsTIGHmiProductionDataSet @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(25)tsTIGHmiProductionDataSet @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)iCavity @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iPartsOK @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)number of parts ok, sum of all articles @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(25)tsTIGHmiProductionDataAct @RT(0) @T @T @STRUCT 0 8 

@StructElem @RT(9)iPartsSum @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)number of parts produced @RT(0) 
@END_Attrib 

@StructElem @RT(8)iPartsOK @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)number of parts ok, sum of all articles @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCavity @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iPartsScrap @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(63)number of parts not ok (all scrap classes), sum of all articles @RT(0) 
@END_Attrib 

@StructElem @RT(8)NewScrap @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(26)tsTIGHmiProductionNewScrap @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)hmi scrap input (new scrap) @RT(0) 
@END_Attrib 

@StructElem @RT(6)yScrap @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tyTIGScrap @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)scrap per scrap class, sum of all articles @RT(0) 
@END_Attrib 

@StructElem @RT(19)yPartsSumPerArticle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyTIGPartsSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)number of parts produced per article @RT(0) 
@END_Attrib 

@StructElem @RT(19)yScrapPerArticleSum @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyTIGPartsSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(37)scrap per article (all scrap classes) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tsTIGHmiProductionNewScrap @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(9)bAddScrap @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(53)hmi wants to add new scrap (yScrapCount) to act scrap @RT(0) 
@END_Attrib 

@StructElem @RT(11)yScrapCount @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tyTIGHmiScrapCount @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)yArticleSelector @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tyTIGHmiScrapCount @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(79)defines to which article the new scrap should be added, zero means all articles @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tyTIGHmiScrapCount @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(18)cNoMaxScrapClasses 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tsTIGHmiUserChange @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(11)iUserChange @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(15)iLanguageChange @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sLanguage @RT(0) @T @F @DT @RT(9)STRING(8) @RT(0) @T @T @STRING 0 @F @RT(1)8 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sUser @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
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


@DT @RT(14)tsTIGHmiDS2Hmi @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)iCmd @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)sParam @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
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


@DT @RT(16)tsTIGHMICavities @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(14)iSetCavChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)ActCavSelected @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyTIGHmiCavities @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(16)tyTIGHmiCavities @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(2)32 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
