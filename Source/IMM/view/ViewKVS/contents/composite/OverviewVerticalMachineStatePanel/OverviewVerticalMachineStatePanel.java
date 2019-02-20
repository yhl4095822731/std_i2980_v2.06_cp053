package composite.OverviewVerticalMachineStatePanel;

import java.awt.BorderLayout;

import viewedit.function.PlastFunctionUtils;
import viewedit.function.UserFunctions;
import com.keba.kemro.kvs.keplast.heating.KNozzleHeating;

public class OverviewVerticalMachineStatePanel extends OverviewVerticalMachineStatePanel_generated {
   private static final long serialVersionUID = 1L;

   public OverviewVerticalMachineStatePanel() throws Exception {
      super();

      panelHeating.add(new KNozzleHeating().getHeatingOnCenteredPanel(), BorderLayout.NORTH);

      // Modify layout for single pump (or no pump)
      if (!UserFunctions.doesDeviceExist(PlastFunctionUtils
            .createDeviceName("Pump2"))) {
         // Align analog bars vertically
         panelPressVelPump1GridLayout.setColumns(1);
         panelPressVelPump1GridLayout.setRows(2);
         panelNorthLeft.setPreferredSize(panelNorthLeft.getPreferredSize().width / 2,
               panelNorthLeft.getPreferredSize().height);
      }
   }

}
