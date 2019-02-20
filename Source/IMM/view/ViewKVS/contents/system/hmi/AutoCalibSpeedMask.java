package system.hmi;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.util.Locale;

import com.keba.kemro.kv.widgets.scroll.KvScrollPanel;
import com.keba.kemro.kvs.keplast.calibration.autocalib.util.IConstantsCalibration;
import com.keba.kemro.kvs.keplast.calibration.autocalib.util.IdentSpeedManager;
import com.keba.kemro.kvs.keplast.calibration.autocalib.widgets.CalibStartStopText;
import com.keba.kemro.kvs.keplast.general.util.KPResourceBundle;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KNumber;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.general.PlastConstants;

public class AutoCalibSpeedMask extends AutoCalibSpeedMask_generated implements ValueChangedListener, IConstantsCalibration {
   private static final long serialVersionUID = 1L;
   public static String sRESOURCE_BUNDLE = "com.keba.kemro.kvs.keplast.calibration.text.Calibration_texts";
   protected KPResourceBundle textBundle = KPResourceBundle.getBundle(sRESOURCE_BUNDLE);

   // states, commands
   protected KVariable kvarGeneralStatusMax;
   protected KVariable kvarGeneralStatusMin;

   protected IdentSpeedManager identMaxSpeedManager = new IdentSpeedManager();
   protected IdentSpeedManager identMinSpeedManager = new IdentSpeedManager();
   private CalibStartStopText maxCalibStartStopText = new CalibStartStopText();
   private CalibStartStopText minCalibStartStopText = new CalibStartStopText();

   public AutoCalibSpeedMask() throws Exception {
      super();

      maxSpeedOutputPanel();
      minSpeedOutputPanel();
      try {
         kvarGeneralStatusMax = hmiService.getVariable("AutoCalibration1.sv_GlobalIdentMaxSpeedStatus.Status");
         HmiVariableService.registerVariable(kvarGeneralStatusMax, null, this, KNumber.class);

         kvarGeneralStatusMin = hmiService.getVariable("AutoCalibration1.sv_GlobalIdentMinSpeedStatus.Status");
         HmiVariableService.registerVariable(kvarGeneralStatusMin, null, this, KNumber.class);

      } catch (Exception ex) {
         LOG_AC.error("AutoIdentSpeedMask: error in registering variables - " + ex.getMessage());
         if (bDEBUG_AUTO_CALIB)
            ex.printStackTrace();
      }

      // vpl3
      if (PlastConstants.isVPL3()) {
         this.setBackground(PlastConstants.COL_BG_PANEL);
      }
   }

   private void maxSpeedOutputPanel() {
      // start button and text
      speedStartButtonTextPanel.setPreferredSize(new Dimension(-1, 110));
      maxCalibStartStopText.setVariable("sv_GlobalIdentMaxSpeedStatus");
      speedStartButtonTextPanel.add(maxCalibStartStopText);

      // movements
      identMaxSpeedManager.readConfiguration("sv_GlobalIdentMaxSpeedStatus");
      identMaxSpeedManager.setTitleTexts(textBundle.getString("ltxtForward"), textBundle.getString("ltxtBackward"));
      KvScrollPanel scrollSpeedMovementsPanel = new KvScrollPanel(identMaxSpeedManager.getDevicesContainer(), false);
      speedMovementsPanel.add(scrollSpeedMovementsPanel, BorderLayout.CENTER);

   }

   private void minSpeedOutputPanel() {
      // start button and text
      minSpeedStartButtonTextPanel.setPreferredSize(new Dimension(-1, 110));
      minCalibStartStopText.setVariable("sv_GlobalIdentMinSpeedStatus");
      minSpeedStartButtonTextPanel.add(minCalibStartStopText);

      // movements
      identMinSpeedManager.readConfiguration("sv_GlobalIdentMinSpeedStatus");
      identMinSpeedManager.setTitleTexts(textBundle.getString("ltxtForward"), textBundle.getString("ltxtBackward"));
      KvScrollPanel scrollSpeedMovementsPanel = new KvScrollPanel(identMinSpeedManager.getDevicesContainer(), false);
      minSpeedMovementsPanel.add(scrollSpeedMovementsPanel, BorderLayout.CENTER);
   }

   /**
    * Reaction on a valueChanged event Changes to next mask
    * 
    * @param e
    *           ValueChanged event
    */
   public void valueChanged(ValueChangedEvent event) {
      int iState = 0;

      if (event.getReason() != ValueChangedEvent.VALUE_CHANGED)
         return;

      try {

         KVariable kvar = event.getVariable();
         if (kvar.equals(kvarGeneralStatusMax)) {
            iState = kvarGeneralStatusMax.getIntValue();
            if (iState == CALIB_STATE_RUNNING) {
               identMaxSpeedManager.disableRedoButtons();
            } else {
               identMaxSpeedManager.enableRedoButtons();
            }
         }
      } catch (Exception ex) {
         if (bDEBUG_AUTO_CALIB)
            ex.printStackTrace();
         LOG_AC.error("AutoIdentSpeedMask: " + ex.getMessage());
      }
   }

   /**
    * @see com.keba.kemro.kv.control.KvMask#changeLocale(java.util.Locale)
    */
   public void changeLocale(Locale locale) {
      super.changeLocale(locale);

      try {
         textBundle = KPResourceBundle.getBundle(sRESOURCE_BUNDLE, locale);
         identMaxSpeedManager.setTitleTexts(textBundle.getString("ltxtForward"), textBundle.getString("ltxtBackward"));
         identMinSpeedManager.setTitleTexts(textBundle.getString("ltxtForward"), textBundle.getString("ltxtBackward"));

         maxCalibStartStopText.changeLocale(locale);
         minCalibStartStopText.changeLocale(locale);

      } catch (Exception ex) {
         CAT.warn("Error during language change", ex);
      }

   }

}
