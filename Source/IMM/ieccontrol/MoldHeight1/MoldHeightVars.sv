%IMPORT_OVER_LISTFILE_SOURCE
 LimitSwitchMode
, VG_MachineData
, MoldAdjustMotor
, Pressure
, Relative
, fmt30
, MaxRampPressure
, fmt41
, Percent
, MaxSystemVelocity
, MaxRampVelocity
, NoRelative
, OnOff
, VG_MoldData
, Time
, fmt32
, fmt31
, fmtPosReached
, UseNoUse

END_IMPORT
%IMPORT_OVER_LISTFILE_OBJECT
 tnLimitSwitchMode
, tnMotorType
, tsMoldHeightOutput
, tOptionId
, tsRequiredPumps
, tsHydrMaxValues
, nHydraulic
, cLevelStartupTechnican
, cLevelProduction
, cLevelMoldPrepare
, cLevelSuperUser
, cLevelProcessOperator
, cPlausMaxRampPressureMax
, cPlausMaxRampPressureMin
, cPlausMaxRampVelocityMax
, cPlausMaxRampVelocityMin
, ALARM_EVENT

END_IMPORT

%SYSTEMVAR_DECL
  sv_LimitSwitchMode : tnLimitSwitchMode
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT LimitSwitchMode 
// Limit switch mode Limit switch mode
;
 sv_bOutputActive : BOOL (* Output is active *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL 16

// Mold height output active Mold height output active
;
 sv_rPressure : REAL
    ;
 sv_rVelocity : REAL
    ;
 sv_MoldHeightAdjustMotor : tnMotorType := nHydraulic (* type of mold height adjust motor *)
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT MoldAdjustMotor 
// Mold height motor Mold height motor
;
 sv_MoldHeightOutput : tsMoldHeightOutput := (rMaxAdjustPressure:=140.0,rMaxAdjustVelocity:=100.0,MoldHeightForward:=(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0)),MoldHeightBackward:=(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0)))
   RETAIN  %VARIABLE_GROUP VG_MachineData 
%ELEMENT sv_MoldHeightOutput.MoldHeightBackward
    
%ELEMENT sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_MoldHeightOutput.rMaxAdjustPressure      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Relative 
// Mold adjust backward Mold adjust backward

%ELEMENT sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure 
// Mold adjust backward Max. ramp mold adjust bwd

%ELEMENT sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_MoldHeightOutput.rMaxAdjustVelocity      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent  %ABSREL MaxSystemVelocity 
// Mold adjust backward Mold adjust backward

%ELEMENT sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL MaxSystemVelocity 
// Mold adjust backward Max. ramp mold adjust bwd

%ELEMENT sv_MoldHeightOutput.MoldHeightForward
    
%ELEMENT sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_MoldHeightOutput.rMaxAdjustPressure      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Pressure  %ABSREL Relative 
// Mold adjust forward Mold adjust forward

%ELEMENT sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampPressureMin..cPlausMaxRampPressureMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampPressure 
// Mold adjust forward Max. ramp mold adjust fwd

%ELEMENT sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue
 %PLAUSIBILITY 0.0..%FU.sv_MoldHeightOutput.rMaxAdjustVelocity      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt30  %UNIT Percent  %ABSREL MaxSystemVelocity 
// Mold adjust forward Mold adjust forward

%ELEMENT sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rRamp
 %PLAUSIBILITY cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt41  %UNIT MaxRampVelocity  %ABSREL MaxSystemVelocity 
// Mold adjust forward Max. ramp mold adjust fwd

%ELEMENT sv_MoldHeightOutput.MoldHeightForward.Velocity.PreOutput.rOutputValue
    
%ELEMENT sv_MoldHeightOutput.rMaxAdjustPressure
 %PLAUSIBILITY 0.0..%FU.sv_rMaxPressure      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Pressure  %ABSREL NoRelative 
// Max. mold adjust pressure Max. pressure mold adjust

%ELEMENT sv_MoldHeightOutput.rMaxAdjustVelocity
 %PLAUSIBILITY 0.0..system.sv_rMaximumVelocity      %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT fmt30  %UNIT Percent  %ABSREL NoRelative 
// Max. mold adjust velocity Max. velocity mold adjust
;
 sv_bMoldHeightAdjustByOneGear : BOOL
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT OnOff 
// Adjust by one gear Adjust by one gear
;
 sv_MoldHeightAdjustTime : TIME := T#1s
 %PLAUSIBILITY T#10ms..T#99s990ms    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT fmt32  %UNIT Time 
