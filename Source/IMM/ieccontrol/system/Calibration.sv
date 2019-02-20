%IMPORT_OVER_LISTFILE_OBJECT
 KAPPL_LintabData3D
, tsPumpCalibError
, tyCalibDevices
, cCompInjection
, cCompMold
, cCompEjector

END_IMPORT

%SYSTEMVAR_DECL
  sv_bDoPumpPressureCalib : BOOL
     %INPUT_LEVEL 16
;
 sv_bDoPumpVelocityCalib : BOOL
     %INPUT_LEVEL 16
;
 sv_bPumpPreVelCalibAnotherStepN : BOOL (* set to true after measuring when another calib step is needed *)
    ;
 sv_bPumpPreVelCalibDone : BOOL (* set to true after measuring when calib is done *)
    ;
 sv_rTmpMaxAbsFlow : REAL
    ;
 sv_TmpLintab : KAPPL_LintabData3D (* temporary lintab that is copied to real lintab after autocalib is finished *)
    ;
 sv_PumpCalibError : tsPumpCalibError
    ;
 sv_iCalibratingPump : DINT (* number of pump which is actually calibrating *)
    ;
 sv_PumpCalibDevices : tyCalibDevices := (DeviceId:=(CompId:=cCompInjection,IndexId:=1)),(DeviceId:=(CompId:=cCompMold,IndexId:=1)),(DeviceId:=(CompId:=cCompEjector,IndexId:=1)) (* !!! device 1 - 20 reserved !!! *)
    ;
%END

%SYSTEM_ALARM
  erHighDiffAtPres
 %CLASS 4 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n: Detected pressure differs strong from maximum pressure!{#]During pump pressure calibration the detected \u000apressure doesn't fit to the setting for maximum system pressure.{#]At the end of a automatic pump pressure calibration the measured maximum\u000a pressure is compared to the maximum system pressure setting. Those two values \u000ashould be rather similar. In case the variation is higher than 5% the warning alarm is \u000agiven.{#]Still all operations are possible, but taking a closer look at the system is strongly \u000asuggested.<br>\u000aCheck the maximum system pressure setting and adjust if necessary.\u000aThen recalibrate the pump pressure.\u000aConsider hardware issues and search for problem causes.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 145 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
9 
@SysVar @RT(23)sv_bDoPumpPressureCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bDoPumpPressureCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bDoPumpVelocityCalib @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bDoPumpVelocityCalib @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(31)sv_bPumpPreVelCalibAnotherStepN @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(61)set to true after measuring when another calib step is needed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(31)sv_bPumpPreVelCalibAnotherStepN @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(61)set to true after measuring when another calib step is needed 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_bPumpPreVelCalibDone @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)set to true after measuring when calib is done 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bPumpPreVelCalibDone @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)set to true after measuring when calib is done 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_rTmpMaxAbsFlow @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(12)sv_TmpLintab @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)KAPPL_LintabData3D @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)temporary lintab that is copied to real lintab after autocalib is finished 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(12)sv_TmpLintab @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)temporary lintab that is copied to real lintab after autocalib is finished 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(17)sv_PumpCalibError @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(16)tsPumpCalibError @RT(0) @T @T @UNKNOWN 0 @F 
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


@SysVar @RT(19)sv_iCalibratingPump @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(44)number of pump which is actually calibrating 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(19)sv_PumpCalibDevices @RT(0) @T @T @DERIVED 0 @F @RT(14)tyCalibDevices @F 
@T 
@BEG_Attrib 
4 @RT(136)(DeviceId:=(CompId:=cCompInjection,IndexId:=1)),(DeviceId:=(CompId:=cCompMold,IndexId:=1)),(DeviceId:=(CompId:=cCompEjector,IndexId:=1)) @RT(30)!!! device 1 - 20 reserved !!! 
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
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erHighDiffAtPres @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(730)%1t%2n: Detected pressure differs strong from maximum pressure!{#]During pump pressure calibration the detected \u000apressure doesn't fit to the setting for maximum system pressure.{#]At the end of a automatic pump pressure calibration the measured maximum\u000a pressure is compared to the maximum system pressure setting. Those two values \u000ashould be rather similar. In case the variation is higher than 5% the warning alarm is \u000agiven.{#]Still all operations are possible, but taking a closer look at the system is strongly \u000asuggested.<br>\u000aCheck the maximum system pressure setting and adjust if necessary.\u000aThen recalibrate the pump pressure.\u000aConsider hardware issues and search for problem causes. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
