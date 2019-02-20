%SYSTEM_ALARM
  erODCBuilderGeneralError
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: unhandled error{#]An ODC builder error has occurred.{#]An unhandled ODC builder error occurred. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderParserException
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder Parser Exception: %1s{#]An ODC builder error has occurred.{#]The ODC parser signals a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderWarning
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder Parser Warning: %1s{#]An ODC builder error has occurred.{#]This is just a warning. The ODC parser met a non-critical problem.{#]This is just a warning, and continued operation is possible.<br><br>\u000aBut a check by an application engineer is indicated. Create a status report. Please contact the machine manufacturer.
 ;
  erODCBuilderWarningFile
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder Parser Warning: %1s - file %2s line %3n col %4n{#]An ODC builder error has occurred.{#]This is just a warning. The ODC parser met a non-critical problem.{#]This is just a warning, and continued operation is possible.<br><br>\u000aBut a check by an application engineer is indicated. Create a status report. Please contact the machine manufacturer.
 ;
  erODCBuilderError
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder Parser Error: %1s - file %2s line %3n col %4n{#]An ODC builder error has occurred.{#]The application part responsible for the online designable cycle could not parse the given information correctly. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderSyntaxError
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder Parser Syntax Error: %1s - file %2s line %3n col %4n{#]An ODC builder error has occurred.{#]A syntax error occurred in an ODC sequence file. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderNoSignature
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: File %1s has no signature{#]An ODC builder error has occurred.{#]This is just a warning. An ODC sequence file carries no signature. It cannot be used for creating the sequence.{#]This is not a crucial error. Basic operation is still possible. But a part of the machine sequence might be missing. In this case, please contact the machine manufacturer.
 ;
  erODCBuilderInvalidSignature
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: File %1s has an invalid signature{#]An ODC builder error has occurred.{#]An ODC sequence file carries an invalid signature. It cannot be used for creating the sequence. There is no further operation possible.{#]Please contact the machine manufacturer.
 ;
  erODCBuilderFileformat
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: fileformat version %1s of file %2s not supported{#]An ODC builder error has occurred.{#]The files provided for the ODC builder have the wrong fileformat version. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderInsertPosNotAvail
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: insert position %1s for insert block %2s not found in sequence{#]An ODC builder error has occurred.{#]The insert position for a movement cannot be found. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderInsertBefNotAllow
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: insert of insert block %1s before ODC.BeginSequence not allowed{#]An ODC builder error has occurred.{#]A movement should be inserted before the start of the overall ODC sequence, which is not possible. There is no further operation possible.{#]Please contact the machine manufacturer.
 ;
  erODCBuilderInsertAfterNotAllow
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: insert of insert block %1s after ODC.EndSequence not allowed{#]An ODC builder error has occurred.{#]A movement should be inserted after the end of the overall ODC sequence, which is not possible. There is no further operation possible.{#]Please contact the machine manufacturer.
 ;
  erODCBuilderMoveNotAvailable
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: movement %1s in file %2s not available in movementlist{#]An ODC builder error has occurred.{#]A movement should be inserted which is not available. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderMultipleBaseSequ
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: two or more base sequences found{#]An ODC builder error has occurred.{#]Only one base sequence is allowed within the ODC. In this case two or more have been found. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderPriorityCollision
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: priority collision of movement %1s and %2s{#]An ODC builder error has occurred.{#]Two movements should be inserted at the same place with the same priority, which is not allowed. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderBaseSeqNotFound
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: base sequence not found (%1s){#]An ODC builder error has occurred.{#]The application part responsible for the online designable cycle could not find the base sequence. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderInstancePriority
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: priority change or instance priority for movement %1s in insert block %2s necessary{#]An ODC builder error has occurred.{#]The priority information is missing or problematic for a movement insertion. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCCouldNotCreateLogFile
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: could not create logfile %1s, check configuration{#]An ODC builder error has occurred.{#]This is just a warning. The log file for ODC sequencing cannot be created.{#]This is just a warning, and continued operation is possible.<br><br>\u000aBut a check by an application engineer is indicated. Create a status report. Please contact the machine manufacturer.
 ;
  erODCBuilderFirstMovement
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: first movement in base sequence must be ODC.BeginSequence, check base sequence{#]An ODC builder error has occurred.{#]The content of the main ODC file, the base sequence, is corrupt. There is no further operation possible.{#]Please contact the machine manufacturer.
 ;
  erODCBuilderLastMovement
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: last movement in base sequence must be ODC.EndSequence, check base sequence{#]An ODC builder error has occurred.{#]The last movement in the base sequence must be the end of the overall ODC sequence. In this case it is not. There is no further operation possible.{#]Please contact the machine manufacturer.
 ;
  erODCBuilderSelectorVarValue
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: could not get value for selector variable %1s, in file %2s{#]An ODC builder error has occurred.{#]The ODC could not retrieve the value for the selector variable. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderIllegalDominantMove
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: illegal dominant movement %1s in insert block %2s{#]An ODC builder error has occurred.{#]The movement configured to be the dominant movement cannot be inserted as such. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderInsertParallel
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: invalid insert parallel at %1s of insert block %2s{#]An ODC builder error has occurred.{#]A movement should be inserted as a parallel where it is not possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderArrayTooSmall
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: sequence size exceeded, max.: %1n lines, %2n columns; act.: %3n lines, %4n columns{#]An ODC builder error has occurred.{#]The sequence size exceeds the preset limitations. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderInvalidCreateSequ
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: invalid call of CreateSequence, error %1s{#]An ODC builder error has occurred.{#]The ODC create sequence function has been called incorrectly. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderElementAlreadyUsed
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: array element line %1s column %2s already used, internal error{#]An ODC builder error has occurred.{#]A cell in the internal sequence table should be used twice, which is not possible. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCBuilderInternalError
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// ODCBuilder: internal error %1s{#]An ODC builder error has occurred.{#]An ODC builder internal error occurred. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erODCMLFExpireTime
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// MLF: Firmware detected exceeding expire time{#]Testperiod exceeded.{#]The controller firmware detected the testperiod has been exceeded. No further operation is possible.{#]Please contact the machine manufacturer to acquire a licence key. Enter the licence key to continue unlimited operation.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
0 
@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
28 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erODCBuilderGeneralError @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(253)ODCBuilder: unhandled error{#]An ODC builder error has occurred.{#]An unhandled ODC builder error occurred. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erODCBuilderParserException @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(251)ODCBuilder Parser Exception: %1s{#]An ODC builder error has occurred.{#]The ODC parser signals a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erODCBuilderWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(330)ODCBuilder Parser Warning: %1s{#]An ODC builder error has occurred.{#]This is just a warning. The ODC parser met a non-critical problem.{#]This is just a warning, and continued operation is possible.<br><br>\u000aBut a check by an application engineer is indicated. Create a status report. Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erODCBuilderWarningFile @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(358)ODCBuilder Parser Warning: %1s - file %2s line %3n col %4n{#]An ODC builder error has occurred.{#]This is just a warning. The ODC parser met a non-critical problem.{#]This is just a warning, and continued operation is possible.<br><br>\u000aBut a check by an application engineer is indicated. Create a status report. Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erODCBuilderError @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(355)ODCBuilder Parser Error: %1s - file %2s line %3n col %4n{#]An ODC builder error has occurred.{#]The application part responsible for the online designable cycle could not parse the given information correctly. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erODCBuilderSyntaxError @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(297)ODCBuilder Parser Syntax Error: %1s - file %2s line %3n col %4n{#]An ODC builder error has occurred.{#]A syntax error occurred in an ODC sequence file. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erODCBuilderNoSignature @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(362)ODCBuilder: File %1s has no signature{#]An ODC builder error has occurred.{#]This is just a warning. An ODC sequence file carries no signature. It cannot be used for creating the sequence.{#]This is not a crucial error. Basic operation is still possible. But a part of the machine sequence might be missing. In this case, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erODCBuilderInvalidSignature @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(263)ODCBuilder: File %1s has an invalid signature{#]An ODC builder error has occurred.{#]An ODC sequence file carries an invalid signature. It cannot be used for creating the sequence. There is no further operation possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erODCBuilderFileformat @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(319)ODCBuilder: fileformat version %1s of file %2s not supported{#]An ODC builder error has occurred.{#]The files provided for the ODC builder have the wrong fileformat version. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erODCBuilderInsertPosNotAvail @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(311)ODCBuilder: insert position %1s for insert block %2s not found in sequence{#]An ODC builder error has occurred.{#]The insert position for a movement cannot be found. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erODCBuilderInsertBefNotAllow @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(296)ODCBuilder: insert of insert block %1s before ODC.BeginSequence not allowed{#]An ODC builder error has occurred.{#]A movement should be inserted before the start of the overall ODC sequence, which is not possible. There is no further operation possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(31)erODCBuilderInsertAfterNotAllow @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(290)ODCBuilder: insert of insert block %1s after ODC.EndSequence not allowed{#]An ODC builder error has occurred.{#]A movement should be inserted after the end of the overall ODC sequence, which is not possible. There is no further operation possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erODCBuilderMoveNotAvailable @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(305)ODCBuilder: movement %1s in file %2s not available in movementlist{#]An ODC builder error has occurred.{#]A movement should be inserted which is not available. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erODCBuilderMultipleBaseSequ @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(321)ODCBuilder: two or more base sequences found{#]An ODC builder error has occurred.{#]Only one base sequence is allowed within the ODC. In this case two or more have been found. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erODCBuilderPriorityCollision @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(336)ODCBuilder: priority collision of movement %1s and %2s{#]An ODC builder error has occurred.{#]Two movements should be inserted at the same place with the same priority, which is not allowed. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(27)erODCBuilderBaseSeqNotFound @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(325)ODCBuilder: base sequence not found (%1s){#]An ODC builder error has occurred.{#]The application part responsible for the online designable cycle could not find the base sequence. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erODCBuilderInstancePriority @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(357)ODCBuilder: priority change or instance priority for movement %1s in insert block %2s necessary{#]An ODC builder error has occurred.{#]The priority information is missing or problematic for a movement insertion. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erODCCouldNotCreateLogFile @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(369)ODCBuilder: could not create logfile %1s, check configuration{#]An ODC builder error has occurred.{#]This is just a warning. The log file for ODC sequencing cannot be created.{#]This is just a warning, and continued operation is possible.<br><br>\u000aBut a check by an application engineer is indicated. Create a status report. Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erODCBuilderFirstMovement @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(277)ODCBuilder: first movement in base sequence must be ODC.BeginSequence, check base sequence{#]An ODC builder error has occurred.{#]The content of the main ODC file, the base sequence, is corrupt. There is no further operation possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erODCBuilderLastMovement @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(317)ODCBuilder: last movement in base sequence must be ODC.EndSequence, check base sequence{#]An ODC builder error has occurred.{#]The last movement in the base sequence must be the end of the overall ODC sequence. In this case it is not. There is no further operation possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erODCBuilderSelectorVarValue @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(319)ODCBuilder: could not get value for selector variable %1s, in file %2s{#]An ODC builder error has occurred.{#]The ODC could not retrieve the value for the selector variable. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(31)erODCBuilderIllegalDominantMove @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(326)ODCBuilder: illegal dominant movement %1s in insert block %2s{#]An ODC builder error has occurred.{#]The movement configured to be the dominant movement cannot be inserted as such. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erODCBuilderInsertParallel @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(277)ODCBuilder: invalid insert parallel at %1s of insert block %2s{#]An ODC builder error has occurred.{#]A movement should be inserted as a parallel where it is not possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erODCBuilderArrayTooSmall @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(329)ODCBuilder: sequence size exceeded, max.: %1n lines, %2n columns; act.: %3n lines, %4n columns{#]An ODC builder error has occurred.{#]The sequence size exceeds the preset limitations. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erODCBuilderInvalidCreateSequ @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(300)ODCBuilder: invalid call of CreateSequence, error %1s{#]An ODC builder error has occurred.{#]The ODC create sequence function has been called incorrectly. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(30)erODCBuilderElementAlreadyUsed @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(342)ODCBuilder: array element line %1s column %2s already used, internal error{#]An ODC builder error has occurred.{#]A cell in the internal sequence table should be used twice, which is not possible. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erODCBuilderInternalError @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(255)ODCBuilder: internal error %1s{#]An ODC builder error has occurred.{#]An ODC builder internal error occurred. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erODCMLFExpireTime @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(293)MLF: Firmware detected exceeding expire time{#]Testperiod exceeded.{#]The controller firmware detected the testperiod has been exceeded. No further operation is possible.{#]Please contact the machine manufacturer to acquire a licence key. Enter the licence key to continue unlimited operation. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
