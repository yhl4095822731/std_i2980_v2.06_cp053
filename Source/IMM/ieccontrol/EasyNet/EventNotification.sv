%IMPORT_OVER_LISTFILE_OBJECT
 tevEventNotificationData

END_IMPORT

%SYSTEMVAR_DECL
  sv_NextEventNotification : tevEventNotificationData (* Central data of next estimated event;  for EasyNet mobile, available since KePlast.IEC 01.36. For usage of this function unit with older KePlast versions delete this instance. *)
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 168 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(24)sv_NextEventNotification @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(24)tevEventNotificationData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(175)Central data of next estimated event;  for EasyNet mobile, available since KePlast.IEC 01.36. For usage of this function unit with older KePlast versions delete this instance. 
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
0 

@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
