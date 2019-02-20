package composite.InjectionIntrusionPanel;

import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

import com.keba.kemro.kvs.widgets.KvsCheckBox;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.general.SequenceControlManager;
import com.keba.keplast.general.util.SequenceControlChangedEvent;
import com.keba.keplast.general.util.SequenceControlChangedListener;

public class InjectionIntrusionPanel extends InjectionIntrusionPanel_generated
		implements ValueChangedListener, ItemListener,
		SequenceControlChangedListener {
	private static final long serialVersionUID = 1L;
	private static HmiVariableService hmiService = HmiVariableService
			.getService();
	private KVariable kvarIntrusionMode = null;

	public InjectionIntrusionPanel() throws Exception {
		super();
		chkBoxUse.addItemListener(this);
		setEnabledFields(false);
		SequenceControlManager.getInstance().addListener(this);
	}

	public void setVariableModeComp(String sVariableName) {
		super.setVariableModeComp(sVariableName);
		try {
			kvarIntrusionMode = hmiService.getVariable(sVariableName);
			chkBoxUse.getVisiController().init(kvarIntrusionMode);
			setCheckboxStateByIntValue(chkBoxUse,
					kvarIntrusionMode.getIntValue());
			HmiVariableService.registerVariable(sVariableName, this);
		} catch (Exception ex) {
		}
	}

	public void valueChanged(ValueChangedEvent event) {
		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
			return;
		}
		int mode = 0;
		try {
			mode = event.getVariable().getIntValue();
		} catch (Exception ex) {
		}
		setCheckboxStateByIntValue(chkBoxUse, mode);
		setEnabledFields(mode != 0);
	}

	private void setEnabledFields(boolean enabled) {
		numfieldBackPressure.setEnabled(enabled);
		numfieldPressure.setEnabled(enabled);
		numfieldVelocity.setEnabled(enabled);
		numfieldTime.setEnabled(enabled);
		repaint();
	}

	public void itemStateChanged(ItemEvent e) {
		Object value = null;
		if (chkBoxUse.getState()) {
			value = new Integer(1);
		} else {
			value = new Integer(0);
		}
		try {
			hmiService.writeValue(kvarIntrusionMode, value);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	private void setCheckboxStateByIntValue(KvsCheckBox checkbox, int value) {
		checkbox.setState(value != 0);
		if (checkbox.isShowing()) {
			checkbox.repaint();
		}
	}

	public void sequenceControlChanged(SequenceControlChangedEvent event) {
		chkBoxUse.setEnabled(!event.isEditorControlled());
		chkBoxUse.repaint();
	}
}
