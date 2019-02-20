package HeatingNozzle1.hmi;

import java.awt.BorderLayout;

import com.keba.kemro.kvs.keplast.heating.KNozzleHeating;

public class HeatingNozzleMask1 extends HeatingNozzleMask1_generated {
	
	private static final long serialVersionUID = 1L;

	public HeatingNozzleMask1() throws Exception {	   
		super();
		KNozzleHeating heatingBean = new KNozzleHeating("HeatingNozzle1", true, true, false, false, true, true);
		brdpanHeating.add(heatingBean.getHeatingOnCenteredPanel(), BorderLayout.NORTH);		
	}

}
