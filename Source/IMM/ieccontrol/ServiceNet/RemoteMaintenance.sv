%IMPORT_OVER_LISTFILE_SOURCE
 fmtSiteManagerState

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsSiteManagerStatus

END_IMPORT

%SYSTEMVAR_DECL
  sv_bRemoteMaintAvailable : BOOL (* True, if the remote maintenance service is available (Linux only) *)
    
// Available Available remote maint.
;
 sv_bRemoteMaintActivate : BOOL (* Set to true, to activate the remote maintenance *)
    
// Activate Activate remote maint.
;
 sv_bRemoteMaintActivated : BOOL (* Actual activation state of the remote maintenance (readonly) *)
    
// Activated Activated remote maint.
;
 sv_iRemoteMaintState : UDINT (* State of the remote maintenance service (1=active) *)
    
// Active state Active state
;
 sv_sSiteManagerSetServer : STRING(255) (* Settable address of the Secomea server *)
    
// Server address Server address
;
 sv_sSiteManagerSetName : STRING(255) (* Settable custom name to display in the site manager *)
    
// Display name Display name
;
 sv_SiteManager : tsSiteManagerStatus (* Secomea site manager structure (read only) *)
    
%ELEMENT sv_SiteManager.iState
     %FORMAT fmtSiteManagerState 
%ELEMENT sv_SiteManager.sState
    
// Connection status Connection status
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 180 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
7 
@SysVar @RT(24)sv_bRemoteMaintAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)True, if the remote maintenance service is available (Linux only) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Available @RT(23)Available remote maint. @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bRemoteMaintAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(65)True, if the remote maintenance service is available (Linux only) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Available @RT(23)Available remote maint. @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bRemoteMaintActivate @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)Set to true, to activate the remote maintenance 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Activate @RT(22)Activate remote maint. @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bRemoteMaintActivate @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)Set to true, to activate the remote maintenance 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(8)Activate @RT(22)Activate remote maint. @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_bRemoteMaintActivated @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(60)Actual activation state of the remote maintenance (readonly) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Activated @RT(23)Activated remote maint. @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_bRemoteMaintActivated @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(47)Set to true, to activate the remote maintenance 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(9)Activated @RT(23)Activated remote maint. @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(20)sv_iRemoteMaintState @RT(0) @T @F @DT @RT(5)UDINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)State of the remote maintenance service (1=active) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Active state @RT(12)Active state @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(20)sv_iRemoteMaintState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)State of the remote maintenance service (1=active) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Active state @RT(12)Active state @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_sSiteManagerSetServer @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(38)Settable address of the Secomea server 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Server address @RT(14)Server address @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_sSiteManagerSetServer @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)State of the remote maintenance service (1=active) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Server address @RT(14)Server address @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_sSiteManagerSetName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(51)Settable custom name to display in the site manager 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Display name @RT(12)Display name @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_sSiteManagerSetName @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(50)State of the remote maintenance service (1=active) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(12)Display name @RT(12)Display name @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(14)sv_SiteManager @RT(0) @T @T @DERIVED 0 @F @RT(19)tsSiteManagerStatus @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(42)Secomea site manager structure (read only) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
2 
@AttrSym @RT(21)sv_SiteManager.iState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(59)Connection state (0=none, 1=red, 2=yellow, 3=green, 4=blue) 
@RT(0) @RT(0) @RT(0) @RT(19)fmtSiteManagerState @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(21)sv_SiteManager.sState @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(36)Connection state of the site manager 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Connection status @RT(17)Connection status @RT(0) @RT(0) @RT(0) 
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
