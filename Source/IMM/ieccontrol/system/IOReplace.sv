%IMPORT_OVER_LISTFILE_SOURCE
 fmtIOReplaceModified

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsIOReplaceDevices
, tsIOReplaceEndpoints
, tsIOReplaceChangedInfo

END_IMPORT

%SYSTEMVAR_DECL
  sv_TriggerCnt : INT := 0
    ;
 sv_IOReplaceDevices : tsIOReplaceDevices
    
%ELEMENT sv_IOReplaceDevices.Device
     %FORMAT fmtIOReplaceModified 
%ELEMENT sv_IOReplaceDevices.Device[0].bModified
     %DISPLAY_LEVEL 1  %FORMAT fmtIOReplaceModified ;
 sv_IOReplaceEndpoints : tsIOReplaceEndpoints
    
%ELEMENT sv_IOReplaceEndpoints.TYP[0][0].EP[0].iIdxOld
   RETAIN ;
 sv_IOReplaceSelectedDeviceIdx : DINT
    ;
 sv_IOReplaceChangedEndpoint : tsIOReplaceChangedInfo
    ;
%END

%SYSTEM_ALARM
  erIOR_ReassignNotAllowed
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// IOReplace: Reassign of endpoint not allowed{#]IO endpoint cannot be used for a new \u000a replacement because it is already used for \u000aanother IO replacement.{#]An IO endpoint which is already the target of an IO replacement should be used for a new IO replacement. This is not possible. Re-assigning an target-endpoint for \u000aanother replacement would, if allowed, drop the first replaced variable for the \u000aendpoint.{#]Use another free IO endpoint as target for the desired IO \u000areplacement.<br><br>\u000aIn case a wrong index has been entered and this should be \u000acorrected now proceed as follows:<br>\u000aFirst enter '-1' as "Defect IO" index in order to revert the previous \u000achanges.<br>\u000aNow the correct and desired index can be entered.
 ;
  erIOR_NoValidEPIndex
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// IOReplace: Entered endpoint index not valid{#]IO endpoint cannot be replaced because the entered endpoint index is not valid.{#]For IO replacement an index has been used which exceeds the valid range of endpoint indexes. Thus no IO replacement is possible.{#]Make sure to use the correct endpoint index and device for \u000aIO replacement.
 ;
  erIOR_NoFreeToFreeMapping
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// IOReplace: No replacement of free endpoints allowed{#]IO endpoint cannot be replaced because a free endpoint was selected as source.{#]Only a configured IO endpoint can be relocated. An IO endpoint which is free and has no configuration cannot be relocated to another endpoint.{#]Make sure to use the correct endpoint index and device for \u000aIO replacement.
 ;
  erIOR_EPAttributesNotMatching
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// IOReplace: Attributes of endpoints not matching{#]IO endpoint cannot be replaced because one or more endpoint attributes are not matching.{#]Relocating configured but broken IO endpoints (let's call it source-endpoint) to another IO endpoint (target-endpoint) requires the endpoints attributes to be \u000asimilar.<br>\u000aAttributes which have to match depend on the endpoint type (digital input, digital\u000a output, analog input, ...). The following attributes are compared:<br>\u000a- isolation (endpoint isolated or not)<br>\u000a- current (0.5A or 2A output current)<br>\u000a- voltage range (0V to 10V versus -10V to +10V)<br>\u000a- sensor type (single ended or differential)<br>\u000aIf one of these attributes doesn't match between source- and target-endpoint the IO replacement is not allowed.{#]Find another target-endpoint which fits the attributes of the \u000asource-endpoint. If required use the manuals or contact the \u000amachine manufacturer.<br>\u000aIn case no more IOs with matching attributes are available, \u000aalso contact the machine manufacturer for hardware \u000areplacement.
 ;
  erIOR_EPChangesMade
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// IOReplace: Changes handed, restart is necessary{#]An IO replacement has been entered by the user. To apply the changes restarting the controller is necessary.{#]This is just a message and doesn't not represent a problematic state.<br>\u000aIn order to apply changes in the IO replacements it is necessary to rewire the\u000a hardware, followed by a restart of the controller.{#]This is just a message, no action required.<br><br>\u000aIn case the IO replacement settings should be applied to the \u000acontroller make sure the IO wiring has been changed and then \u000arestart the controller.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 80 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
5 
@SysVar @RT(13)sv_TriggerCnt @RT(0) @T @F @DT @RT(3)INT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_TriggerCnt @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(1)0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_IOReplaceDevices @RT(0) @T @T @DERIVED 0 @F @RT(18)tsIOReplaceDevices @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(26)sv_IOReplaceDevices.Device @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(20)fmtIOReplaceModified @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(39)sv_IOReplaceDevices.Device[0].bModified @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(0) @RT(0) @RT(20)fmtIOReplaceModified @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_IOReplaceEndpoints @RT(0) @T @T @DERIVED 0 @F @RT(20)tsIOReplaceEndpoints @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(45)sv_IOReplaceEndpoints.TYP[0][0].EP[0].iIdxOld @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_IOReplaceSelectedDeviceIdx @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(27)sv_IOReplaceChangedEndpoint @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsIOReplaceChangedInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
5 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erIOR_ReassignNotAllowed @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(772)IOReplace: Reassign of endpoint not allowed{#]IO endpoint cannot be used for a new \u000a replacement because it is already used for \u000aanother IO replacement.{#]An IO endpoint which is already the target of an IO replacement should be used for a new IO replacement. This is not possible. Re-assigning an target-endpoint for \u000aanother replacement would, if allowed, drop the first replaced variable for the \u000aendpoint.{#]Use another free IO endpoint as target for the desired IO \u000areplacement.<br><br>\u000aIn case a wrong index has been entered and this should be \u000acorrected now proceed as follows:<br>\u000aFirst enter '-1' as "Defect IO" index in order to revert the previous \u000achanges.<br>\u000aNow the correct and desired index can be entered. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erIOR_NoValidEPIndex @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(339)IOReplace: Entered endpoint index not valid{#]IO endpoint cannot be replaced because the entered endpoint index is not valid.{#]For IO replacement an index has been used which exceeds the valid range of endpoint indexes. Thus no IO replacement is possible.{#]Make sure to use the correct endpoint index and device for \u000aIO replacement. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erIOR_NoFreeToFreeMapping @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(360)IOReplace: No replacement of free endpoints allowed{#]IO endpoint cannot be replaced because a free endpoint was selected as source.{#]Only a configured IO endpoint can be relocated. An IO endpoint which is free and has no configuration cannot be relocated to another endpoint.{#]Make sure to use the correct endpoint index and device for \u000aIO replacement. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erIOR_EPAttributesNotMatching @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(1109)IOReplace: Attributes of endpoints not matching{#]IO endpoint cannot be replaced because one or more endpoint attributes are not matching.{#]Relocating configured but broken IO endpoints (let's call it source-endpoint) to another IO endpoint (target-endpoint) requires the endpoints attributes to be \u000asimilar.<br>\u000aAttributes which have to match depend on the endpoint type (digital input, digital\u000a output, analog input, ...). The following attributes are compared:<br>\u000a- isolation (endpoint isolated or not)<br>\u000a- current (0.5A or 2A output current)<br>\u000a- voltage range (0V to 10V versus -10V to +10V)<br>\u000a- sensor type (single ended or differential)<br>\u000aIf one of these attributes doesn't match between source- and target-endpoint the IO replacement is not allowed.{#]Find another target-endpoint which fits the attributes of the \u000asource-endpoint. If required use the manuals or contact the \u000amachine manufacturer.<br>\u000aIn case no more IOs with matching attributes are available, \u000aalso contact the machine manufacturer for hardware \u000areplacement. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erIOR_EPChangesMade @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(592)IOReplace: Changes handed, restart is necessary{#]An IO replacement has been entered by the user. To apply the changes restarting the controller is necessary.{#]This is just a message and doesn't not represent a problematic state.<br>\u000aIn order to apply changes in the IO replacements it is necessary to rewire the\u000a hardware, followed by a restart of the controller.{#]This is just a message, no action required.<br><br>\u000aIn case the IO replacement settings should be applied to the \u000acontroller make sure the IO wiring has been changed and then \u000arestart the controller. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
