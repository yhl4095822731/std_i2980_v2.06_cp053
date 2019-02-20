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

%IMPORT_OVER_LISTFILE_SOURCE
 VG_OPC
, fmtString80
, fmtString30
, Time
, fmt40
, fmtTIGConnection
, OnOff

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsTIG
, tsTIGHmi
, CMD_ID_JOB_START
, CMD_ID_JOB_STARTNEXT
, CMD_ID_JOB_STOP
, CMD_ID_JOB_BREAK
, CMD_ID_DATASET_SAVE
, CMD_ID_DATASET_LOAD
, cLevelProduction

END_IMPORT

%SYSTEMVAR_DECL
  sv_TIG : tsTIG
     %VARIABLE_GROUP VG_OPC  %DISPLAY_LEVEL 1  %UPDATE_CYCLE "Slow"
%ELEMENT sv_TIG.dataSet.yDataSetList[0].dDT
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.dataSet.yDataSetList[0].sDT
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.dataSet.yDataSetList[0].sName
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.dialog
     %UPDATE_CYCLE "Fast"
%ELEMENT sv_TIG.job.jobData
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.job.jobData.JobActBegin
     %DISPLAY_LEVEL 1 
// act

%ELEMENT sv_TIG.job.jobData.JobActEnd
     %DISPLAY_LEVEL 1 
// end

%ELEMENT sv_TIG.job.jobData.JobDelivery
     %DISPLAY_LEVEL 1 
// delivery

%ELEMENT sv_TIG.job.jobData.JobSetBegin
     %DISPLAY_LEVEL 1 
// begin

%ELEMENT sv_TIG.job.jobData.JobSetEnd
     %DISPLAY_LEVEL 1 
// set

%ELEMENT sv_TIG.job.jobData.iJobID
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

// ID

%ELEMENT sv_TIG.job.jobData.sJobComment
     %DISPLAY_LEVEL 1  %FORMAT fmtString80 
// comment

%ELEMENT sv_TIG.job.jobData.sJobCustomer
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmtString30 
// customer

%ELEMENT sv_TIG.job.jobData.sJobName
     %DISPLAY_LEVEL 1 
// name

%ELEMENT sv_TIG.job.jobData.sJobType
     %DISPLAY_LEVEL 1 
// type

%ELEMENT sv_TIG.job.jobData.yJobArticle[0].sArticleName
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Act.Cycle
     %DISPLAY_LEVEL 1  %FORMAT fmt40  %UNIT Time 
%ELEMENT sv_TIG.productionData.Act.bResetCounter
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Act.iAbsShots
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Act.iShots
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Act.yCavity
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Act.yParts
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Act.yParts[0].iPartsOK
     %DISPLAY_LEVEL 1 
// ok

%ELEMENT sv_TIG.productionData.Act.yParts[0].iPartsScrap
     %DISPLAY_LEVEL 1 
// scrap

%ELEMENT sv_TIG.productionData.Act.yParts[0].yScrap[0].iCount
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Set.Cycle
     %DISPLAY_LEVEL 1  %FORMAT fmt40  %UNIT Time 
// cycletime

%ELEMENT sv_TIG.productionData.Set.iShots
     %DISPLAY_LEVEL 1 
// shots

%ELEMENT sv_TIG.productionData.Set.yCavity
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.Set.yParts
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIG.productionData.yScrapText
     %DISPLAY_LEVEL 1 ;
 sv_TIGHmi : tsTIGHmi := (job:=(cmdStartJob:=(cmdID:=CMD_ID_JOB_START),cmdStartNextJob:=(cmdID:=CMD_ID_JOB_STARTNEXT),cmdStopJob:=(cmdID:=CMD_ID_JOB_STOP),cmdBreakJob:=(cmdID:=CMD_ID_JOB_BREAK)),dataSet:=(cmdDataSetUpload2TIG:=(cmdID:=CMD_ID_DATASET_SAVE),cmdDataSetDownload2Ctrl:=(cmdID:=CMD_ID_DATASET_LOAD)))
     %VARIABLE_GROUP VG_OPC  %DISPLAY_LEVEL 1 
%ELEMENT sv_TIGHmi.bIsConnected
     %DISPLAY_LEVEL 1  %FORMAT fmtTIGConnection 
%ELEMENT sv_TIGHmi.dataSet.cmdDataSetDownload2Ctrl.sText
     %FORMAT fmtString30 
%ELEMENT sv_TIGHmi.dataSet.cmdDataSetUpload2TIG.sText
     %FORMAT fmtString30 
%ELEMENT sv_TIGHmi.job.cmdBreakJob.Status
     %FORMAT fmtString30 
%ELEMENT sv_TIGHmi.job.cmdStartJob.sText
     %FORMAT fmtString30 
%ELEMENT sv_TIGHmi.job.cmdStartNextJob.sText
     %FORMAT fmtString30 
