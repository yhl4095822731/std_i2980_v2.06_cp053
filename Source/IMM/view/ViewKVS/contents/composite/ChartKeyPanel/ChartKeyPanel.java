package composite.ChartKeyPanel;

import java.awt.CardLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Locale;
import java.util.ResourceBundle;
import com.keba.kemro.kv.util.KvConstants;
import com.keba.kemro.kv.util.KvLanguageManager;
import com.keba.kemro.kv.widgets.KvButton;
import com.keba.kemro.kv.widgets.KvPopupMenu;
import com.keba.kemro.kvs.widgets.KvsActionButton;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.utils.UncheckedException;
import com.keba.keplast.widgets.chart.KvsChart;
import com.keba.keplast.widgets.chart.KvsMsChart;
import com.keba.util.ImageLoader;

public class ChartKeyPanel extends ChartKeyPanel_generated {
   private static final long serialVersionUID = 1L;

   private final static String mActivateKeyResourceBundleName = "com.keba.kemro.view2serv2Tx";
   private final static String[] mActivateKeyTextKeys = new String[] { "measure_stop1", "measure_start1" };

   private CardLayout mCardLayout;
   private KvsMsChart mChart;
   private KVariable mActivateVariable;
   protected int mActivateKeyState;

   public ChartKeyPanel() throws Exception {
      super();
      mCardLayout = new CardLayout();
      setLayout(mCardLayout);
      mCardLayout.first(this);

      /* create popup view */
      setToggleState(btnActValue, false);
      setToggleState(btnMaximize, false);
      createPopup(btnViewPopup, new KvButton[] {
            btnActValue,
            btnMaximize
      });

      createPopup(btnZoomPopup, new KvButton[] {
            btnZoomX100,
            btnZoomY100,
            btnZoomXAuto,
            btnZoomYAuto
      });

      updateActivateKeyText();
   }

   public void setActivateVariable(String varName) {
      if (mActivateVariable != null)
         throw new IllegalStateException("variable already set!");

      btnActivate.setEnabled(true);

      try {

         mActivateVariable = HmiVariableService.registerVariable(varName, new ValueChangedListener() {
            public void valueChanged(ValueChangedEvent event) {
               try {
                  mActivateKeyState = event.getVariable().getIntValue();
                  updateChartHoldMode();
               }
               catch (VartypeException e) {
                  throw new UncheckedException("", e);
               }
            }
         });
      } catch (Exception e) {
         throw new UncheckedException("could not set variable", e);
      }
   }

   private void setToggleState(KvsActionButton btn, boolean state) {
      btn.setImagePosition(KvConstants.LEFT_MIDDLE);
      if (state) {
         btn.setIcon(ImageLoader.loadStdIcon("checked.gif"));
      }
      else {
         btn.setIcon(ImageLoader.loadStdIcon("not_checked.gif"));
      }
   }

   public void setChart(KvsMsChart chart) {
      mChart = chart;
      maximize(true);
   }

   public void actionPerformed(ActionEvent ev) {
      Object src = ev.getSource();

      if (src == btnActivate) {
         mActivateKeyState = (mActivateKeyState + 1) % 2; // Toggle active state
         updateActivateState();
      }
      else if (src == btnMaximize) {
         boolean stateMaximized = !mChart.isVisible(KvsChart.COMPID_KEYS);
         stateMaximized = !stateMaximized;
         maximize(stateMaximized);
      }
      else if (src == btnActValue) {
         boolean stateCursor = mChart.isCursorOn();
         stateCursor = !stateCursor;
         setToggleState(btnActValue, stateCursor);
         mChart.setCursorOn(stateCursor);
      }
      else if (src == btnZoomXOut) {
         mChart.zoom(true, false, false, true);
      }
      else if (src == btnZoomXIn) {
         mChart.zoom(true, false, true, true);
      }
      else if (src == btnZoomYOut) {
         mChart.zoom(false, true, false, true);
      }
      else if (src == btnZoomYIn) {
         mChart.zoom(false, true, true, true);
      }
      else if (src == btnCursorLeft) {
         mChart.moveCursor(KvsChart.SCROLLDIRECTION_LEFT, KvsChart.SCROLLMODE_PAGE, true);
      }
      else if (src == btnCursorRight) {
         mChart.moveCursor(KvsChart.SCROLLDIRECTION_RIGHT, KvsChart.SCROLLMODE_PAGE, true);
      }
      else if (src == btnZoomX100) {
         mChart.zoomDefault(true, false, true);
      }
      else if (src == btnZoomY100) {
         mChart.zoomDefault(false, true, true);
      }
      else if (src == btnZoomXAuto) {
         mChart.zoomAutoRange(true, false, true);
      }
      else if (src == btnZoomYAuto) {
         mChart.zoomAutoRange(false, true, true);
      }

   }

   private void maximize(boolean on) {
      setToggleState(btnMaximize, on);
      mChart.setVisible(!on, KvsChart.COMPID_KEYS, true);
   }

   private KvPopupMenu createPopup(final KvsActionButton mainButton, KvButton[] subButtons) {
      mainButton.setImagePosition(KvConstants.LEFT_MIDDLE);
      mainButton.setIcon(ImageLoader.loadStdIcon("upmenu32.gif"));

      final KvPopupMenu popUp = new KvPopupMenu();
      popUp.setAutoClose(true);

      mainButton.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            popUp.show(mainButton);
         }
      });

      ActionListener closeListener = new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            popUp.close();
         }
      };

      for (int i = 0; i < subButtons.length; i++) {
         popUp.add(subButtons[i]);
         subButtons[i].addActionListener(closeListener);
      }

      return popUp;
   }

   private void updateActivateKeyText() {
      String text = null;
      try {
         ResourceBundle res = ResourceBundle.getBundle(mActivateKeyResourceBundleName, KvLanguageManager.sharedInstance().getLanguage()
               .getLocale());
         text = res.getString(mActivateKeyTextKeys[mActivateKeyState]);
      } catch (Exception e) {
         text = "???";
      }
      btnActivate.setText(text);
      btnActivate.repaint();
   }

   /**
    * Updates activate state variable (if available) and also chart hold mode.
    */
   private void updateActivateState() {
      if (hasActivateVariable()) {
         updateActivateStateVariable();
      }

      updateChartHoldMode();
   }

   /**
    * Updates the hold mode of the chart depending on active state
    */
   private void updateChartHoldMode() {
      if (mChart != null) {
         mChart.setHold(mActivateKeyState != 0);
      }
      updateActivateKeyText();
   }

   /**
    * Updates the hold mode of the chart depending on internal and external active state
    */
   private void updateActivateStateVariable() {
      try {
         HmiVariableService.getService().writeValue(mActivateVariable, new Boolean(mActivateKeyState != 0));
      } catch (Exception e) {
         throw new UncheckedException("cannot write variable value", e);
      }
   }

   private boolean hasActivateVariable() {
      return mActivateVariable != null;
   }

   public void changeLocale(Locale locale) {
      updateActivateKeyText();
      super.changeLocale(locale);
   }

}
