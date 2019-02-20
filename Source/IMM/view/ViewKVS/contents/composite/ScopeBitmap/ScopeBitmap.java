package composite.ScopeBitmap;

import com.ibm.log4j.Category;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;

public class ScopeBitmap extends ScopeBitmap_generated {
   // due to compatibility with KVB, we update the scope state icons manually and don't use a symbol display overlay
	private static final long serialVersionUID = 1L;
	private final String VAR_PATH_SCOPE_MEASURE_STATE = "Scope.sv_iMeasureState";
	private Category CAT;
	
   
	public ScopeBitmap() throws Exception {
		super();		
		CAT = Category.getInstance(getClass().getName());
      try {
         initVariables();
      }
      catch (Exception ex) {
         CAT.error("constructor (ScopeBitmap): ", ex);
      }
	}
	
   private void initVariables() {
      try {
         HmiVariableService.registerVariable(VAR_PATH_SCOPE_MEASURE_STATE, new ValueChangedListener() {
            public void valueChanged(ValueChangedEvent event) {
               try {
                  updateBitmap(event.getVariable().getIntValue());
               }
               catch (Exception ex) {
                  CAT.error("valueChanged (ScopeBitmap): ", ex);
               }
            }
         });
      }
      catch (Exception ex) {
         CAT.error("initVariables (ScopeBitmap): ", ex);
      }
   }
	
	
	private void updateBitmap(int measureState) {
      String iconPath;
      switch(measureState)
      {
      case 1:
         iconPath = "Scope.hmi.images.scope_ready.gif";
         break;
      case 2:
         iconPath = "Scope.hmi.images.scope_rec.gif";
         break;
      case 3:
      case 4:
      case 5:
         iconPath = "Scope.hmi.images.scope_save.gif";
         break;
      default:
         iconPath = "composite/ScopeBitmap/images/movNoMove.gif";
      }
      // set icon
      bmpState.setIconName(iconPath);
      bmpState.repaint();
   }	
}
