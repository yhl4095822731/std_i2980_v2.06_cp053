package composite.SingleAirValvePanel;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.keplast.general.SequenceControlManager;
import com.keba.keplast.general.util.SequenceControlChangedEvent;
import com.keba.keplast.general.util.SequenceControlChangedListener;

public class SingleAirValvePanel extends SingleAirValvePanel_generated implements ValueChangedListener, SequenceControlChangedListener {
	private static final long serialVersionUID = 1L;

	private boolean bEditorControlled = false;
	private int iAirValveMode = Integer.MAX_VALUE;

	public SingleAirValvePanel() throws Exception {
		super();
		SequenceControlManager.getInstance().addListener(this);
	}

	public void setDeviceNameComp(String sDeviceName) {
		super.setDeviceNameComp(sDeviceName);
		// set variables to fields
		selectListMode.setVariable(sDeviceName + ".sv_AirValveMode");
		markActive.setVariable(sDeviceName + ".do_Air");
		numfieldActiveTime.setVariable(sDeviceName + ".sv_AirValveTimesSet.dSetMoveTime");
		numfieldDelayTime.setVariable(sDeviceName + ".sv_AirValveTimesSet.dSetDelayTime");
		numfieldStartPos.setVariable(sDeviceName + ".sv_rStartPosition");
		
		try {
			HmiVariableService.registerVariable(sDeviceName + ".sv_AirValveMode", this);
		} catch (Exception ex) {
		}
	}

	/**
	 *
	 * @see com.keba.kemro.plc.event.ValueChangedListener#valueChanged(com.keba.kemro.plc.event.ValueChangedEvent)
	 */
	public void valueChanged(ValueChangedEvent e) {

		if (e.getReason() == ValueChangedEvent.VALUE_CHANGED) {
			try {		   
				iAirValveMode = e.getVariable().getIntValue();
				updateEnabledByMode();
			} catch (Exception ex) {
			}
		}
	}

	/**
	 * @see com.keba.keplast.general.util.SequenceControlChangedListener#sequenceControlChanged(com.keba.keplast.general.util.SequenceControlChangedEvent)
	 */
	public void sequenceControlChanged(SequenceControlChangedEvent event) {
		bEditorControlled = event.isEditorControlled();
		updateEnabledByMode();      
	}

	private void updateEnabledByMode() {  
		numfieldDelayTime.setEnabled(bEditorControlled || (!bEditorControlled && iAirValveMode >= 1));
		numfieldActiveTime.setEnabled(bEditorControlled || (!bEditorControlled && iAirValveMode >= 1));
		numfieldStartPos.setEnabled(!bEditorControlled && (iAirValveMode == 4 || iAirValveMode == 7));
	}

}
