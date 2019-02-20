%IMPORT_OVER_LISTFILE_SOURCE
 VG_MachineData

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tsActiveMovements
, tsStartedMoveData
, cLevelStartupTechnican
, cLevelSuperUser

END_IMPORT

%SYSTEMVAR_DECL
  sv_bUseStartPosProfiles : BOOL
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican

// Use startposition profiles Use startposition profiles on hmi
;
 sv_iMovementsAvailable : DINT
    ;
 sv_ActiveMovements : tsActiveMovements (* list of active movements *)
    ;
 sv_StartedMovements : tsStartedMoveData (* list of movements where a start event was sent *)
    ;
 sv_bAllPUTasksExecuted : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
 sv_iActiveParamTransfers : DINT (* number of actually active parameter transfers (written by ABDriveParam.pu) *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
%END

%SYSTEM_ALARM
  erProfileSequence
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error in %1t%2n %3t sequence{#]Profile settings are invalid.{#]When setting a profile for a movement the independent variable needs to \u000aincrease or decrease monotonically. For example the mold close profile \u000arequires the position settings to decrease monotonically. If this is not the case \u000athe profile cannot be calculated.{#]Change the according profile settings.<br>\u000aIf it is desired to make it impossible to enter problematic values on the \u000ahmi, please contact the machine manufacturer.
 ;
  erMoveTimeout
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink,MoldHeightAdjust1.evMoveTimeout  %RESET_ALARM_EVENTS %FU.evAlarmLampReset,MoldHeightAdjust1.evMoveTimeoutReset 
// Timeout during %1t%2n %3t{#]A movement is not in endposition while \u000atime supervision exceeded the limit.{#]The violation of a maximum move time is reported by this alarm. This means a \u000amovement did not reach its target or endposition before the maximum move time \u000aexpired.<br>\u000aSeveral reasons can cause this behavior.<br>\u000aFirst is inappropriate movement settings. The output profile could be too low to \u000aovercome friction, or the target value is not set correctly.<br>\u000aSecond the supervision time could be set too low.<br>\u000aThird the feedback from sensors could be broken. This last and possible other \u000areasons point toward a machine hardware problem, which can also cause this \u000aerror.{#]Check the supervision time setting of the timed out movement.<br>\u000aEither increase the time, if allowed, and retry the desired operation. \u000aOtherwise continue with the following steps.<br>\u000aMake sure the component can move with the output settings \u000aprovided. In case the settings are very low and the movement almost \u000areached its target, try to increase the output settings to overcome \u000afriction.<br>\u000aIf this didn't help and the movement uses a sensor feedback to \u000aindicate it has reached its target, check this sensor feedback.<br>\u000aWhen considering machine hardware problems, it can be tested, if \u000athe reaction of the machine to the very basic movements in setup\u000aoperation mode is proper. If there is a problem at this point the problem \u000ais either machine hardware or movement calibration. Before \u000arecalibrating the machine make sure all other possible causes \u000aare out of question.
 ;
  erPresProfDamaged
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error in %1t%2n %3t pressure profile (Point: %4n, maxValue: %1f3){#]Pressure profile settings are not valid.{#]The pressure profile output cannot be calculated properly by the control \u000aapplication. The profile settings by the user are invalid.{#]Adjust the according pressure profile settings before retrying the \u000adesired operation.
 ;
  erVelProfDamaged
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error in %1t%2n %3t velocity profile (Point: %4n, maxValue: %1f3){#]Velocity profile settings are not valid.{#]The velocity profile output cannot be calculated properly by the control \u000aapplication. The profile settings by the user are invalid.{#]Adjust the according velocity profile settings before retrying the \u000adesired operation.
 ;
  erBackPresProfDamaged
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error in %1t%2n %3t backpressure profile (Point: %4n, maxValue: %1f3){#]The backpressure profile doesn't fit the configured maximum acceleration or deceleration.{#]From the backpressure profile set on the hmi the control application calculates a \u000amore detailed profile including the ramps for acceleration and deceleration. Because \u000aof the machine limits also these ramps need to be limited. If the user set profile does \u000anot fit with the maximum backpressure ramp this error is generated and backpressure \u000amovement is not possible. The maximum backpressure ramp is also an hmi setting.{#]Changes to create a valid backpressure profile are possible in two \u000aplaces.<br>\u000aFirst is the {Injection1.sv_PlastProfVis.Profile:c:back pressure profile} itself.<br>\u000aThe second setting is the {Injection1.sv_PlastProfVis.rMaxRampBackPress:l}.<br>\u000aManually tune these settings in order to create a valid profile and to \u000acontinue the desired operation.
 ;
  erMaxStartedMovementsExceeded
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink,%FU.evAlarmMotorLock  %RESET_ALARM_EVENTS %FU.evAlarmLampReset,%FU.evAlarmMotorRelease 
// Too much movements started (max: %1n){#]Only a limited number of movements can \u000abe executed at the same time. Trying to \u000astart a movement when the limit is already \u000areached.{#]According to various settings regarding the machine cycle, several movements \u000aare started at the same time. The control application software carries a limitation \u000afor the maximum number of parallel started movements. Once a movement is \u000astarted while the maximum number of movements is already started at the same \u000atime, this alarm is raised.{#]Adjust the process settings, parallel movements, according to the \u000aprocess requirements in order to reduce the number of parallel \u000amovements to fit within limits.<br><br>\u000aIf this is not possible, please contact the machine manufacturer.
 ;
  erComponentLocked
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// %1t%2n %4t locked by %3t%1s{#]A desired component movement can not be executed because it is locked by another \u000acomponent.{#]Components have the ability to lock other components movements. This is for example required for the mold safety gate. The safety gate locks any mold close movement.<br>\u000aOne component movement can be locked by several sources at the same time.{#]Use the information given in the alarm text to unlock the desired \u000amovement. For example close safetygates, move other components \u000ainto endposition, etc.
 ;
  erMaxActiveMovementsExceeded
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink,%FU.evAlarmMotorLock  %RESET_ALARM_EVENTS %FU.evAlarmLampReset,%FU.evAlarmMotorRelease 
// Too much movements active (max: %1n){#]Only a limited number of movements can \u000abe executed at the same time. While the \u000alimit is already reached another \u000amovement indicated that it is active.{#]According to various settings regarding the machine cycle, several movements \u000aare active at the same time. The control application software carries a limitation \u000afor the maximum number of parallel active movements. Once a movement signals \u000athat it is active now, while the maximum number of movements is already active \u000aat the same time, this alarm is raised.{#]Adjust the process settings, parallel movements, according to the \u000aprocess requirements in order to reduce the number of parallel \u000amovements to fit within limits.<br><br>\u000aIf this is not possible, please contact the machine manufacturer.
 ;
  erInvalidProfileReference
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Invalid profile reference in %1t%2n MoveId: %3t{#]A movement profile cannot be referenced.{#]The profile reference provided to a control application movement block is invalid.\u000a No movement is possible.{#]Please contact the machine manufacturer.
 ;
  erInvalidConstReference
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Invalid reference to const move data in %1t%2n MoveId: %3t{#]The movement output data for a constant \u000amovement is not available.{#]Every constant movement requires output settings. In this case there are no \u000awrong settings, but the settings themselves are actually missing.{#]Please contact the machine manufacturer.
 ;
  erVelocityOutput
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error during velocity output in %1t%2n (MoveId: %3t, ErrorInfo : %4n){#]An error during velocity output occurred.{#]The velocity output stopped because an error occurred.{#]Check the velocity profile setting and the ramp settings on the HMI mask.
 ;
  erPressureOutput
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error during pressure output in %1t%2n (MoveId: %3t, ErrorInfo : %4n){#]An error during pressure output occurred.{#]The pressure output stopped because an error occurred.{#]Check the pressure profile setting and the ramp settings on the HMI mask.
 ;
  erInjectOutput
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error during inject output in %1t%2n (ErrorInfo : %3n){#]An error during inject or hold output occurred.{#]The inject movement can not be executed because the inject block reports an error.{#]Check the profile settings, ramp settings and the PID-parameters for inject and hold movement on the HMI mask.
 ;
  erPlasticizingOutput
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Error during plasticizing output in %1t%2n (ErrorInfo : %3n){#]An error in the plasticizing block occurred.{#]Plasticizing movement is not possible because the plasticizing block reports an error.{#]Check the profile settings, ramp settings and the PID-parameters for plasticize movement on the HMI mask.
 ;
  erInvalidLintabReference
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Invalid lintab reference in measure block of %1t%2n{#]A linearization table cannot be referenced \u000afor measurement.{#]The reference provided to a control application measurement block is invalid. No\u000a measurement is possible.{#]Please contact the machine manufacturer.
 ;
  erInvalidEndpointReference
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Invalid endpoint reference in measure block of %1t%2n (Endpoint:%1s){#]An endpoint cannot be referenced for \u000ameasurement.{#]The reference provided to a control application measurement block is invalid. No\u000a measurement is possible.{#]Please contact the machine manufacturer.
 ;
  erInvalidStatReference
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Invalid reference to _stat flag in measure block of %1t%2n (Endpoint:%1s){#]The status flag reference of a hardware \u000aendpoint is invalid.{#]An analog input status reference provided to a control application movement block is invalid. No measurement is possible.{#]Please contact the machine manufacturer.
 ;
  erAnalogMeasure
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Measure Error in %1t%2n (ErrorInfo: %3n){#]An error during measurement of an analog input occurred.{#]Measuring of the analog input reports an error. As a result the measured value is not correct anymore. The operation mode automatically changes to manual mode.{#]Check the linearisation table for the affected analog input on the HMI mask.
 ;
  erAnalogSensor
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Measured value below limitation in %1t%2n (Lintab:%1s){#]An analog measured value fell below the limitation configured in the application software.{#]For analog input values it is necessary to translate the measured voltage into a \u000aspecific value (e.g.: distance, pressure, etc.) using a linearization table. The range \u000afor valid calculations has been undercut by the measured voltage. Further operation \u000aof the according device is not possible until the input value is back within limitations \u000aand the alarm has been confirmed by a user.{#]Check the analog input voltage and solve hardware problems if \u000anecessary. Then retry the desired operation.<br>\u000aIn case this doesn't provide a solution please contact the machine \u000amanufacturer.
 ;
  erNoValidCustomerID
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// No valid customer ID{#]Invalid customer ID.{#]The controller hardware does not fit to the application software. Either the application software or the controller hardware must be replaced.{#]Please contact the machine manufacturer.
 ;
  erNoValidCustomerVariant
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// No valid customer variant{#]Invalid customer variant.{#]The controller hardware does not fit to the application software. Either the application software or the controller hardware must be replaced.{#]Please contact the machine manufacturer.
 ;
  erNoValidCustomerApplication
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// No valid customer application{#]Invalid control application software.{#]The control application software is invalid and needs to replaced or updated.{#]Please contact the machine manufacturer.
 ;
  erInjectParam
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// %1t%2n too much pressure limit controller modes activated (max: 1){#]More than one pressure limitation controller \u000amode is selected which is not allowed.{#]Only one pressure limit controller must be activated at precutoff.<br>\u000aWhen all controllers are parametrized numbers of activated pressure controllers is checked.{#]Check all pressure limit controller parameters and enable only one of them.
 ;
  erCompNotInCorrectPosition
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n not in correct position{#]A machine component is not in correct \u000aposition to allow the desired operation.{#]Several movements of machine components require other components to be in the \u000acorrect position first. For example the ejector could be required to be in backward \u000aend position to allow a mold close movement. The alarm contains the information \u000aabout the component which needs to be in the correct target or end position to allow \u000acertain movement.{#]Move required components into the correct position before continuing \u000awith the desired operation.<br>\u000aIn case cyclic operation is prevented by this problem, make sure the \u000arequired components can reach their target or end position by checking \u000athe according settings and possibly mechanical checks.
 ;
  erWaitingForCheckCondition
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Waiting for %1t%2n %3t{#]A movement is locked because it is \u000awaiting for another movement to finish.{#]This is just a message and does not indicate a problem.<br>\u000aThe message appears when for example the mold close movement is \u000awaiting for a core to reach its target position. Once the core reached its \u000atarget position the message will disappear and the mold will continue moving.{#]This is just a message, no action required.<br>\u000aOnce the movement which is waited for finishes, the message will \u000adisappear.
 ;
  erInjectScrewPosition
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmAutoManual, %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// %1t%2n screw moved backward to screw stroke during inject{#]Injection screw moved backward to almost \u000ascrew stroke.{#]The machine reaches a problematic state when the injection screw moves backward to screw stroke before inject is finished.{#]Check if a cold slug is inside the nozzle tip.<br>If nozzle is not blocked check pressure sensor.
 ;
  erCANOnlyForSpeedPump
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmWatchdog 
// CAN can only be used for speed pump!{#]A device other than a speed pump is connected to the CAN bus. This is not allowed.{#]On KePlast ECO systems the CAN bus is only allowed for speedpumps. It is not allowed to connect any other devices to the CAN\u000abus.{#]Remove all devices other than speed pumps from the CAN bus.<br>\u000aIf additional CAN devices need to be connected to the machine, \u000aplease contact the machine manufacturer.
 ;
  erCycleTimeIOUpdate
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS %FU.evAlarmLampBlink  %RESET_ALARM_EVENTS %FU.evAlarmLampReset 
// Cycle time of IO update different to TaskInject{#]Using onboard hardware comparator TaskInject must have same cycle time as IO update.{#]If onboard hardware comparator is available, cycle time of IO update task and TaskInject must have same value.<br>Time difference of hardware comparator is not valid.{#]Change IO ONBOARD cycle time to same value of TaskInject cycle time.
 ;
  erProfileMinOutput
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// %1t%2n: value at %3t profile lower than minimum output at profile point %4n{#]Value of min output is higher than profile value{#]Minimum output is higher than paramtrized value. Protection of device not ensured{#]Reduce minimum output for this movement.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
6 
@SysVar @RT(23)sv_bUseStartPosProfiles @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Use startposition profiles @RT(33)Use startposition profiles on hmi @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_bUseStartPosProfiles @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)TRUE @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(26)Use startposition profiles @RT(33)Use startposition profiles on hmi @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_iMovementsAvailable @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(18)sv_ActiveMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsActiveMovements @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)list of active movements 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_ActiveMovements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(24)list of active movements 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_StartedMovements @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tsStartedMoveData @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)list of movements where a start event was sent 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(19)sv_StartedMovements @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(46)list of movements where a start event was sent 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bAllPUTasksExecuted @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bAllPUTasksExecuted @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(24)sv_iActiveParamTransfers @RT(0) @T @F @DT @RT(4)DINT @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)number of actually active parameter transfers (written by ABDriveParam.pu) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_iActiveParamTransfers @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(74)number of actually active parameter transfers (written by ABDriveParam.pu) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
29 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erProfileSequence @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(515)Error in %1t%2n %3t sequence{#]Profile settings are invalid.{#]When setting a profile for a movement the independent variable needs to \u000aincrease or decrease monotonically. For example the mold close profile \u000arequires the position settings to decrease monotonically. If this is not the case \u000athe profile cannot be calculated.{#]Change the according profile settings.<br>\u000aIf it is desired to make it impossible to enter problematic values on the \u000ahmi, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erMoveTimeout @RT(1)2 @RT(1)y @RT(75)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink,MoldHeightAdjust1.evMoveTimeout @RT(57)%FU.evAlarmLampReset,MoldHeightAdjust1.evMoveTimeoutReset @RT(4)User @RT(1686)Timeout during %1t%2n %3t{#]A movement is not in endposition while \u000atime supervision exceeded the limit.{#]The violation of a maximum move time is reported by this alarm. This means a \u000amovement did not reach its target or endposition before the maximum move time \u000aexpired.<br>\u000aSeveral reasons can cause this behavior.<br>\u000aFirst is inappropriate movement settings. The output profile could be too low to \u000aovercome friction, or the target value is not set correctly.<br>\u000aSecond the supervision time could be set too low.<br>\u000aThird the feedback from sensors could be broken. This last and possible other \u000areasons point toward a machine hardware problem, which can also cause this \u000aerror.{#]Check the supervision time setting of the timed out movement.<br>\u000aEither increase the time, if allowed, and retry the desired operation. \u000aOtherwise continue with the following steps.<br>\u000aMake sure the component can move with the output settings \u000aprovided. In case the settings are very low and the movement almost \u000areached its target, try to increase the output settings to overcome \u000afriction.<br>\u000aIf this didn't help and the movement uses a sensor feedback to \u000aindicate it has reached its target, check this sensor feedback.<br>\u000aWhen considering machine hardware problems, it can be tested, if \u000athe reaction of the machine to the very basic movements in setup\u000aoperation mode is proper. If there is a problem at this point the problem \u000ais either machine hardware or movement calibration. Before \u000arecalibrating the machine make sure all other possible causes \u000aare out of question. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erPresProfDamaged @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(342)Error in %1t%2n %3t pressure profile (Point: %4n, maxValue: %1f3){#]Pressure profile settings are not valid.{#]The pressure profile output cannot be calculated properly by the control \u000aapplication. The profile settings by the user are invalid.{#]Adjust the according pressure profile settings before retrying the \u000adesired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erVelProfDamaged @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(342)Error in %1t%2n %3t velocity profile (Point: %4n, maxValue: %1f3){#]Velocity profile settings are not valid.{#]The velocity profile output cannot be calculated properly by the control \u000aapplication. The profile settings by the user are invalid.{#]Adjust the according velocity profile settings before retrying the \u000adesired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erBackPresProfDamaged @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(983)Error in %1t%2n %3t backpressure profile (Point: %4n, maxValue: %1f3){#]The backpressure profile doesn't fit the configured maximum acceleration or deceleration.{#]From the backpressure profile set on the hmi the control application calculates a \u000amore detailed profile including the ramps for acceleration and deceleration. Because \u000aof the machine limits also these ramps need to be limited. If the user set profile does \u000anot fit with the maximum backpressure ramp this error is generated and backpressure \u000amovement is not possible. The maximum backpressure ramp is also an hmi setting.{#]Changes to create a valid backpressure profile are possible in two \u000aplaces.<br>\u000aFirst is the {Injection1.sv_PlastProfVis.Profile:c:back pressure profile} itself.<br>\u000aThe second setting is the {Injection1.sv_PlastProfVis.rMaxRampBackPress:l}.<br>\u000aManually tune these settings in order to create a valid profile and to \u000acontinue the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(29)erMaxStartedMovementsExceeded @RT(1)1 @RT(1)y @RT(64)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink,%FU.evAlarmMotorLock @RT(44)%FU.evAlarmLampReset,%FU.evAlarmMotorRelease @RT(4)User @RT(807)Too much movements started (max: %1n){#]Only a limited number of movements can \u000abe executed at the same time. Trying to \u000astart a movement when the limit is already \u000areached.{#]According to various settings regarding the machine cycle, several movements \u000aare started at the same time. The control application software carries a limitation \u000afor the maximum number of parallel started movements. Once a movement is \u000astarted while the maximum number of movements is already started at the same \u000atime, this alarm is raised.{#]Adjust the process settings, parallel movements, according to the \u000aprocess requirements in order to reduce the number of parallel \u000amovements to fit within limits.<br><br>\u000aIf this is not possible, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erComponentLocked @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(544)%1t%2n %4t locked by %3t%1s{#]A desired component movement can not be executed because it is locked by another \u000acomponent.{#]Components have the ability to lock other components movements. This is for example required for the mold safety gate. The safety gate locks any mold close movement.<br>\u000aOne component movement can be locked by several sources at the same time.{#]Use the information given in the alarm text to unlock the desired \u000amovement. For example close safetygates, move other components \u000ainto endposition, etc. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erMaxActiveMovementsExceeded @RT(1)1 @RT(1)y @RT(64)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink,%FU.evAlarmMotorLock @RT(44)%FU.evAlarmLampReset,%FU.evAlarmMotorRelease @RT(4)User @RT(842)Too much movements active (max: %1n){#]Only a limited number of movements can \u000abe executed at the same time. While the \u000alimit is already reached another \u000amovement indicated that it is active.{#]According to various settings regarding the machine cycle, several movements \u000aare active at the same time. The control application software carries a limitation \u000afor the maximum number of parallel active movements. Once a movement signals \u000athat it is active now, while the maximum number of movements is already active \u000aat the same time, this alarm is raised.{#]Adjust the process settings, parallel movements, according to the \u000aprocess requirements in order to reduce the number of parallel \u000amovements to fit within limits.<br><br>\u000aIf this is not possible, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erInvalidProfileReference @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(249)Invalid profile reference in %1t%2n MoveId: %3t{#]A movement profile cannot be referenced.{#]The profile reference provided to a control application movement block is invalid.\u000a No movement is possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erInvalidConstReference @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(326)Invalid reference to const move data in %1t%2n MoveId: %3t{#]The movement output data for a constant \u000amovement is not available.{#]Every constant movement requires output settings. In this case there are no \u000awrong settings, but the settings themselves are actually missing.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erVelocityOutput @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(246)Error during velocity output in %1t%2n (MoveId: %3t, ErrorInfo : %4n){#]An error during velocity output occurred.{#]The velocity output stopped because an error occurred.{#]Check the velocity profile setting and the ramp settings on the HMI mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erPressureOutput @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(246)Error during pressure output in %1t%2n (MoveId: %3t, ErrorInfo : %4n){#]An error during pressure output occurred.{#]The pressure output stopped because an error occurred.{#]Check the pressure profile setting and the ramp settings on the HMI mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erInjectOutput @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(302)Error during inject output in %1t%2n (ErrorInfo : %3n){#]An error during inject or hold output occurred.{#]The inject movement can not be executed because the inject block reports an error.{#]Check the profile settings, ramp settings and the PID-parameters for inject and hold movement on the HMI mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erPlasticizingOutput @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(304)Error during plasticizing output in %1t%2n (ErrorInfo : %3n){#]An error in the plasticizing block occurred.{#]Plasticizing movement is not possible because the plasticizing block reports an error.{#]Check the profile settings, ramp settings and the PID-parameters for plasticize movement on the HMI mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erInvalidLintabReference @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(276)Invalid lintab reference in measure block of %1t%2n{#]A linearization table cannot be referenced \u000afor measurement.{#]The reference provided to a control application measurement block is invalid. No\u000a measurement is possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erInvalidEndpointReference @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(283)Invalid endpoint reference in measure block of %1t%2n (Endpoint:%1s){#]An endpoint cannot be referenced for \u000ameasurement.{#]The reference provided to a control application measurement block is invalid. No\u000a measurement is possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erInvalidStatReference @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(11)Application @RT(309)Invalid reference to _stat flag in measure block of %1t%2n (Endpoint:%1s){#]The status flag reference of a hardware \u000aendpoint is invalid.{#]An analog input status reference provided to a control application movement block is invalid. No measurement is possible.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erAnalogMeasure @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(340)Measure Error in %1t%2n (ErrorInfo: %3n){#]An error during measurement of an analog input occurred.{#]Measuring of the analog input reports an error. As a result the measured value is not correct anymore. The operation mode automatically changes to manual mode.{#]Check the linearisation table for the affected analog input on the HMI mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erAnalogSensor @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(20)User and Application @RT(769)Measured value below limitation in %1t%2n (Lintab:%1s){#]An analog measured value fell below the limitation configured in the application software.{#]For analog input values it is necessary to translate the measured voltage into a \u000aspecific value (e.g.: distance, pressure, etc.) using a linearization table. The range \u000afor valid calculations has been undercut by the measured voltage. Further operation \u000aof the according device is not possible until the input value is back within limitations \u000aand the alarm has been confirmed by a user.{#]Check the analog input voltage and solve hardware problems if \u000anecessary. Then retry the desired operation.<br>\u000aIn case this doesn't provide a solution please contact the machine \u000amanufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erNoValidCustomerID @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(231)No valid customer ID{#]Invalid customer ID.{#]The controller hardware does not fit to the application software. Either the application software or the controller hardware must be replaced.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erNoValidCustomerVariant @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(241)No valid customer variant{#]Invalid customer variant.{#]The controller hardware does not fit to the application software. Either the application software or the controller hardware must be replaced.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erNoValidCustomerApplication @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(192)No valid customer application{#]Invalid control application software.{#]The control application software is invalid and needs to replaced or updated.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erInjectParam @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(406)%1t%2n too much pressure limit controller modes activated (max: 1){#]More than one pressure limitation controller \u000amode is selected which is not allowed.{#]Only one pressure limit controller must be activated at precutoff.<br>\u000aWhen all controllers are parametrized numbers of activated pressure controllers is checked.{#]Check all pressure limit controller parameters and enable only one of them. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erCompNotInCorrectPosition @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(809)%1t%2n not in correct position{#]A machine component is not in correct \u000aposition to allow the desired operation.{#]Several movements of machine components require other components to be in the \u000acorrect position first. For example the ejector could be required to be in backward \u000aend position to allow a mold close movement. The alarm contains the information \u000aabout the component which needs to be in the correct target or end position to allow \u000acertain movement.{#]Move required components into the correct position before continuing \u000awith the desired operation.<br>\u000aIn case cyclic operation is prevented by this problem, make sure the \u000arequired components can reach their target or end position by checking \u000athe according settings and possibly mechanical checks. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erWaitingForCheckCondition @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(538)Waiting for %1t%2n %3t{#]A movement is locked because it is \u000awaiting for another movement to finish.{#]This is just a message and does not indicate a problem.<br>\u000aThe message appears when for example the mold close movement is \u000awaiting for a core to reach its target position. Once the core reached its \u000atarget position the message will disappear and the mold will continue moving.{#]This is just a message, no action required.<br>\u000aOnce the movement which is waited for finishes, the message will \u000adisappear. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erInjectScrewPosition @RT(1)2 @RT(1)y @RT(43)%FU.evAlarmAutoManual, %FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(345)%1t%2n screw moved backward to screw stroke during inject{#]Injection screw moved backward to almost \u000ascrew stroke.{#]The machine reaches a problematic state when the injection screw moves backward to screw stroke before inject is finished.{#]Check if a cold slug is inside the nozzle tip.<br>If nozzle is not blocked check pressure sensor. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erCANOnlyForSpeedPump @RT(1)1 @RT(1)y @RT(19)%FU.evAlarmWatchdog @RT(0) @RT(11)Application @RT(439)CAN can only be used for speed pump!{#]A device other than a speed pump is connected to the CAN bus. This is not allowed.{#]On KePlast ECO systems the CAN bus is only allowed for speedpumps. It is not allowed to connect any other devices to the CAN\u000abus.{#]Remove all devices other than speed pumps from the CAN bus.<br>\u000aIf additional CAN devices need to be connected to the machine, \u000aplease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erCycleTimeIOUpdate @RT(1)2 @RT(1)y @RT(20)%FU.evAlarmLampBlink @RT(20)%FU.evAlarmLampReset @RT(4)User @RT(374)Cycle time of IO update different to TaskInject{#]Using onboard hardware comparator TaskInject must have same cycle time as IO update.{#]If onboard hardware comparator is available, cycle time of IO update task and TaskInject must have same value.<br>Time difference of hardware comparator is not valid.{#]Change IO ONBOARD cycle time to same value of TaskInject cycle time. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erProfileMinOutput @RT(1)3 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(253)%1t%2n: value at %3t profile lower than minimum output at profile point %4n{#]Value of min output is higher than profile value{#]Minimum output is higher than paramtrized value. Protection of device not ensured{#]Reduce minimum output for this movement. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
