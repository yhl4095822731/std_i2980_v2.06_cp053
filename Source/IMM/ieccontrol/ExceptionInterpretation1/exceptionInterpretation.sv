%IMPORT_OVER_LISTFILE_OBJECT
 cLevelSuperUser
, KMSG_Event

END_IMPORT

%SYSTEMVAR_DECL
  sv_bCFRemoved : BOOL
   %FAST_RETAIN  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
;
%END

%SYSTEMEVENT_DECL
  evGeneralErrorOLC : KMSG_Event
;
%END

%SYSTEM_ALARM
  erApplicationException
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Application exception! ( %1s, F%2n/C%1n, %2s ){#]An application internal problem happened.{#]A serious problem during application loading/executing happened. No further \u000aoperation is possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erApplicationExceptionOLC
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Application exception! ( %1s, F%2n/C%1n/I%3n, %2s ){#]An application internal problem happened.{#]A serious problem during application loading/executing happened. No further \u000aoperation is possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erGeneralException
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// General exception %1n/%2n! restart machine and send status report to manufacturer{#]A controller internal error happened.{#]This is a fall-back error, representing various problems. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erTimeException
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Time exception! restart machine and send status report to manufacturer %1s{#]A CPU time exception occurred.{#]The CPU time available was exceeded resulting in an overflow and this alarm. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erFWResourceException
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// FW resource exception! Kind: %1s{#]A controller internal error happened.{#]The management of a software resource of the controller reports a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erFWTaskException
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// FW task exception! ( %1s, F%2n/C%1n, Kind:%2s ){#]A controller internal error happened.{#]The management of a task of the controller reports a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erFWTaskExceptionOLC
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// FW task exception! ( %1s, F%2n/C%1n/I%3n, Kind:%2s ){#]A controller internal error happened.{#]The management of a task of the controller reports a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erWatchdog
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock,system.evAlarmWatchdog 
// Watchdog! restart machine and send status report to manufacturer{#]A crucial error happened.{#]A crucial error triggered a watchdog alarm. There is no further operation possible. A status report has been created.{#]Please contact the machine manufacturer.
 ;
  erCustomError
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// %1s{#]An error with corrupt data happened.{#]The error raised cannot be identified by the control application because of corrupt error data.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erShortCircuit
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// Short circuit: %1s{#]A short circuit happened.{#]On the IO system a device reports a short circuit. Most likely there is a wiring problem. Keba products are well protected against short circuits and are rarely damaged by it. At this point there is no further operation possible.{#]Check the wiring and terminal to remove the short circuit. After solving the short circuit check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer.
 ;
  erShortCircuitAO
 %CLASS 1 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// Short circuit on analog current outputs (%1s){#]A short circuit on an analog output happened.{#]On an analog current output a short circuit happened. Most likely there is a wiring problem. Keba products are well protected against short circuits and are rarely damaged by it. At this point there is no further operation possible.{#]Check the wiring and terminal to remove the short circuit. After solving the short circuit check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer.
 ;
  erLineFrequency
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Unknown voltage line frequency (%1s){#]An unknown line voltage frequency was detected.{#]An unknown or invalid frequency was detected on the specified line.{#]Check the wiring and terminal to remove the invalid line frequency. After solving invalid line frequency check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer.
 ;
  erZeroCrossing
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// No voltage zero crossing detected (%1s){#]No more voltage zero crossings detected.{#]An alternating voltage is expected, but it is diagnosed that no zero crossings are occurring.{#]Check the wiring and terminal to remove the zero crossing alarm. After solving invalid line frequency check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer.
 ;
  erCPUTempHigh
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// CPU temperature too high: %1s°C{#]The CPU temperature is too high.{#]The CPU temperature of the controller is too high. There is no further cyclic operation possible{#]Make sure the ventilation system of the cabinet is working properly. Make sure the controller is mounted horizontally, in order to allow air to move through the venting slots. Make sure the CPU fan is not raising an alarm.<br><br>\u000aIf the problem appears again, please contact the machine manufacturer.
 ;
  erCPUTempWarn
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// CPU temperature warning: %1s°C{#]The CPU temperature is reaching a critical level.{#]This is just a message. The CPU temperature of the controller is getting too high. If the temperature increases further no more cyclic operation will be possible.{#]This is just a message, but taking actions is strongly suggested.<br><br>\u000aMake sure the ventilation system of the cabinet is working properly. Make sure the controller is mounted horizontally, in order to allow air to move through the venting slots. Make sure the CPU fan is not raising an alarm.
 ;
  erCompactFlashFull
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Compact flash disk full{#]Compact flash disk is full.{#]The limited storage of the compact flash card is full. This should not happen without causing behavior of a user. It is possible that extensive screenshots have been made or other files have been copied to the compact flash card.{#]Remove not required files that have been placed by an user from the card. Remove screenshots if possible (search for *.png files). Remove mold data sets if too many of them are stored on the card.<br><br>\u000aIf the alarm happens without a very clear reason what is using up the storage of the compact flash card, please contact the machine manufacturer.
 ;
  erDuplicateIPAdr
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Duplicate IP address: %1s{#]The IP address of the controller is not unique.{#]This is not a crucial error, machine operation is still possible. In the local area network connected to the controller the current IP address of the controller exists multiple times. Local machine functionalities operate normally. But there is no TCP/IP communication based functionality available.{#]This is not a crucial error, machine operation is still possible, no action required.<br>\u000aChange the IP address of the controller, or on the device which also carries the same IP address to enable network functionality.
 ;
  erHWNotFound
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// Hardware not found: %1s{#]A configured hardware device cannot be found.{#]There is no communication possible with a device that is configured and required for operation. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erInvalidCalibData
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Invalid calibrate data: %1s, %2s{#]A device of the IO system signals invalid calibration data.{#]An invalid calibration error is recognized by the IO system. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erPCIDeviceNotFound
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// PCI device %1s.%2s not found in slot %3s{#]A configured PCI hardware device cannot be found.{#]There is no communication possible with a PCI device that is configured and required for operation. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erPCIDeviceDefect
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmLampReset, system.evAlarmMotorRelease 
// PCI device defect: Comp: %1n, Nr: %2n{#]A PCI device signals a defect.{#]A device connected via PCI signals a defect. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erInfolog
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Infolog error: Comp: %1n, Nr: %2n{#]An error during reading or writing infolog occurred.{#]The controller can not add new infolog entries or read the existing entries.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erHardwareConflict
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Hardware conflict: %1s, %2s{#]There is a hardware conflict in the IO system.{#]There is a conflict between two or more devices of the controller system. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erDeviceDefect
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Device defect: %1n Nr: %2n, %1s{#]A device is defect.{#]The system detected a defect device. No further operation is possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erSJA1000Defect
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// Device SJA1000 defect{#]A SJA1000 device signals a defect.{#]A drive device of the type SJA1000 signals a defect hardware state. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.<br>\u000aIn case spare parts are available, replace the defect device.
 ;
  erUI450Defect
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// UI450 defect: %1n Nr: %2n, %1s{#]A UI450 device signals a defect.{#]A device of the type UI450 signals a defect hardware state. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.<br>\u000aIn case spare parts are available, replace the defect device.
 ;
  erKNETDefect
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// KNET device defect: %1n Nr: %2n, %1s{#]A KNET device signals a defect.{#]A device connected via KNET signals a defect. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.<br>\u000aIn case spare parts are available, replace the defect device.
 ;
  erFX400Defect
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock 
// FX400 defect: %1n Nr: %2n, %1s{#]A interface device FX400 signals a defect.{#]A FX400 device is recognized as defect. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.
 ;
  erStaRep
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Statusreport error : %1n Nr: %2n{#]An error occurred during starep creation or writing.{#]The status report could not be created or stored properly.{#]Please contact the machine manufacturer.
 ;
  erEndpointAlreadyExists
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink, system.evAlarmMotorLock 
// Duplicate endpoint declaration, check configuration: %2s{#]An endpoint declaration in the IO configuration is duplicate.{#]Each used hardware endpoint is assigned with one system variable in the IO configuration. In this case one variable is used for two endpoint assignments. A change in the IO configuration is necessary.{#]Please contact the machine manufacturer.
 ;
  erBatteryLowVoltage
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// CMOS battery voltage is low - replace battery{#]CMOS battery voltage is getting low.{#]After several years the CMOS battery in the controller needs to be replaced.{#]Replace the CMOS battery of the controller.
 ;
  erInjGraphMeasureNotFinished
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Inject graph measure not finished{#]Inject graph measurement was not finished.{#]This is not a crucial error, machine operation is still possible. The inject graph cannot finish its measurements. Inject graph cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the infolog problem create a status report. Then please contact the machine manufacturer.
 ;
  erBatteryNoVoltage
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// No CMOS battery voltage - replace battery{#]CMOS battery is empty.{#]After several years the CMOS battery in the controller needs to be replaced.{#]Replace the CMOS battery of the controller.
 ;
  erRetaindataLost
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Retaindata lost, please check machine settings and send a status report to manufacturer{#]Retaindata has been lost.{#]Usersettings and variable values stored within the retaindata have been partially lost. The cause is either a new control application version or a dying battery. The latter would be indicated by its own alarm.{#]If available, re-load all available data (mold data, machine data, ...). Check all settings.<br><br>\u000aCheck if the battery low alarm is raised. In this case replace the CMOS battery. Otherwise create a status report. Then please contact the machine manufacturer.<br><br>\u000aAfter re-loading all data and/or checking all HMI settings continued operation is possible. Although it is possible that some settings are lost again with the next reboot.
 ;
  erCpuFanLowVelocity
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// CPU fan speed low - replace fan{#]The CPU fan is showing low speed.{#]A working CPU fan is required to ensure proper operation of the controller.{#]Replace the CPU fan.
 ;
  erPdpExportNotCreated
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// PDP export file not created (%1s){#]PDP export file could not be created.{#]This is not a crucial error, machine operation is still possible. The export file for PDP could not be created. PDP export cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the PDP problem create a status report. Then please contact the machine manufacturer.
 ;
  erInjGraphLogNotCreated
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Inject graph log file not created (%1s){#]Inject graph log file cannot be created.{#]This is not a crucial error, machine operation is still possible. In order to log the inject graph measurements a file should be created. This file creation process failed. Inject graph cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the infolog problem create a status report. Then please contact the machine manufacturer.
 ;
  erCpuFanDefect
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// CPU fan is not working - replace fan{#]The CPU fan is not working.{#]A working CPU fan is required to ensure proper operation of the controller.{#]Replace the CPU fan.
 ;
  erECATStateChanged
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// EtherCAT unexpected state transition{#]EtherCAT unexpected state transition.{#]While communicating over EtherCAT the state is transited unexpectedly. Continued operation is not possible. The motor is locked.{#]Check the EtherCAT wiring and terminal.
 ;
  erInjGraphLostTrigger
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO

// Inject graph lost trigger{#]Inject graph lost its trigger.{#]This is not a crucial error, machine operation is still possible. The inject graph cannot access the configured trigger variable. Inject graph cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the infolog problem create a status report. Then please contact the machine manufacturer.
 ;
  erStarepWriting
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Writing status report - please wait until finished before restarting the controller{#]Status report is currently created, do not turn off the power!{#]A status report, containing various information about the hardware and software system state and history, is created and stored. In case the controller is turned off while status report creation interesting information might be lost.{#]This is just a message, no action required.
 ;
  erStarepFinished
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO

// Writing status report finished!{#]Writing the status report is finished.{#]A complete status report has been created and stored, containing various information about the hardware and software system state and history. When searching for a status report file, look for starep_***.tgz.{#]This is just a message, no action required.
 ;
  erNoSocketLeft
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Network problem occurred (no socket left){#]No socket is left for further network communications.{#]This is not a crucial error, machine operation is still possible. There is no more TCP/IP communication possible because there are no sockets left.{#]This is not a crucial error, machine operation is still possible.<br>\u000aTo solve the problem first create a statusreport. Check if the problem still appears after a reboot of the controller. If the problem is permanent please contact the machine manufacturer.
 ;
  erDeviceDisconnected
 %CLASS 1 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmMotorRelease 
// Device disconnected (%1s) - check cable connection or drive status{#]A device has been disconnected.{#]A device has been disconnected from a hardware interface.{#]If the disconnected device is a drive, check the drive status. In any case check the wiring and terminal.
 ;
  erInputDatatypeWrong
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Data type is wrong - check documentation{#]Data type for CAN communication is wrong.{#]The datatype of a CAN setting is wrong, resulting in a buffer size which is too small. The CAN connection cannot be used.{#]Set the correct datatype before retrying the desired communication.
 ;
  erECATFrameLost
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmMotorRelease 
// EtherCAT frame lost{#]EtherCAT communication problem.{#]While communicating over EtherCAT the frame, a part of a telegram, has been lost. Continued operation is not possible. The motor is locked.{#]Check the EtherCAT wiring and terminal.
 ;
  erNoFinalVersion
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Testversion of firmware package is running on CPU{#]The software on this controller is only a testversion.{#]The software currently installed and running on this controller is not a final released version. Only final released software versions are allowed to run on a machine permanently.{#]Please contact the machine manufacturer or software provider in order to get a final released software version.
 ;
  erECATInitCmdFailed
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmMotorRelease 
// EtherCAT init command failed during state transition (%1s){#]Command send to drive while it is not ready.{#]If drive is reseted or disconnected no command can be sent to drive.{#]Wait until drive is ready after reset or connecting.
 ;
  erECATSlaveNotFound
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual,system.evAlarmMotorLock  %RESET_ALARM_EVENTS system.evAlarmMotorRelease 
// EtherCAT slave not found (%1s){#]EtherCAT slave is disconnected.{#]EtherCAT cable is disconnected or reset on drive is done.{#]If cable is disconnected from drive reconnect.<br>\u000aIf drive is reseted wait until drive is ready again.
 ;
  erCFCardRemoved
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %NO
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// CF card removed!{#]The CF card was removed while the controller was running.{#]The CF card was removed while the controller was running. There is no further cyclic operation possible.{#]Make sure the CF card is inserted correctly.
 ;
  erRestartAfterCFRemoved
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Restart of controller because CF card was removed!{#]The controller was restarted because the CF card was removed.{#]A restart of the controller was triggered by the application because the CF card was removed.{#]Make sure the CF card is inserted correctly.
 ;
  erCFLifetimeWarning
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// Remaining compact flash lifetime is only %1s%{#]The remaining lifetime of the compact flash is low.{#]Due to long usage the remaining lifetime of the compact flash is low. {#]Change the compact flash.
 ;
  erDiskUsageWarning
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// The disk usage is over %3n%{#]Actually more than 90% (95%) of the disk size is used.{#]The controller actually uses more than 90% (95%) of the disk space. Possible reasons are: Several sets of mold data, data loggings (spc or pdp), screenshots, state reports, ...\u000aIt is recommended to free some diskspace to avoid the risk of data loss.{#]Delete unused files or folders. The alarm will disappear if the disk usage is below 90%.
 ;
  erRAMUsageWarning
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// The RAM usage is over 90%{#]Actually more than 90% of the RAM is in use.{#]The controller actually uses more than 90% of the RAM. Possible reasons are big HMI or IEC applications, animations, ... .{#]The alarm will disappear if the RAM usage is below 90%. If the alarm does not disappear in time, please contact the machine manufacturer.
 ;
  erFileHandleUsageWarning
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// The file handle usage is over 90%{#]Actually more than 90% of the file handles are in use.{#]The controller actually uses more than 90% of the file handles. Opening new files can lead to an exception.{#]The alarm will disappear if the file handle usage is below 90%. If the alarm does not disappear in time, please contact the machine manufacturer.
 ;
  erFastRetain
 %CLASS 1 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink, system.evAlarmMotorLock 
// Invalid fast retain data{#]An error in the fast retain data was detected.{#]A fast retain data block is not valid. This can happen for example after a "restore" operation.{#]Delete fast retain data on the controller.
 ;
  erSMARTDataNotAvailable
 %CLASS 5 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// SMART data of CF not available{#]The SMART data of the used compact flash is not available.{#]The used compact flash does not provide SMART data. This means that it is not possible to detect the remaining compact flash lifetime.{#]Please contact the machine manufacturer.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 68 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
1 
@SysVar @RT(13)sv_bCFRemoved @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(13)sv_bCFRemoved @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)f @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@RT(15)SETreeContainer 
1 
@SysEvent @RT(17)evGeneralErrorOLC @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(10)KMSG_Event @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
57 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(22)erApplicationException @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(303)Application exception! ( %1s, F%2n/C%1n, %2s ){#]An application internal problem happened.{#]A serious problem during application loading/executing happened. No further \u000aoperation is possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erApplicationExceptionOLC @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(308)Application exception! ( %1s, F%2n/C%1n/I%3n, %2s ){#]An application internal problem happened.{#]A serious problem during application loading/executing happened. No further \u000aoperation is possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erGeneralException @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(327)General exception %1n/%2n! restart machine and send status report to manufacturer{#]A controller internal error happened.{#]This is a fall-back error, representing various problems. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erTimeException @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(332)Time exception! restart machine and send status report to manufacturer %1s{#]A CPU time exception occurred.{#]The CPU time available was exceeded resulting in an overflow and this alarm. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erFWResourceException @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(295)FW resource exception! Kind: %1s{#]A controller internal error happened.{#]The management of a software resource of the controller reports a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erFWTaskException @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(297)FW task exception! ( %1s, F%2n/C%1n, Kind:%2s ){#]A controller internal error happened.{#]The management of a task of the controller reports a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erFWTaskExceptionOLC @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(302)FW task exception! ( %1s, F%2n/C%1n/I%3n, Kind:%2s ){#]A controller internal error happened.{#]The management of a task of the controller reports a problem. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(10)erWatchdog @RT(1)1 @RT(1)y @RT(97)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock,system.evAlarmWatchdog @RT(0) @RT(11)Application @RT(255)Watchdog! restart machine and send status report to manufacturer{#]A crucial error happened.{#]A crucial error triggered a watchdog alarm. There is no further operation possible. A status report has been created.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erCustomError @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(246)%1s{#]An error with corrupt data happened.{#]The error raised cannot be identified by the control application because of corrupt error data.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erShortCircuit @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(4)User @RT(492)Short circuit: %1s{#]A short circuit happened.{#]On the IO system a device reports a short circuit. Most likely there is a wiring problem. Keba products are well protected against short circuits and are rarely damaged by it. At this point there is no further operation possible.{#]Check the wiring and terminal to remove the short circuit. After solving the short circuit check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erShortCircuitAO @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(20)User and Application @RT(542)Short circuit on analog current outputs (%1s){#]A short circuit on an analog output happened.{#]On an analog current output a short circuit happened. Most likely there is a wiring problem. Keba products are well protected against short circuits and are rarely damaged by it. At this point there is no further operation possible.{#]Check the wiring and terminal to remove the short circuit. After solving the short circuit check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erLineFrequency @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(384)Unknown voltage line frequency (%1s){#]An unknown line voltage frequency was detected.{#]An unknown or invalid frequency was detected on the specified line.{#]Check the wiring and terminal to remove the invalid line frequency. After solving invalid line frequency check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erZeroCrossing @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(403)No voltage zero crossing detected (%1s){#]No more voltage zero crossings detected.{#]An alternating voltage is expected, but it is diagnosed that no zero crossings are occurring.{#]Check the wiring and terminal to remove the zero crossing alarm. After solving invalid line frequency check the alarm information if any permanent damage has been done. In this case please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erCPUTempHigh @RT(1)1 @RT(1)y @RT(57)system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(11)Application @RT(475)CPU temperature too high: %1s°C{#]The CPU temperature is too high.{#]The CPU temperature of the controller is too high. There is no further cyclic operation possible{#]Make sure the ventilation system of the cabinet is working properly. Make sure the controller is mounted horizontally, in order to allow air to move through the venting slots. Make sure the CPU fan is not raising an alarm.<br><br>\u000aIf the problem appears again, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erCPUTempWarn @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(552)CPU temperature warning: %1s°C{#]The CPU temperature is reaching a critical level.{#]This is just a message. The CPU temperature of the controller is getting too high. If the temperature increases further no more cyclic operation will be possible.{#]This is just a message, but taking actions is strongly suggested.<br><br>\u000aMake sure the ventilation system of the cabinet is working properly. Make sure the controller is mounted horizontally, in order to allow air to move through the venting slots. Make sure the CPU fan is not raising an alarm. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erCompactFlashFull @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(643)Compact flash disk full{#]Compact flash disk is full.{#]The limited storage of the compact flash card is full. This should not happen without causing behavior of a user. It is possible that extensive screenshots have been made or other files have been copied to the compact flash card.{#]Remove not required files that have been placed by an user from the card. Remove screenshots if possible (search for *.png files). Remove mold data sets if too many of them are stored on the card.<br><br>\u000aIf the alarm happens without a very clear reason what is using up the storage of the compact flash card, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erDuplicateIPAdr @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(604)Duplicate IP address: %1s{#]The IP address of the controller is not unique.{#]This is not a crucial error, machine operation is still possible. In the local area network connected to the controller the current IP address of the controller exists multiple times. Local machine functionalities operate normally. But there is no TCP/IP communication based functionality available.{#]This is not a crucial error, machine operation is still possible, no action required.<br>\u000aChange the IP address of the controller, or on the device which also carries the same IP address to enable network functionality. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erHWNotFound @RT(1)1 @RT(1)y @RT(48)system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(4)User @RT(315)Hardware not found: %1s{#]A configured hardware device cannot be found.{#]There is no communication possible with a device that is configured and required for operation. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erInvalidCalibData @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(303)Invalid calibrate data: %1s, %2s{#]A device of the IO system signals invalid calibration data.{#]An invalid calibration error is recognized by the IO system. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erPCIDeviceNotFound @RT(1)1 @RT(1)y @RT(48)system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(4)User @RT(340)PCI device %1s.%2s not found in slot %3s{#]A configured PCI hardware device cannot be found.{#]There is no communication possible with a PCI device that is configured and required for operation. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erPCIDeviceDefect @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(51)system.evAlarmLampReset, system.evAlarmMotorRelease @RT(4)User @RT(263)PCI device defect: Comp: %1n, Nr: %2n{#]A PCI device signals a defect.{#]A device connected via PCI signals a defect. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(9)erInfolog @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(273)Infolog error: Comp: %1n, Nr: %2n{#]An error during reading or writing infolog occurred.{#]The controller can not add new infolog entries or read the existing entries.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erHardwareConflict @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(298)Hardware conflict: %1s, %2s{#]There is a hardware conflict in the IO system.{#]There is a conflict between two or more devices of the controller system. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erDeviceDefect @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(232)Device defect: %1n Nr: %2n, %1s{#]A device is defect.{#]The system detected a defect device. No further operation is possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erSJA1000Defect @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(345)Device SJA1000 defect{#]A SJA1000 device signals a defect.{#]A drive device of the type SJA1000 signals a defect hardware state. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.<br>\u000aIn case spare parts are available, replace the defect device. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erUI450Defect @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(344)UI450 defect: %1n Nr: %2n, %1s{#]A UI450 device signals a defect.{#]A device of the type UI450 signals a defect hardware state. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.<br>\u000aIn case spare parts are available, replace the defect device. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erKNETDefect @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(335)KNET device defect: %1n Nr: %2n, %1s{#]A KNET device signals a defect.{#]A device connected via KNET signals a defect. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer.<br>\u000aIn case spare parts are available, replace the defect device. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erFX400Defect @RT(1)1 @RT(1)y @RT(74)system.evAlarmAutoManual, system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(263)FX400 defect: %1n Nr: %2n, %1s{#]A interface device FX400 signals a defect.{#]A FX400 device is recognized as defect. There is no further operation possible.{#]Create a status report before restarting the machine.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(8)erStaRep @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(191)Statusreport error : %1n Nr: %2n{#]An error occurred during starep creation or writing.{#]The status report could not be created or stored properly.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erEndpointAlreadyExists @RT(1)1 @RT(1)y @RT(48)system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(366)Duplicate endpoint declaration, check configuration: %2s{#]An endpoint declaration in the IO configuration is duplicate.{#]Each used hardware endpoint is assigned with one system variable in the IO configuration. In this case one variable is used for two endpoint assignments. A change in the IO configuration is necessary.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erBatteryLowVoltage @RT(1)2 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(209)CMOS battery voltage is low - replace battery{#]CMOS battery voltage is getting low.{#]After several years the CMOS battery in the controller needs to be replaced.{#]Replace the CMOS battery of the controller. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(28)erInjGraphMeasureNotFinished @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(434)Inject graph measure not finished{#]Inject graph measurement was not finished.{#]This is not a crucial error, machine operation is still possible. The inject graph cannot finish its measurements. Inject graph cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the infolog problem create a status report. Then please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erBatteryNoVoltage @RT(1)2 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(191)No CMOS battery voltage - replace battery{#]CMOS battery is empty.{#]After several years the CMOS battery in the controller needs to be replaced.{#]Replace the CMOS battery of the controller. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erRetaindataLost @RT(1)1 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(781)Retaindata lost, please check machine settings and send a status report to manufacturer{#]Retaindata has been lost.{#]Usersettings and variable values stored within the retaindata have been partially lost. The cause is either a new control application version or a dying battery. The latter would be indicated by its own alarm.{#]If available, re-load all available data (mold data, machine data, ...). Check all settings.<br><br>\u000aCheck if the battery low alarm is raised. In this case replace the CMOS battery. Otherwise create a status report. Then please contact the machine manufacturer.<br><br>\u000aAfter re-loading all data and/or checking all HMI settings continued operation is possible. Although it is possible that some settings are lost again with the next reboot. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erCpuFanLowVelocity @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(168)CPU fan speed low - replace fan{#]The CPU fan is showing low speed.{#]A working CPU fan is required to ensure proper operation of the controller.{#]Replace the CPU fan. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erPdpExportNotCreated @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(420)PDP export file not created (%1s){#]PDP export file could not be created.{#]This is not a crucial error, machine operation is still possible. The export file for PDP could not be created. PDP export cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the PDP problem create a status report. Then please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erInjGraphLogNotCreated @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(496)Inject graph log file not created (%1s){#]Inject graph log file cannot be created.{#]This is not a crucial error, machine operation is still possible. In order to log the inject graph measurements a file should be created. This file creation process failed. Inject graph cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the infolog problem create a status report. Then please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erCpuFanDefect @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(167)CPU fan is not working - replace fan{#]The CPU fan is not working.{#]A working CPU fan is required to ensure proper operation of the controller.{#]Replace the CPU fan. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erECATStateChanged @RT(1)1 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(249)EtherCAT unexpected state transition{#]EtherCAT unexpected state transition.{#]While communicating over EtherCAT the state is transited unexpectedly. Continued operation is not possible. The motor is locked.{#]Check the EtherCAT wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erInjGraphLostTrigger @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(4)User @RT(429)Inject graph lost trigger{#]Inject graph lost its trigger.{#]This is not a crucial error, machine operation is still possible. The inject graph cannot access the configured trigger variable. Inject graph cannot be used at this point.{#]This is not a crucial error, no action required for further machine operation.<br><br>In order to solve the infolog problem create a status report. Then please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erStarepWriting @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(430)Writing status report - please wait until finished before restarting the controller{#]Status report is currently created, do not turn off the power!{#]A status report, containing various information about the hardware and software system state and history, is created and stored. In case the controller is turned off while status report creation interesting information might be lost.{#]This is just a message, no action required. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erStarepFinished @RT(1)5 @RT(0) @RT(0) @RT(0) @RT(11)Application @RT(329)Writing status report finished!{#]Writing the status report is finished.{#]A complete status report has been created and stored, containing various information about the hardware and software system state and history. When searching for a status report file, look for starep_***.tgz.{#]This is just a message, no action required. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erNoSocketLeft @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(512)Network problem occurred (no socket left){#]No socket is left for further network communications.{#]This is not a crucial error, machine operation is still possible. There is no more TCP/IP communication possible because there are no sockets left.{#]This is not a crucial error, machine operation is still possible.<br>\u000aTo solve the problem first create a statusreport. Check if the problem still appears after a reboot of the controller. If the problem is permanent please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erDeviceDisconnected @RT(1)1 @RT(1)y @RT(48)system.evAlarmAutoManual,system.evAlarmMotorLock @RT(26)system.evAlarmMotorRelease @RT(20)User and Application @RT(268)Device disconnected (%1s) - check cable connection or drive status{#]A device has been disconnected.{#]A device has been disconnected from a hardware interface.{#]If the disconnected device is a drive, check the drive status. In any case check the wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erInputDatatypeWrong @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(278)Data type is wrong - check documentation{#]Data type for CAN communication is wrong.{#]The datatype of a CAN setting is wrong, resulting in a buffer size which is too small. The CAN connection cannot be used.{#]Set the correct datatype before retrying the desired communication. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erECATFrameLost @RT(1)1 @RT(1)y @RT(48)system.evAlarmAutoManual,system.evAlarmMotorLock @RT(26)system.evAlarmMotorRelease @RT(11)Application @RT(237)EtherCAT frame lost{#]EtherCAT communication problem.{#]While communicating over EtherCAT the frame, a part of a telegram, has been lost. Continued operation is not possible. The motor is locked.{#]Check the EtherCAT wiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erNoFinalVersion @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(402)Testversion of firmware package is running on CPU{#]The software on this controller is only a testversion.{#]The software currently installed and running on this controller is not a final released version. Only final released software versions are allowed to run on a machine permanently.{#]Please contact the machine manufacturer or software provider in order to get a final released software version. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erECATInitCmdFailed @RT(1)1 @RT(1)y @RT(48)system.evAlarmAutoManual,system.evAlarmMotorLock @RT(26)system.evAlarmMotorRelease @RT(4)User @RT(231)EtherCAT init command failed during state transition (%1s){#]Command send to drive while it is not ready.{#]If drive is reseted or disconnected no command can be sent to drive.{#]Wait until drive is ready after reset or connecting. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erECATSlaveNotFound @RT(1)1 @RT(1)y @RT(48)system.evAlarmAutoManual,system.evAlarmMotorLock @RT(26)system.evAlarmMotorRelease @RT(4)User @RT(235)EtherCAT slave not found (%1s){#]EtherCAT slave is disconnected.{#]EtherCAT cable is disconnected or reset on drive is done.{#]If cable is disconnected from drive reconnect.<br>\u000aIf drive is reseted wait until drive is ready again. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erCFCardRemoved @RT(1)1 @RT(0) @RT(57)system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(11)Application @RT(230)CF card removed!{#]The CF card was removed while the controller was running.{#]The CF card was removed while the controller was running. There is no further cyclic operation possible.{#]Make sure the CF card is inserted correctly. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erRestartAfterCFRemoved @RT(1)2 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(257)Restart of controller because CF card was removed!{#]The controller was restarted because the CF card was removed.{#]A restart of the controller was triggered by the application because the CF card was removed.{#]Make sure the CF card is inserted correctly. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erCFLifetimeWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(200)Remaining compact flash lifetime is only %1s%{#]The remaining lifetime of the compact flash is low.{#]Due to long usage the remaining lifetime of the compact flash is low. {#]Change the compact flash. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erDiskUsageWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(432)The disk usage is over %3n%{#]Actually more than 90% (95%) of the disk size is used.{#]The controller actually uses more than 90% (95%) of the disk space. Possible reasons are: Several sets of mold data, data loggings (spc or pdp), screenshots, state reports, ...\u000aIt is recommended to free some diskspace to avoid the risk of data loss.{#]Delete unused files or folders. The alarm will disappear if the disk usage is below 90%. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erRAMUsageWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(337)The RAM usage is over 90%{#]Actually more than 90% of the RAM is in use.{#]The controller actually uses more than 90% of the RAM. Possible reasons are big HMI or IEC applications, animations, ... .{#]The alarm will disappear if the RAM usage is below 90%. If the alarm does not disappear in time, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(24)erFileHandleUsageWarning @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(348)The file handle usage is over 90%{#]Actually more than 90% of the file handles are in use.{#]The controller actually uses more than 90% of the file handles. Opening new files can lead to an exception.{#]The alarm will disappear if the file handle usage is below 90%. If the alarm does not disappear in time, please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(12)erFastRetain @RT(1)1 @RT(1)y @RT(48)system.evAlarmLampBlink, system.evAlarmMotorLock @RT(0) @RT(11)Application @RT(216)Invalid fast retain data{#]An error in the fast retain data was detected.{#]A fast retain data block is not valid. This can happen for example after a "restore" operation.{#]Delete fast retain data on the controller. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erSMARTDataNotAvailable @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(271)SMART data of CF not available{#]The SMART data of the used compact flash is not available.{#]The used compact flash does not provide SMART data. This means that it is not possible to detect the remaining compact flash lifetime.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
