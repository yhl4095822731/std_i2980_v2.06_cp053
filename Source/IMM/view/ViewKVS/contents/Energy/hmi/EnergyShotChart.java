package Energy.hmi;

import com.keba.keplast.general.PlastConstants;

public class EnergyShotChart extends EnergyShotChart_generated {
   private static final long serialVersionUID = 1L;

   public EnergyShotChart() throws Exception {
      super();
   }

   void Init_Generated() throws Exception {
      if (mmsChartCtrl != null) {
         mmsChartCtrl.setUpdateCycleTime(200);
         initCurveColorsChart();
      }
      super.Init_Generated();

      if (mmsChartCtrl != null) {
         chartKeyPanel.setChart(mmsChartCtrl);
      }
   }
   
   private void initCurveColorsChart() {
      mmsChartCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
   }

}
