package composite.OverviewMachineStatePanel;

import java.awt.BorderLayout;

import com.keba.kemro.kvs.keplast.heating.KNozzleHeating;

public class OverviewMachineStatePanel
		extends
			OverviewMachineStatePanel_generated {
	private static final long serialVersionUID = 1L;
	public OverviewMachineStatePanel() throws Exception {
		super();
		
		panelNorthCenter.add(new KNozzleHeating().getHeatingOnCenteredPanel(), BorderLayout.NORTH);
	}

}
