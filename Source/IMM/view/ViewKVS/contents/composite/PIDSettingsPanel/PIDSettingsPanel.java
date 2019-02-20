package composite.PIDSettingsPanel;

import com.keba.kemro.kvs.keplast.widgets.KNumFieldText;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;

public class PIDSettingsPanel extends PIDSettingsPanel_generated implements ValueChangedListener {
	private static final long serialVersionUID = 1L;
	public PIDSettingsPanel() throws Exception {
		super();
	}
	
	public void setParamNameComp(String sVarName) {
        checkBoxUse.setVariable(sVarName + ".bUsePIDControl");
        numFieldP.setVariable(sVarName + ".rP");
        numFieldI.setVariable(sVarName + ".dTN");
        numFieldD.setVariable(sVarName + ".dTV");

        try {
           HmiVariableService.registerVariable(sVarName + ".bUsePIDControl", this);
        } catch (Exception ex) {
        }
	}

	public void valueChanged(ValueChangedEvent event) {
		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED)
			return;

		try {
			boolean bvalue = event.getVariable().getBooleanValue();
			numFieldP.setEditable(bvalue);
			numFieldI.setEditable(bvalue);
			numFieldD.setEditable(bvalue);
			this.repaint();
		} catch (Exception ex) {
		}
	}
	
    /**
     * Get the variable of the checkbox
     *
     * @return
     */
    public KVariable getCheckBoxVariable() {
       return checkBoxUse.getKVariable();
    }

    /**
     * Set the checkbox enabled
     *
     * @param b
     */
    public void setCheckBoxEnabled(boolean b) {
    	checkBoxUse.setEnabled(b);
    }

    public KNumFieldText getNumfieldD() {
       return numFieldD;
    }
}
