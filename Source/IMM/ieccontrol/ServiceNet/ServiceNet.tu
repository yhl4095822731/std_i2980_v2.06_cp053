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

general types for FU ServiceNet 
*)

CONSTANT
 cMaxContacts : DINT := 3 (* maximum number of contacts that can be stored *);
 cHttp_PortNumber : WORD := 80 (* port number for HTTP connection to modem *);
 cServiceNet_PortNumber : WORD := 7891 (* port number for connection to ServiceNet Server *);
 cREMOTEVIS_KVBRPC : DINT := 1 (* indicates that KVB RPC protocol should be used by ServiceNet Server for remote visualisation *);
 cREMOTEVIS_VNC : DINT := 0 (* indicates that VNC protocol should be used by ServiceNet Server for remote visualisation *);
 cREQSTATE_SERVICE_REQPENDING : DINT := 16#0 (* constant for setting client into state "request pending" *);
 cREQSTATE_SERVICE_ACCEPTED : DINT := 16#100 (* constant for setting client into state "service accepted" *);
 cREQSTATE_SERVICE_ACCESSREQ : DINT := 16#200 (* constant for setting client into state "request pending" *);
 cREQSTATE_SERVICE_CLOSE : DINT := 16#1000 (* constant for setting client into state "service closed"  *);
END_CONSTANT

TYPE
 tsRequestFrom : 
   STRUCT 
    sName : STRING(63) (* user name *);
    sEmail : STRING(63) (* email part one (before 'at') *);
    sEmail2 : STRING(63) (* email part two (after 'at') *);
    sPhoneNumber : STRING(63) (* phone number *);
    sSkypeName : STRING(63) (* skype name *);
   END_STRUCT (* information about user that sent a service request *);
 tyRequestFrom : ARRAY  [1..cMaxContacts] OF tsRequestFrom (* stores 3 sets of user informations *);
 tsContactTo : 
   STRUCT 
    sName : STRING(63) (* display name of ServiceNet Server *);
    sAddress : STRING(63) (* IP address or hostname of ServiceNet Server *);
   END_STRUCT (* address information about ServiceNet Server *);
 tyContactTo : ARRAY  [1..cMaxContacts] OF tsContactTo (* stores 3 sets of ServiceNet Server data *);
 tsMachineInfo : 
   STRUCT 
    sCustomerName : STRING(63) (* name of customer *);
    sMachineName : STRING(63) (* name of machine *);
    sCountryCode : STRING(63) (* country the machine is located *);
    sLicenseKey : STRING(63) (* license key for ServiceNet software option *);
   END_STRUCT (* machine dependent information *);
 tsSimInfo : 
   STRUCT 
    sUserName : STRING(63) (* username *);
    sPassword : STRING(63) (* password *);
    sAPN : STRING(63) (* access point name *);
    sPIN : STRING(4) (* SIM card PIN *);
   END_STRUCT (* SIM info that is necessary for modem to connect to provider *);
 tnConnectionStatus : (nDisconnected, nConnecting, nRequestPending, nServiceAccepted, nServiceAccessRequest, nServiceActive) (* ServiceNet client status *);
 tnDialogOption : (nWaiting, nYes, nNo, nCancel) (* stores user input on option dialog yes/no/cancel *);
 tyByteBuf : ARRAY  [0..255] OF BYTE (* byte buffer for TCP functions *);
 tySBuf : ARRAY  [0..7] OF STRING(255) (* String buffer for TCP send function *);
 tsNetworkCfg : 
   STRUCT 
    sIP : STRING(63);
    sSubnetMask : STRING(63);
    sGateway : STRING(63);
   END_STRUCT;
 tsSiteManagerStatus : 
   STRUCT 
    sState : STRING(255) (* Connection state message of the site manager *);
    iState : UDINT (* Connection state (0=none, 1=red, 2=yellow, 3=green, 4=blue) *);
    sColor : STRING(32) (* Color of the site manager connection (red, blue, green, yellow) *);
    bConnected : BOOL (* Connection status of the SiteManager *);
    sName : STRING(255) (* Custom name *);
    sServer : STRING(255) (* Server address *);
    sDomain : STRING(255) (* Domain name *);
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 121 @Tou 25 
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

