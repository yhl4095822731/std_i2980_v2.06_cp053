package system.hmi;

import java.util.Vector;

import com.keba.keplast.odc.model.core.Aggregate;
import com.keba.keplast.odc.panels.sequence.safety.ConditionPosition;
import com.keba.keplast.odc.panels.sequence.safety.ISafetyCondition;
import com.keba.keplast.odc.panels.sequence.safety.ISafetyConditionFactory2;
import com.keba.keplast.odc.panels.sequence.safety.MovementDirection;
import com.keba.keplast.odc.panels.sequence.safety.SafetyCondition;
import com.keba.keplast.odc.utils.IMessageProvider;

/**
 * Factory class for creating standard sequencer safety conditions.
 *
 */
public class SequencerSafetyConditionFactory implements ISafetyConditionFactory2 {
	
	/**
	 * Default constructor
	 */
	public SequencerSafetyConditionFactory() {
	}

	public ISafetyCondition[] getSafetyConditions(Aggregate[] aggregates) {	
		
		Vector vConditions = new Vector();
			
		// Safety conditions for mold, ejector and cores are not relevant any more for new sequencer.
		// -> Check conditions for auto safety gate only!
      //		vConditions.addElement(new SafetyCondition("Mold1", MovementDirection.CLOSE, "Ejector1", ConditionPosition.EJECTOR_BACKWARD, "SafetyDialog.MessageDetail.EjectorBwdMoldClose"));
      //		vConditions.addElement(new SafetyCondition("Ejector1", MovementDirection.FORWARD, "Mold1", ConditionPosition.BACKWARD, "SafetyDialog.MessageDetail.MoldOpenCoreNotOutEjectorForward"));
      //		// create conditions for cores
      //		for (int i = 0; i < aggregates.length; i++) {
      //			String name = aggregates[i].getName();
      //			if (name.startsWith("Core")) {
      //				// for ejector forward or backward all cores have to be out
      //				vConditions.addElement(new SafetyCondition("Ejector1", MovementDirection.FORWARD, name, ConditionPosition.CORE_OUT, "SafetyDialog.MessageDetail.MoldOpenCoreNotOutEjectorForward"));
      //				vConditions.addElement(new SafetyCondition("Ejector1", MovementDirection.BACKWARD, name, ConditionPosition.CORE_OUT, "SafetyDialog.MessageDetail.CoreNotOutEjectorBwd"));
      //				// ejector has to be backward for all core movements
      //				vConditions.addElement(new SafetyCondition(name, MovementDirection.IN, "Ejector1", ConditionPosition.EJECTOR_BACKWARD, "SafetyDialog.MessageDetail.EjectorNotBwdCoreIn"));
      //				vConditions.addElement(new SafetyCondition(name, MovementDirection.OUT, "Ejector1", ConditionPosition.EJECTOR_BACKWARD, "SafetyDialog.MessageDetail.EjectorNotBwdCoreIn"));
      //			}
      //		}
		
		// automatic safety gate
		if (MachineEquipment.doesDeviceExist("SafetyGateAuto1")) {
			vConditions.addElement(new SafetyCondition("SafetyGateAuto1", MovementDirection.OPEN, "SafetyGateAuto1", ConditionPosition.AVAILABLE, "SafetyDialog.MessageDetail.SafetyGateAutoOpenProgrammed"));
			vConditions.addElement(new SafetyCondition("SafetyGateAuto1", MovementDirection.CLOSE, "SafetyGateAuto1", ConditionPosition.AVAILABLE, "SafetyDialog.MessageDetail.SafetyGateAutoOpenProgrammed"));
		}
		
		// create an array for return
		ISafetyCondition[] conditions = new SafetyCondition[vConditions.size()]; 
		vConditions.copyInto(conditions);
		return conditions;
	}
	
	public String getLocalizedMessageString(IMessageProvider messageProvider, ISafetyCondition[] conditionsNotOk) {
		// Build detailed error message
		StringBuffer buffer = new StringBuffer();
		buffer.append(messageProvider.getString("SafetyDialog.Message2"));
		String text = null;
		for (int i = 0; i < conditionsNotOk.length; i++) {
			text = conditionsNotOk[i].getTranslatedErrorMessage(messageProvider);
			if (buffer.toString().indexOf(text) < 0) {
				buffer.append("\n  * ");
				buffer.append(text);
			}
		}
		return buffer.toString();
	}
	
	public String getLocalizedMessageString(IMessageProvider messageProvider) {
		return messageProvider.getString("SafetyDialog.Message");
	}
	
}
