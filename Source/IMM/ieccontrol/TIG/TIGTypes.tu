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

CONSTANT
 CMD_RET_OK : DWORD := 0;
 CMD_RET_INVALID_ID : DWORD := 1;
 CMD_RET_TIMEOUT : DWORD := 2;
 CMD_RET_JOB_NOT_EXISTING : DWORD := 3;
 CMD_RET_JOB_LOCKED : DWORD := 4;
 CMD_RET_JOB_NO_JOB : DWORD := 5;
 CMD_RET_DATASET_NOT_EXISTING : DWORD := 6;
 CMD_RET_DATASET_LOCKED : DWORD := 7;
 CMD_RET_OTHERERROR : DWORD := 16#0000_FFFF;
 CMD_RET_WORKING : DWORD := 16#FFFF_FFFF;
 CMD_ID_NOCMD : DINT := 0;
 CMD_ID_JOB_START : DINT := 1;
 CMD_ID_JOB_STARTNEXT : DINT := 2;
 CMD_ID_JOB_STOP : DINT := 3;
 CMD_ID_JOB_BREAK : DINT := 4;
 CMD_ID_DATASET_SAVE : DINT := 5;
 CMD_ID_DATASET_LOAD : DINT := 6;
 cNoMaxScrapClasses : DINT := 20;
 cNoMaxArticles : DINT := 8;
END_CONSTANT