%ELEMENT sv_TIGHmi.job.cmdStopJob.Status
     %FORMAT fmtString30 
%ELEMENT sv_TIGHmi.productionData.cavities.ActCavSelected
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT OnOff 
// select select

%ELEMENT sv_TIGHmi.productionData.productionDataAct
     %UPDATE_CYCLE "Slow"
%ELEMENT sv_TIGHmi.productionData.productionDataAct.NewScrap.yArticleSelector
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

%ELEMENT sv_TIGHmi.productionData.productionDataAct.NewScrap.yScrapCount
 %PLAUSIBILITY 0..16#7FFFFFFF      %DISPLAY_LEVEL 1  %INPUT_LEVEL 1

%ELEMENT sv_TIGHmi.productionData.productionDataAct.iCavity
     %DISPLAY_LEVEL 1 
// cavity cavity

%ELEMENT sv_TIGHmi.productionData.productionDataAct.iPartsOK
     %DISPLAY_LEVEL 1 
// ok

%ELEMENT sv_TIGHmi.productionData.productionDataAct.iPartsScrap
     %DISPLAY_LEVEL 1 
// scrap sum

%ELEMENT sv_TIGHmi.productionData.productionDataAct.iPartsSum
     %DISPLAY_LEVEL 1 
// total

%ELEMENT sv_TIGHmi.productionData.productionDataAct.yPartsSumPerArticle
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIGHmi.productionData.productionDataAct.yScrap
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIGHmi.productionData.productionDataAct.yScrapPerArticleSum
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIGHmi.productionData.productionDataAct.yScrap[0].iCount
     %DISPLAY_LEVEL 1 
%ELEMENT sv_TIGHmi.productionData.productionDataSet
     %UPDATE_CYCLE "Slow"
%ELEMENT sv_TIGHmi.productionData.productionDataSet.iCavity
     %DISPLAY_LEVEL 1 
// cavity cavity

%ELEMENT sv_TIGHmi.productionData.productionDataSet.iPartsOK
     %DISPLAY_LEVEL 1 
// ok

%ELEMENT sv_TIGHmi.userChange
     %UPDATE_CYCLE "Fast";
 sv_Test : BOOL
   RETAIN 
// testshort testlong
;
 sv_bTIGAvailable : BOOL
   RETAIN ;
%END

