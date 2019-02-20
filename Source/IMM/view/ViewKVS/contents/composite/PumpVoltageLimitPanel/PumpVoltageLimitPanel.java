package composite.PumpVoltageLimitPanel;

import java.util.Locale;

public class PumpVoltageLimitPanel extends PumpVoltageLimitPanel_generated {
   private static final long serialVersionUID = 1L;

   private int pumpIdx = 0;

   public PumpVoltageLimitPanel() throws Exception {
      super();
   }

   public void setIdxComp(int index) {
      super.setIdxComp(index);
      pumpIdx = index;
      updateTitle();
   }

   private void updateTitle() {
      // Set title text depending on pump index
      if (pumpIdx == 0) {
         return;
      }
      String newTitle = borderPanel1.getTitle() + " " + pumpIdx;
      borderPanel1.setTitleString(newTitle);
   }

   public void changeLocale(Locale locale) {
      super.changeLocale(locale);
      updateTitle();
   }
}
