%SYSTEM_ALARM
  erInvalidPWMSettings
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: invalid PWM settings for zone %3n!{#]Wrong PWM parameters are used.{#]Either cycle time (lower than 0.0s), minimum on time (lower than 0.0s or higher than cycle time) or minimum threshold (lower than 0.0 or higher 1.0) has wrong values.{#]Check parameters of cycle time, minimum on time and minimum threshold.<br>Change to valid values inside limits.
 ;
  erInvalidStabilitySettings
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: invalid stability settings for zone %3n!{#]Parameters for checking stability of actual temperature are wrong.{#]Either stability range is 0.0 or observation time is 0.0s.{#]Check parameters for range and observation time.<br>Change to valid values inside limits.
 ;
  erInvalidStabSettings
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: invalid stab settings for zone %3n!{#]Parameters for checking stability of actual temperature are wrong before starting optimizing of PID-parameters.{#]Either cycle time is lower or equal than 0.0s, stability range is 0.0 or observation time is 0.0s.{#]Check parameters for cycle time, range and observation time.<br>Change to valid values inside limits.
 ;
  erInvalidTempControllerSettings
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: invalid controller settings for zone %3n!{#]Parameters of PID-controller are invalid.{#]Either cycle time is lower or equal than 0.0s, P-value is lower or equal than 0.0, I- or D-value lower than 0.0s{#]Start temperature optimization.
 ;
  erZoneCalcError
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Application error %4n in Zone %3n{#]Failure at calculation of controller output.{#]Calculation of PID-controller output fails.{#]Check controller parameter of actual zone.
 ;
  erTempDiffTooLow
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: temp diff too low for optimization{#]A temperature zone is already too close to \u000asetpoint, preventing heating optimization.{#]The difference between the current temperature of a heating zone \u000aand its setpoint needs to be greater than 50\u00b0C. If the difference is \u000asmaller than 50\u00b0C the optimization function is disabled.{#]Let the heating zones cool down close to \u000aenvironment temperature. Then retry heating optimization.<br><br>\u000aAnother option is to increase the \u000asetpoint within allowed temperature range to fit the 50\u00b0C \u000adifference requirement, before restarting heating optimization.
 ;
  erMeanValueTooLow
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: mean output value too low for optimization{#]Mean output value at start of optimization is to low.{#]During optimization at operation point the output is set to 0.0 until actual temperature is lower than 10\u00b0C as temperature at start of optimization.<br>To heat up after temperature drop the mean value of output before optimization is used.<br>If the mean value was very low temperature won't rise.{#]Switch off heating and wait until temperature drops more than 30\u00b0.<br>Switch on heating again, wait until temperature reaches reference value and start optimization again.
 ;
  erTempTooHighForOpt
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Temperature too high for Optimization{#]A temperature zone is already too close to \u000asetpoint, preventing heating optimization.{#]The difference between the current temperature of a heating zone \u000aand its setpoint needs to be greater than 50\u00b0C. If the difference is \u000asmaller than 50\u00b0C the optimization function is disabled.{#]If a optimization close to setpoint is desired, increase the \u000asetpoint within allowed temperature range to fit the 50\u00b0C \u000adifference requirement, before restarting heating optimization.<br><br>\u000aAnother option is to let the heating zones cool down close\u000ato environment temperature. Then retry heating optimization.
 ;
  erZoneNotAvailable
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n not available{#]A heating zone signals a hardware error and cannot be used.{#]Available zones are prepared and linked in the control application software, \u000aas well as having at least one hardware endpoint configured. In the current error \u000astate the number of zones used is larger than the available zones, because of a missing \u000aconfiguration for a zone.{#]An appropriate IO configuration update is required.<br>\u000aPlease contact the machine manufacturer.
 ;
  erVariableMissing
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Variable missing: %1s{#]A basic temperature zone variable is missing.{#]The application software does not provide a basic \u000avariable necessary for the heating zones operation.{#]A control application software update/change is required.<br>\u000aPlease contact the machine manufacturer.
 ;
  erOptimizationActive
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// %1t%2n: Optimization active{#]Temperature zones optimization is active.{#]This is just a message and does not indicate a problem.<br><br>\u000aThe PID parameters of each heating zone are determined, The \u000aprocess requires a test heatup of all zones to setpoint temperatures.{#]This is just a message, no action required.<br><br>\u000aWhen optimization is finished the alarm message will disappear.\u000aAlso by turning off the heating the process can be stopped.
 ;
  erHeatingOutput
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Error on Heating Output{#]An error occurred on a heating output hardware endpoint.{#]The status flag of a TO or DO temperature output, depending \u000aon the current machinetype and system, signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.{#]Check the hardware endpoint information and state in the IO monitor. \u000aExamine the wiring and hardware connected to the output. If controller \u000aexternal causes can be ruled out further help is required.<br>\u000aPlease contact the machine manufacturer.
 ;
  erCoolingOutput
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Error on Cooling Output{#]An error occurred on a cooling output hardware endpoint.{#]The status flag of a TO or DO temperature output, depending \u000aon the current machinetype and system, signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.{#]Check the hardware endpoint information and state in the IO monitor. \u000aExamine the wiring and hardware connected to the output. If controller \u000aexternal causes can be ruled out further help is required.<br>\u000aPlease contact the machine manufacturer.
 ;
  erSensor
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: sensor failure, check terminal and wiring %1s{#]An error occurred at a temperature sensor hardware input.{#]The status flag of a TI temperature input signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.\u000aWithout a working sensor the heating cannot be controlled.{#]Check the IO monitor and the according hardware including its wiring.<br>\u000aIn case of a broken sensor it is possible to switch\u000athe according temperature zones setting to work\u000ain "setter" mode instead of "PID":\u000aThis allows to enter a PWM percentage for the\u000aconstant power output to the heater, when heating\u000ais switched on. If set correctly the setpoint can be\u000areached and production can be continued until\u000athe sensor is repaired.
 ;
  erSensorPower
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: power sensor failure{#]An error occurred at a nozzle heating power sensor \u000ahardware input.{#]The status flag of a power (PWRIN), voltage (VOLTIN) or current (CURRIN) input signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.\u000aWithout a working power sensor the heating cannot be controlled.{#]Check the IO monitor and the according hardware including the terminal and its wiring.
 ;
  erHeatingFailure
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: No Temp change while Heating Output 100%{#]Temperature zone doesn't heatup up when full output is given.{#]A broken heating zone can cause this feedback behavior:<br>\u000aWhile the output is 100 percent to the heating element, it's temperature\u000adoesn't increase beyond a small range of temperature change caused by \u000asurrounding air and hardware. The lack of temperature change has \u000aoccurred for a predefined supervision time - leading to the conclusion, the\u000aheating element or wiring is malfunctioning.{#]Check the heating element and the wiring to find the hardware source of the problem.
 ;
  erHeatingNotOn
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: heating not on, no injection movement possible{#]Heating is off, preventing other movements and functionalities.{#]As long as heating is off, no injection movement and no semi- or full automatic cycle is possible.{#]Turn on heating, wait for the temperature to reach the setpoint range and \u000arestart the previous intended movement or select the \u000adesired operation mode.
 ;
  erHeatupActive
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop 
// %1t%2n: heatup active, no injection movement possible{#]Heatup is active, setpoint tolerance range is not reached for all zones.{#]While heatup is active cyclic operation and injection movement is not possible.{#]Wait for heatup to finish before retrying the desired operation.
 ;
  erZoneOutOfTol
 %CLASS 3 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n out of tolerance, check heating and heating parameters{#]A temperature zone is out of tolerance.{#]A temperature zone has exceeded the setpoint tolerance range. Operation cannot be continued.{#]Check the heating parameter settings.<br>\u000aIt might be necessary to perform a heating optimization.
 ;
  erOutOfTol
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: GroupHeating Failed, out of Tolerance{#]During group heating one or more temperature zones dropped out of tolerance.{#]In "group heating" mode all temperature zones are heated to reach temperatures \u000asimultaneously. The lowest and highest temperature \u000aof zones need to stay within a given tolerance.<br>\u000aWhen group heating fails it can be because the tolerance is set too small \u000aby the user. Another reason could be bad (non optimal) PID parameters. Also\u000asome machine designs don't allow for group heating.{#]Start optimization again.<br>If temperature difference between zones still to high increase tolerance for group heating.
 ;
  erMaxTempExeeded
 %CLASS 3 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n exceeded max. Temperature{#]One or more temperature zones exceeded the \u000amaximum temperature allowed for the heating hardware.{#]When a temperature zone violates the maximum temperature \u000alimit no cyclic operation is possible and heating is stopped.\u000aCauses could be problematic heating settings, heating \u000aoptimization parameter or broken hardware.{#]Please check the heating settings for the according temperature\u000azone. In case a setter temperature zone is used, the setter value\u000ahas to be reduced. <br>\u000aIf the settings are ok, two more solutions are possible. Depending \u000aon the time available and or experience with the situation choose from \u000athe two which to try first.<br>\u000aOne is: perform a heating optimization to retrain the PID controller of\u000aall heating zones. In this case make sure to start with cooled zones. The\u000atemperatures should be close to the environment-temperature.<br>\u000aThe other option is searching for hardware problems, which could\u000aalso produce the overheating.
 ;
  erKeepWarmActive
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual 
// %1t%2n: standby active, no injection movement possible{#]Keep Warm function is active and prevents injection movement.{#]The keep warm function allows to keep the temperature zones at a standby temperature while machine is not used. This means the temperatures will be at the standby level. For operation the setpoint level is required.{#]If cyclic operation or an injection movement is desired, deactivate \u000athe "keep warm" feature and activate heating to heatup all \u000atemperature zones to setpoint tolerance range. Then retry the \u000adesired operation.
 ;
  erCoolingPrevent
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual 
// %1t%2n: cooling prevent time active, no injection movement possible{#]The material temperature has not reached the setpoint tolerance range.{#]When the heating zones reach setpoint tolerance range the material still needs a given time to heat to the same temperature. This time has not expired, while a semi- or autocycle, or an injection movement should start. This time delay prevents the execution.{#]Wait for the cooling prevent time period to expire, before retrying\u000athe desired action.\u000a\u000aFor future operation the cooling prevent time setting can be changed \u000aaccording to the process requirements.
 ;
  erSwitchToEMOP
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// %1t%2n: Zone %3n: Sensor failure switch to Emergency Operation{#]Sensor failure is detected, emergency operation is enabled and production with failure is allowed.{#]If sensor failure is detected, emergency operation is activated heating mode has to be switched to setter mode.<br>Auto cycle is not stopped.<br>Setter value can be used for output instead of PID-controller.{#]Change heating mode to setter mode.<br>After stopping autocycle check sensor
 ;
  erSwitchToConst
 %CLASS 4 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// %1t%2n: Zone %3n: Sensor failure switch to Setter output{#]Sensor failure is detected and emergency operation is enabled.{#]If sensor failure is detected and emergency operation is activated heating mode has to be switched to setter mode<br>Auto cycle is stopped.<br>Setter value can be used for output instead of PID-controller.{#]Check sensor wiring.<br>Change heating mode to setter mode for production.
 ;
  erSensorNotConfig
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Sensor not configured (Setter mode only){#]No sensor configured for a temperature zone.{#]A temperature zone can only be controlled when using a sensor. \u000aIn this case for a specific temperature zone no sensor is configured. \u000aThis means it is not possible to use the operation mode "PID" for \u000athe according zone. Valid operation modes are "setter" mode, or "off/disabled".{#]If there is a sensor required, connected but not configured \u000acontact service to receive an according configuration and \u000afurther update instructions.<br><br>\u000aIf no sensor is used but the zone should be used for heating,\u000ause the operation mode "setter" and adjust the setter value\u000ato an appropriate output percentage which produces the \u000adesired setpoint temperature for the zone.<br><br>\u000aIt is also possible that a zone has been activated that is \u000ausually not used. In this case simply set the operation mode \u000aof the zone to "off".
 ;
  erInvalidSetterSettings
 %CLASS 3 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Const. value out of range{#]The setter value for a temperature zone is out of tolerance.{#]Depending on the availability of a heating and or a cooling output for one \u000atemperature zone, the limitation for the setter value changes accordingly. \u000aFor example with a cooling output setter values below 0 are possible. In case \u000aof a hardware endpoint change the setter value could be out of range.{#]Change the setter value for the problematic temperature zone \u000ato a value within limits and according to the process requirements.
 ;
  erHeatingNotReady
 %CLASS 2 %ACKNOWLEDGEMENT %APPLICATION %PROTOCOL %YES

// %1t%2n not ready{#]One or more temperature zones are not within set point tolerance \u000arange. One or more zones either have not finished heating up, or\u000adropped out of tolerance.{#]As long as one or more temperature zones are not within setpoint tolerance no semi- or half-automatic cycle is possible.{#]Wait for heatup to be finished before restarting the desired operation.\u000aMake sure the heating has been successfully tuned before, otherwise\u000aperform a heating optimization before restarting the desired operation.\u000aIf the heating zones were within setpoint tolerance before, check the \u000ahardware and environment for possible causes.
 ;
  erHeatingTimeout
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Timeout during heating, heating switched off{#]Timeout during softstart at hotrunner heat up.{#]If maximum heating power is limited with value lower than 100% and heat up time exceeds limit heating is stopped.{#]Increase max. heating power.<br>If limit is already 100% check hardware.
 ;
  erHeatingTimeoutWarning
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Timeout during heating, max. heating power increased{#]Timeout during softstart at hotrunner heat up.{#]If maximum heating power is limited with value lower than 100% and heat up time exceeds limit maximum heating power is increased to 100%.<br> Heating is still on.{#]Increase max. heating power.<br>If limit is already 100% check hardware.
 ;
  erOptimizationFailed
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink,system.evAlarmAutoManual  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Zone %3n: Optimization failed{#]Temperature optimization can't be finished successfully.{#]After measuring output and actual temperature calculation of parameters from heating zone model and PID-parameters is done.<br>If it's not possible to find valid model parameters the PID-parameter can't be calculated.{#]Start optimization again.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 102 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
0 
@RT(15)SETreeContainer 
0 
@RT(15)SOTreeContainer 
0 

@RT(15)SATreeContainer 
31 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erInvalidPWMSettings @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(358)%1t%2n: invalid PWM settings for zone %3n!{#]Wrong PWM parameters are used.{#]Either cycle time (lower than 0.0s), minimum on time (lower than 0.0s or higher than cycle time) or minimum threshold (lower than 0.0 or higher 1.0) has wrong values.{#]Check parameters of cycle time, minimum on time and minimum threshold.<br>Change to valid values inside limits. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erInvalidStabilitySettings @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(270)%1t%2n: invalid stability settings for zone %3n!{#]Parameters for checking stability of actual temperature are wrong.{#]Either stability range is 0.0 or observation time is 0.0s.{#]Check parameters for range and observation time.<br>Change to valid values inside limits. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(21)erInvalidStabSettings @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(362)%1t%2n: invalid stab settings for zone %3n!{#]Parameters for checking stability of actual temperature are wrong before starting optimizing of PID-parameters.{#]Either cycle time is lower or equal than 0.0s, stability range is 0.0 or observation time is 0.0s.{#]Check parameters for cycle time, range and observation time.<br>Change to valid values inside limits. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(31)erInvalidTempControllerSettings @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(242)%1t%2n: invalid controller settings for zone %3n!{#]Parameters of PID-controller are invalid.{#]Either cycle time is lower or equal than 0.0s, P-value is lower or equal than 0.0, I- or D-value lower than 0.0s{#]Start temperature optimization. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erZoneCalcError @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(179)%1t%2n: Application error %4n in Zone %3n{#]Failure at calculation of controller output.{#]Calculation of PID-controller output fails.{#]Check controller parameter of actual zone. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erTempDiffTooLow @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(654)%1t%2n: Zone %3n: temp diff too low for optimization{#]A temperature zone is already too close to \u000asetpoint, preventing heating optimization.{#]The difference between the current temperature of a heating zone \u000aand its setpoint needs to be greater than 50\u00b0C. If the difference is \u000asmaller than 50\u00b0C the optimization function is disabled.{#]Let the heating zones cool down close to \u000aenvironment temperature. Then retry heating optimization.<br><br>\u000aAnother option is to increase the \u000asetpoint within allowed temperature range to fit the 50\u00b0C \u000adifference requirement, before restarting heating optimization. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erMeanValueTooLow @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(600)%1t%2n: Zone %3n: mean output value too low for optimization{#]Mean output value at start of optimization is to low.{#]During optimization at operation point the output is set to 0.0 until actual temperature is lower than 10\u00b0C as temperature at start of optimization.<br>To heat up after temperature drop the mean value of output before optimization is used.<br>If the mean value was very low temperature won't rise.{#]Switch off heating and wait until temperature drops more than 30\u00b0.<br>Switch on heating again, wait until temperature reaches reference value and start optimization again. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erTempTooHighForOpt @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(704)%1t%2n: Zone %3n: Temperature too high for Optimization{#]A temperature zone is already too close to \u000asetpoint, preventing heating optimization.{#]The difference between the current temperature of a heating zone \u000aand its setpoint needs to be greater than 50\u00b0C. If the difference is \u000asmaller than 50\u00b0C the optimization function is disabled.{#]If a optimization close to setpoint is desired, increase the \u000asetpoint within allowed temperature range to fit the 50\u00b0C \u000adifference requirement, before restarting heating optimization.<br><br>\u000aAnother option is to let the heating zones cool down close\u000ato environment temperature. Then retry heating optimization. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erZoneNotAvailable @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(489)%1t%2n: Zone %3n not available{#]A heating zone signals a hardware error and cannot be used.{#]Available zones are prepared and linked in the control application software, \u000aas well as having at least one hardware endpoint configured. In the current error \u000astate the number of zones used is larger than the available zones, because of a missing \u000aconfiguration for a zone.{#]An appropriate IO configuration update is required.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erVariableMissing @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(297)%1t%2n: Variable missing: %1s{#]A basic temperature zone variable is missing.{#]The application software does not provide a basic \u000avariable necessary for the heating zones operation.{#]A control application software update/change is required.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erOptimizationActive @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(466)%1t%2n: Optimization active{#]Temperature zones optimization is active.{#]This is just a message and does not indicate a problem.<br><br>\u000aThe PID parameters of each heating zone are determined, The \u000aprocess requires a test heatup of all zones to setpoint temperatures.{#]This is just a message, no action required.<br><br>\u000aWhen optimization is finished the alarm message will disappear.\u000aAlso by turning off the heating the process can be stopped. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erHeatingOutput @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(624)%1t%2n: Zone %3n: Error on Heating Output{#]An error occurred on a heating output hardware endpoint.{#]The status flag of a TO or DO temperature output, depending \u000aon the current machinetype and system, signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.{#]Check the hardware endpoint information and state in the IO monitor. \u000aExamine the wiring and hardware connected to the output. If controller \u000aexternal causes can be ruled out further help is required.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erCoolingOutput @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(624)%1t%2n: Zone %3n: Error on Cooling Output{#]An error occurred on a cooling output hardware endpoint.{#]The status flag of a TO or DO temperature output, depending \u000aon the current machinetype and system, signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.{#]Check the hardware endpoint information and state in the IO monitor. \u000aExamine the wiring and hardware connected to the output. If controller \u000aexternal causes can be ruled out further help is required.<br>\u000aPlease contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(8)erSensor @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(855)%1t%2n: Zone %3n: sensor failure, check terminal and wiring %1s{#]An error occurred at a temperature sensor hardware input.{#]The status flag of a TI temperature input signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.\u000aWithout a working sensor the heating cannot be controlled.{#]Check the IO monitor and the according hardware including its wiring.<br>\u000aIn case of a broken sensor it is possible to switch\u000athe according temperature zones setting to work\u000ain "setter" mode instead of "PID":\u000aThis allows to enter a PWM percentage for the\u000aconstant power output to the heater, when heating\u000ais switched on. If set correctly the setpoint can be\u000areached and production can be continued until\u000athe sensor is repaired. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(13)erSensorPower @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(507)%1t%2n: Zone %3n: power sensor failure{#]An error occurred at a nozzle heating power sensor \u000ahardware input.{#]The status flag of a power (PWRIN), voltage (VOLTIN) or current (CURRIN) input signals an error state. \u000aThe problem can be at the specific hardware endpoint on the \u000aIO board, or with the hardware or wiring on the endpoint.\u000aWithout a working power sensor the heating cannot be controlled.{#]Check the IO monitor and the according hardware including the terminal and its wiring. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erHeatingFailure @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(627)%1t%2n: Zone %3n: No Temp change while Heating Output 100%{#]Temperature zone doesn't heatup up when full output is given.{#]A broken heating zone can cause this feedback behavior:<br>\u000aWhile the output is 100 percent to the heating element, it's temperature\u000adoesn't increase beyond a small range of temperature change caused by \u000asurrounding air and hardware. The lack of temperature change has \u000aoccurred for a predefined supervision time - leading to the conclusion, the\u000aheating element or wiring is malfunctioning.{#]Check the heating element and the wiring to find the hardware source of the problem. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erHeatingNotOn @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(386)%1t%2n: heating not on, no injection movement possible{#]Heating is off, preventing other movements and functionalities.{#]As long as heating is off, no injection movement and no semi- or full automatic cycle is possible.{#]Turn on heating, wait for the temperature to reach the setpoint range and \u000arestart the previous intended movement or select the \u000adesired operation mode. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erHeatupActive @RT(1)3 @RT(1)y @RT(32)system.evAlarmFinishCycleAndStop @RT(0) @RT(11)Application @RT(277)%1t%2n: heatup active, no injection movement possible{#]Heatup is active, setpoint tolerance range is not reached for all zones.{#]While heatup is active cyclic operation and injection movement is not possible.{#]Wait for heatup to finish before retrying the desired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erZoneOutOfTol @RT(1)3 @RT(1)y @RT(57)system.evAlarmFinishCycleAndStop, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(314)%1t%2n: Zone %3n out of tolerance, check heating and heating parameters{#]A temperature zone is out of tolerance.{#]A temperature zone has exceeded the setpoint tolerance range. Operation cannot be continued.{#]Check the heating parameter settings.<br>\u000aIt might be necessary to perform a heating optimization. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(10)erOutOfTol @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(661)%1t%2n: GroupHeating Failed, out of Tolerance{#]During group heating one or more temperature zones dropped out of tolerance.{#]In "group heating" mode all temperature zones are heated to reach temperatures \u000asimultaneously. The lowest and highest temperature \u000aof zones need to stay within a given tolerance.<br>\u000aWhen group heating fails it can be because the tolerance is set too small \u000aby the user. Another reason could be bad (non optimal) PID parameters. Also\u000asome machine designs don't allow for group heating.{#]Start optimization again.<br>If temperature difference between zones still to high increase tolerance for group heating. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erMaxTempExeeded @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(1066)%1t%2n: Zone %3n exceeded max. Temperature{#]One or more temperature zones exceeded the \u000amaximum temperature allowed for the heating hardware.{#]When a temperature zone violates the maximum temperature \u000alimit no cyclic operation is possible and heating is stopped.\u000aCauses could be problematic heating settings, heating \u000aoptimization parameter or broken hardware.{#]Please check the heating settings for the according temperature\u000azone. In case a setter temperature zone is used, the setter value\u000ahas to be reduced. <br>\u000aIf the settings are ok, two more solutions are possible. Depending \u000aon the time available and or experience with the situation choose from \u000athe two which to try first.<br>\u000aOne is: perform a heating optimization to retrain the PID controller of\u000aall heating zones. In this case make sure to start with cooled zones. The\u000atemperatures should be close to the environment-temperature.<br>\u000aThe other option is searching for hardware problems, which could\u000aalso produce the overheating. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erKeepWarmActive @RT(1)3 @RT(1)y @RT(24)system.evAlarmAutoManual @RT(0) @RT(11)Application @RT(564)%1t%2n: standby active, no injection movement possible{#]Keep Warm function is active and prevents injection movement.{#]The keep warm function allows to keep the temperature zones at a standby temperature while machine is not used. This means the temperatures will be at the standby level. For operation the setpoint level is required.{#]If cyclic operation or an injection movement is desired, deactivate \u000athe "keep warm" feature and activate heating to heatup all \u000atemperature zones to setpoint tolerance range. Then retry the \u000adesired operation. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erCoolingPrevent @RT(1)3 @RT(1)y @RT(24)system.evAlarmAutoManual @RT(0) @RT(11)Application @RT(621)%1t%2n: cooling prevent time active, no injection movement possible{#]The material temperature has not reached the setpoint tolerance range.{#]When the heating zones reach setpoint tolerance range the material still needs a given time to heat to the same temperature. This time has not expired, while a semi- or autocycle, or an injection movement should start. This time delay prevents the execution.{#]Wait for the cooling prevent time period to expire, before retrying\u000athe desired action.\u000a\u000aFor future operation the cooling prevent time setting can be changed \u000aaccording to the process requirements. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(14)erSwitchToEMOP @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(452)%1t%2n: Zone %3n: Sensor failure switch to Emergency Operation{#]Sensor failure is detected, emergency operation is enabled and production with failure is allowed.{#]If sensor failure is detected, emergency operation is activated heating mode has to be switched to setter mode.<br>Auto cycle is not stopped.<br>Setter value can be used for output instead of PID-controller.{#]Change heating mode to setter mode.<br>After stopping autocycle check sensor 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(15)erSwitchToConst @RT(1)4 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(406)%1t%2n: Zone %3n: Sensor failure switch to Setter output{#]Sensor failure is detected and emergency operation is enabled.{#]If sensor failure is detected and emergency operation is activated heating mode has to be switched to setter mode<br>Auto cycle is stopped.<br>Setter value can be used for output instead of PID-controller.{#]Check sensor wiring.<br>Change heating mode to setter mode for production. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erSensorNotConfig @RT(1)2 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(981)%1t%2n: Zone %3n: Sensor not configured (Setter mode only){#]No sensor configured for a temperature zone.{#]A temperature zone can only be controlled when using a sensor. \u000aIn this case for a specific temperature zone no sensor is configured. \u000aThis means it is not possible to use the operation mode "PID" for \u000athe according zone. Valid operation modes are "setter" mode, or "off/disabled".{#]If there is a sensor required, connected but not configured \u000acontact service to receive an according configuration and \u000afurther update instructions.<br><br>\u000aIf no sensor is used but the zone should be used for heating,\u000ause the operation mode "setter" and adjust the setter value\u000ato an appropriate output percentage which produces the \u000adesired setpoint temperature for the zone.<br><br>\u000aIt is also possible that a zone has been activated that is \u000ausually not used. In this case simply set the operation mode \u000aof the zone to "off". 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erInvalidSetterSettings @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(11)Application @RT(561)%1t%2n: Zone %3n: Const. value out of range{#]The setter value for a temperature zone is out of tolerance.{#]Depending on the availability of a heating and or a cooling output for one \u000atemperature zone, the limitation for the setter value changes accordingly. \u000aFor example with a cooling output setter values below 0 are possible. In case \u000aof a hardware endpoint change the setter value could be out of range.{#]Change the setter value for the problematic temperature zone \u000ato a value within limits and according to the process requirements. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erHeatingNotReady @RT(1)2 @RT(1)y @RT(0) @RT(0) @RT(11)Application @RT(659)%1t%2n not ready{#]One or more temperature zones are not within set point tolerance \u000arange. One or more zones either have not finished heating up, or\u000adropped out of tolerance.{#]As long as one or more temperature zones are not within setpoint tolerance no semi- or half-automatic cycle is possible.{#]Wait for heatup to be finished before restarting the desired operation.\u000aMake sure the heating has been successfully tuned before, otherwise\u000aperform a heating optimization before restarting the desired operation.\u000aIf the heating zones were within setpoint tolerance before, check the \u000ahardware and environment for possible causes. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erHeatingTimeout @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(302)%1t%2n: Zone %3n: Timeout during heating, heating switched off{#]Timeout during softstart at hotrunner heat up.{#]If maximum heating power is limited with value lower than 100% and heat up time exceeds limit heating is stopped.{#]Increase max. heating power.<br>If limit is already 100% check hardware. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(23)erHeatingTimeoutWarning @RT(1)3 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(359)%1t%2n: Zone %3n: Timeout during heating, max. heating power increased{#]Timeout during softstart at hotrunner heat up.{#]If maximum heating power is limited with value lower than 100% and heat up time exceeds limit maximum heating power is increased to 100%.<br> Heating is still on.{#]Increase max. heating power.<br>If limit is already 100% check hardware. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(20)erOptimizationFailed @RT(1)3 @RT(1)y @RT(48)system.evAlarmLampBlink,system.evAlarmAutoManual @RT(23)system.evAlarmLampReset @RT(4)User @RT(344)%1t%2n: Zone %3n: Optimization failed{#]Temperature optimization can't be finished successfully.{#]After measuring output and actual temperature calculation of parameters from heating zone model and PID-parameters is done.<br>If it's not possible to find valid model parameters the PID-parameter can't be calculated.{#]Start optimization again. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
