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

contains constant declarations used for safety editor programs
*)

CONSTANT
 cSEO_NOP : UINT := 16#00 (* Operator "no operation" (e.g. line contains only additional parameter for last operation) *);
 cSEO_START : UINT := 16#01 (* start conditions for a certain movement defined in parameter as string (e.g. "Mold1.MoveFwd" *);
 cSEO_LD : UINT := 16#02 (* Load condition result, if a condition result has been calculated before this result is pushed to stack *);
 cSEO_AND : UINT := 16#03 (* AND operation with actual result and condition result *);
 cSEO_OR : UINT := 16#04 (* OR operation with actual result and condition result *);
 cSEO_XOR : UINT := 16#05 (* XOR operation with actual result and condition result *);
 cSEO_END : UINT := 16#FF (* END of program *);
 // xxxxxxxxxxxxxxx : BYTE;
 cSEC_BC_EQ_NOT : UINT := 16#10 (* Condition BOOL SV = FALSE *);
 cSEC_BC_EQ : UINT := 16#11 (* Condition BOOL SV = TRUE *);
 cSEC_BV_EQ_NOT : UINT := 16#12 (* Condition BOOL SV <> SV *);
 cSEC_BV_EQ : UINT := 16#13 (* Condition BOOL SV = SV *);
 cSEC_RC_GT : UINT := 16#20 (* Condition REAL SV > VALUE *);
 cSEC_RC_LT : UINT := 16#21 (* Condition REAL SV < VALUE *);
 cSEC_RV_GT : UINT := 16#22 (* Condition REAL SV > SV *);
 cSEC_RV_LT : UINT := 16#23 (* Condition REAL SV < SV *);
 cSEC_POP : UINT := 16#FF (* pop Condition from Stack *);
 // xxxxxxxxxxxxxxx : BYTE;
 cSET_String : UINT := 16#00 (* Param Type "String" *);
 cSET_ConstReal : UINT := 16#01 (* Param Type "Const Value", interprete Param as Real value *);
 cSET_VariableBool : UINT := 16#02 (* Param Type " Bool SV", interprete Param as name of Bool SV *);
 cSET_VariableReal : UINT := 16#03 (* Param Type "Real SV", interprete Param as name of Real SV *);
END_CONSTANT



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

contains constant declarations used for safety editor programs
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
22 
@Constant @RT(8)cSEO_NOP @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#00 @RT(89)Operator "no operation" (e.g. line contains only additional parameter for last operation) 
@END_Attrib 


@Constant @RT(10)cSEO_START @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#01 @RT(92)start conditions for a certain movement defined in parameter as string (e.g. "Mold1.MoveFwd" 
@END_Attrib 


@Constant @RT(7)cSEO_LD @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#02 @RT(102)Load condition result, if a condition result has been calculated before this result is pushed to stack 
@END_Attrib 


@Constant @RT(8)cSEO_AND @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#03 @RT(53)AND operation with actual result and condition result 
@END_Attrib 


@Constant @RT(7)cSEO_OR @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#04 @RT(52)OR operation with actual result and condition result 
@END_Attrib 


@Constant @RT(8)cSEO_XOR @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#05 @RT(53)XOR operation with actual result and condition result 
@END_Attrib 


@Constant @RT(8)cSEO_END @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#FF @RT(14)END of program 
@END_Attrib 


@Constant @RT(15)xxxxxxxxxxxxxxx @RT(0) @T @F @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(0) @RT(0) 
@END_Attrib 


@Constant @RT(14)cSEC_BC_EQ_NOT @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#10 @RT(25)Condition BOOL SV = FALSE 
@END_Attrib 


@Constant @RT(10)cSEC_BC_EQ @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#11 @RT(24)Condition BOOL SV = TRUE 
@END_Attrib 


@Constant @RT(14)cSEC_BV_EQ_NOT @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#12 @RT(23)Condition BOOL SV <> SV 
@END_Attrib 


@Constant @RT(10)cSEC_BV_EQ @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#13 @RT(22)Condition BOOL SV = SV 
@END_Attrib 


@Constant @RT(10)cSEC_RC_GT @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#20 @RT(25)Condition REAL SV > VALUE 
@END_Attrib 


@Constant @RT(10)cSEC_RC_LT @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#21 @RT(25)Condition REAL SV < VALUE 
@END_Attrib 


@Constant @RT(10)cSEC_RV_GT @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#22 @RT(22)Condition REAL SV > SV 
@END_Attrib 


@Constant @RT(10)cSEC_RV_LT @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#23 @RT(22)Condition REAL SV < SV 
@END_Attrib 


@Constant @RT(8)cSEC_POP @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#FF @RT(24)pop Condition from Stack 
@END_Attrib 


@Constant @RT(15)xxxxxxxxxxxxxxx @RT(0) @T @F @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F @T 
@T 
@BEG_Attrib 
0 @RT(0) @RT(0) 
@END_Attrib 


@Constant @RT(11)cSET_String @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#00 @RT(19)Param Type "String" 
@END_Attrib 


@Constant @RT(14)cSET_ConstReal @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#01 @RT(56)Param Type "Const Value", interprete Param as Real value 
@END_Attrib 


@Constant @RT(17)cSET_VariableBool @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#02 @RT(58)Param Type " Bool SV", interprete Param as name of Bool SV 
@END_Attrib 


@Constant @RT(17)cSET_VariableReal @RT(0) @T @F @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(5)16#03 @RT(57)Param Type "Real SV", interprete Param as name of Real SV 
@END_Attrib 


@RT(17)TypeTreeContainer 
0 
@END_Export 

@END_Contents 
