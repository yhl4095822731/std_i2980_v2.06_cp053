%SYSTEM_ALARM
  erNoPumpDefinition
 %CLASS 1 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// No pump assignment for %1t%2n %3t; Check application{#]The requested movement has no information about the required pumps.{#]On hydraulic machines every movement must provide the information about which pumps will be required for this movement. The requested movement does not provide this information.{#]Please contact the machine manufacturer.
 ;
  erPumpInterruptNotAllowed
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Giving pump %1n to %2t%3n %4t not possible because pump %1n is already interrupted!{#]The requested pump can not be interrupted for another movement.{#]It is not possible to interrupt the requested pump because another movement has already interrupted the pump.{#]Adapt the pump assignment on the pump assignment mask.
 ;
  erInterruptLastPump
 %CLASS 2 %ACKNOWLEDGEMENT %USER %PROTOCOL %YES
 %SET_ALARM_EVENTS system.evAlarmAutoManual, system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Giving pump %1n to %2t%3n not allowed because otherwise no pump remains for %4t movement{#]The requested pump can not be given to another movement.{#]It is not possible to give the requested pump to another movement because otherwise no pump remains for the actual active movement.{#]Adapt the pump assignment on the pump assignment mask.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 97 @Sve 25 
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
3 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erNoPumpDefinition @RT(1)1 @RT(1)y @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(345)No pump assignment for %1t%2n %3t; Check application{#]The requested movement has no information about the required pumps.{#]On hydraulic machines every movement must provide the information about which pumps will be required for this movement. The requested movement does not provide this information.{#]Please contact the machine manufacturer. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(25)erPumpInterruptNotAllowed @RT(1)2 @RT(1)y @RT(49)system.evAlarmAutoManual, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(318)Giving pump %1n to %2t%3n %4t not possible because pump %1n is already interrupted!{#]The requested pump can not be interrupted for another movement.{#]It is not possible to interrupt the requested pump because another movement has already interrupted the pump.{#]Adapt the pump assignment on the pump assignment mask. 
@END_Attrib 
@F @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(19)erInterruptLastPump @RT(1)2 @RT(1)y @RT(49)system.evAlarmAutoManual, system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(338)Giving pump %1n to %2t%3n not allowed because otherwise no pump remains for %4t movement{#]The requested pump can not be given to another movement.{#]It is not possible to give the requested pump to another movement because otherwise no pump remains for the actual active movement.{#]Adapt the pump assignment on the pump assignment mask. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
