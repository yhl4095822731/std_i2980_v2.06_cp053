package composite.DecompressionPanel;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;

public class DecompressionPanel extends DecompressionPanel_generated implements
		ValueChangedListener {
	private static final long serialVersionUID = 1L;

	private String sVarNameModeBefore = null;
	private String sVarNameModeAfter = null;

	public DecompressionPanel() throws Exception {
		super();
	}

	public void setDeviceNameComp(String deviceName) {
		selectListModeBefore.setVariable(deviceName + ".sv_DecompBefPlastSettings.Mode");
		numfieldPressureBefore.setVariable(deviceName + ".sv_DecompBefPlastSettings.ConstOutput.Pressure.Output.rOutputValue");
		numfieldVelocityBefore.setVariable(deviceName + ".sv_DecompBefPlastSettings.ConstOutput.Velocity.Output.rOutputValue");
		numfieldPositionBefore.setVariable(deviceName + ".sv_DecompBefPlastSettings.rDecompPos");
		numfieldTimeBefore.setVariable(deviceName + ".sv_DecompBefPlastSettings.dDecompTime");

		selectListModeAfter.setVariable(deviceName + ".sv_DecompAftPlastSettings.Mode");
		numfieldPressureAfter.setVariable(deviceName + ".sv_DecompAftPlastSettings.ConstOutput.Pressure.Output.rOutputValue");
		numfieldVelocityAfter.setVariable(deviceName + ".sv_DecompAftPlastSettings.ConstOutput.Velocity.Output.rOutputValue");
		numfieldPositionAfter.setVariable(deviceName + ".sv_DecompAftPlastSettings.rDecompPos");
		numfieldTimeAfter.setVariable(deviceName + ".sv_DecompAftPlastSettings.dDecompTime");

		unitPressure.setVariable(deviceName + ".sv_DecompBefPlastSettings.ConstOutput.Pressure.Output.rOutputValue");
		unitVelocity.setVariable(deviceName + ".sv_DecompBefPlastSettings.ConstOutput.Velocity.Output.rOutputValue");
		unitPosition.setVariable(deviceName + ".sv_DecompBefPlastSettings.rDecompPos");
		unitTime.setVariable(deviceName + ".sv_DecompBefPlastSettings.dDecompTime");
		
		sVarNameModeBefore = deviceName + ".sv_DecompBefPlastSettings.Mode";
		sVarNameModeAfter = deviceName + ".sv_DecompAftPlastSettings.Mode";

		try {
			HmiVariableService.registerVariable(sVarNameModeBefore, this);
			HmiVariableService.registerVariable(sVarNameModeAfter, this);
		} catch (Exception ex) {
		}
	}

	public void valueChanged(ValueChangedEvent event) {

		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
			return;
		}

		try {
			int value = event.getVariable().getIntValue();
			if (event.getVariable().getName().equals(sVarNameModeBefore)) {
				numfieldPressureBefore.setEnabled(value != 0);
				numfieldVelocityBefore.setEnabled(value != 0);
				numfieldPositionBefore.setEnabled(value == 2);
				numfieldTimeBefore.setEnabled(value == 1);
				repaint();
			}
			if (event.getVariable().getName().equals(sVarNameModeAfter)) {
				numfieldPressureAfter.setEnabled(value != 0);
				numfieldVelocityAfter.setEnabled(value != 0);
				numfieldPositionAfter.setEnabled(value == 2);
				numfieldTimeAfter.setEnabled(value == 1);
				repaint();
			}
		} catch (Exception ex) {
		}
	}
}