// Adjust time Adjust time
;
 sv_bMoldHeightAdjustByTime : BOOL
   RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelMoldPrepare
 %FORMAT OnOff 
// Adjust by time Adjust by time
;
 sv_Options : tOptionId
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser

// Options Device options
;
 sv_dMaxImpulseTime : TIME := T#1s (* Single impulse timeout *)
 %PLAUSIBILITY T#10ms..T#99s990ms    RETAIN  %VARIABLE_GROUP VG_MoldData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelProduction
 %FORMAT fmt31  %UNIT Time 
// Single impulse timeout Single impulse timeout
;
 sv_dActImpulseTime : TIME (* Actual impulse time *)
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmt31  %UNIT Time 
// Actual impulse time Actual impulse time
 %UPDATE_CYCLE "Fast";
 sv_bImpulseFeedbackMarker : BOOL
     %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelSuperUser
 %FORMAT fmtPosReached 
// Impulse sensor Impulse sensor
;
 sv_bAdjustInProduction : BOOL (* Adjust in production *)
   RETAIN  %VISI_CLASS system.hmi.ODCEditDisabledController  %INPUT_LEVEL cLevelProcessOperator
 %FORMAT OnOff 
// Adjust during production Adjust during production
;
 sv_RequiredPumps : tsRequiredPumps := (RequiredPumps:=TRUE,iOrder:=4000)
    
%ELEMENT sv_RequiredPumps.RequiredPumps
   RETAIN  %VARIABLE_GROUP VG_MachineData  %DISPLAY_LEVEL 1  %INPUT_LEVEL cLevelStartupTechnican
 %FORMAT UseNoUse 
// Mold adjust Mold adjust
;
 sv_HydrMaxValues : tsHydrMaxValues (* hydraulic max values for mold close *)
    ;
 sv_rMaxPressure : REAL
    ;
%END

%SYSTEMEVENT_DECL
  evMaxImpulseExceeded : ALARM_EVENT
;
 evMaxImpulseExceededReset : ALARM_EVENT
;
%END

%SYSTEM_ALARM
  erMoldHeightMaxDI
 %CLASS 1 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES

// Maximum mold height reached{#]The mold height maximum is reached.{#]The limitswitch feedback for mold height maximum position indicates the end position has been reached. \u000aMold height cannot increase further.{#]In case this alarm happens during mold height auto adjustment, \u000aanother alarm is given with more details about possible solutions.<br>\u000aOtherwise this is just a message.
 ;
  erMoldHeightMinDI
 %CLASS 1 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES

// Minimum mold height reached{#]The mold height minimum is reached.{#]The limitswitch feedback for mold height minimum position indicates the end position has been reached. \u000aMold height cannot decrease further.{#]In case this alarm happens during mold height auto adjustment, \u000aanother alarm is given with more details about possible solutions.<br>\u000aOtherwise this is just a message.
 ;
  erMoldHeightMotorOverload
 %CLASS 2 %ACKNOWLEDGEMENT %USER_AND_APPLICATION %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// %1t%2n: Motor overloaded{#]Mold height motor overload signal \u000areceived. No more mold height movement \u000apossible.{#]The digital input for mold height motor overload signals an overload state. In case of a motor \u000aoverload no further mold height movement is possible including of course \u000aautomatic mold height adjustment processes. Usually the overload signal is valid \u000aand the motor needs to cool down / get back into operational state. In rare \u000acases the sensor might be broken.{#]Let the motor cool down / get back into operational state before \u000aretrying the desired mold height operation.<br>\u000aIn case the overload stays check the hardware including the \u000awiring and terminal.
 ;
  erMHMaxImpulseTimeExceeded
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO
 %SET_ALARM_EVENTS %FU.evMaxImpulseExceeded  %RESET_ALARM_EVENTS %FU.evMaxImpulseExceededReset 
// Max impulse time for mold height exceeded{#]A mold height movement impulse feedback \u000atimeout happened.{#]The sensor feedback for mold height position usually delivers impulses. When \u000amold height is moving an impulse is expected within a preset time. If the time \u000abetween two impulses exceeds the preset time this alarm is raised. The reason can be too low output settings for mold height \u000amovement or a malfunction at the limitswitches for mold height. A faulty \u000alimitswitch feedback can result in a mold height movement hitting the \u000amechanical limit while the application cannot detect this state of the machine.{#]Check whether mold height reached its absolute minimum or \u000amaximum. If this is the case check the limitswitch feedback as well \u000aas hardware, wiring and terminal.<br><br>\u000aIf the limitswitches work and the timeout happened within normal \u000amold height movement range try to increase the mold height \u000aoutput settings (fwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue:c:velocity}, bwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue:c:velocity} to achieve a more precise mold height adjustment.
 ;
  erAdjustSettings
 %CLASS 5 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES

