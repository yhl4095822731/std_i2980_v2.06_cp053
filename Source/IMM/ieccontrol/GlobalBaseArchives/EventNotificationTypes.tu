CONSTANT
 cUTCZeroDate : DATE_AND_TIME := DT#1970-01-01-00:00:00.000000;
 cEvNotification_Invalid : DINT := 0;
 cEvNotificationType_Service : DINT := 1;
 cEvNotificationType_Production : DINT := 2;
END_CONSTANT

TYPE
 tevEventNotificationData : 
   STRUCT 
    iType : DINT := cEvNotification_Invalid (* Type of event (Service, Production running out,..) *);
    iInstance : DINT := cEvNotification_Invalid (* Instance number of event of corresponding type *);
    dExpirationDate : DATE_AND_TIME := cUTCZeroDate (* Date when event expires *);
   END_STRUCT;
 tevUpdateEventNotification : EVENT WITH tevEventNotificationData;
 tevRequestEventNotification : EVENT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 131 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
4 
@Constant @RT(12)cUTCZeroDate @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(29)DT#1970-01-01-00:00:00.000000 @RT(0) 
@END_Attrib 


@Constant @RT(23)cEvNotification_Invalid @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(27)cEvNotificationType_Service @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(30)cEvNotificationType_Production @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)2 @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
3 
@DT @RT(26)tevUpdateEventNotification @RT(0) @T @T @EVENT 0 @RT(24)tevEventNotificationData @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(24)tevEventNotificationData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(5)iType @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(23)cEvNotification_Invalid @RT(50)Type of event (Service, Production running out,..) @RT(0) 
@END_Attrib 

@StructElem @RT(9)iInstance @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(23)cEvNotification_Invalid @RT(46)Instance number of event of corresponding type @RT(0) 
@END_Attrib 

@StructElem @RT(15)dExpirationDate @RT(0) @T @F @DT @RT(13)DATE_AND_TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(12)cUTCZeroDate @RT(23)Date when event expires @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(97)(iType:=cEvNotification_Invalid,iInstance:=cEvNotification_Invalid,dExpirationDate:=cUTCZeroDate) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(27)tevRequestEventNotification @RT(0) @T @T @EVENT 0 @RT(0) @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
