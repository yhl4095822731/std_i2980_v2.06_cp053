package system.hmi;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.utils.UncheckedException;

public class AutoCalibLimitsMask extends AutoCalibLimitsMask_generated implements ValueChangedListener {
   private static final long serialVersionUID = 1L;
   private KVariable varDeviceForPumpCalib1;
   private KVariable varDeviceForPumpCalib2;
   private KVariable varDeviceForPumpCalib3;

   private static final int AXIS_INJECTION = 1;
   private static final int AXIS_MOLD = 2;
   private static final int AXIS_EJECTOR = 3;

   public AutoCalibLimitsMask() throws Exception {
      super();

      // Register value changed listeners for axis selections of pump calibrations
      HmiVariableService varService = HmiVariableService.getService();
      if (comboboxTextAxisForPumpCalib1 != null) {
         varDeviceForPumpCalib1 = varService.getVariable(comboboxTextAxisForPumpCalib1.getVariable());
         varDeviceForPumpCalib1.addListener(this);
      }
      if (comboboxTextAxisForPumpCalib2 != null) {
         varDeviceForPumpCalib2 = varService.getVariable(comboboxTextAxisForPumpCalib2.getVariable());
         varDeviceForPumpCalib2.addListener(this);
      }
      if (comboboxTextAxisForPumpCalib3 != null) {
         varDeviceForPumpCalib3 = varService.getVariable(comboboxTextAxisForPumpCalib3.getVariable());
         varDeviceForPumpCalib3.addListener(this);
      }
   }

   public void valueChanged(ValueChangedEvent event) {
      if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
         return;
      }

      // Enable/disable max measure position numfields
      numFieldTextMaxMeasurePosScrew.setEnabled(isAxisSelected(AXIS_INJECTION));
      numFieldTextMaxMeasurePosMold.setEnabled(isAxisSelected(AXIS_MOLD));
      numFieldTextMaxMeasurePosEje.setEnabled(isAxisSelected(AXIS_EJECTOR));

   }

   /**
    * Checks if axis is selected for any pump calibration.
    * 
    * @param axis
    *           Number of axis (Injection, Mold or Ejector)
    * @return <code>true</code> if axis is selected for any pump calibration.
    */
   private boolean isAxisSelected(int axis) {
      try {
         boolean screwAxisSelected = (varDeviceForPumpCalib1 != null && varDeviceForPumpCalib1.getIntValue() == axis) ||
               (varDeviceForPumpCalib2 != null && varDeviceForPumpCalib2.getIntValue() == axis) ||
               (varDeviceForPumpCalib3 != null && varDeviceForPumpCalib3.getIntValue() == axis);
         return screwAxisSelected;
      } catch (VartypeException e) {
         throw new UncheckedException("", e);
      }
   }
}
