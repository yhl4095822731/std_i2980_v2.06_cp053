/*-------------------------------------------------------------------------
 *                         (c) 2010 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : IMM - View.Standard Visualization
 *    Date         : 22.11.2010
 *    Archive      : system.hmi
 *--------------------------------------------------------------------------*/
package system.hmi;

public class MachineEquipmentMask extends MachineEquipmentMask_generated {
   private static final long serialVersionUID = 1L;

   public MachineEquipmentMask() throws Exception {
      super();

      // Remove empty tabs
      Object tabExtended = tabPanelPlast1.getTabSelector().getTabAt(1);
      Object tabExtended2 = tabPanelPlast1.getTabSelector().getTabAt(2);
      if (panelLeftExtended.getComponentCount() == 0 && panelRightExtended.getComponentCount() == 0) {
         tabPanelPlast1.removeTab(tabExtended);
      }

      if (panelLeftExtended2.getComponentCount() == 0 && panelRightExtended2.getComponentCount() == 0) {
         tabPanelPlast1.removeTab(tabExtended2);
      }
   }
}
