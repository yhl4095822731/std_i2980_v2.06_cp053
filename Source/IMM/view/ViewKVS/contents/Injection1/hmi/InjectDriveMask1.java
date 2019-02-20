package Injection1.hmi;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.PlastConstants;
import com.keba.keplast.utils.UncheckedException;
import com.keba.keplast.widgets.chart.KvsMsChart;

public class InjectDriveMask1 extends InjectDriveMask1_generated {
   private static final long serialVersionUID = 1L;

   private KVariable mTriggerVarInject;

   public InjectDriveMask1() throws Exception {
      super();
   }

   void Init_Generated() throws Exception {
      if (mmsChartInject1Ctrl != null) {
         mmsChartInject1Ctrl.setUpdateCycleTime(200);
         initCurveColorsChart(mmsChartInject1Ctrl);
      }

      // Optional chart inject axis 2
      if (mmsChartInject2Ctrl != null) {
         mmsChartInject2Ctrl.setUpdateCycleTime(200);
         initCurveColorsChart(mmsChartInject2Ctrl);
      }

      super.Init_Generated();

      if (mmsChartInject1Ctrl != null) {
         chartKeyPanelInject1.setChart(mmsChartInject1Ctrl);
         chartKeyPanelInject1.setActivateVariable("Injection1.sv_bDriveChartInject1HoldRun");

         // Init charts with single shot trigger mode.
         // Charts will only draw measurements of one direction.
         mmsChartInject1Ctrl.activateSingleShotTriggerMode();
         try {

            mTriggerVarInject = HmiVariableService.getService().getVariable("Injection1.sv_bInjectActive");
            mTriggerVarInject.addListener(new TriggerChangedListener());

            // Trigger charts always, even if mask is not open!
            HmiVariableService.getService().startRefresh(new KVariable[] { mTriggerVarInject });
         } catch (Exception e) {
            throw new UncheckedException("could not register trigger variable for drive chart", e);
         }
      }

      // Optional chart inject axis 2
      if (mmsChartInject2Ctrl != null) {
         chartKeyPanelInject2.setChart(mmsChartInject2Ctrl);
         chartKeyPanelInject2.setActivateVariable("Injection1.sv_bDriveChartInject2HoldRun");

         // Init charts with single shot trigger mode.
         // Charts will only draw measurements of one direction.
         mmsChartInject2Ctrl.activateSingleShotTriggerMode();
      }

   }

   private void initCurveColorsChart(KvsMsChart chartCtrl) {
      try {
         chartCtrl.setCurveColor(0, PlastConstants.COL_PLAST_GREEN);
         chartCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
         chartCtrl.setCurveColor(2, PlastConstants.COL_PLAST_DARKGRAY);
         chartCtrl.setCurveColor(3, PlastConstants.COL_PLAST_YELLOW);
         chartCtrl.setCurveColor(4, PlastConstants.COL_PLAST_RED);
         chartCtrl.setCurveColor(5, PlastConstants.COL_ORANGE);
         chartCtrl.setCurveColor(6, PlastConstants.COL_BROWN);
         chartCtrl.setCurveColor(7, PlastConstants.COL_GREEN_LIGHT);
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
            if (event.getVariable() == mTriggerVarInject) {
               if (mTriggerVarInject.getBooleanValue()) {
                  mmsChartInject1Ctrl.armSingleShotTrigger();

                  // Optional chart inject axis 2
                  if (mmsChartInject2Ctrl != null) {
                     mmsChartInject2Ctrl.armSingleShotTrigger();
                  }
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
