package composite.DriveInfoAnalogBar;

import java.awt.Dimension;

import com.keba.kemro.kvs.keplast.rtk.AnalogBarRendererStartByZero;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.network.SvPlaus;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.DecimalFormat2;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.PlastConstants;

public class DriveInfoAnalogBar extends DriveInfoAnalogBar_generated {
   private static final long serialVersionUID = 1L;

   private static final int MINIMUM = 2;
   private static final int MAXIMUM = 3;

   private boolean explicitMin = false;
   private boolean explicitMax = false;
   private boolean rendererInitDone = false;
   private boolean useNegMaxAsMin = false;

   public DriveInfoAnalogBar() throws Exception {
      super();

      // Workaround: Setting preferred size in VE Designer calculates wrong pref width
      analogBarActValue.setPreferredSize(new Dimension(10, 214));

   }

   public void setVariableActValueComp(String varName) {
      super.setVariableActValueComp(varName);

      SvPlaus plaus = null;
      KVariable var = null;
      try {
         HmiVariableService hmiVarService = HmiVariableService.getService();
         var = hmiVarService.getTempVariable(varName, false);
         plaus = hmiVarService.getPlaus(var);
      } catch (Exception e) {
         e.printStackTrace();
      }
      if (plaus != null) {
         Number[][] pl = plaus.getLimit();
         double min = pl[0][0].doubleValue();
         if (!explicitMin) {
            if (min < 0) {
               analogBarActValue.setProgressRenderer(new AnalogBarRendererStartByZero(analogBarActValue));
            }
            analogBarActValue.setMinimumDouble(min);
         }

         if (!explicitMax) {
            analogBarActValue.setMaximumDouble(pl[0][1].doubleValue());
         }
      }

      // Workaround: Set custom formatter that works correctly with custom unit mode
      if (var != null) {
         DecimalFormat2[] formatter = analogBarActValue.getFormatter();
         if (formatter != null) {
            // Create new formatter with additional format for custom unit mode
            DecimalFormat2[] customFormatter = new DecimalFormat2[formatter.length + 1];
            for (int i = 0; i < formatter.length; i++) {
               customFormatter[i] = formatter[i];
            }
            customFormatter[customFormatter.length - 1] = new DecimalFormat2(var.getPreKomma(), analogBarActValue.getPostCommaISO());
            analogBarActValue.setFormatter(customFormatter);
         }
      }

      numFieldActVal.setPreferredSize(PlastConstants.iDEF_FIELD_WIDTH, PlastConstants.iDEF_FIELD_HEIGHT);

      setTicks();
   }

   public void setVariableMinimumComp(String varName) {
      super.setVariableMinimumComp(varName);
      explicitMin = true;
      registerValueChangedHandler(varName, MINIMUM);
   }

   public void setVariableMaximumComp(String varName) {
      super.setVariableMaximumComp(varName);
      explicitMax = true;
      registerValueChangedHandler(varName, MAXIMUM);
   }

   public void setUseNegativeMaximumAsMinimumComp(boolean useNegMaxAsMin) {
      super.setUseNegativeMaximumAsMinimumComp(useNegMaxAsMin);
      this.useNegMaxAsMin = useNegMaxAsMin;

      if (this.useNegMaxAsMin && explicitMax) {
         double min = analogBarActValue.getMaximumDouble() * (-1);
         analogBarActValue.setMinimumDouble(min);
         if (min < 0) {
            initStartByZeroRenderer();
         }
      }
   }

   /**
    * Sets the ticks for the analogbar (tick at bottom, middle and top)
    */
   private void setTicks() {

      int iTick = Math.abs((analogBarActValue.getMaximum() - analogBarActValue.getMinimum()) / 2);
      analogBarActValue.setTickSpacing(iTick);

   }

   /**
    * Registers value changed handlers for handling limits, minimum and maximum of the analogbar.
    * 
    * @param varName
    *           Variable name
    * @param type
    *           Type of change: high limit, critical limit, minimum, maximums
    */
   private void registerValueChangedHandler(final String varName, final int type) {
      try {
         HmiVariableService.registerVariable(varName, new ValueChangedListener() {

            public void valueChanged(ValueChangedEvent event) {
               try {
                  if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
                     return;
                  }

                  if (type == MINIMUM) {
                     double min = event.getVariable().getDoubleValue();
                     if (min < 0) {
                        initStartByZeroRenderer();
                     }
                     analogBarActValue.setMinimumDouble(min);

                  } else if (type == MAXIMUM) {
                     analogBarActValue.setMaximumDouble(event.getVariable().getDoubleValue());

                     if (useNegMaxAsMin) {
                        double min = analogBarActValue.getMaximumDouble() * (-1);
                        analogBarActValue.setMinimumDouble(min);
                        if (min < 0) {
                           initStartByZeroRenderer();
                        }
                     }
                  } else {
                     // Wrong type
                  }
               } catch (VartypeException e) {
                  e.printStackTrace();
               }
            }
         });
      } catch (VartypeException e) {
         e.printStackTrace();
      }
   }

   private void initStartByZeroRenderer() {
      if (!rendererInitDone) {
         analogBarActValue.setProgressRenderer(new AnalogBarRendererStartByZero(analogBarActValue));
         rendererInitDone = true;
      }
   }
}
