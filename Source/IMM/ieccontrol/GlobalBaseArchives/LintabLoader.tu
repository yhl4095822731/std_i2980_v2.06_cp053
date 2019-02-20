IMPORT_OVER_LISTFILE
 KAPPL_LintabData

END_IMPORT

CONSTANT
 CMD_LINTABLOAD : DINT := 0;
 CMD_LINTABLISTFILES : DINT := 1;
 cLTBLDR_MAXFILES : DINT := 20;
 cLTBLDR_ERR_UNKNOWNCMD : DINT := 1;
 cLTBLDR_ERR_MAXFILESREACHED : DINT := 16#0001_0001;
 cLTBLDR_ERR_FILENOTFOUND : DINT := 16#0002_0001;
 cLTBLDR_ERR_OUTOFBOUND : DINT := 16#0002_0002;
 cLTBLDR_ROOTPATH : STRING(255) := '/workspace/data/lintab/';
END_CONSTANT

TYPE
 tyLintabLoaderFileList : ARRAY  [1..cLTBLDR_MAXFILES] OF STRING(255);
 tsLintabLoaderFileList : 
   STRUCT 
    iFileCount : DINT;
    yFile : tyLintabLoaderFileList;
   END_STRUCT;
 tsLintabLoaderHMIComm : 
   STRUCT 
    iCmdCtrl : DINT (* i MOD 2 = 1 starts command, i MOD 2 = 0 command done *);
    iCmdSel : DINT (* select command to run *);
    iCmdRet : DINT (* return code 0 no error *);
    sFileName : STRING(255) (* filename to load *);
    sActFileName : STRING(255) (* loaded file *);
    FileList : tsLintabLoaderFileList (* list with available lintab files *);
   END_STRUCT;
 tsLintabLoaderData : 
   STRUCT 
    sName : STRING(31) (* instance name for lintabloader, used for debug output and for directory *);
    pLintab : REFTO KAPPL_LintabData (* Lintab SV where filedata  should be written *);
    HMIComm : tsLintabLoaderHMIComm (* Interface for communication with HMI Mask *);
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 103 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
8 
@Constant @RT(14)CMD_LINTABLOAD @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)0 @RT(0) 
@END_Attrib 


@Constant @RT(19)CMD_LINTABLISTFILES @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(16)cLTBLDR_MAXFILES @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)20 @RT(0) 
@END_Attrib 


@Constant @RT(22)cLTBLDR_ERR_UNKNOWNCMD @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)1 @RT(0) 
@END_Attrib 


@Constant @RT(27)cLTBLDR_ERR_MAXFILESREACHED @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(12)16#0001_0001 @RT(0) 
@END_Attrib 


@Constant @RT(24)cLTBLDR_ERR_FILENOTFOUND @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(12)16#0002_0001 @RT(0) 
@END_Attrib 


@Constant @RT(22)cLTBLDR_ERR_OUTOFBOUND @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(12)16#0002_0002 @RT(0) 
@END_Attrib 


@Constant @RT(16)cLTBLDR_ROOTPATH @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(25)'/workspace/data/lintab/' @RT(0) 
@END_Attrib 


@RT(17)TypeTreeContainer 
4 
@DT @RT(18)tsLintabLoaderData @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(5)sName @RT(0) @T @F @DT @RT(10)STRING(31) @RT(0) @T @T @STRING 0 @F @RT(2)31 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(71)instance name for lintabloader, used for debug output and for directory @RT(0) 
@END_Attrib 

@StructElem @RT(7)pLintab @RT(0) @T @T @REFTO 0 @F @DERIVED 0 @T @T @DT @RT(16)KAPPL_LintabData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(43)Lintab SV where filedata  should be written @RT(0) 
@END_Attrib 

@StructElem @RT(7)HMIComm @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tsLintabLoaderHMIComm @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(41)Interface for communication with HMI Mask @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(21)tsLintabLoaderHMIComm @RT(0) @T @T @STRUCT 0 6 

@StructElem @RT(8)iCmdCtrl @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(52)i MOD 2 = 1 starts command, i MOD 2 = 0 command done @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCmdSel @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(21)select command to run @RT(0) 
@END_Attrib 

@StructElem @RT(7)iCmdRet @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(22)return code 0 no error @RT(0) 
@END_Attrib 

@StructElem @RT(9)sFileName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(16)filename to load @RT(0) 
@END_Attrib 

@StructElem @RT(12)sActFileName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(11)loaded file @RT(0) 
@END_Attrib 

@StructElem @RT(8)FileList @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tsLintabLoaderFileList @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(32)list with available lintab files @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(22)tsLintabLoaderFileList @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(10)iFileCount @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)yFile @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(22)tyLintabLoaderFileList @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(22)tyLintabLoaderFileList @RT(0) @T @T @ARRAY 0 @T @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F 1 @RT(1)1 @RT(16)cLTBLDR_MAXFILES 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@END_Export 

@END_Contents 
