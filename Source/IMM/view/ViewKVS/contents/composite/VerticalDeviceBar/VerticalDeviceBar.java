package composite.VerticalDeviceBar;

import com.ibm.log4j.Category;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KNumber;
import com.keba.kemro.plc.variable.KVariable;

public class VerticalDeviceBar extends VerticalDeviceBar_generated implements ValueChangedListener{
	private static final long serialVersionUID = 1L;
    public static final boolean ZERO_UP = true;
    public static final boolean ZERO_DOWN = false;

	private KVariable kvarMaxValue = null;
	private KVariable kvarActValue = null;
	
	private boolean bZeroPosition = ZERO_DOWN;
	private Category CAT;

	public VerticalDeviceBar() throws Exception {
		super();
		CAT = Category.getInstance(this.getClass().getName());

	}

	
	public void setZeroPositionIsUpComp(boolean bZeroPosition) {
		this.bZeroPosition = bZeroPosition;
		valueChanged(new ValueChangedEvent(this));
	}

	public boolean getZeroPositionIsUpComp() {
		return bZeroPosition;
	}

	public void setVariableComp(final String sVariable) {
		HmiVariableService hmiService;

		numField1.setVariable(sVariable);
		try {
			if (kvarActValue != null) {
				kvarActValue.remove(ValueChangedListener.class, this);
			}
			hmiService = HmiVariableService.getService();
			kvarActValue = hmiService.getVariable(sVariable);
			HmiVariableService.registerVariable(kvarActValue, null, this,
					KNumber.class);
		}
		catch (Exception ex) {
		   CAT.error("setVariableComp: ", ex);
		}
	}
	public void setVariableMaximumComp(final String sVariable) {
		HmiVariableService hmiService;
		
		try {
			hmiService = HmiVariableService.getService();
			if (kvarMaxValue != null) {
				kvarMaxValue.remove(ValueChangedListener.class, this);
			}
			kvarMaxValue = hmiService.getVariable(sVariable);
//			HmiVariableService.registerVariable(sVariable, this);
			HmiVariableService.registerVariable(kvarMaxValue, null, this, KNumber.class);
		}
		catch (Exception ex) {
			CAT.error("setVariableMaximumComp: ", ex);
		}
	}
	public String getVariableMaximumComp() {
		return kvarMaxValue.getName();
	}
	public void valueChanged(ValueChangedEvent event) {
		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
			return;
		}
		try {
	         double actValue = kvarActValue == null ? 0 : kvarActValue.getDoubleValue();
	         double maxValue = kvarMaxValue == null ? 0 : kvarMaxValue.getDoubleValue();

	         if (bZeroPosition == ZERO_UP ^ bar.isInverted()) {
	            actValue = maxValue - actValue;
	         }
	         bar.setActValue(actValue);
	         bar.setMaximumDouble(maxValue);
		}
		catch (Exception ex) {
			CAT.error("valueChanged: ", ex);
		}
	}
}
