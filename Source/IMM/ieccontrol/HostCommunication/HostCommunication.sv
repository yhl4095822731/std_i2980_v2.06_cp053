%IMPORT_OVER_LISTFILE_SOURCE
 fmtS5
, fmtS1

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsHostCom
, tsHostHmi
, tsProcessDataRecorder
, tsEM63
, tsEM77
, tsHostDataSet

END_IMPORT

%SYSTEMVAR_DECL
  sv_HostCom : tsHostCom
    ;
 sv_HostHmi : tsHostHmi
    ;
 sv_bHostAvailable : BOOL
   RETAIN  %UPDATE_CYCLE "Slow";
 sv_ProcessDataRecorder : tsProcessDataRecorder
    ;
 sv_EM63 : tsEM63 := (SetCfgBrlZn:=24('0'),SetCfgMldZn:=72('0'))
    
%ELEMENT sv_EM63.ActStsMachine
     %FORMAT fmtS5 
%ELEMENT sv_EM63.SetCfgBrlZn
     %FORMAT fmtS1 
%ELEMENT sv_EM63.SetCfgMldZn
     %FORMAT fmtS1 ;
 sv_EM77 : tsEM77
    
%ELEMENT sv_EM77.bAvailable
   RETAIN ;
 sv_DataSet : tsHostDataSet
    ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 114 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
7 
@SysVar @RT(10)sv_HostCom @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)tsHostCom @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(10)sv_HostHmi @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)tsHostHmi @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(17)sv_bHostAvailable @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(17)sv_bHostAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(4)Slow 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_ProcessDataRecorder @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsProcessDataRecorder @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(7)sv_EM63 @RT(0) @T @T @DERIVED 0 @F @RT(6)tsEM63 @F 
@T 
@BEG_Attrib 
4 @RT(43)(SetCfgBrlZn:=24('0'),SetCfgMldZn:=72('0')) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(21)sv_EM63.ActStsMachine @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmtS5 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_EM63.SetCfgBrlZn @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)24('0') @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmtS1 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(19)sv_EM63.SetCfgMldZn @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(7)72('0') @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(5)fmtS1 @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(7)sv_EM77 @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(6)tsEM77 @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_EM77.bAvailable @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(57)set after a EM77 client has been connected the first time 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_DataSet @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tsHostDataSet @RT(0) @T @T @UNKNOWN 0 @F 
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
0 

@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
