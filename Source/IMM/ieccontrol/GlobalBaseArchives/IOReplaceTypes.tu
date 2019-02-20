CONSTANT
 cCAT_ROOT_IO : STRING(2) := 'IO' (* Catalog IO Root *);
 cDEVICE_MAX_COUNT : DINT := 50 (* Max Number of Elements in Stack *);
 cENDPOINT_MAX_COUNT : DINT := 5 (* Max Number of Elements in Stack *);
 cEP_EMPTY : DINT := -1 (* Value for not replaced Endpoint *);
 cEP_NONE : DINT := -1 (* Value for cnt when no Endpoint exists *);
 cEP_DEFECT : STRING(255) := 'DEFECT' (* String attached to varname when marked as defect *);
 cEP_REPLACE : STRING(255) := 'REPLACE' (* Substring in applstate when endpoint replaces another one *);
END_CONSTANT

TYPE
 tsIOReplaceDeviceInfo : 
   STRUCT 
    bModified : BOOL;
    sHWPath : STRING(255);
    sSerialNumber : STRING(12);
   END_STRUCT;
 tyIOReplaceDeviceList : ARRAY  [1..cDEVICE_MAX_COUNT] OF tsIOReplaceDeviceInfo;
 tsIOReplaceDevices : 
   STRUCT 
    iCnt : DINT;
    Device : tyIOReplaceDeviceList;
   END_STRUCT;
 tsIOReplaceEP : 
   STRUCT 
    iIdx : DINT;
    iIdxOld : DINT := cEP_EMPTY;
    sVarName : STRING(255);
   END_STRUCT;
 tyIOReplaceEP : ARRAY  [1..cENDPOINT_MAX_COUNT] OF tsIOReplaceEP;
 tsIOReplaceEP_DIR : 
   STRUCT 
    iCnt : DINT := cEP_NONE;
    sType : STRING(2);
    EP : tyIOReplaceEP;
   END_STRUCT;
 tyIOReplaceEP_TYP : ARRAY  [0..1] OF tsIOReplaceEP_DIR;
 tyIOReplaceEndpoints : ARRAY  [0..2] OF tyIOReplaceEP_TYP;
 tsIOReplaceEndpoints : 
   STRUCT 
    sDeviceHWPath : STRING(255);
    bModified : BOOL;
    TYP : tyIOReplaceEndpoints := (sType:='AI'),(sType:='AO'),(sType:='DI'),(sType:='DO'),(sType:='TI'),(sType:='');
   END_STRUCT;
 tsIOReplaceEndpointAttributes : 
   STRUCT 
    sIsolated : STRING(255);
    sCurrent : STRING(255);
    sRange : STRING(255);
    sSensorType : STRING(255);
   END_STRUCT;
 tsIOReplaceChangedInfo : 
   STRUCT 
    bTrigger : BOOL;
    iTYP : DINT;
    iDIR : DINT;
    iEP : DINT;
    iIdxOldSaved : DINT;
   END_STRUCT;
END_TYPE



#END_OF_IEC_PART

@Puma @IecEditor 6 107 @Tou 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(22)TypeConstTreeContainer 
7 
@Constant @RT(12)cCAT_ROOT_IO @RT(0) @T @F @DT @RT(9)STRING(2) @RT(0) @T @T @STRING 0 @F @RT(1)2 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(4)'IO' @RT(15)Catalog IO Root 
@END_Attrib 


@Constant @RT(17)cDEVICE_MAX_COUNT @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)50 @RT(31)Max Number of Elements in Stack 
@END_Attrib 


@Constant @RT(19)cENDPOINT_MAX_COUNT @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(1)5 @RT(31)Max Number of Elements in Stack 
@END_Attrib 


@Constant @RT(9)cEP_EMPTY @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)-1 @RT(31)Value for not replaced Endpoint 
@END_Attrib 


@Constant @RT(8)cEP_NONE @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(2)-1 @RT(37)Value for cnt when no Endpoint exists 
@END_Attrib 


@Constant @RT(10)cEP_DEFECT @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(8)'DEFECT' @RT(48)String attached to varname when marked as defect 
@END_Attrib 


@Constant @RT(11)cEP_REPLACE @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
0 @RT(9)'REPLACE' @RT(57)Substring in applstate when endpoint replaces another one 
@END_Attrib 


@RT(17)TypeTreeContainer 
11 
@DT @RT(21)tsIOReplaceDeviceInfo @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(9)bModified @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)sHWPath @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(13)sSerialNumber @RT(0) @T @F @DT @RT(10)STRING(12) @RT(0) @T @T @STRING 0 @F @RT(2)12 @F 
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


@DT @RT(21)tyIOReplaceDeviceList @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(21)tsIOReplaceDeviceInfo @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(17)cDEVICE_MAX_COUNT 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(18)tsIOReplaceDevices @RT(0) @T @T @STRUCT 0 2 

@StructElem @RT(4)iCnt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)Device @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(21)tyIOReplaceDeviceList @RT(0) @T @T @UNKNOWN 0 @F 
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


@DT @RT(13)tsIOReplaceEP @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(4)iIdx @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(7)iIdxOld @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(9)cEP_EMPTY @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sVarName @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(20)(iIdxOld:=cEP_EMPTY) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(13)tyIOReplaceEP @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(13)tsIOReplaceEP @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)1 @RT(19)cENDPOINT_MAX_COUNT 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tsIOReplaceEP_DIR @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(4)iCnt @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(8)cEP_NONE @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(5)sType @RT(0) @T @F @DT @RT(9)STRING(2) @RT(0) @T @T @STRING 0 @F @RT(1)2 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(2)EP @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(13)tyIOReplaceEP @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(16)(iCnt:=cEP_NONE) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(17)tyIOReplaceEP_TYP @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tsIOReplaceEP_DIR @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)0 @RT(1)1 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tyIOReplaceEndpoints @RT(0) @T @T @ARRAY 0 @F @DERIVED 0 @T @T @DT @RT(17)tyIOReplaceEP_TYP @RT(0) @T @T @UNKNOWN 0 @F 
@F 1 @RT(1)0 @RT(1)2 0 @F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(20)tsIOReplaceEndpoints @RT(0) @T @T @STRUCT 0 3 

@StructElem @RT(13)sDeviceHWPath @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(9)bModified @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)TYP @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(20)tyIOReplaceEndpoints @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(81)(sType:='AI'),(sType:='AO'),(sType:='DI'),(sType:='DO'),(sType:='TI'),(sType:='') @RT(0) @RT(0) 
@END_Attrib 
@F 
@T 
@BEG_Attrib 
2 @RT(88)(TYP:=(sType:='AI'),(sType:='AO'),(sType:='DI'),(sType:='DO'),(sType:='TI'),(sType:='')) @RT(0) @RT(0) 
@END_Attrib 


@DT @RT(29)tsIOReplaceEndpointAttributes @RT(0) @T @T @STRUCT 0 4 

@StructElem @RT(9)sIsolated @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(8)sCurrent @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(6)sRange @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(11)sSensorType @RT(0) @T @F @DT @RT(11)STRING(255) @RT(0) @T @T @STRING 0 @F @RT(3)255 @F 
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


@DT @RT(22)tsIOReplaceChangedInfo @RT(0) @T @T @STRUCT 0 5 

@StructElem @RT(8)bTrigger @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)iTYP @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(4)iDIR @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(3)iEP @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
2 @RT(0) @RT(0) @RT(0) 
@END_Attrib 

@StructElem @RT(12)iIdxOldSaved @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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
