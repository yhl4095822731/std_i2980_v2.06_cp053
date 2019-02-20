package composite.InjectionColdDropPanel;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.SequenceControlManager;
import com.keba.keplast.general.util.SequenceControlChangedEvent;
import com.keba.keplast.general.util.SequenceControlChangedListener;
public class InjectionColdDropPanel extends InjectionColdDropPanel_generated implements ValueChangedListener, SequenceControlChangedListener {
	private static final long serialVersionUID = 1L;

	public InjectionColdDropPanel() throws Exception {
		super();		
		setEnabledFields(false);		
		SequenceControlManager.getInstance().addListener(this);		
	}

	public void setVariableUseComp(String sVariableName) {
		super.setVariableUseComp(sVariableName);
		try {
			HmiVariableService.registerVariable(sVariableName, this);

		} catch (VartypeException ex) {}      
	}

	/**
	 * @see com.keba.kemro.plc.event.ValueChangedListener#valueChanged(com.keba.kemro.plc.event.ValueChangedEvent)
	 */
	public void valueChanged(ValueChangedEvent event) {
		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED){
			return;
		}

		boolean bUsed = false;
		try {
			bUsed = event.getVariable().getBooleanValue();         
		} catch (Exception ex){}
		setEnabledFields(bUsed);

	}

	private void setEnabledFields(boolean enabled){
		numfieldPressure.setEnabled(enabled);
		numfieldVelocity.setEnabled(enabled);
		numfieldTime.setEnabled(enabled);
		repaint();  
	}
	public void sequenceControlChanged(SequenceControlChangedEvent event) {
		chkBoxUse.setEnabled(!event.isEditorControlled());
		chkBoxUse.repaint();      
	}

}






