package composite.PumpSelector;

public class PumpSelector extends PumpSelector_generated {
   private static final long serialVersionUID = 1L;

   public PumpSelector() throws Exception {
      super();
   }

   public void setVariableUsePump2Comp(String varName) {
      if (checkBoxUsePump2 != null) {
         super.setVariableUsePump2Comp(varName);
      }
   }

   public void setVariableUsePump3Comp(String varName) {
      if (checkBoxUsePump3 != null) {
         super.setVariableUsePump3Comp(varName);
      }
   }
}
