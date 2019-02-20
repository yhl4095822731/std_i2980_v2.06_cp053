package Drive.hmi;

import com.keba.keplast.general.PlastConstants;
import com.keba.keplast.widgets.chart.KvsChart;
import com.keba.keplast.widgets.chart.vis.KeyPanelLayout;
import com.keba.keplast.widgets.chart.vis.KvsChartScrollBar;

public class PQChart extends PQChart_generated {
   private static final long serialVersionUID = 1L;

   public PQChart() throws Exception {
      super();
   }

   void Init_Generated() throws Exception {
      if ((mmsChartMovementsCtrl != null) && (mmsChartCtrl != null)) {
         mmsChartCtrl.setUpdateCycleTime(200);
         mmsChartMovementsCtrl.setUpdateCycleTime(200);
         mmsChartMovementsCtrl.setCreateComponent(false, KvsChart.COMPID_RULERX);
         mmsChartMovementsCtrl.setCreateComponent(false, KvsChart.COMPID_RULERY_RIGHT);
         mmsChartMovementsCtrl.setCreateComponent(false, KvsChart.COMPID_RULERY_LEFT);
         initCurveColorsChart();
      }
      super.Init_Generated();

      if ((mmsChartMovementsCtrl != null) && (mmsChartCtrl != null)) {
         mmsChartCtrl.setXAxisSlave(mmsChartMovementsCtrl);
         mmsChartMovementsCtrl.setKeyDisplayMode(KeyPanelLayout.eKeySizeSmall);
         mmsChartMovementsCtrl.setScrollBarVisibilityMode(KvsChartScrollBar.VISMODE_NEVER, KvsChartScrollBar.VISMODE_NEVER);
         
         chartKeyPanel.setChart(mmsChartCtrl);
         chartKeyPanel.setActivateVariable("PDP1.sv_bPQChartHoldRun");
        }
   }

   private void initCurveColorsChart() {
      // chart 1
      mmsChartCtrl.setCurveColor(0, PlastConstants.COL_PLAST_GREEN);
      mmsChartCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
      mmsChartCtrl.setCurveColor(2, PlastConstants.COL_PLAST_DARKGRAY);
      mmsChartCtrl.setCurveColor(3, PlastConstants.COL_PLAST_YELLOW);
      try {
         mmsChartCtrl.setCurveColor(4, PlastConstants.COL_PLAST_RED);
         mmsChartCtrl.setCurveColor(5, PlastConstants.COL_ORANGE);
      } catch (Exception ex) {
         // curves are optional
      }
      
      // chart 2
      mmsChartMovementsCtrl.setCurveColor(0, PlastConstants.COL_GREEN_DARKER);
      mmsChartMovementsCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
      mmsChartMovementsCtrl.setCurveColor(2, PlastConstants.COL_PLAST_DARKGRAY);
      mmsChartMovementsCtrl.setCurveColor(3, PlastConstants.COL_PLAST_YELLOW);
   }

 
}
