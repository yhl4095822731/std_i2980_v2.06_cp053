package composite.SingleCoreStateHorizontal;

import com.keba.kemro.kv.util.KvConstants;
import com.keba.kemro.kvs.keplast.general.BaseMachineEquipment;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;

public class SingleCoreStateHorizontal extends SingleCoreStateHorizontal_generated implements ValueChangedListener {
	private static final long serialVersionUID = 1L;
   final private String sv_CoreSelector = "CoreSelector.sv_iSelector";
   private int deviceId;

	public SingleCoreStateHorizontal() throws Exception {
		super();
	}

	public void setDeviceIdCoreComp(int iDeviceId) {
		super.setDeviceIdCoreComp(iDeviceId);
		this.deviceId = iDeviceId;
		
		labelId.setText(String.valueOf(iDeviceId));
		markCoreIn.setVariable("Core" + iDeviceId + ".sv_bCoreIn");
		markCoreOut.setVariable("Core" + iDeviceId + ".sv_bCoreOut");
		
		
		if (BaseMachineEquipment.doesDeviceExist(sv_CoreSelector)){
         try {
            HmiVariableService.registerVariable(sv_CoreSelector, this);
      
         } catch (Exception e) {
            e.printStackTrace();
         }
      
		}

	}

	/**
	 * If the selected core (CoreSelector-SV) is related to the deviceID of this widget, highlight the corresponding core.
	 * If this widget does not contain the corresponding core then remove the selection if it was selected previously or do nothing if
	 * it was not selected previously.
	 */
   public void valueChanged(ValueChangedEvent event) {
      KVariable varTemp = (KVariable)event.getSource();
      int value = -1;
      try {
         value = varTemp.getIntValue();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      if (value == deviceId){
         labelId.getParent().setBackground(KvConstants.COL_FG_SELECTED);
         labelId.getParent().repaint();
      }else{
         if (labelId.getParent().getBackground() == KvConstants.COL_FG_SELECTED){
            labelId.getParent().setBackground(null);
            labelId.getParent().repaint();
         }
      }
      
   }
}
