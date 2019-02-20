package composite.PumpSelectionPanel;

import java.util.Locale;

import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.utils.UncheckedException;

import composite.PumpSelector.PumpSelector;

public class PumpSelectionPanel extends PumpSelectionPanel_generated {
   private static final long serialVersionUID = 1L;
   private static final String PUMP_CONNECTION_MOVEMENTS = "system.sv_PumpConnectionList.Movements";
   private static final String PUMP_CONNECTION_COUNT = "system.sv_PumpConnectionList.iCount";

   private int idxMin = 0;
   private int idxMax = 0;
   private PumpSelector[] pumpSelectors;
   private int pumpConnectionCount;

   public PumpSelectionPanel() throws Exception {
      super();
   }

   /**
    * Set minimum index.
    */
   public void setIdxMinComp(int idxMin) {
      this.idxMin = idxMin;
      initPumpSelectors();
   }

   /**
    * Set maximum index.
    */
   public void setIdxMaxComp(int idxMax) {
      this.idxMax = idxMax;
      initPumpSelectors();
   }

   private void initPumpSelectors() {
      if (idxMin <= 0 || idxMax <= 0) {
         return;
      }

      if (idxMin > idxMax) {
         throw new UncheckedException("Invalid pump selection min or max index", null);
      }

      pumpSelectors = new PumpSelector[12];
      pumpSelectors[0] = pumpSelector1;
      pumpSelectors[1] = pumpSelector2;
      pumpSelectors[2] = pumpSelector3;
      pumpSelectors[3] = pumpSelector4;
      pumpSelectors[4] = pumpSelector5;
      pumpSelectors[5] = pumpSelector6;
      pumpSelectors[6] = pumpSelector7;
      pumpSelectors[7] = pumpSelector8;
      pumpSelectors[8] = pumpSelector9;
      pumpSelectors[9] = pumpSelector10;
      pumpSelectors[10] = pumpSelector11;
      pumpSelectors[11] = pumpSelector12;

      try {
         HmiVariableService varService = HmiVariableService.getService();
         KVariable pumpConnectionCountVar = varService
               .getVariable(PUMP_CONNECTION_COUNT);
         varService.readValue(pumpConnectionCountVar);
         pumpConnectionCount = pumpConnectionCountVar.getIntValue();

         int idxPumpSel = 0;
         for (int idxArray = idxMin; idxArray <= idxMax; idxArray++) {
            if (idxArray <= pumpConnectionCount) {
               // Set "use" variables to pump selector
               String requiredPumpArrayPath = PUMP_CONNECTION_MOVEMENTS + "[" + idxArray + "]^.RequiredPumps";
               pumpSelectors[idxPumpSel].setVariableUsePump1Comp(requiredPumpArrayPath + "[1]");
               pumpSelectors[idxPumpSel].setVariableUsePump2Comp(requiredPumpArrayPath + "[2]");
               pumpSelectors[idxPumpSel].setVariableUsePump3Comp(requiredPumpArrayPath + "[3]");
            } else {
               // Remove pump selector from panel
               pumpSelectors[idxPumpSel].getParent().remove(pumpSelectors[idxPumpSel]);
            }
            idxPumpSel++;
         }

         updateTitle();
      } catch (Exception e) {
         throw new UncheckedException("", e);
      }
   }

   private void updateTitle() {
      // Set title text depending on min and max indices
      String newTitle = borderPanel1.getTitle();
      int idxLast = Math.min(idxMax, pumpConnectionCount);
      if (idxMin == idxLast) {
         newTitle = newTitle + " " + idxMin;
      } else {
         newTitle = newTitle + " " + idxMin + "-" + idxLast;
      }

      borderPanel1.setTitleString(newTitle);
   }

   public void changeLocale(Locale locale) {
      super.changeLocale(locale);
      updateTitle();
   }
}