TYPE
 tsTIGMachineIdent : 
   STRUCT 
    sType : STRING(20);
    sControl : STRING(20);
    sVersion : STRING(20);
    iSerialNo : DINT;
    iProtocol : INT := 1 (* login required *);
   END_STRUCT (* 3.4 *);
 tsTIGUserChange : 
   STRUCT 
    bUserChanged : BOOL;
    sUserName : STRING(20);
    bLanguageChanged : BOOL;
    sUserLanguage : STRING(8);
   END_STRUCT (* 3.5 *);
 tTIGStandStillReasonText : WSTRING(32);
 tsTIGStandstillReasonTexts : 
   STRUCT 
    iGrp : DINT;
    iNo : DINT;
    sText : tTIGStandStillReasonText;
   END_STRUCT (* 3.6.4 *);
 tyTIGStandstillReasonTexts : ARRAY  [1..225] OF tsTIGStandstillReasonTexts (* 3.6.4 *);
 tsTIGMachineStatus : 
   STRUCT 
    iState : DINT;
    iStandstillReasonGrp : DINT;
    iStandstillReasonNo : DINT;
    StandstillReasonTexts : tyTIGStandstillReasonTexts;
    iAlarmCount : DINT;
   END_STRUCT (* 3.6 *);
 tsTIGJobArticle : 
   STRUCT 
    sArticleName : STRING(20);
   END_STRUCT;
 tyTIGJobArticle : ARRAY  [1..cNoMaxArticles] OF tsTIGJobArticle;
 tsTIGJobPartList : 
   STRUCT 
    sType : STRING(20);
    sName : STRING(20);
   END_STRUCT;
 tyTIGJobPartList : ARRAY  [1..10] OF tsTIGJobPartList;
 tsTIGJobData : 
   STRUCT 
    iJobID : DINT;
    sJobName : STRING(20);
    sJobType : STRING(10);
    sJobComment : STRING(128);
    sJobCustomer : STRING(40);
    JobSetBegin : STRING(31);
    JobSetEnd : STRING(31);
    JobActBegin : STRING(31);
    JobActEnd : STRING(31);
    JobDelivery : STRING(31);
    yJobArticle : tyTIGJobArticle;
    yJobPartList : tyTIGJobPartList;
   END_STRUCT (* 3.7.1 *);
 tsTIGJobList : 
   STRUCT 
    iJobID : DINT;
    sJobName : STRING(20);
    sJobArticle : STRING(20);
    sJobMould : STRING(20);
   END_STRUCT;
 tyTIGJobList : ARRAY  [1..10] OF tsTIGJobList (* 3.7.2 *);
 tsTIGJob : 
   STRUCT 
    jobData : tsTIGJobData;
    yJobList : tyTIGJobList;
   END_STRUCT (* 3.7 *);
 tyTIGPartsSet : ARRAY  [1..cNoMaxArticles] OF DINT;
 tsTIGProductionDataSet : 
   STRUCT 
    Cycle : TIME;
    iShots : DINT;
    yCavity : tyTIGPartsSet (* Cavity for each article *);
    yParts : tyTIGPartsSet;
   END_STRUCT (* 3.8.1 *);
 tsTIGScrap : 
   STRUCT 
    iNumber : DINT;
    iCount : DINT;
   END_STRUCT;
 tyTIGScrap : ARRAY  [1..cNoMaxScrapClasses] OF tsTIGScrap;
 tsTIGPartsAct : 
   STRUCT 
    iPartsOK : DINT;
    iPartsScrap : DINT;
    yScrap : tyTIGScrap;
   END_STRUCT;
 tyTIGPartsAct : ARRAY  [1..cNoMaxArticles] OF tsTIGPartsAct;
 tsTIGProductionDataAct : 
   STRUCT 
    bResetCounter : BOOL;
    iAbsShots : DINT;
    Cycle : TIME;
    iShots : DINT;
    yCavity : tyTIGPartsSet (* Cavity for each article *);
    yParts : tyTIGPartsAct;
   END_STRUCT (* 3.8.2 *);
 tsTIGScrapText : 
   STRUCT 
    iNumber : DINT;
    sText : STRING(32);
   END_STRUCT;
 tyTIGScrapText : ARRAY  [1..cNoMaxScrapClasses] OF tsTIGScrapText (* 3.8.3 *);
 tsTIGProductionData : 
   STRUCT 
    Set : tsTIGProductionDataSet;
    Act : tsTIGProductionDataAct;
    yScrapText : tyTIGScrapText;
   END_STRUCT (* 3.8 *);
 tyTIGProcessData : ARRAY  [1..20] OF REAL;
 tsTIGProcessData : 
   STRUCT 
    iTrigger : DINT;
    yParameter : tyTIGProcessData;
   END_STRUCT (* 3.9 *);
 tsDataSetList : 
   STRUCT 
    sName : STRING(20);
    sDT : STRING(31) (* from TIG: string *);
    dDT : DT (* to HMI: DT *);
   END_STRUCT;
 tyTIGDataSetList : ARRAY  [1..10] OF tsDataSetList (* 3.10.2 *);
 tsTIGDataSet : 
   STRUCT 
    sDataSetPath : STRING(255) (* 3.10.1 *);
    yDataSetList : tyTIGDataSetList;
   END_STRUCT (* 3.10 *);
 tsTIGDialogDef : 
   STRUCT 
    command : DINT;
    sName : STRING(20);
    sText : STRING(128);
    State : DWORD;
   END_STRUCT;
 tsTIGDialog : 
   STRUCT 
    Control : tsTIGDialogDef;
    Host : tsTIGDialogDef;
   END_STRUCT (* 3.11 *);
 tsTIG : 
   STRUCT 
    bConnect : BOOL (* 3.2 *);
    machineIdent : tsTIGMachineIdent (* 3.4 *);
    userChange : tsTIGUserChange (* 3.5 *);
    machineStatus : tsTIGMachineStatus (* 3.6 *);
    job : tsTIGJob (* 3.7 *);
    productionData : tsTIGProductionData (* 3.8 *);
    processData : tsTIGProcessData (* 3.9 *);
    dataSet : tsTIGDataSet (* 3.10 *);
    dialog : tsTIGDialog (* 3.11 *);
   END_STRUCT (* communication with TIG System *);
 tyTIGDInt : ARRAY  [] OF DINT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 60 @Tou 25 
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
19 
@Constant @RT(10)CMD_RET_OK @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(18)CMD_RET_INVALID_ID @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(15)CMD_RET_TIMEOUT @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(24)CMD_RET_JOB_NOT_EXISTING @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(18)CMD_RET_JOB_LOCKED @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@Constant @RT(18)CMD_RET_JOB_NO_JOB @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(0) 
@END_Attrib 


@Constant @RT(28)CMD_RET_DATASET_NOT_EXISTING @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(0) 
@END_Attrib 


@Constant @RT(22)CMD_RET_DATASET_LOCKED @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)7 @RT(0) 
@END_Attrib 


