package Energy.hmi;

import java.io.File;
import com.keba.kemro.kv.util.KvToolkit;
import com.keba.kemro.kvs.control.PrintAction;
import com.keba.kemro.kvs.control.PrintAction.Action;
import com.keba.kemro.kvs.print.PrinterSettings;
import com.keba.keplast.general.PlastConstants;
import com.keba.keplast.widgets.chart.KvsChart;
import com.keba.keplast.widgets.chart.vis.KeyPanelLayout;
import com.keba.keplast.widgets.chart.vis.KvsChartScrollBar;

public class EnergyCycleChart extends EnergyCycleChart_generated {
   private static final long serialVersionUID = 1L;

   public EnergyCycleChart() throws Exception {
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
         chartKeyPanel.setActivateVariable("PDP1.sv_bEnergyCycleHoldRun");
      }
   }

   private void initCurveColorsChart() {
      // chart 1
      mmsChartCtrl.setCurveColor(0, PlastConstants.COL_BLUE);
      mmsChartCtrl.setCurveColor(1, PlastConstants.COL_PLAST_RED);
      mmsChartCtrl.setCurveColor(2, PlastConstants.COL_PLAST_GREEN);
      
      // chart 2
      mmsChartMovementsCtrl.setCurveColor(0, PlastConstants.COL_GREEN_DARKER);
      mmsChartMovementsCtrl.setCurveColor(1, PlastConstants.COL_BLUE);
      mmsChartMovementsCtrl.setCurveColor(2, PlastConstants.COL_PLAST_DARKGRAY);
      mmsChartMovementsCtrl.setCurveColor(3, PlastConstants.COL_PLAST_YELLOW);
   }
   
   protected void printScreen() {
      
      System.out.println("printScreen-----------------------------------------");
      if (!KvToolkit.isVxWorks()) return;
      Action printAction;

      PrinterSettings printSettings = null;
      printAction = PrintAction.getInstance().getFramePrintAction();

      printSettings = PrinterSettings.getSettings();
      printSettings.setPrintToFile(true);
      printSettings.setImageDir(new File("/harddisk0/"));
      printSettings.setImageFileName("chartenergy");
      printAction.actionPerformed(null);
      
   }


}
