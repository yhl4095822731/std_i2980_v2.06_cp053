package Energy.hmi;

import java.awt.event.ActionEvent;
import java.util.Locale;

import system.hmi.MachineEquipment;

public class EnergyMask extends EnergyMask_generated {
   private static final long serialVersionUID = 1L;

   public EnergyMask() throws Exception {
      super();
      // Reaction on Component actions like pressed button
      // Todo: register component to react here
      // <component>.addActionListener(this);
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

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);

      // Set dynamic title to border panel
      if (MachineEquipment.doesDeviceExist("EnergyMeter1")) {
         cLeft_bpCenter.setTitleString(textBundle
               .getString("cLeft_bpCenter.setTitleStringDynamicTrue"));
      } else {
         cLeft_bpCenter.setTitleString(textBundle
               .getString("cLeft_bpCenter.setTitleStringDynamicFalse"));
      }
   }
}
