/*-------------------------------------------------------------------------
 *                         (c) 2010 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : IMM - View.Standard Visualization
 *    Date         : 22.11.2010
 *    Archive      : HeatingNozzle1.hmi
 *--------------------------------------------------------------------------*/
package HeatingNozzle1.hmi;

import system.hmi.MachineEquipment;

public class HeatingNozzleParameterMask1 extends
		HeatingNozzleParameterMask1_generated {

	private static final long serialVersionUID = -6677567031416615839L;

	public HeatingNozzleParameterMask1() throws Exception {
		super();
		if (MachineEquipment
				.doesVariableExist("HeatingNozzle1.do_HopperCooler")) {
			this.setIconName("HeatingNozzle1/hmi/images/iconHeatingParam1.gif");
		}
	}

}
