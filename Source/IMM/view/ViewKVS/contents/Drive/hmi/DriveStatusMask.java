package Drive.hmi;

import java.awt.event.ActionEvent;

import com.keba.keplast.general.PlastConstants;

public class DriveStatusMask extends DriveStatusMask_generated {
   private static final long serialVersionUID = 1L;

   public DriveStatusMask() throws Exception {
      super();

      // vpl3
      if (PlastConstants.isVPL3()) {
         this.setBackground(PlastConstants.COL_BG_PANEL);
      }
   }

   /**
    * This method reacts on action commands
    */
   public void actionPerformed(ActionEvent ev) {
      super.actionPerformed(ev);
      // if (ev.getSource() == <component>) {
      // Todo: add action here
      // }
   }
}
