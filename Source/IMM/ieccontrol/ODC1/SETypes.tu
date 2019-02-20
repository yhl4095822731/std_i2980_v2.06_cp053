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

contains type and constant declarations for safety editor 
*)

CONSTANT
 cSafetyListLen : DINT := 200 (* array length of safety program variable *);
 cINTERPRETER_VERSION : DWORD := 16#0100 (* IEC Safety Interpreter version *);
 cSEStackSize : INT := 8 (* size of stack for condition evaluation in ABSEInterpreter *);
 cMaxSafetyMovements : DINT := 32 (* max. number of safety relevant movements *);
 cSE_PRGLOG_NO : INT := 0;
 cSE_PRGLOG_DEFAULT : INT := 1 (* Trace program to statusreport, Reason Default Program loaded *);
 cSE_PRGLOG_MLDDATA : INT := 2 (* Trace program to statusreport, Reason Program changed by Mold Data load *);
END_CONSTANT

TYPE
 tySafetyMovementList : ARRAY  [1..cMaxSafetyMovements] OF UINT (* all mold safety relevant movments (tsMoveData.iSafetyIdentifier = 1), points to system.sv_MovementsAvailable[].,  *);
 tySafetyMovementBOOL : ARRAY  [1..cMaxSafetyMovements] OF BOOL;
 tsSafetyInstruction : 
   STRUCT 
    Operator : UINT (* Operator: see "cSEO_" constants in SECommands.tu *);
    Condition : UINT (* Condition: see "cSEC_" constants in SECommands.tu *);
    ParamType : UINT (* Type: see "cSET_" constants in SECommands.tu *);
    sParameter : STRING(70) (* String parameter, meaning depends on Operator and ParamType *);
   END_STRUCT;
 tySafetyList : ARRAY  [1..cSafetyListLen] OF tsSafetyInstruction (* instruction list *);
 tsSafetyCondition : 
   STRUCT 
    iProgVersion : DWORD (* version of safety program *);
    bDataAvailable : BOOL (* some safety program has been loaded (if false, standard safety program will be loaded) *);
    List : tySafetyList (* instruction list *);
   END_STRUCT (* contains safety program *);
 tsSafetyHMICom : 
   STRUCT 
    iVersion : DWORD := cINTERPRETER_VERSION (* version of safety program interpreter in IEC *);
    bAvailable : BOOL (* IEC detected option "SafetyEditor"  *);
    iListDataChanged : DWORD (* IEC signals that safety program has changed and is interpreted, HMI should update Safety Editor  mask *);
    MovementAllowed : DWORD (* IEC signals allowed movements to HMI, the corresponding movement for each bit n can be found in  sv_SafetyMovements[n+1] *);
    MovementToActivate : DWORD (* IEC signals that a movement is to activate (start button pressed) to HMI, the corresponding movement for each bit n can be found in  sv_SafetyMovements[n+1] *);
    bSEMaskVisible : BOOL (* HMI signals that a SafetyEditor mask is visible *);
    iRestoreDefault : UINT (* HMI signals that standard safety program should be restored *);
    iNewHMIData : UINT (* HMI signals that new safety program has been written to sv_SafetyCondition and must be interpreted *);
    bTeachMode : BOOL (* HMI signals that teach mode is activated, IEC should lock all movements *);
    bOverrideDefaultSafety : BOOL (* HMI signals that ODC default safety conditions should be ignored *);
   END_STRUCT;
 tsSafetyInstructionTmp : 
   STRUCT 
    Operator : UINT (* Operator: see "cSEO_" constants in SECommands.tu *);
    Condition : UINT (* Condition: see "cSEC_" constants in SECommands.tu *);
    prParamReal : REFTO REAL;
    pbParamBool : REFTO BOOL;
    rValueReal : REAL;
   END_STRUCT;
 tySafetyListTmp : ARRAY  [1..cSafetyListLen] OF tsSafetyInstructionTmp (* temporary data for ABSEInterpreter, contains a parameter from a safetyinstruction either as a refto or a constant real value *);
 tsGlbSafetyData : 
   STRUCT 
    SafetyListTmp : tySafetyListTmp (* temporary data for ABSEInterpreter, contains a parameter from a safetyinstruction either as a refto or a constant real value *);
    bAvailable : BOOL (* contains value of sv_SafetyHMICom.bAvailable *);
    MovementAllowed : tySafetyMovementBOOL := 32(TRUE) (* IEC signals allowed movements to HMI, the corresponding movement for each array element n can be found in  sv_SafetyMovements[n] *);
    MovementToActivate : DWORD (* IEC signals that a movement is to activate (start button pressed) to HMI, the corresponding movement for each bit n can be found in  sv_SafetyMovements[n+1] *);
   END_STRUCT (* data needed for communication between ABSafetyEditor and ABSEInterpreter instances *);
 tySEStack : ARRAY  [1..cSEStackSize] OF BOOL (* stack for ABSEInterpreter *);
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 113 @Tou 25 
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

contains type and constant declarations for safety editor 
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
7 
@Constant @RT(14)cSafetyListLen @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(3)200 @RT(39)array length of safety program variable 
@END_Attrib 


@Constant @RT(20)cINTERPRETER_VERSION @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(7)16#0100 @RT(30)IEC Safety Interpreter version 
@END_Attrib 


@Constant @RT(12)cSEStackSize @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)8 @RT(57)size of stack for condition evaluation in ABSEInterpreter 
@END_Attrib 


@Constant @RT(19)cMaxSafetyMovements @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)32 @RT(40)max. number of safety relevant movements 
@END_Attrib 