general types for FU ServiceNet 
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
9 
@Constant @RT(12)cMaxContacts @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)3 @RT(45)maximum number of contacts that can be stored 
@END_Attrib 


@Constant @RT(16)cHttp_PortNumber @RT(0) @T @F @DT @RT(4)WORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)80 @RT(40)port number for HTTP connection to modem 
@END_Attrib 


@Constant @RT(22)cServiceNet_PortNumber @RT(0) @T @F @DT @RT(4)WORD @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)7891 @RT(47)port number for connection to ServiceNet Server 
@END_Attrib 


@Constant @RT(17)cREMOTEVIS_KVBRPC @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(92)indicates that KVB RPC protocol should be used by ServiceNet Server for remote visualisation 
@END_Attrib 


@Constant @RT(14)cREMOTEVIS_VNC @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(88)indicates that VNC protocol should be used by ServiceNet Server for remote visualisation 
@END_Attrib 


@Constant @RT(28)cREQSTATE_SERVICE_REQPENDING @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)16#0 @RT(56)constant for setting client into state "request pending" 
@END_Attrib 


@Constant @RT(26)cREQSTATE_SERVICE_ACCEPTED @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#100 @RT(57)constant for setting client into state "service accepted" 
@END_Attrib 


@Constant @RT(27)cREQSTATE_SERVICE_ACCESSREQ @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(6)16#200 @RT(56)constant for setting client into state "request pending" 
@END_Attrib 


@Constant @RT(23)cREQSTATE_SERVICE_CLOSE @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(7)16#1000 @RT(56)constant for setting client into state "service closed"  
@END_Attrib 


@RT(17)TypeTreeContainer 
12 
@DT @RT(13)tsRequestFrom @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(9)user name @RT(0) 
@END_Attrib 

@StructElem @RT(6)sEmail @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(28)email part one (before 'at') @RT(0) 
@END_Attrib 

@StructElem @RT(7)sEmail2 @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(27)email part two (after 'at') @RT(0) 
@END_Attrib 

@StructElem @RT(12)sPhoneNumber @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)phone number @RT(0) 
@END_Attrib 

@StructElem @RT(10)sSkypeName @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(10)skype name @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(50)information about user that sent a service request @RT(0) 
@END_Attrib 


@DT @RT(13)tyRequestFrom @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsRequestFrom @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(12)cMaxContacts 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(34)stores 3 sets of user informations @RT(0) 
@END_Attrib 


@DT @RT(11)tsContactTo @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)display name of ServiceNet Server @RT(0) 
@END_Attrib 

@StructElem @RT(8)sAddress @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)IP address or hostname of ServiceNet Server @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)address information about ServiceNet Server @RT(0) 
@END_Attrib 


@DT @RT(11)tyContactTo @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(11)tsContactTo @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(12)cMaxContacts 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(39)stores 3 sets of ServiceNet Server data @RT(0) 
@END_Attrib 


@DT @RT(13)tsMachineInfo @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(13)sCustomerName @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)name of customer @RT(0) 
@END_Attrib 

@StructElem @RT(12)sMachineName @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(15)name of machine @RT(0) 
@END_Attrib 

@StructElem @RT(12)sCountryCode @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(30)country the machine is located @RT(0) 
@END_Attrib 

@StructElem @RT(11)sLicenseKey @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(42)license key for ServiceNet software option @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)machine dependent information @RT(0) 
@END_Attrib 


@DT @RT(9)tsSimInfo @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(9)sUserName @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(8)username @RT(0) 
@END_Attrib 

@StructElem @RT(9)sPassword @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(8)password @RT(0) 
@END_Attrib 

@StructElem @RT(4)sAPN @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(17)access point name @RT(0) 
@END_Attrib 