%SYSTEM_ALARM
  erTIGEnterStandstillReason
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// enter standstill reason{#]A standstill reason is requested.{#]This is just a message, not a critical machine error. The control station recognized a standstill and requests the information about the cause from the user. Autocycle is not possible as long as no standstill reason is entered{#]This is just a message, for basic machine operation no action is required.<br>\u000aEnter a standstill reason.
 ;
  erTIGAvailable
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Control station wants to connect - activate control station, restart system{#]The control station want to connect.{#]This is just a message, not a critical machine error. The control station requests a connection.{#]This is just a message, for basic machine operation no action is required.<br>\u000aTo enable the connection activate the control station before restarting the controller.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
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
@RT(16)SveTreeContainer 
4 
@SysVar @RT(6)sv_TIG @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(5)tsTIG @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(6)VG_OPC @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
31 
@AttrSym @RT(6)sv_TIG @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(6)VG_OPC @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_TIG.dataSet.yDataSetList[0].dDT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(10)to HMI: DT 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_TIG.dataSet.yDataSetList[0].sDT @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)from TIG: string 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(36)sv_TIG.dataSet.yDataSetList[0].sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(13)sv_TIG.dialog @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(4)3.11 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(18)sv_TIG.job.jobData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_TIG.job.jobData.JobActBegin @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)act @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_TIG.job.jobData.JobActEnd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)end @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_TIG.job.jobData.JobDelivery @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)delivery @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_TIG.job.jobData.JobSetBegin @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)begin @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_TIG.job.jobData.JobSetEnd @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)set @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_TIG.job.jobData.iJobID @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)ID @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_TIG.job.jobData.sJobComment @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(11)fmtString80 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)comment @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_TIG.job.jobData.sJobCustomer @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)customer @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_TIG.job.jobData.sJobName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)name @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_TIG.job.jobData.sJobType @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)type @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(46)sv_TIG.job.jobData.yJobArticle[0].sArticleName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_TIG.productionData.Act.Cycle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt40 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_TIG.productionData.Act.bResetCounter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_TIG.productionData.Act.iAbsShots @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_TIG.productionData.Act.iShots @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_TIG.productionData.Act.yCavity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)Cavity for each article 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_TIG.productionData.Act.yParts @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_TIG.productionData.Act.yParts[0].iPartsOK @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)ok @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_TIG.productionData.Act.yParts[0].iPartsScrap @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)scrap @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_TIG.productionData.Act.yParts[0].yScrap[0].iCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_TIG.productionData.Set.Cycle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(5)fmt40 @RT(4)Time @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)cycletime @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_TIG.productionData.Set.iShots @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)shots @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_TIG.productionData.Set.yCavity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)Cavity for each article 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_TIG.productionData.Set.yParts @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_TIG.productionData.yScrapText @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(9)sv_TIGHmi @RT(0) @T @T @DERIVED 0 @F @RT(8)tsTIGHmi @F 
@T 
@BEG_Attrib 
4 @RT(286)(job:=(cmdStartJob:=(cmdID:=CMD_ID_JOB_START),cmdStartNextJob:=(cmdID:=CMD_ID_JOB_STARTNEXT),cmdStopJob:=(cmdID:=CMD_ID_JOB_STOP),cmdBreakJob:=(cmdID:=CMD_ID_JOB_BREAK)),dataSet:=(cmdDataSetUpload2TIG:=(cmdID:=CMD_ID_DATASET_SAVE),cmdDataSetDownload2Ctrl:=(cmdID:=CMD_ID_DATASET_LOAD))) @RT(0) 
@RT(1)1 @RT(0) @RT(6)VG_OPC @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
24 
@AttrSym @RT(9)sv_TIGHmi @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(286)(job:=(cmdStartJob:=(cmdID:=CMD_ID_JOB_START),cmdStartNextJob:=(cmdID:=CMD_ID_JOB_STARTNEXT),cmdStopJob:=(cmdID:=CMD_ID_JOB_STOP),cmdBreakJob:=(cmdID:=CMD_ID_JOB_BREAK)),dataSet:=(cmdDataSetUpload2TIG:=(cmdID:=CMD_ID_DATASET_SAVE),cmdDataSetDownload2Ctrl:=(cmdID:=CMD_ID_DATASET_LOAD))) @RT(0) 
@RT(1)1 @RT(0) @RT(6)VG_OPC @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(22)sv_TIGHmi.bIsConnected @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(16)fmtTIGConnection @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(47)sv_TIGHmi.dataSet.cmdDataSetDownload2Ctrl.sText @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(44)sv_TIGHmi.dataSet.cmdDataSetUpload2TIG.sText @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_TIGHmi.job.cmdBreakJob.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_TIGHmi.job.cmdStartJob.sText @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_TIGHmi.job.cmdStartNextJob.sText @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_TIGHmi.job.cmdStopJob.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(11)fmtString30 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(48)sv_TIGHmi.productionData.cavities.ActCavSelected @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)select @RT(6)select @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_TIGHmi.productionData.productionDataAct @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(68)sv_TIGHmi.productionData.productionDataAct.NewScrap.yArticleSelector @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(79)defines to which article the new scrap should be added, zero means all articles 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(63)sv_TIGHmi.productionData.productionDataAct.NewScrap.yScrapCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(14)0..16#7FFFFFFF @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(50)sv_TIGHmi.productionData.productionDataAct.iCavity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)cavity @RT(6)cavity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(51)sv_TIGHmi.productionData.productionDataAct.iPartsOK @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)ok @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(54)sv_TIGHmi.productionData.productionDataAct.iPartsScrap @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)scrap sum @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(52)sv_TIGHmi.productionData.productionDataAct.iPartsSum @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)total @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_TIGHmi.productionData.productionDataAct.yPartsSumPerArticle @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)number of parts produced per article 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(49)sv_TIGHmi.productionData.productionDataAct.yScrap @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)scrap per scrap class, sum of all articles 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(62)sv_TIGHmi.productionData.productionDataAct.yScrapPerArticleSum @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(37)scrap per article (all scrap classes) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_TIGHmi.productionData.productionDataAct.yScrap[0].iCount @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(42)sv_TIGHmi.productionData.productionDataSet @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(50)sv_TIGHmi.productionData.productionDataSet.iCavity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)cavity @RT(6)cavity @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(51)sv_TIGHmi.productionData.productionDataSet.iPartsOK @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(2)ok @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_TIGHmi.userChange @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(7)sv_Test @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)testshort @RT(8)testlong @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(7)sv_Test @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)testshort @RT(8)testlong @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bTIGAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
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
@AttrSym @RT(16)sv_bTIGAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
2 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erTIGEnterStandstillReason @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(401)enter standstill reason{#]A standstill reason is requested.{#]This is just a message, not a critical machine error. The control station recognized a standstill and requests the information about the cause from the user. Autocycle is not possible as long as no standstill reason is entered{#]This is just a message, for basic machine operation no action is required.<br>\u000aEnter a standstill reason. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erTIGAvailable @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(387)Control station wants to connect - activate control station, restart system{#]The control station want to connect.{#]This is just a message, not a critical machine error. The control station requests a connection.{#]This is just a message, for basic machine operation no action is required.<br>\u000aTo enable the connection activate the control station before restarting the controller. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