@Constant @RT(13)cSE_PRGLOG_NO @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(18)cSE_PRGLOG_DEFAULT @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(60)Trace program to statusreport, Reason Default Program loaded 
@END_Attrib 


@Constant @RT(18)cSE_PRGLOG_MLDDATA @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(71)Trace program to statusreport, Reason Program changed by Mold Data load 
@END_Attrib 


@RT(17)TypeTreeContainer 
10 
@DT @RT(20)tySafetyMovementList @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxSafetyMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(113)all mold safety relevant movments (tsMoveData.iSafetyIdentifier = 1), points to system.sv_MovementsAvailable[].,  @RT(0) 
@END_Attrib 


@DT @RT(20)tySafetyMovementBOOL @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(19)cMaxSafetyMovements 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsSafetyCondition @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(12)iProgVersion @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)version of safety program @RT(0) 
@END_Attrib 

@StructElem @RT(14)bDataAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(86)some safety program has been loaded (if false, standard safety program will be loaded) @RT(0) 
@END_Attrib 

@StructElem @RT(4)List @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tySafetyList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)instruction list @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(23)contains safety program @RT(0) 
@END_Attrib 


@DT @RT(12)tySafetyList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(19)tsSafetyInstruction @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cSafetyListLen 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)instruction list @RT(0) 
@END_Attrib 


@DT @RT(19)tsSafetyInstruction @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(8)Operator @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)Operator: see "cSEO_" constants in SECommands.tu @RT(0) 
@END_Attrib 

@StructElem @RT(9)Condition @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)Condition: see "cSEC_" constants in SECommands.tu @RT(0) 
@END_Attrib 

@StructElem @RT(9)ParamType @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)Type: see "cSET_" constants in SECommands.tu @RT(0) 
@END_Attrib 

@StructElem @RT(10)sParameter @RT(0) @T @F @DT @RT(10)STRING(70) @RT(0) @T @T @STRING 0 @F @RT(2)70 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)String parameter, meaning depends on Operator and ParamType @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tsSafetyHMICom @RT(0) @T @T @STRUCT 0 10 

@StructElem @RT(8)iVersion @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(20)cINTERPRETER_VERSION @RT(44)version of safety program interpreter in IEC @RT(0) 
@END_Attrib 

@StructElem @RT(10)bAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)IEC detected option "SafetyEditor"  @RT(0) 
@END_Attrib 

@StructElem @RT(16)iListDataChanged @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(101)IEC signals that safety program has changed and is interpreted, HMI should update Safety Editor  mask @RT(0) 
@END_Attrib 

@StructElem @RT(15)MovementAllowed @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(120)IEC signals allowed movements to HMI, the corresponding movement for each bit n can be found in  sv_SafetyMovements[n+1] @RT(0) 
@END_Attrib 

@StructElem @RT(18)MovementToActivate @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(156)IEC signals that a movement is to activate (start button pressed) to HMI, the corresponding movement for each bit n can be found in  sv_SafetyMovements[n+1] @RT(0) 
@END_Attrib 

@StructElem @RT(14)bSEMaskVisible @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(47)HMI signals that a SafetyEditor mask is visible @RT(0) 
@END_Attrib 

@StructElem @RT(15)iRestoreDefault @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)HMI signals that standard safety program should be restored @RT(0) 
@END_Attrib 

@StructElem @RT(11)iNewHMIData @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(98)HMI signals that new safety program has been written to sv_SafetyCondition and must be interpreted @RT(0) 
@END_Attrib 

@StructElem @RT(10)bTeachMode @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(71)HMI signals that teach mode is activated, IEC should lock all movements @RT(0) 
@END_Attrib 

@StructElem @RT(22)bOverrideDefaultSafety @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(64)HMI signals that ODC default safety conditions should be ignored @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(32)(iVersion:=cINTERPRETER_VERSION) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(15)tySafetyListTmp @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(22)tsSafetyInstructionTmp @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(14)cSafetyListLen 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(124)temporary data for ABSEInterpreter, contains a parameter from a safetyinstruction either as a refto or a constant real value @RT(0) 
@END_Attrib 


@DT @RT(22)tsSafetyInstructionTmp @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(8)Operator @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)Operator: see "cSEO_" constants in SECommands.tu @RT(0) 
@END_Attrib 

@StructElem @RT(9)Condition @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(49)Condition: see "cSEC_" constants in SECommands.tu @RT(0) 
@END_Attrib 

@StructElem @RT(11)prParamReal @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)pbParamBool @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(10)rValueReal @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(15)tsGlbSafetyData @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(13)SafetyListTmp @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tySafetyListTmp @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(124)temporary data for ABSEInterpreter, contains a parameter from a safetyinstruction either as a refto or a constant real value @RT(0) 
@END_Attrib 

@StructElem @RT(10)bAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)contains value of sv_SafetyHMICom.bAvailable @RT(0) 
@END_Attrib 

@StructElem @RT(15)MovementAllowed @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tySafetyMovementBOOL @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(8)32(TRUE) @RT(128)IEC signals allowed movements to HMI, the corresponding movement for each array element n can be found in  sv_SafetyMovements[n] @RT(0) 
@END_Attrib 

@StructElem @RT(18)MovementToActivate @RT(0) @T @F @DT @RT(5)DWORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(156)IEC signals that a movement is to activate (start button pressed) to HMI, the corresponding movement for each bit n can be found in  sv_SafetyMovements[n+1] @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(27)(MovementAllowed:=32(TRUE)) @RT(82)data needed for communication between ABSafetyEditor and ABSEInterpreter instances @RT(0) 
@END_Attrib 


@DT @RT(9)tySEStack @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)1 @RT(12)cSEStackSize 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(25)stack for ABSEInterpreter @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
