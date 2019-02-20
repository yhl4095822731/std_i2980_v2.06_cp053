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

systemvariables for FU ServiceNet
*)

%IMPORT_OVER_LISTFILE_SOURCE
 VG_ServiceNetContactData
, VG_ServiceNetConnectionData
, fmtPIN
, fmtMessage
, YesNo
, fmtConnectDisconnect
, fmtConnectionStatus

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tyContactTo
, tyRequestFrom
, tsMachineInfo
, tsSimInfo
, tnConnectionStatus
, tnDialogOption
, tsNetworkCfg
, cLevelServiceEngineer
, cMaxContacts

END_IMPORT

%SYSTEMVAR_DECL
  sv_ContactTo : tyContactTo := (sAddress:='192.168.0.2') (* address information about ServiceNet Server *)
   RETAIN  %VARIABLE_GROUP VG_ServiceNetContactData 
%ELEMENT sv_ContactTo[0].sAddress
    
// Hostname Hostname or address

%ELEMENT sv_ContactTo[0].sName
    
// Contact Name Contact Name
;
 sv_RequestFrom : tyRequestFrom (* information about user that sent a service request *)
   RETAIN  %VARIABLE_GROUP VG_ServiceNetContactData 
%ELEMENT sv_RequestFrom[0].sEmail
    
// EMail EMail address

%ELEMENT sv_RequestFrom[0].sName
    
// Name Name

%ELEMENT sv_RequestFrom[0].sPhoneNumber
    
// Phone Phone number

%ELEMENT sv_RequestFrom[0].sSkypeName
    
// Skype name Skype name
;
 sv_MachineInformation : tsMachineInfo (* machine dependent information *)
   RETAIN  %VARIABLE_GROUP VG_ServiceNetContactData 
%ELEMENT sv_MachineInformation.sCountryCode
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Country Country

%ELEMENT sv_MachineInformation.sCustomerName
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Customer name Customer name

%ELEMENT sv_MachineInformation.sLicenseKey
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// License key License key

%ELEMENT sv_MachineInformation.sMachineName
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

// Machine name Machine name
;
 sv_SIMInfo : tsSimInfo (* SIM info that is necessary for modem to connect to provider *)
   RETAIN  %VARIABLE_GROUP VG_ServiceNetConnectionData 
%ELEMENT sv_SIMInfo.sAPN
    
// APN Access Point Name

%ELEMENT sv_SIMInfo.sPIN
     %FORMAT fmtPIN 
// PIN SIM card PIN

%ELEMENT sv_SIMInfo.sPassword
    
// Password Password

%ELEMENT sv_SIMInfo.sUserName
    
// User Name User Name
;
 sv_sTextMessage : STRING(255) (* additional textmessage that is sent to ServiceNet Server with a service request *)
     %FORMAT fmtMessage 
// Text message Text message (max. 250 characters)
;
 sv_iContactToIdx : DINT := 1 (* selects which ServiceNet Server address information to use (sv_ContactTo) *)
 %PLAUSIBILITY 1..cMaxContacts    RETAIN 
// Contact to Contact to
;
 sv_iRequestFromIdx : DINT := 1 (* selects which user information set to use (sv_RequestFrom) *)
 %PLAUSIBILITY 1..cMaxContacts    RETAIN 
// Request from Request from
;
 sv_bDownloadSIMInfo : BOOL (* trigger set by HMI for downloading configuration to modem; reset by IEC if done or error *)
 %PLAUSIBILITY 1..1      %FORMAT YesNo 
// Download Download to modem
;
 sv_iDownloadSIMInfoErrorCode : DINT (* indicates an error when downloading modem configuration; no error if zero; cleared on raising edge on sv_bDonwloadSIMInfo, valid after falling edge *)
    