// Act. impulse count higher than set impulse count. Increase ramps and reduce output{#]Mold height is moving too far.{#]For each adjustment step the mold height is moved to a desired number of \u000aimpulses. If the movement output is too high, or if the ramps are to flat, an \u000aovershoot is possible, which reduces the accuracy of the mold height \u000aadjustment process. In case such an overshoot happens this alarm is raised. \u000aAlthough this is only a message and the adjustment process will continue a \u000aproper mold height adjustment is strongly recommended.{#]Try reducing the movement settings for mold height output settings (fwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue:c:velocity}, bwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue:c:velocity} and \u000aincrease the mold height ramp settings in order to achieve a \u000aprecise mold height adjustment.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
@@@BEG_Comment@@@

@@@END_Comment@@@

@BEG_Contents 

@BEG_Export 
@RT(16)SveTreeContainer 
17 
@SysVar @RT(18)sv_LimitSwitchMode @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(17)tnLimitSwitchMode @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)LimitSwitchMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Limit switch mode @RT(17)Limit switch mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_LimitSwitchMode @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)LimitSwitchMode @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Limit switch mode @RT(17)Limit switch mode @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_bOutputActive @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold height output active @RT(25)Mold height output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(16)sv_bOutputActive @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(16)Output is active 
@RT(1)1 @RT(2)16 @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Mold height output active @RT(25)Mold height output active @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(12)sv_rPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(12)sv_rVelocity @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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


