%IMPORT_OVER_LISTFILE_OBJECT
 tsGlobalCalibStatus
, cLevelServiceEngineer
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_GlobalCalibStatus : tsGlobalCalibStatus (* status of total autocalibration *)
    
%ELEMENT sv_GlobalCalibStatus.Command
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelServiceEngineer

%ELEMENT sv_GlobalCalibStatus.Status
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iLogFileChanged : DINT (* uesd to notify HMI that the auto calib log file changed *)
     %INPUT_LEVEL cLevelSuperUser
;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 30 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
2 
@SysVar @RT(20)sv_GlobalCalibStatus @RT(0) @T @T @DERIVED 0 @F @RT(19)tsGlobalCalibStatus @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)status of total autocalibration 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
3 
@AttrSym @RT(20)sv_GlobalCalibStatus @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(31)status of total autocalibration 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(28)sv_GlobalCalibStatus.Command @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(43)command for starting / stopping calibration 
@RT(1)1 @RT(21)cLevelServiceEngineer @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(27)sv_GlobalCalibStatus.Status @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(29)status of overall calibration 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_iLogFileChanged @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)uesd to notify HMI that the auto calib log file changed 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_iLogFileChanged @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(55)uesd to notify HMI that the auto calib log file changed 
@RT(0) @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
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
@@@BEG_Password@@@
MWhzZjE=
@@@END_Password@@@