@StructElem @RT(4)sPIN @RT(0) @T @F @DT @RT(9)STRING(4) @RT(0) @T @T @STRING 0 @F @RT(1)4 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(12)SIM card PIN @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)SIM info that is necessary for modem to connect to provider @RT(0) 
@END_Attrib 


@DT @RT(18)tnConnectionStatus @RT(0) @T @T @ENUM 0 6 
@EnumConst @RT(13)nDisconnected @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)client is disconnected @RT(0) 
@END_Attrib 
@EnumConst @RT(11)nConnecting @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(73)client has established a TCP connection to ServiceNet Server successfully @RT(0) 
@END_Attrib 
@EnumConst @RT(15)nRequestPending @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(119)a service request has been sent by client which was acknowledged by ServiceNet Server with cREQSTATE_SERVICE_REQPENDING @RT(0) 
@END_Attrib 
@EnumConst @RT(16)nServiceAccepted @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(67)server has sent an "accepted" message (cREQSTATE_SERVICE_ACCEPTED}) @RT(0) 
@END_Attrib 
@EnumConst @RT(21)nServiceAccessRequest @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(220)server has sent a "service access request" (cREQSTATE_SERVICE_ACCESSREQ) because the client should be informed that a remote visualization should be started; client can acknowledge with state nServiceActive or disconnect @RT(0) 
@END_Attrib 
@EnumConst @RT(14)nServiceActive @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(123)client has accepted service access request (cREQSTATE_SERVICE_ACCESSREQ); server is allowed to start a remote visualization @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(24)ServiceNet client status @RT(0) 
@END_Attrib 


@DT @RT(14)tnDialogOption @RT(0) @T @T @ENUM 0 4 
@EnumConst @RT(8)nWaiting @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(177)means dialog is open and user has not selected an option yet; this value has to be set initially by IEC application before dialog is shown in order to detect a  selection option @RT(0) 
@END_Attrib 
@EnumConst @RT(4)nYes @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(33)user selected dialog option "Yes" @RT(0) 
@END_Attrib 
@EnumConst @RT(3)nNo @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)user selected dialog option "No" @RT(0) 
@END_Attrib 
@EnumConst @RT(7)nCancel @RT(0) @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)user selected dialog option "Cancel" @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(48)stores user input on option dialog yes/no/cancel @RT(0) 
@END_Attrib 


@DT @RT(9)tyByteBuf @RT(0) @T @T @ARRAY 0 @T @DT @RT(4)BYTE @RT(0) @T @T @BASIC 0 @F 
@F 1 @RT(1)0 @RT(3)255 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(29)byte buffer for TCP functions @RT(0) 
@END_Attrib 


@DT @RT(6)tySBuf @RT(0) @T @T @ARRAY 0 @T @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F 1 @RT(1)0 @RT(1)7 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(35)String buffer for TCP send function @RT(0) 
@END_Attrib 


@DT @RT(12)tsNetworkCfg @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(3)sIP @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)sSubnetMask @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sGateway @RT(0) @T @F @DT @RT(10)STRING(63) @RT(0) @T @T @STRING 0 @F @RT(2)63 @F 
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


@DT @RT(19)tsSiteManagerStatus @RT(0) @T @T @STRUCT 0 7 

@StructElem @RT(6)sState @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(44)Connection state message of the site manager @RT(0) 
@END_Attrib 

@StructElem @RT(6)iState @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(59)Connection state (0=none, 1=red, 2=yellow, 3=green, 4=blue) @RT(0) 
@END_Attrib 

@StructElem @RT(6)sColor @RT(0) @T @F @DT @RT(10)STRING(32) @RT(0) @T @T @STRING 0 @F @RT(2)32 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(63)Color of the site manager connection (red, blue, green, yellow) @RT(0) 
@END_Attrib 

@StructElem @RT(10)bConnected @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(36)Connection status of the SiteManager @RT(0) 
@END_Attrib 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)Custom name @RT(0) 
@END_Attrib 

@StructElem @RT(7)sServer @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(14)Server address @RT(0) 
@END_Attrib 

@StructElem @RT(7)sDomain @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)Domain name @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
