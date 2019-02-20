package composite.PIDControlExtendedPanel;

import com.ibm.log4j.Category;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.event.ValueChangedListener;

public class PIDControlExtendedPanel extends PIDControlExtendedPanel_generated implements ValueChangedListener {
	private static final long serialVersionUID = 1L;
	private Category CAT;
	
	public PIDControlExtendedPanel() throws Exception {
		super();
		CAT = Category.getInstance(getClass().getName());
	}

	public void setParamNameComp(String sVarName) {
        checkBoxUse.setVariable(sVarName + ".bUsePIDControl");
        numFieldP.setVariable(sVarName + ".rP");
        try {
           HmiVariableService.registerVariable(sVarName + ".bUsePIDControl", this);
        }
        catch (Exception ex) {
           CAT.error("setParamNameComp: ", ex);
        }
	}

	public void valueChanged(ValueChangedEvent event) {
		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED)
			return;

		try {
			boolean bvalue = event.getVariable().getBooleanValue();
			numFieldP.setEditable(bvalue);
			numFieldTime.setEditable(bvalue);
			this.repaint();
      }
      catch (Exception ex) {
         CAT.error("valueChanged: ", ex);
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
}
