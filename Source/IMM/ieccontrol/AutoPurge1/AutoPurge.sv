%SYSTEM_ALARM
  erAutoPurgeTimeout
 %CLASS 3 %ACKNOWLEDGEMENT %USER %PROTOCOL %NO
 %SET_ALARM_EVENTS system.evAlarmLampBlink  %RESET_ALARM_EVENTS system.evAlarmLampReset 
// Timeout during auto purge{#]Active auto purge exceeded the maximum purge time.{#]The auto purge sequence consisting of injection, decompression and \u000aplasticizing uses its own constant output settings for all included movements.\u000aIn addition a purge count for the number of overall repetitions of the sequence \u000aand a maximum purge time can be set. If the purge sequence set by the user \u000adoesn't finish within the maximum time this alarm is raised.{#]First make sure all included devices can perform the required \u000amovements.<br>\u000aIf the movements work, two basic changes can be made to the \u000aauto purge settings. Either changing the {Injection1.sv_PurgeSettings.dMaxPurgeTime} \u000ato allow auto purge to finish, or change the following auto purge \u000asettings for a faster auto purge. Adjust the purge output settings:<br> inject: {Injection1.sv_PurgeSettings.InjectParams.ConstOutput.Velocity.Output.rOutputValue:c:velocity} / {Injection1.sv_PurgeSettings.InjectParams.ConstOutput.Pressure.Output.rOutputValue:c:pressure} <br> decomp: {Injection1.sv_PurgeSettings.DecompParams.ConstOutput.Velocity.Output.rOutputValue:c:velocity} / {Injection1.sv_PurgeSettings.DecompParams.ConstOutput.Pressure.Output.rOutputValue:c:pressure} <br> plast: {Injection1.sv_PurgeSettings.PlastParams.ConstOutput.Velocity.Output.rOutputValue:c:velocity} / {Injection1.sv_PurgeSettings.PlastParams.ConstOutput.Pressure.Output.rOutputValue:c:pressure} <br> as well as the values for {Injection1.sv_PurgeSettings.InjectParams.rEndPos:c:injection endposition}, {Injection1.sv_PurgeSettings.DecompParams.rEndPos:c:decompression endposition} and \u000a{Injection1.sv_PurgeSettings.PlastParams.dSetPlastTime:c:plasticizing time}.
 ;
%END



#END_OF_IEC_PART

@Puma @IecEditor 6 22 @Sve 25 
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
1 @BEG_Attrib 
15 @RT(0) @RT(0) 
@RT(18)erAutoPurgeTimeout @RT(1)3 @RT(0) @RT(23)system.evAlarmLampBlink @RT(23)system.evAlarmLampReset @RT(4)User @RT(1736)Timeout during auto purge{#]Active auto purge exceeded the maximum purge time.{#]The auto purge sequence consisting of injection, decompression and \u000aplasticizing uses its own constant output settings for all included movements.\u000aIn addition a purge count for the number of overall repetitions of the sequence \u000aand a maximum purge time can be set. If the purge sequence set by the user \u000adoesn't finish within the maximum time this alarm is raised.{#]First make sure all included devices can perform the required \u000amovements.<br>\u000aIf the movements work, two basic changes can be made to the \u000aauto purge settings. Either changing the {Injection1.sv_PurgeSettings.dMaxPurgeTime} \u000ato allow auto purge to finish, or change the following auto purge \u000asettings for a faster auto purge. Adjust the purge output settings:<br> inject: {Injection1.sv_PurgeSettings.InjectParams.ConstOutput.Velocity.Output.rOutputValue:c:velocity} / {Injection1.sv_PurgeSettings.InjectParams.ConstOutput.Pressure.Output.rOutputValue:c:pressure} <br> decomp: {Injection1.sv_PurgeSettings.DecompParams.ConstOutput.Velocity.Output.rOutputValue:c:velocity} / {Injection1.sv_PurgeSettings.DecompParams.ConstOutput.Pressure.Output.rOutputValue:c:pressure} <br> plast: {Injection1.sv_PurgeSettings.PlastParams.ConstOutput.Velocity.Output.rOutputValue:c:velocity} / {Injection1.sv_PurgeSettings.PlastParams.ConstOutput.Pressure.Output.rOutputValue:c:pressure} <br> as well as the values for {Injection1.sv_PurgeSettings.InjectParams.rEndPos:c:injection endposition}, {Injection1.sv_PurgeSettings.DecompParams.rEndPos:c:decompression endposition} and \u000a{Injection1.sv_PurgeSettings.PlastParams.dSetPlastTime:c:plasticizing time}. 
@END_Attrib 
@F 


@RT(21)SExtAttrTreeContainer 
0 
@END_Export 

@END_Contents 
