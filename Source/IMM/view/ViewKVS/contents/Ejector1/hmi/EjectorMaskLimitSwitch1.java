package Ejector1.hmi;

import com.keba.keplast.general.SequenceControlManager;
import com.keba.keplast.general.util.SequenceControlChangedEvent;
import com.keba.keplast.general.util.SequenceControlChangedListener;

public class EjectorMaskLimitSwitch1 extends EjectorMaskLimitSwitch1_generated
		implements SequenceControlChangedListener {
	private static final long serialVersionUID = 1L;

	public EjectorMaskLimitSwitch1() throws Exception {
		super();

		SequenceControlManager.getInstance().addListener(this);
	}

	public void sequenceControlChanged(SequenceControlChangedEvent event) {
		if (numfieldMoldCheckPos != null) {
			numfieldMoldCheckPos.setVisible(!event.isEditorControlled());
			panelBwdRightDummy.repaint();
		}
	}
}
