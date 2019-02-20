package composite.SingleTabCoreSetup;


public class SingleTabCoreSetup extends SingleTabCoreSetup_generated {
	private static final long serialVersionUID = 1L;
	public SingleTabCoreSetup() throws Exception {
		super();
	}
	
	public void setDeviceNameComp(String sNameDevice) {
		super.setDeviceNameComp(sNameDevice);
		twonumfieldManualRampIn.setVariableLeft(sNameDevice + ".sv_CoreOutput.NormalIn.Pressure.Output.rRamp");
		twonumfieldManualRampIn.setVariableRight(sNameDevice + ".sv_CoreOutput.NormalIn.Velocity.Output.rRamp");
		twonumfieldManualRampOut.setVariableLeft(sNameDevice + ".sv_CoreOutput.NormalOut.Pressure.Output.rRamp");
		twonumfieldManualRampOut.setVariableRight(sNameDevice + ".sv_CoreOutput.NormalOut.Velocity.Output.rRamp");

		twonumfieldSetupConstIn.setVariableLeft(sNameDevice + ".sv_CoreOutput.SetupIn.Pressure.Output.rOutputValue");
		twonumfieldSetupConstIn.setVariableRight(sNameDevice + ".sv_CoreOutput.SetupIn.Velocity.Output.rOutputValue");
		twonumfieldSetupConstOut.setVariableLeft(sNameDevice + ".sv_CoreOutput.SetupOut.Pressure.Output.rOutputValue");
		twonumfieldSetupConstOut.setVariableRight(sNameDevice + ".sv_CoreOutput.SetupOut.Velocity.Output.rOutputValue");

		twonumfieldSetupRampIn.setVariableLeft(sNameDevice + ".sv_CoreOutput.SetupIn.Pressure.Output.rRamp");
		twonumfieldSetupRampIn.setVariableRight(sNameDevice + ".sv_CoreOutput.SetupIn.Velocity.Output.rRamp");
		twonumfieldSetupRampOut.setVariableLeft(sNameDevice + ".sv_CoreOutput.SetupOut.Pressure.Output.rRamp");
		twonumfieldSetupRampOut.setVariableRight(sNameDevice + ".sv_CoreOutput.SetupOut.Velocity.Output.rRamp");

		numfieldDelayIn.setVariableLeft(sNameDevice + ".sv_CoreSetTimes.MoveIn.dSetDelayTimePump");
		numfieldDelayIn.setVariableRight(sNameDevice + ".sv_CoreSetTimes.MoveIn.dSetDelayTimeValve");
		numfieldDelayOut.setVariableLeft(sNameDevice + ".sv_CoreSetTimes.MoveOut.dSetDelayTimePump");
		numfieldDelayOut.setVariableRight(sNameDevice + ".sv_CoreSetTimes.MoveOut.dSetDelayTimeValve");
	}
}
