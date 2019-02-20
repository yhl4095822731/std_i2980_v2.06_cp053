/*-------------------------------------------------------------------------
 *                         (c) 2010 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : IMM - View.Standard Visualization
 *    Date         : 22.11.2010
 *    Archive      : Ejector1.hmi
 *--------------------------------------------------------------------------*/
package Ejector1.hmi;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KNumber;
import com.keba.kemro.plc.variable.KVariable;

public class EjectorMask1 extends EjectorMask1_generated implements ValueChangedListener {
	private static final long serialVersionUID = 1L;

	private KVariable kvarNOFPointsFwd = null;
	private KVariable kvarNOFPointsBwd = null;

	public EjectorMask1() throws Exception {
		super();

		kvarNOFPointsFwd = hmiService.getVariable(profileEjector1_EjectorFwdVisRel.getVariableNOFStages());
		HmiVariableService.registerVariable(kvarNOFPointsFwd, null, this, KNumber.class);
		kvarNOFPointsBwd = hmiService.getVariable(profileEjector1_EjectorBwdVisRel.getVariableNOFStages());
		HmiVariableService.registerVariable(kvarNOFPointsBwd, null, this, KNumber.class);
	}

	public void valueChanged(ValueChangedEvent e) {

		if (e.getReason() != ValueChangedEvent.VALUE_CHANGED)
			return;

		try {
			if (e.getVariable().equals(kvarNOFPointsBwd)) {
				// refresh the lower limit for the ejector forward profile, when the
				// number of
				// stages has changed in the ejectro backward profile
				profileEjector1_EjectorFwdVisRel
						.setVariableLowerLimit("Ejector1.sv_EjectorBwdVisRel.Profile.Points["
								+ (kvarNOFPointsBwd.getIntValue() + 1) + "].rStartPos");
				profileEjector1_EjectorFwdVisRel.refreshProfile();
			} else if (e.getVariable().equals(kvarNOFPointsFwd)) {
				// refresh the lower limit for the ejector forward profile, when the
				// number of
				// stages has changed in the ejectro backward profile
				profileEjector1_EjectorBwdVisRel
						.setVariableUpperLimit("Ejector1.sv_EjectorFwdVisRel.Profile.Points["
								+ (kvarNOFPointsFwd.getIntValue() + 1) + "].rStartPos");
				profileEjector1_EjectorBwdVisRel.refreshProfile();
			}
		} catch (Exception ex) {
			ex.printStackTrace(System.err);
		}
	}
}