@SysVar @RT(24)sv_MoldHeightAdjustMotor @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)tnMotorType @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(10)nHydraulic @RT(32)type of mold height adjust motor 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)MoldAdjustMotor @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Mold height motor @RT(17)Mold height motor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(24)sv_MoldHeightAdjustMotor @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(11)enHydraulic @RT(32)type of mold height adjust motor 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(15)MoldAdjustMotor @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(17)Mold height motor @RT(17)Mold height motor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(19)sv_MoldHeightOutput @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(18)tsMoldHeightOutput @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(556)(rMaxAdjustPressure:=140.0,rMaxAdjustVelocity:=100.0,MoldHeightForward:=(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0)),MoldHeightBackward:=(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=9999.9),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0))) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
14 
@AttrSym @RT(19)sv_MoldHeightOutput @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(552)(rMaxAdjustPressure:=140.0,rMaxAdjustVelocity:=100.0,MoldHeightForward:=(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0)),MoldHeightBackward:=(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0))) @RT(0) 
@RT(0) @RT(0) @RT(14)VG_MachineData @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldHeightOutput.MoldHeightBackward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(229)(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0)) @RT(47)output values for mold height backward movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(67)sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)20.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Relative @RT(0) 
@RT(47)0.0..%FU.sv_MoldHeightOutput.rMaxAdjustPressure @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Mold adjust backward @RT(20)Mold adjust backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(60)sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(0) @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Mold adjust backward @RT(25)Max. ramp mold adjust bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(67)sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)20.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(17)MaxSystemVelocity @RT(0) 
@RT(47)0.0..%FU.sv_MoldHeightOutput.rMaxAdjustVelocity @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Mold adjust backward @RT(20)Mold adjust backward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(60)sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(17)MaxSystemVelocity @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(20)Mold adjust backward @RT(25)Max. ramp mold adjust bwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(37)sv_MoldHeightOutput.MoldHeightForward @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(229)(Velocity:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0),Pressure:=(Output:=(rOutputValue:=20.0,rRamp:=200.0),PreOutput:=(rOutputValue:=0.0,rRamp:=200.0),rMinOutput:=0.0)) @RT(46)output values for mold height forward movement 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)20.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(8)Relative @RT(0) 
@RT(47)0.0..%FU.sv_MoldHeightOutput.rMaxAdjustPressure @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold adjust forward @RT(19)Mold adjust forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampPressure @RT(0) @RT(0) 
@RT(50)cPlausMaxRampPressureMin..cPlausMaxRampPressureMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold adjust forward @RT(25)Max. ramp mold adjust fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(66)sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(4)20.0 @RT(0) 
@RT(1)1 @RT(16)cLevelProduction @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(17)MaxSystemVelocity @RT(0) 
@RT(47)0.0..%FU.sv_MoldHeightOutput.rMaxAdjustVelocity @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold adjust forward @RT(19)Mold adjust forward @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(59)sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rRamp @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)200.0 @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt41 @RT(15)MaxRampVelocity @RT(17)MaxSystemVelocity @RT(0) 
@RT(50)cPlausMaxRampVelocityMin..cPlausMaxRampVelocityMax @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Mold adjust forward @RT(25)Max. ramp mold adjust fwd @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(69)sv_MoldHeightOutput.MoldHeightForward.Velocity.PreOutput.rOutputValue @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(3)0.0 @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldHeightOutput.rMaxAdjustPressure @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)140.0 @RT(60)maximum value for pressure that can be set for the movements 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(8)Pressure @RT(10)NoRelative @RT(0) 
@RT(24)0.0..%FU.sv_rMaxPressure @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Max. mold adjust pressure @RT(25)Max. pressure mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 
@AttrSym @RT(38)sv_MoldHeightOutput.rMaxAdjustVelocity @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(5)100.0 @RT(60)maximum value for velocity that can be set for the movements 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(0) @RT(5)fmt30 @RT(7)Percent @RT(10)NoRelative @RT(0) 
@RT(31)0.0..system.sv_rMaximumVelocity @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(25)Max. mold adjust velocity @RT(25)Max. velocity mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(29)sv_bMoldHeightAdjustByOneGear @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Adjust by one gear @RT(18)Adjust by one gear @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(29)sv_bMoldHeightAdjustByOneGear @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(18)Adjust by one gear @RT(18)Adjust by one gear @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(23)sv_MoldHeightAdjustTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#1s @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(18)T#10ms..T#99s990ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Adjust time @RT(11)Adjust time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(23)sv_MoldHeightAdjustTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(15)act. cylce time 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)fmt32 @RT(4)Time @RT(0) @RT(0) 
@RT(18)T#10ms..T#99s990ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Adjust time @RT(11)Adjust time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(26)sv_bMoldHeightAdjustByTime @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Adjust by time @RT(14)Adjust by time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(26)sv_bMoldHeightAdjustByTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(17)cLevelMoldPrepare @RT(11)VG_MoldData @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Adjust by time @RT(14)Adjust by time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(10)sv_Options @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(9)tOptionId @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Options @RT(14)Device options @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(10)sv_Options @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(16)cOptionHydraulic @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(7)Options @RT(14)Device options @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dMaxImpulseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(4)T#1s @RT(22)Single impulse timeout 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(18)T#10ms..T#99s990ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Single impulse timeout @RT(22)Single impulse timeout @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dMaxImpulseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Single impulse timeout 
@RT(1)1 @RT(16)cLevelProduction @RT(11)VG_MoldData @RT(5)fmt31 @RT(4)Time @RT(0) @RT(0) 
@RT(18)T#10ms..T#99s990ms @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(22)Single impulse timeout @RT(22)Single impulse timeout @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(18)sv_dActImpulseTime @RT(0) @T @F @DT @RT(4)TIME @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(19)Actual impulse time 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Actual impulse time @RT(19)Actual impulse time @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(18)sv_dActImpulseTime @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(22)Single impulse timeout 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(5)fmt31 @RT(4)Time @RT(0) @RT(4)Fast 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(19)Actual impulse time @RT(19)Actual impulse time @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(25)sv_bImpulseFeedbackMarker @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Impulse sensor @RT(14)Impulse sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(25)sv_bImpulseFeedbackMarker @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(15)cLevelSuperUser @RT(0) @RT(13)fmtPosReached @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(14)Impulse sensor @RT(14)Impulse sensor @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(22)sv_bAdjustInProduction @RT(0) @T @F @DT @RT(4)BOOL @RT(0) @T @T @BASIC 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(20)Adjust in production 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(24)Adjust during production @RT(24)Adjust during production @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(22)sv_bAdjustInProduction @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(0) @RT(21)cLevelProcessOperator @RT(0) @RT(5)OnOff @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(36)system.hmi.ODCEditDisabledController 
@RT(24)Adjust during production @RT(24)Adjust during production @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_RequiredPumps @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsRequiredPumps @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(34)(RequiredPumps:=TRUE,iOrder:=4000) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
1 
@AttrSym @RT(30)sv_RequiredPumps.RequiredPumps @RT(0) @F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(0) 
@RT(1)1 @RT(22)cLevelStartupTechnican @RT(14)VG_MachineData @RT(8)UseNoUse @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(1)y @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(11)Mold adjust @RT(11)Mold adjust @RT(0) @RT(0) @RT(0) 
@END_Attrib 


