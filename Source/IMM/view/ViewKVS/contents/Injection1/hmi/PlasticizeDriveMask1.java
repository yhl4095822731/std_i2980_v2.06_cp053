package Injection1.hmi;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.PlastConstants;
import com.keba.keplast.utils.UncheckedException;
import com.keba.keplast.widgets.chart.KvsMsChart;

public class PlasticizeDriveMask1 extends PlasticizeDriveMask1_generated {
   private static final long serialVersionUID = 1L;

   private KVariable mTriggerVarPlast;

   public PlasticizeDriveMask1() throws Exception {
      super();

   }

   void Init_Generated() throws Exception {
      if (mmsChartPlastCtrl != null) {
         mmsChartPlastCtrl.setUpdateCycleTime(200);
         initCurveColorsChart(mmsChartPlastCtrl);
      }

      super.Init_Generated();

      if (mmsChartPlastCtrl != null) {
         chartKeyPanelPlast.setChart(mmsChartPlastCtrl);
         chartKeyPanelPlast.setActivateVariable("Injection1.sv_bDriveChartPlastHoldRun");

         // Init charts with single shot trigger mode.
         // Charts will only draw measurements of one direction.
         mmsChartPlastCtrl.activateSingleShotTriggerMode();
         try {

            mTriggerVarPlast = HmiVariableService.getService().getVariable("Injection1.sv_bPlastActive");
            mTriggerVarPlast.addListener(new TriggerChangedListener());

            // Trigger charts always, even if mask is not open!
            HmiVariableService.getService().startRefresh(new KVariable[] { mTriggerVarPlast });
         } catch (Exception e) {
            throw new UncheckedException("could not register trigger variable for drive chart", e);
         }
      }
   }

   private void initCurveColorsChart(KvsMsChart chartCtrl) {
      try {
         chartCtrl.setCurveColor(0, PlastConstants.COL_PLAST_GREEN);
         chartCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
         chartCtrl.setCurveColor(2, PlastConstants.COL_PLAST_DARKGRAY);
         chartCtrl.setCurveColor(3, PlastConstants.COL_PLAST_YELLOW);
         // chartCtrl.setCurveColor(4, PlastConstants.COL_PLAST_RED);
         // chartCtrl.setCurveColor(5, PlastConstants.COL_ORANGE);
      } catch (Exception ex) {
         // curves are optional
      }
   }

   /**
    * Reacts on rising edge of a variable and arms the chart trigger for one single measurement.
    * 
    * @author steg
    * 
    */
   private class TriggerChangedListener implements ValueChangedListener {

      public void valueChanged(ValueChangedEvent event) {
         try {
            if (event.getVariable() == mTriggerVarPlast) {
               if (mTriggerVarPlast.getBooleanValue()) {
                  mmsChartPlastCtrl.armSingleShotTrigger();
               }
            } else {
               // Nothing to do
            }

         } catch (VartypeException e) {
            throw new UncheckedException("", e);
         }
      }
   }
}