// Download error code Download to modem error code
;
 sv_bConnect : BOOL (* establishes a connection to ServiceNet Server and posts a Service Request *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 1
 %FORMAT fmtConnectDisconnect ;
 sv_ConnectionStatus : tnConnectionStatus (* status of client *)
     %FORMAT fmtConnectionStatus 
// Status Connection status
;
 sv_sSIMDataName : STRING(99) (* name of SIM dataset file where SIM data has been loaded from *)
   RETAIN 
// SIM data SIM data
;
 sv_HMIResponse : tnDialogOption (* stores user input on option dialog yes/no/cancel *)
    ;
 sv_iRemoteVisType : DINT (* protocol that should be used by ServiceNet for a remote visualisation session; see cREMOTEVIS constants *)
    ;
 sv_SNNetworkConfig : tsNetworkCfg := (sIP:='192.168.0.1',sSubnetMask:='255.255.255.0',sGateway:='192.168.0.100') (* network config to use when connecting to servicenet *)
   RETAIN ;
%END

%SYSTEM_ALARM
  erDownloadSimInfoFailed
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Download SIM Info failed (error ID %1i){#]The download of SIM card configuration (pin, apn, user, password) to the modem fails.{#]The control writes the configuration for the used SIM card to the modem.\u000aFollowing error codes are possible:\u000a<ul>\u000a<li>1: network error - connection cannot be established</li>\u000a<li>2: network error - socket error, no sockets available</li>\u000a<li>4: network error - error sending data</li>\u000a<li>5: network error - error in select function</li>\u000a<li>6: network error - error reading data</li>\u000a<li>100: no default gateway is configured</li>\u000a<li>101: modem request: parameter error</li>\u000a<li>102: modem request: command error</li>\u000a<li>105: timeout occurred</li>\u000a<li>110: error when setting temp network configuration</li>\u000a<li>111: error when resetting temp network configuration</li>\u000a</ul>{#]Check connection to modem.<br>\u000aCheck network settings.
 ;
  erNoConnection
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// No connection to host %1s{#]No network connection between control and ServiceNet can be established.{#]It is not possible to establish a network connection between control and ServiceNet.{#]Check connection to modem.<br>\u000aCheck network settings.<br>\u000aMaybe the data connection is bad.
 ;
  erConnectionReset
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Connection reset (Error ID %1i){#]Communication timeout occurs.{#]The communication between the control and the ServiceNet times out.{#]Check connection to modem.<br>\u000aCheck network settings.<br>\u000aMaybe the data connection is bad.
 ;
  erWrongVersion
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Expected ServiceNet Version >= %1s (found %2s){#]ServiceNet version is to old, newer version of ServiceNet is required.{#]The used ServiceNet version is to old. The actual and the required ServiceNet version is shown in the error message.{#]Install the required version of ServiceNet.
 ;
  erConnectionClosed
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Connection closed by ServiceNet{#]ServiceNet sends a disconnect command.{#]The data connection between control and ServiceNet is closed by the ServiceNet.{#]-
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 121 @Sve 25 
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

systemvariables for FU ServiceNet
@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
15 
@SysVar @RT(12)sv_ContactTo @RT(0) @T @T @DERIVED 0 @F @RT(11)tyContactTo @F 
@T 
@BEG_Attrib 
4 @RT(25)(sAddress:='192.168.0.2') @RT(43)address information about ServiceNet Server 
@RT(0) @RT(0) @RT(24)VG_ServiceNetContactData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(12)sv_ContactTo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(24)VG_ServiceNetContactData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_ContactTo[0].sAddress @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Hostname @RT(19)Hostname or address @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_ContactTo[0].sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Contact Name @RT(12)Contact Name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_RequestFrom @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyRequestFrom @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)information about user that sent a service request 
@RT(0) @RT(0) @RT(24)VG_ServiceNetContactData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(14)sv_RequestFrom @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(24)VG_ServiceNetContactData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(24)sv_RequestFrom[0].sEmail @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)EMail @RT(13)EMail address @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(23)sv_RequestFrom[0].sName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(4)Name @RT(4)Name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(30)sv_RequestFrom[0].sPhoneNumber @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(5)Phone @RT(12)Phone number @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_RequestFrom[0].sSkypeName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Skype name @RT(10)Skype name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(21)sv_MachineInformation @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsMachineInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)machine dependent information 
@RT(0) @RT(0) @RT(24)VG_ServiceNetContactData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(21)sv_MachineInformation @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(24)VG_ServiceNetContactData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MachineInformation.sCountryCode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Country @RT(7)Country @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(35)sv_MachineInformation.sCustomerName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(13)Customer name @RT(13)Customer name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(33)sv_MachineInformation.sLicenseKey @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)License key @RT(11)License key @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(34)sv_MachineInformation.sMachineName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Machine name @RT(12)Machine name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_SIMInfo @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)tsSimInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)SIM info that is necessary for modem to connect to provider 
@RT(0) @RT(0) @RT(27)VG_ServiceNetConnectionData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
5 
@AttrSym @RT(10)sv_SIMInfo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(27)VG_ServiceNetConnectionData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(15)sv_SIMInfo.sAPN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)APN @RT(17)Access Point Name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(15)sv_SIMInfo.sPIN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(6)fmtPIN @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(3)PIN @RT(12)SIM card PIN @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_SIMInfo.sPassword @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Password @RT(8)Password @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(20)sv_SIMInfo.sUserName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)User Name @RT(9)User Name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_sTextMessage @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(79)additional textmessage that is sent to ServiceNet Server with a service request 
@RT(0) @RT(0) @RT(0) @RT(10)fmtMessage @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Text message @RT(34)Text message (max. 250 characters) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_sTextMessage @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(10)fmtMessage @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Text message @RT(34)Text message (max. 250 characters) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_iContactToIdx @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(73)selects which ServiceNet Server address information to use (sv_ContactTo) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)1..cMaxContacts @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Contact to @RT(10)Contact to @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_iContactToIdx @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)1..cMaxContacts @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(10)Contact to @RT(10)Contact to @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iRequestFromIdx @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(1)1 @RT(58)selects which user information set to use (sv_RequestFrom) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)1..cMaxContacts @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Request from @RT(12)Request from @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iRequestFromIdx @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(15)1..cMaxContacts @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Request from @RT(12)Request from @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_bDownloadSIMInfo @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(88)trigger set by HMI for downloading configuration to modem; reset by IEC if done or error 
@RT(0) @RT(0) @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(4)1..1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Download @RT(17)Download to modem @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_bDownloadSIMInfo @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)YesNo @RT(0) @RT(0) @RT(0) 
@RT(4)1..1 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Download @RT(17)Download to modem @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(28)sv_iDownloadSIMInfoErrorCode @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(147)indicates an error when downloading modem configuration; no error if zero; cleared on raising edge on sv_bDonwloadSIMInfo, valid after falling edge 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Download error code @RT(28)Download to modem error code @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(28)sv_iDownloadSIMInfoErrorCode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Download error code @RT(28)Download to modem error code @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(11)sv_bConnect @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(73)establishes a connection to ServiceNet Server and posts a Service Request 
@RT(1)1 @RT(1)1 @RT(0) @RT(20)fmtConnectDisconnect @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(11)sv_bConnect @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(23)modem dial / disconnect 
@RT(1)1 @RT(1)1 @RT(0) @RT(20)fmtConnectDisconnect @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_ConnectionStatus @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tnConnectionStatus @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)status of client 
@RT(0) @RT(0) @RT(0) @RT(19)fmtConnectionStatus @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(17)Connection status @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_ConnectionStatus @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(19)fmtConnectionStatus @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(6)Status @RT(17)Connection status @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(15)sv_sSIMDataName @RT(0) @T @F @DT @RT(10)STRING(99) @RT(0) @T @T @STRING 0 @F @RT(2)99 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)name of SIM dataset file where SIM data has been loaded from 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)SIM data @RT(8)SIM data @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(15)sv_sSIMDataName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)SIM data @RT(8)SIM data @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_HMIResponse @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(14)tnDialogOption @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(48)stores user input on option dialog yes/no/cancel 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(17)sv_iRemoteVisType @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(103)protocol that should be used by ServiceNet for a remote visualisation session; see cREMOTEVIS constants 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(18)sv_SNNetworkConfig @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(12)tsNetworkCfg @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(75)(sIP:='192.168.0.1',sSubnetMask:='255.255.255.0',sGateway:='192.168.0.100') @RT(51)network config to use when connecting to servicenet 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_SNNetworkConfig @RT(0) @F @F 
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
5 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erDownloadSimInfoFailed @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(940)Download SIM Info failed (error ID %1i){#]The download of SIM card configuration (pin, apn, user, password) to the modem fails.{#]The control writes the configuration for the used SIM card to the modem.\u000aFollowing error codes are possible:\u000a<ul>\u000a<li>1: network error - connection cannot be established</li>\u000a<li>2: network error - socket error, no sockets available</li>\u000a<li>4: network error - error sending data</li>\u000a<li>5: network error - error in select function</li>\u000a<li>6: network error - error reading data</li>\u000a<li>100: no default gateway is configured</li>\u000a<li>101: modem request: parameter error</li>\u000a<li>102: modem request: command error</li>\u000a<li>105: timeout occurred</li>\u000a<li>110: error when setting temp network configuration</li>\u000a<li>111: error when resetting temp network configuration</li>\u000a</ul>{#]Check connection to modem.<br>\u000aCheck network settings. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erNoConnection @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(292)No connection to host %1s{#]No network connection between control and ServiceNet can be established.{#]It is not possible to establish a network connection between control and ServiceNet.{#]Check connection to modem.<br>\u000aCheck network settings.<br>\u000aMaybe the data connection is bad. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erConnectionReset @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(238)Connection reset (Error ID %1i){#]Communication timeout occurs.{#]The communication between the control and the ServiceNet times out.{#]Check connection to modem.<br>\u000aCheck network settings.<br>\u000aMaybe the data connection is bad. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erWrongVersion @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(284)Expected ServiceNet Version >= %1s (found %2s){#]ServiceNet version is to old, newer version of ServiceNet is required.{#]The used ServiceNet version is to old. The actual and the required ServiceNet version is shown in the error message.{#]Install the required version of ServiceNet. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erConnectionClosed @RT(1)3 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(158)Connection closed by ServiceNet{#]ServiceNet sends a disconnect command.{#]The data connection between control and ServiceNet is closed by the ServiceNet.{#]- 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
