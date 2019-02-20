package Drive.hmi;

import java.util.Locale;
import java.util.ResourceBundle;
import com.keba.keplast.general.PlastConstants;

public class DriveTempChart extends DriveTempChart_generated {
   private static final long serialVersionUID = 1L;

   public DriveTempChart() throws Exception {
      super();
   }

   void Init_Generated() throws Exception {
      if (mmsChartCtrl != null) {
         mmsChartCtrl.setUpdateCycleTime(200);
         initCurveColorsChart();
         updateDescriptionTexts(locale);
      }
      super.Init_Generated();

      if (mmsChartCtrl != null) {
         chartKeyPanel.setChart(mmsChartCtrl);
      }
   }

   private void initCurveColorsChart() {
      mmsChartCtrl.setCurveColor(0, PlastConstants.COL_PLAST_GREEN);
      mmsChartCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
      try {
         mmsChartCtrl.setCurveColor(2, PlastConstants.COL_PLAST_DARKGRAY);
         mmsChartCtrl.setCurveColor(3, PlastConstants.COL_PLAST_YELLOW);
         mmsChartCtrl.setCurveColor(4, PlastConstants.COL_PLAST_RED);
         mmsChartCtrl.setCurveColor(5, PlastConstants.COL_ORANGE);
      }
      catch (Exception ex) {
         // curves are optional
      }
   }
   
   private void updateDescriptionTexts(Locale loc) {
      ResourceBundle res = ResourceBundle.getBundle("Drive.hmi.text.DriveTempChart_CurveTexts", loc);
      for (int i = 0; i < 6; i++) {
         try {
            mmsChartCtrl.setCurveDescriptionText(i, res.getString("Curve" + i));
         }
         catch (Exception e) {
            mmsChartCtrl.setCurveDescriptionText(i, "---");
         }
      }
   }

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);
      updateDescriptionTexts(locale);
   }

}