@SysVar @RT(16)sv_HydrMaxValues @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(15)tsHydrMaxValues @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
4 @RT(0) @RT(35)hydraulic max values for mold close 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@END_Attrib 
0 


@SysVar @RT(15)sv_rMaxPressure @RT(0) @T @F @DT @RT(4)REAL @RT(0) @T @T @BASIC 0 @F 
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
2 
@SysEvent @RT(20)evMaxImpulseExceeded @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
@F @F 
@T 
@BEG_Attrib 
13 @RT(0) @RT(0) 
@RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) @RT(0) 
@RT(0) 
@END_Attrib 
0 


@SysEvent @RT(25)evMaxImpulseExceededReset @RT(0) @T @T @DERIVED 0 @T @T @DT @RT(11)ALARM_EVENT @RT(0) @T @T @UNKNOWN 0 @F 
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
5 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erMoldHeightMaxDI @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(20)User and Application @RT(394)Maximum mold height reached{#]The mold height maximum is reached.{#]The limitswitch feedback for mold height maximum position indicates the end position has been reached. \u000aMold height cannot increase further.{#]In case this alarm happens during mold height auto adjustment, \u000aanother alarm is given with more details about possible solutions.<br>\u000aOtherwise this is just a message. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(17)erMoldHeightMinDI @RT(1)1 @RT(1)y @RT(0) @RT(0) @RT(20)User and Application @RT(394)Minimum mold height reached{#]The mold height minimum is reached.{#]The limitswitch feedback for mold height minimum position indicates the end position has been reached. \u000aMold height cannot decrease further.{#]In case this alarm happens during mold height auto adjustment, \u000aanother alarm is given with more details about possible solutions.<br>\u000aOtherwise this is just a message. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erMoldHeightMotorOverload @RT(1)2 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(20)User and Application @RT(719)%1t%2n: Motor overloaded{#]Mold height motor overload signal \u000areceived. No more mold height movement \u000apossible.{#]The digital input for mold height motor overload signals an overload state. In case of a motor \u000aoverload no further mold height movement is possible including of course \u000aautomatic mold height adjustment processes. Usually the overload signal is valid \u000aand the motor needs to cool down / get back into operational state. In rare \u000acases the sensor might be broken.{#]Let the motor cool down / get back into operational state before \u000aretrying the desired mold height operation.<br>\u000aIn case the overload stays check the hardware including the \u000awiring and terminal. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(26)erMHMaxImpulseTimeExceeded @RT(1)3 @RT(0) @RT(24)%FU.evMaxImpulseExceeded @RT(29)%FU.evMaxImpulseExceededReset @RT(4)User @RT(1418)Max impulse time for mold height exceeded{#]A mold height movement impulse feedback \u000atimeout happened.{#]The sensor feedback for mold height position usually delivers impulses. When \u000amold height is moving an impulse is expected within a preset time. If the time \u000abetween two impulses exceeds the preset time this alarm is raised. The reason can be too low output settings for mold height \u000amovement or a malfunction at the limitswitches for mold height. A faulty \u000alimitswitch feedback can result in a mold height movement hitting the \u000amechanical limit while the application cannot detect this state of the machine.{#]Check whether mold height reached its absolute minimum or \u000amaximum. If this is the case check the limitswitch feedback as well \u000aas hardware, wiring and terminal.<br><br>\u000aIf the limitswitches work and the timeout happened within normal \u000amold height movement range try to increase the mold height \u000aoutput settings (fwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue:c:velocity}, bwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue:c:velocity} to achieve a more precise mold height adjustment. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(16)erAdjustSettings @RT(1)5 @RT(1)y @RT(0) @RT(0) @RT(4)User @RT(1137)Act. impulse count higher than set impulse count. Increase ramps and reduce output{#]Mold height is moving too far.{#]For each adjustment step the mold height is moved to a desired number of \u000aimpulses. If the movement output is too high, or if the ramps are to flat, an \u000aovershoot is possible, which reduces the accuracy of the mold height \u000aadjustment process. In case such an overshoot happens this alarm is raised. \u000aAlthough this is only a message and the adjustment process will continue a \u000aproper mold height adjustment is strongly recommended.{#]Try reducing the movement settings for mold height output settings (fwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightForward.Velocity.Output.rOutputValue:c:velocity}, bwd: {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Pressure.Output.rOutputValue:c:pressure} / {MoldHeight1.sv_MoldHeightOutput.MoldHeightBackward.Velocity.Output.rOutputValue:c:velocity} and \u000aincrease the mold height ramp settings in order to achieve a \u000aprecise mold height adjustment. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