@Constant @RT(18)CMD_RET_OTHERERROR @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(12)16#0000_FFFF @RT(0) 
@END_Attrib 


@Constant @RT(15)CMD_RET_WORKING @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(12)16#FFFF_FFFF @RT(0) 
@END_Attrib 


@Constant @RT(12)CMD_ID_NOCMD @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(16)CMD_ID_JOB_START @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(20)CMD_ID_JOB_STARTNEXT @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@Constant @RT(15)CMD_ID_JOB_STOP @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(0) 
@END_Attrib 


@Constant @RT(16)CMD_ID_JOB_BREAK @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)4 @RT(0) 
@END_Attrib 


@Constant @RT(19)CMD_ID_DATASET_SAVE @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(0) 
@END_Attrib 


@Constant @RT(19)CMD_ID_DATASET_LOAD @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)6 @RT(0) 
@END_Attrib 


@Constant @RT(18)cNoMaxScrapClasses @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(0) 
@END_Attrib 


@Constant @RT(14)cNoMaxArticles @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)8 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
33 
@DT @RT(5)tsTIG @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(8)bConnect @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.2 @RT(0) 
@END_Attrib 

@StructElem @RT(12)machineIdent @RT(0) @T @T @DERIVED 0 @F @RT(17)tsTIGMachineIdent @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.4 @RT(0) 
@END_Attrib 

@StructElem @RT(10)userChange @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsTIGUserChange @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.5 @RT(0) 
@END_Attrib 

@StructElem @RT(13)machineStatus @RT(0) @T @T @DERIVED 0 @F @RT(18)tsTIGMachineStatus @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.6 @RT(0) 
@END_Attrib 

@StructElem @RT(3)job @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(8)tsTIGJob @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.7 @RT(0) 
@END_Attrib 

@StructElem @RT(14)productionData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(19)tsTIGProductionData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.8 @RT(0) 
@END_Attrib 

@StructElem @RT(11)processData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsTIGProcessData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.9 @RT(0) 
@END_Attrib 

@StructElem @RT(7)dataSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsTIGDataSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(4)3.10 @RT(0) 
@END_Attrib 

@StructElem @RT(6)dialog @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tsTIGDialog @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(4)3.11 @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)communication with TIG System @RT(0) 
@END_Attrib 


@DT @RT(17)tsTIGMachineIdent @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(5)sType @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sControl @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sVersion @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)iSerialNo @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)iProtocol @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(1)1 @RT(14)login required @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(14)(iProtocol:=1) @RT(3)3.4 @RT(0) 
@END_Attrib 


@DT @RT(15)tsTIGUserChange @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(12)bUserChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sUserName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bLanguageChanged @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)sUserLanguage @RT(0) @T @F @DT @RT(9)STRING(8) @RT(0) @T @T @STRING 0 @F @RT(1)8 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.5 @RT(0) 
@END_Attrib 


@DT @RT(18)tsTIGMachineStatus @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(6)iState @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(20)iStandstillReasonGrp @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(19)iStandstillReasonNo @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(21)StandstillReasonTexts @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(26)tyTIGStandstillReasonTexts @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iAlarmCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.6 @RT(0) 
@END_Attrib 


@DT @RT(26)tsTIGStandstillReasonTexts @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(4)iGrp @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)iNo @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sText @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tTIGStandStillReasonText @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.6.4 @RT(0) 
@END_Attrib 


@DT @RT(26)tyTIGStandstillReasonTexts @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(26)tsTIGStandstillReasonTexts @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(3)225 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.6.4 @RT(0) 
@END_Attrib 


@DT @RT(8)tsTIGJob @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)jobData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsTIGJobData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)yJobList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tyTIGJobList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.7 @RT(0) 
@END_Attrib 


@DT @RT(12)tsTIGJobData @RT(0) @T @T @STRUCT 0 12 

@StructElem @RT(6)iJobID @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sJobName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sJobType @RT(0) @T @F @DT @RT(10)STRING(10) @RT(0) @T @T @STRING 0 @F @RT(2)10 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)sJobComment @RT(0) @T @F @DT @RT(11)STRING(128) @RT(0) @T @T @STRING 0 @F @RT(3)128 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)sJobCustomer @RT(0) @T @F @DT @RT(10)STRING(40) @RT(0) @T @T @STRING 0 @F @RT(2)40 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)JobSetBegin @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)JobSetEnd @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)JobActBegin @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)JobActEnd @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)JobDelivery @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)yJobArticle @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tyTIGJobArticle @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)yJobPartList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyTIGJobPartList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.7.1 @RT(0) 
@END_Attrib 


