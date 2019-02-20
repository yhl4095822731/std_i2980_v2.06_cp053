CONSTANT
 cMaxPanelButtons : DINT := 64;
 cBarInvert : BYTE := 1;
 cBarRightToLeft : BYTE := 2;
END_CONSTANT

TYPE
 tnPanelButtonType : (nPanelButtonNone, nPanelButtonAction, nPanelButtonMovement);
 tsOptionalButtonInfo : 
   STRUCT 
    piHeaderId : REFTO DINT;
    prActVar : REFTO REAL;
    prMinVar : REFTO REAL;
    prMaxVar : REFTO REAL;
    iBarAttr : BYTE;
    pbLimitSwitch1 : REFTO BOOL;
    pbLimitSwitch2 : REFTO BOOL;
    pbLedVar : REFTO BOOL;
    piLedVarAttr : REFTO BYTE;
   END_STRUCT;
 tsPanelButton : 
   STRUCT 
    nPanelButtonType : tnPanelButtonType;
    iCompId : DINT;
    iIndexId : DINT;
    iButtonId : DINT;
    bSelectorAsIndex : BOOL;
    piSelectorVar : REFTO UINT;
    pbActionVar1 : REFTO BOOL;
    pbActionVar2 : REFTO BOOL;
    Optional : tsOptionalButtonInfo;
   END_STRUCT;
 tyPanelButton : ARRAY  [1..cMaxPanelButtons] OF tsPanelButton;
 tpPanelButton : REFTO tsPanelButton;
 tpyPanelButton : ARRAY  [1..cMaxPanelButtons] OF tpPanelButton;
 tevPanelButtonRegisterData : 
   STRUCT 
    Button : tsPanelButton;
   END_STRUCT;
 tevPanelButtonRegister : EVENT WITH tevPanelButtonRegisterData;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 150 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
3 
@Constant @RT(16)cMaxPanelButtons @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)64 @RT(0) 
@END_Attrib 


@Constant @RT(10)cBarInvert @RT(0) @T @F @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(15)cBarRightToLeft @RT(0) @T @F @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
8 
@DT @RT(13)tyPanelButton @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsPanelButton @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxPanelButtons 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(14)tpyPanelButton @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tpPanelButton @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(16)cMaxPanelButtons 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tnPanelButtonType @RT(0) @T @T @ENUM 0 3 
@EnumConst @RT(16)nPanelButtonNone @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(18)nPanelButtonAction @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@EnumConst @RT(20)nPanelButtonMovement @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tsOptionalButtonInfo @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(10)piHeaderId @RT(0) @T @T @REFTO 0 @T @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)prActVar @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)prMinVar @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)prMaxVar @RT(0) @T @T @REFTO 0 @T @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iBarAttr @RT(0) @T @F @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)pbLimitSwitch1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(14)pbLimitSwitch2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)pbLedVar @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)piLedVarAttr @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
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


@DT @RT(13)tsPanelButton @RT(0) @T @T @STRUCT 0 9 

@StructElem @RT(16)nPanelButtonType @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnPanelButtonType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCompId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)iIndexId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)iButtonId @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(16)bSelectorAsIndex @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)piSelectorVar @RT(0) @T @T @REFTO 0 @T @DT @RT(4)UINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbActionVar1 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)pbActionVar2 @RT(0) @T @T @REFTO 0 @T @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)Optional @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tsOptionalButtonInfo @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(13)tpPanelButton @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(13)tsPanelButton @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tevPanelButtonRegister @RT(0) @T @T @EVENT 0 @RT(26)tevPanelButtonRegisterData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(26)tevPanelButtonRegisterData @RT(0) @T @T @STRUCT 0 1 

@StructElem @RT(6)Button @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsPanelButton @RT(0) @T @T @UNKNOWN 0 @F 
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


@END_Export 

@END_Contents 
