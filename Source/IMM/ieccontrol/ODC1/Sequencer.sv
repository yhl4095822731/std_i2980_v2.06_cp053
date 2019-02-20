%IMPORT_OVER_LISTFILE_SOURCE
 VG_MoldData
, VG_SequenceData
, fmt20

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 KODC_Sequence
, tyStartCondInstanceData
, tyCheckCondInstanceData
, tyIFConditionData
, tyLoopData
, tyODCGroupData
, cLevelProcessOperator

END_IMPORT

%SYSTEMVAR_DECL
  sv_ODCSequence : KODC_Sequence (* ODC sequence from firmware/editor *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData ;
 sv_StartConditionInstanceData : tyStartCondInstanceData (* list with start condition params for all instances *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData ;
 sv_CheckConditionInstanceData : tyCheckCondInstanceData (* list with check condition params for all instances *)
   RETAIN  %VARIABLE_GROUP VG_MoldData,VG_SequenceData ;
 sv_ConditionParameter : tyIFConditionData
   RETAIN  %VARIABLE_GROUP VG_SequenceData,VG_MoldData 
%ELEMENT sv_ConditionParameter[0].CompareOperator
     %VISI_CLASS system.hmi.ODCTeachModeActiveController 
// Operator Operator

%ELEMENT sv_ConditionParameter[0].iValue
    
// Value Value

%ELEMENT sv_ConditionParameter[0].rValue
    
// Value Value

%ELEMENT sv_ConditionParameter[0].sIconKey
    
// Icon Icon

%ELEMENT sv_ConditionParameter[0].sName
    
// Name Name

%ELEMENT sv_ConditionParameter[0].sTextKey
     %VISI_CLASS system.hmi.ODCTeachModeActiveController 
// Type Type

%ELEMENT sv_ConditionParameter[0].sVariable1
     %VISI_CLASS system.hmi.ODCTeachModeActiveController 
// Variable Variable

%ELEMENT sv_ConditionParameter[0].sVariable2
     %VISI_CLASS system.hmi.ODCTeachModeActiveController 
// Variable Variable
;
 sv_LoopParameter : tyLoopData := 10((iValue:=1)) (* array with data of all programmed loops *)
   RETAIN  %VARIABLE_GROUP VG_SequenceData,VG_MoldData 
%ELEMENT sv_LoopParameter[0].CompareOperator
    
// Operator Operator

%ELEMENT sv_LoopParameter[0].iValue
 %PLAUSIBILITY 1..99      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT fmt20 
// Count Count

%ELEMENT sv_LoopParameter[0].rValue
    
// Value Value

%ELEMENT sv_LoopParameter[0].sIconKey
    
// Icon Icon

%ELEMENT sv_LoopParameter[0].sName
    
// Name Name

%ELEMENT sv_LoopParameter[0].sTextKey
     %VISI_CLASS system.hmi.ODCTeachModeActiveController 
// Type Type

%ELEMENT sv_LoopParameter[0].sVariable1
    
// Variable Variable

%ELEMENT sv_LoopParameter[0].sVariable2
    
// Variable Variable
;
 sv_GroupParameter : tyODCGroupData := 10((iDisplayLevel:=1,iInputLevel:=cLevelProcessOperator)) (* array with data of all groups *)
   RETAIN  %VARIABLE_GROUP VG_SequenceData,VG_MoldData 
%ELEMENT sv_GroupParameter[0].iDisplayLevel
 %PLAUSIBILITY 1..16      %VISI_CLASS system.hmi.ODCTeachModeActiveController  %FORMAT fmt20 
// Display level Display level

%ELEMENT sv_GroupParameter[0].iInputLevel
 %PLAUSIBILITY 1..16      %VISI_CLASS system.hmi.ODCTeachModeActiveController  %FORMAT fmt20 
// Input level Input level

%ELEMENT sv_GroupParameter[0].sDescription
    
// Description Description

%ELEMENT sv_GroupParameter[0].sIcon
    
// Icon Icon

%ELEMENT sv_GroupParameter[0].sName
    
// Name Name
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 138 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
6 
@SysVar @RT(14)sv_ODCSequence @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)KODC_Sequence @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)ODC sequence from firmware/editor 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(14)sv_ODCSequence @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(33)ODC sequence from firmware/editor 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_StartConditionInstanceData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tyStartCondInstanceData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)list with start condition params for all instances 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_StartConditionInstanceData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)list with start condition params for all instances 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_CheckConditionInstanceData @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(23)tyCheckCondInstanceData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)list with check condition params for all instances 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_CheckConditionInstanceData @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)list with check condition params for all instances 
@RT(0) @RT(0) @RT(27)VG_MoldData,VG_SequenceData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_ConditionParameter @RT(0) @T @T @DERIVED 0 @F @RT(17)tyIFConditionData @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
9 
@AttrSym @RT(21)sv_ConditionParameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(432)(sName:='freier text 1',sTextKey:='TxtFirstCycle',sIconKey:='IconPathFirstCycle',sVariable1:='system.sv_bFirstCycle',sVariable2:='system.sv_bTRUE',CompareOperator:=nCompOperatorEqual),(sTextKey:='TxtCheckDI',sIconKey:='IconPathCheckDI',sVariable1:='Mold1.di_MoldClosed',sVariable2:='system.sv_bFALSE',CompareOperator:=nCompOperatorNotEqual),(sVariable1:='Ejector1.sv_rPosition',CompareOperator:=nCompOperatorLowerThan,rValue:=100.0) @RT(0) 
@RT(0) @RT(0) @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(40)sv_ConditionParameter[0].CompareOperator @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)operator for variable comparison 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(8)Operator @RT(8)Operator @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ConditionParameter[0].iValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(83)integer value for comparison (for example necessary with condition "every x cycle") 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Value @RT(5)Value @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(31)sv_ConditionParameter[0].rValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)real value for comparison 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Value @RT(5)Value @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ConditionParameter[0].sIconKey @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)key for getting according icon from propertie file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Icon @RT(4)Icon @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_ConditionParameter[0].sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)short discription (not translated!) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Name @RT(4)Name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_ConditionParameter[0].sTextKey @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)key for getting according text from propertie file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(4)Type @RT(4)Type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_ConditionParameter[0].sVariable1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(48)variable name (variable that should be compared) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(8)Variable @RT(8)Variable @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_ConditionParameter[0].sVariable2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)second variable for comparison 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(8)Variable @RT(8)Variable @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_LoopParameter @RT(0) @T @T @DERIVED 0 @F @RT(10)tyLoopData @F 
@T 
@BEG_Attrib 
4 @RT(15)10((iValue:=1)) @RT(39)array with data of all programmed loops 
@RT(0) @RT(0) @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
9 
@AttrSym @RT(16)sv_LoopParameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(39)array with data of all programmed loops 
@RT(0) @RT(0) @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_LoopParameter[0].CompareOperator @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(32)operator for variable comparison 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Operator @RT(8)Operator @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_LoopParameter[0].iValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(83)integer value for comparison (for example necessary with condition "every x cycle") 
@RT(1)1 @RT(21)cLevelProcessOperator @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..99 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Count @RT(5)Count @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_LoopParameter[0].rValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(25)real value for comparison 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Value @RT(5)Value @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_LoopParameter[0].sIconKey @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)key for getting according icon from propertie file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Icon @RT(4)Icon @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(25)sv_LoopParameter[0].sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)short discription (not translated!) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Name @RT(4)Name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_LoopParameter[0].sTextKey @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)key for getting according text from propertie file 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(4)Type @RT(4)Type @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_LoopParameter[0].sVariable1 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(48)variable name (variable that should be compared) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Variable @RT(8)Variable @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_LoopParameter[0].sVariable2 @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(30)second variable for comparison 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Variable @RT(8)Variable @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_GroupParameter @RT(0) @T @T @DERIVED 0 @F @RT(14)tyODCGroupData @F 
@T 
@BEG_Attrib 
4 @RT(57)10((iDisplayLevel:=1,iInputLevel:=cLevelProcessOperator)) @RT(29)array with data of all groups 
@RT(0) @RT(0) @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
6 
@AttrSym @RT(17)sv_GroupParameter @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(53)(iDisplayLevel:=1,iInputLevel:=cLevelServiceEngineer) @RT(0) 
@RT(0) @RT(0) @RT(27)VG_SequenceData,VG_MoldData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_GroupParameter[0].iDisplayLevel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(13)display level 
@RT(0) @RT(0) @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(13)Display level @RT(13)Display level @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(32)sv_GroupParameter[0].iInputLevel @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(21)cLevelServiceEngineer @RT(11)input level 
@RT(0) @RT(0) @RT(0) @RT(5)fmt20 @RT(0) @RT(0) @RT(0) 
@RT(5)1..16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(39)system.hmi.ODCTeachModeActiveController 
@RT(11)Input level @RT(11)Input level @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_GroupParameter[0].sDescription @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(26)description for this group 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Description @RT(11)Description @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_GroupParameter[0].sIcon @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)name of according icon 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Icon @RT(4)Icon @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(26)sv_GroupParameter[0].sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)name of this group (defined by user) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Name @RT(4)Name @RT(0) @RT(0) @RT(0) 
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
