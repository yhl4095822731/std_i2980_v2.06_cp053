/*-------------------------------------------------------------------------
 *                         (c) 2010 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : IMM - View.Standard Visualization
 *    Date         : 22.11.2010
 *    Archive      : Nozzle1.hmi
 *--------------------------------------------------------------------------*/

package Nozzle1.hmi;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;

public class NozzleMask1 extends NozzleMask1_generated implements
		ValueChangedListener {

	private static final long serialVersionUID = 1L;

	public NozzleMask1() throws Exception {
		super();
		HmiVariableService.registerVariable("Nozzle1.sv_MovementMode", this);
	}

	public void valueChanged(ValueChangedEvent e) {

		if (e.getReason() != ValueChangedEvent.VALUE_CHANGED)
			return;

		try {
			int iMode = e.getVariable().getIntValue();
			// If Nozzle1.di_LimitSwitchFwd2 is linked and Nozzle movement mode
			// is "Limit",
			// do not allow editing of the field "Time after limit switch" on
			// the Nozzle Mask
			try {
				hmiService.getVariable("Nozzle1.di_LimitSwitchFwd2");
				numfieldTimeSetAfter.setEnabled(!(iMode == 1));
			} catch (Exception ex) {
				numfieldTimeSetAfter.setEnabled(true);
			}

			this.validate();
			this.repaint();

		} catch (Exception ex) {
		}
	}

}
