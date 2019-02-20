/*-------------------------------------------------------------------------
 *                   (c) 2006 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : KePlast view.standard HMI
 *    Datum     : 06.06.2006
 *    Archive   : system.hmi
 *--------------------------------------------------------------------------  *
 */
package system.hmi;

/**
 * 
 */
public class PIDSettingsMask extends PIDSettingsMask_generated {
   private static final long serialVersionUID = 1L;

   public PIDSettingsMask() throws Exception {
      super();

      if (MachineEquipment.isDeviceElectric("Injection1")) {
         // set inject PID to false, not editable and not visible
         try {
            hmiService.writeValue(pidpanelInject.getCheckBoxVariable(), Boolean.FALSE);
         } catch (Exception ex) {
            CAT.error("Could not write to variable!", ex);
         }
         pidpanelInject.getCheckBoxVariable().setInputLevel(17);
         // only add on hydraulic machines
         panelLeft.remove(pidpanelInject);
      }

      // pidPanel is null if both, Injection1.ai_Pressure AND Injection1.ai_SysPressure are missing
      if (pidpanelHold != null) {
         if (MachineEquipment.isDeviceElectric("Injection1") || MachineEquipment.doesDeviceExist("ValveServoInj1")) {
            try {
               hmiService.writeValue(pidpanelHold.getCheckBoxVariable(), Boolean.TRUE);
            } catch (Exception ex) {
               CAT.error("Could not write to variable!", ex);
            }
            pidpanelHold.getCheckBoxVariable().setInputLevel(17);
            pidpanelHold.setCheckBoxEnabled(false);
         }
      }

      // in case of an electric plast drive select backpressurecontrol an do not allow deselect
      if (pidpanelBackpressure != null) {
         if (MachineEquipment.isDeviceElectric("Injection1") || MachineEquipment.doesDeviceExist("ValveServoInj1")) {
            try {
               hmiService.writeValue(pidpanelBackpressure.getCheckBoxVariable(), Boolean.TRUE);
            } catch (Exception ex) {
               CAT.error("Could not write to variable!", ex);
            }
            pidpanelBackpressure.getCheckBoxVariable().setInputLevel(17);
            pidpanelBackpressure.setCheckBoxEnabled(false);
         }
      }
   }
}