@DT @RT(15)tyTIGJobArticle @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(15)tsTIGJobArticle @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cNoMaxArticles 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tyTIGJobPartList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(16)tsTIGJobPartList @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(2)10 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(16)tsTIGJobPartList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(5)sType @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
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


@DT @RT(15)tsTIGJobArticle @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(12)sArticleName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
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


@DT @RT(12)tyTIGJobList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(12)tsTIGJobList @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(2)10 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.7.2 @RT(0) 
@END_Attrib 


@DT @RT(12)tsTIGJobList @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(6)iJobID @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sJobName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)sJobArticle @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)sJobMould @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
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


@DT @RT(19)tsTIGProductionData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(3)Set @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsTIGProductionDataSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)Act @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsTIGProductionDataAct @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)yScrapText @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tyTIGScrapText @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.8 @RT(0) 
@END_Attrib 


@DT @RT(22)tsTIGProductionDataSet @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(5)Cycle @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iShots @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)yCavity @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyTIGPartsSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)Cavity for each article @RT(0) 
@END_Attrib 

@StructElem @RT(6)yParts @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyTIGPartsSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.8.1 @RT(0) 
@END_Attrib 


@DT @RT(22)tsTIGProductionDataAct @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(13)bResetCounter @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)iAbsShots @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)Cycle @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iShots @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)yCavity @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyTIGPartsSet @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)Cavity for each article @RT(0) 
@END_Attrib 

@StructElem @RT(6)yParts @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyTIGPartsAct @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.8.2 @RT(0) 
@END_Attrib 


@DT @RT(13)tyTIGPartsAct @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsTIGPartsAct @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cNoMaxArticles 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tyTIGPartsSet @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(14)cNoMaxArticles 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsTIGPartsAct @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(8)iPartsOK @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)iPartsScrap @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)yScrap @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)tyTIGScrap @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(10)tyTIGScrap @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(10)tsTIGScrap @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cNoMaxScrapClasses 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(10)tsTIGScrap @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)iNumber @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)iCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(14)tsTIGScrapText @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)iNumber @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sText @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
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


@DT @RT(14)tyTIGScrapText @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(14)tsTIGScrapText @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(18)cNoMaxScrapClasses 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(5)3.8.3 @RT(0) 
@END_Attrib 


@DT @RT(16)tsTIGProcessData @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(8)iTrigger @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)yParameter @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyTIGProcessData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(3)3.9 @RT(0) 
@END_Attrib 


@DT @RT(16)tyTIGProcessData @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(2)20 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(12)tsTIGDataSet @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(12)sDataSetPath @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(6)3.10.1 @RT(0) 
@END_Attrib 

@StructElem @RT(12)yDataSetList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tyTIGDataSetList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(4)3.10 @RT(0) 
@END_Attrib 


@DT @RT(16)tyTIGDataSetList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsDataSetList @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(2)10 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(6)3.10.2 @RT(0) 
@END_Attrib 


@DT @RT(11)tsTIGDialog @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(7)Control @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsTIGDialogDef @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)Host @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tsTIGDialogDef @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(4)3.11 @RT(0) 
@END_Attrib 


@DT @RT(14)tsTIGDialogDef @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(7)command @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sText @RT(0) @T @F @DT @RT(11)STRING(128) @RT(0) @T @T @STRING 0 @F @RT(3)128 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)State @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(9)tyTIGDInt @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)0 @RT(1)0 0 @T @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tsDataSetList @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(20) @RT(0) @T @T @STRING 0 @F @RT(2)20 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)sDT @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)from TIG: string @RT(0) 
@END_Attrib 

@StructElem @RT(3)dDT @RT(0) @T @F @DT @RT(2)DT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)to HMI: DT @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tTIGStandStillReasonText @RT(0) @T @T @RENAMED 0 @T @T @DT @RT(11)WSTRING(32) @RT(0) @T @T @STRING 0 @T @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
