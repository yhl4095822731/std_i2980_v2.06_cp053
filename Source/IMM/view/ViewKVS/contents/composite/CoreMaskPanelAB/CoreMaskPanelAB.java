package composite.CoreMaskPanelAB;

import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

import Core.hmi.ICoreModes;

import com.keba.kemro.kvs.keplast.general.BaseMachineEquipment;
import com.keba.kemro.kvs.widgets.KvsCheckBox;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.general.SequenceControlManager;
import com.keba.keplast.general.util.SequenceControlChangedEvent;
import com.keba.keplast.general.util.SequenceControlChangedListener;

public class CoreMaskPanelAB extends CoreMaskPanelAB_generated implements ItemListener,
		SequenceControlChangedListener, ICoreModes, ValueChangedListener {
	private static final long serialVersionUID = 1L;

	private static final HmiVariableService hmiService = HmiVariableService.getService();

	private KVariable kvarCoreModeTypeA = null;
	private KVariable kvarCoreModeTypeB = null;
	private KVariable kvarCoreModeInA = null;
	private KVariable kvarCoreModeInB = null;
	private KVariable kvarCoreModeOutA = null;
	private KVariable kvarCoreModeOutB = null;
	private KVariable kvarCoreHoldA = null;
	private KVariable kvarCoreHoldB = null;
	private KVariable kvarCoreControlInA = null;
	private KVariable kvarCoreControlInB = null;
	private KVariable kvarCoreControlOutA = null;
	private KVariable kvarCoreControlOutB = null;

	private int iCoreModeTypeA = 0;
	private int iCoreModeTypeB = 0;
	private int iCoreModeInA = 0;
	private int iCoreModeInB = 0;
	private int iCoreModeOutA = 0;
	private int iCoreModeOutB = 0;
	private int iCoreControlInA = 0;
	private int iCoreControlInB = 0;
	private int iCoreControlOutA = 0;
	private int iCoreControlOutB = 0;

	private boolean bEditorControlled = false;

	private boolean bUnitVariablesSet = false;

	private boolean bInitializedCoreA = false;
	private boolean bInitializedCoreB = false;

	public CoreMaskPanelAB() throws Exception {
		super();
		SequenceControlManager.getInstance().addListener(this);
	}

	public void setDeviceIdCoreAComp(int iDeviceIdCoreA) {
		super.setDeviceIdCoreAComp(iDeviceIdCoreA);
		if (iDeviceIdCoreA > 0 && BaseMachineEquipment.doesDeviceExist("Core" + iDeviceIdCoreA)) {
			// core device A does exist
			String sDeviceNameCoreA = "Core" + iDeviceIdCoreA;
			setVariablesToUnitFields(sDeviceNameCoreA, iDeviceIdCoreA);
			// core control fields
			numfieldPosActivateInA.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreA
					+ "].rCoreInPosition");
			numfieldPosMonitorInA.setVariable(sDeviceNameCoreA + ".sv_rCoreInMonitorPos");
			numfieldPosActivateOutA.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreA
					+ "].rCoreOutPosition");
			numfieldPosMonitorOutA.setVariable(sDeviceNameCoreA + ".sv_rCoreOutMonitorPos");
			selectListModeInA.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreA + "].InMode");
			selectListModeOutA.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreA + "].OutMode");
			// core settings fields
			selectListControlInA.setShowInvalidValues(false);
			selectListControlOutA.setShowInvalidValues(false);
			selectListControlInA.setVariable(sDeviceNameCoreA + ".sv_CoreMode.CoreControlIn");
			selectListControlOutA.setVariable(sDeviceNameCoreA + ".sv_CoreMode.CoreControlOut");
			numfieldPressureInA.setVariable(sDeviceNameCoreA
					+ ".sv_CoreOutput.NormalIn.Pressure.Output.rOutputValue");
			numfieldPressureOutA.setVariable(sDeviceNameCoreA
					+ ".sv_CoreOutput.NormalOut.Pressure.Output.rOutputValue");
			numfieldVelocityInA.setVariable(sDeviceNameCoreA
					+ ".sv_CoreOutput.NormalIn.Velocity.Output.rOutputValue");
			numfieldVelocityOutA.setVariable(sDeviceNameCoreA
					+ ".sv_CoreOutput.NormalOut.Velocity.Output.rOutputValue");

			numfieldSetTimeInA.setVariable(sDeviceNameCoreA + ".sv_CoreSetTimes.MoveIn.dSetMoveTime");
			numfieldActTimeInA.setVariable(sDeviceNameCoreA + ".sv_CoreActTimes.MoveIn.dActMoveTime");
			numfieldActTimeInA.setVariableMaximum(sDeviceNameCoreA + ".sv_CoreSetTimes.MoveIn.dSetMoveTime");
			numfieldSetTimeOutA.setVariable(sDeviceNameCoreA + ".sv_CoreSetTimes.MoveOut.dSetMoveTime");
			numfieldActTimeOutA.setVariable(sDeviceNameCoreA + ".sv_CoreActTimes.MoveOut.dActMoveTime");
			numfieldActTimeOutA.setVariableMaximum(sDeviceNameCoreA + ".sv_CoreSetTimes.MoveOut.dSetMoveTime");

			numfieldSetCountInA.setVariable(sDeviceNameCoreA + ".sv_CoreScrewSetValues.iSetRoundsCount");
			numfieldActCountInA.setVariable(sDeviceNameCoreA + ".sv_CoreScrewActValues.iActRoundsCount");
			numfieldActCountInA.setVariableMaximum(sDeviceNameCoreA + ".sv_CoreScrewSetValues.iSetRoundsCount");
			numfieldSetCountOutA.setVariable(sDeviceNameCoreA + ".sv_CoreScrewSetValues.iSetRoundsCount");
			numfieldActCountOutA.setVariable(sDeviceNameCoreA + ".sv_CoreScrewActValues.iActRoundsCount");
			numfieldActCountOutA.setVariableMaximum(sDeviceNameCoreA + ".sv_CoreScrewSetValues.iSetRoundsCount");

			try {
				kvarCoreModeTypeA = hmiService.getVariable(sDeviceNameCoreA + ".sv_CoreMode.CoreType");
				chkBoxUseCoreA.getVisiController().init(kvarCoreModeTypeA);
				setCheckboxStateByIntValue(chkBoxUseCoreA, kvarCoreModeTypeA.getIntValue());
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			try {
				kvarCoreHoldA = hmiService.getVariable(sDeviceNameCoreA + ".sv_CoreMode.Hold");
				chkboxCoreHoldInA.getVisiController().init(kvarCoreHoldA);
				setCheckboxStateByIntValue(chkboxCoreHoldInA, kvarCoreHoldA.getIntValue());

			} catch (Exception ex) {
				ex.printStackTrace();
			}
			chkBoxUseCoreA.addItemListener(this);
			chkboxCoreHoldInA.addItemListener(this);
			try {
				kvarCoreModeInA = hmiService.getVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreA
						+ "].InMode");
				kvarCoreModeOutA = hmiService.getVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreA
						+ "].OutMode");
				kvarCoreControlInA = hmiService.getVariable(sDeviceNameCoreA + ".sv_CoreMode.CoreControlIn");
				kvarCoreControlOutA = hmiService.getVariable(sDeviceNameCoreA + ".sv_CoreMode.CoreControlOut");
				HmiVariableService.registerVariable(kvarCoreModeTypeA, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreHoldA, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreModeInA, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreModeOutA, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreControlInA, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreControlOutA, null, this, KVariable.class);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			// handle field states
			bInitializedCoreA = true;
			handleFieldStatesCoreA();
		} else {
			// core device A does NOT exist, hide fields
			coreControlPanelA.setVisible(false);
			coreSettingsPanelA.setVisible(false);
		}
	}

	public void setDeviceIdCoreBComp(int iDeviceIdCoreB) {
		super.setDeviceIdCoreBComp(iDeviceIdCoreB);
		if (iDeviceIdCoreB > 0 && BaseMachineEquipment.doesDeviceExist("Core" + iDeviceIdCoreB)) {
			// core device B does exist
			String sDeviceNameCoreB = "Core" + iDeviceIdCoreB;
			setVariablesToUnitFields(sDeviceNameCoreB, iDeviceIdCoreB);
			// core control fields
			numfieldPosActivateInB.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreB
					+ "].rCoreInPosition");
			numfieldPosMonitorInB.setVariable(sDeviceNameCoreB + ".sv_rCoreInMonitorPos");
			numfieldPosActivateOutB.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreB
					+ "].rCoreOutPosition");
			numfieldPosMonitorOutB.setVariable(sDeviceNameCoreB + ".sv_rCoreOutMonitorPos");
			selectListModeInB.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreB + "].InMode");
			selectListModeOutB.setVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreB + "].OutMode");
			// core settings fields
			selectListControlInB.setShowInvalidValues(false);
			selectListControlOutB.setShowInvalidValues(false);
			selectListControlInB.setVariable(sDeviceNameCoreB + ".sv_CoreMode.CoreControlIn");
			selectListControlOutB.setVariable(sDeviceNameCoreB + ".sv_CoreMode.CoreControlOut");
			numfieldPressureInB.setVariable(sDeviceNameCoreB
					+ ".sv_CoreOutput.NormalIn.Pressure.Output.rOutputValue");
			numfieldPressureOutB.setVariable(sDeviceNameCoreB
					+ ".sv_CoreOutput.NormalOut.Pressure.Output.rOutputValue");
			numfieldVelocityInB.setVariable(sDeviceNameCoreB
					+ ".sv_CoreOutput.NormalIn.Velocity.Output.rOutputValue");
			numfieldVelocityOutB.setVariable(sDeviceNameCoreB
					+ ".sv_CoreOutput.NormalOut.Velocity.Output.rOutputValue");

			numfieldSetTimeInB.setVariable(sDeviceNameCoreB + ".sv_CoreSetTimes.MoveIn.dSetMoveTime");
			numfieldActTimeInB.setVariable(sDeviceNameCoreB + ".sv_CoreActTimes.MoveIn.dActMoveTime");
			numfieldActTimeInB.setVariableMaximum(sDeviceNameCoreB + ".sv_CoreSetTimes.MoveIn.dSetMoveTime");
			numfieldSetTimeOutB.setVariable(sDeviceNameCoreB + ".sv_CoreSetTimes.MoveOut.dSetMoveTime");
			numfieldActTimeOutB.setVariable(sDeviceNameCoreB + ".sv_CoreActTimes.MoveOut.dActMoveTime");
			numfieldActTimeOutB.setVariableMaximum(sDeviceNameCoreB + ".sv_CoreSetTimes.MoveOut.dSetMoveTime");

			numfieldSetCountInB.setVariable(sDeviceNameCoreB + ".sv_CoreScrewSetValues.iSetRoundsCount");
			numfieldActCountInB.setVariable(sDeviceNameCoreB + ".sv_CoreScrewActValues.iActRoundsCount");
			numfieldActCountInB.setVariableMaximum(sDeviceNameCoreB + ".sv_CoreScrewSetValues.iSetRoundsCount");
			numfieldSetCountOutB.setVariable(sDeviceNameCoreB + ".sv_CoreScrewSetValues.iSetRoundsCount");
			numfieldActCountOutB.setVariable(sDeviceNameCoreB + ".sv_CoreScrewActValues.iActRoundsCount");
			numfieldActCountOutB.setVariableMaximum(sDeviceNameCoreB + ".sv_CoreScrewSetValues.iSetRoundsCount");

			try {
				kvarCoreModeTypeB = hmiService.getVariable(sDeviceNameCoreB + ".sv_CoreMode.CoreType");
				chkBoxUseCoreB.getVisiController().init(kvarCoreModeTypeB);
				setCheckboxStateByIntValue(chkBoxUseCoreB, kvarCoreModeTypeB.getIntValue());
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			try {
				kvarCoreHoldB = hmiService.getVariable(sDeviceNameCoreB + ".sv_CoreMode.Hold");
				chkboxCoreHoldInB.getVisiController().init(kvarCoreHoldB);
				setCheckboxStateByIntValue(chkboxCoreHoldInB, kvarCoreHoldB.getIntValue());
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			chkBoxUseCoreB.addItemListener(this);
			chkboxCoreHoldInB.addItemListener(this);
			try {
				kvarCoreModeInB = hmiService.getVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreB
						+ "].InMode");
				kvarCoreModeOutB = hmiService.getVariable("CentralCoordination1.sv_CoreData[" + iDeviceIdCoreB
						+ "].OutMode");
				kvarCoreControlInB = hmiService.getVariable(sDeviceNameCoreB + ".sv_CoreMode.CoreControlIn");
				kvarCoreControlOutB = hmiService.getVariable(sDeviceNameCoreB + ".sv_CoreMode.CoreControlOut");
				HmiVariableService.registerVariable(kvarCoreModeTypeB, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreHoldB, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreModeInB, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreModeOutB, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreControlInB, null, this, KVariable.class);
				HmiVariableService.registerVariable(kvarCoreControlOutB, null, this, KVariable.class);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			// handle field states
			bInitializedCoreB = true;
			handleFieldStatesCoreB();
		} else {
			// core device B does NOT exist, hide fields
			coreControlPanelB.setVisible(false);
			coreSettingsPanelB.setVisible(false);
		}
	}

	private void setVariablesToUnitFields(String sDeviceName, int deviceId) {
		if (bUnitVariablesSet) {
			return;
		}
		bUnitVariablesSet = true;
		// set variables
		unitActPosIn.setVariable("CentralCoordination1.sv_CoreData[" + deviceId + "].rCoreInPosition");
		unitMonPosIn.setVariable("CentralCoordination1.sv_CoreData[" + deviceId + "].rCoreInPosition");
		unitActPosOut.setVariable("CentralCoordination1.sv_CoreData[" + deviceId + "].rCoreOutPosition");
		unitMonPosOut.setVariable("CentralCoordination1.sv_CoreData[" + deviceId + "].rCoreOutPosition");
		// settings fields
		labelUnitPressure.setVariable(sDeviceName + ".sv_CoreOutput.NormalIn.Pressure.Output.rOutputValue");
		labelUnitVelocity.setVariable(sDeviceName + ".sv_CoreOutput.NormalIn.Velocity.Output.rOutputValue");
		labelUnitTime.setVariable(sDeviceName + ".sv_CoreSetTimes.MoveOut.dSetMoveTime");
	}

	private void handleFieldStatesCoreA() {
		if (!bInitializedCoreA) {
			return;
		}
		// handle field states for core A
		// control fields
		chkBoxUseCoreA.setEnabled(!bEditorControlled);
		setCheckboxStateByIntValue(chkBoxUseCoreA, iCoreModeTypeA);
		numfieldPosMonitorInA.setEnabled(!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF
				&& iCoreModeInA == MODE_IN_DURING_CLOSE);
		numfieldPosActivateInA.setEnabled(!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF
				&& iCoreModeInA == MODE_IN_DURING_CLOSE);
		numfieldPosMonitorOutA.setEnabled(!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF
				&& iCoreModeOutA == MODE_OUT_DURING_OPEN);
		numfieldPosActivateOutA.setEnabled(!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF
				&& iCoreModeOutA == MODE_OUT_DURING_OPEN);
		selectListModeInA.setEnabled(!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF);
		selectListModeOutA.setEnabled(!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF);
		// settings fields
		selectListControlInA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		selectListControlOutA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		chkboxCoreHoldInA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		// core in objects
		numfieldPressureInA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		numfieldVelocityInA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		numfieldSetTimeInA.setEnabled(iCoreControlInA == CORE_CTRL_IN_TIME
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF)));
		numfieldSetCountInA.setEnabled(iCoreControlInA == CORE_CTRL_IN_COUNT
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF)));
		// core out objects
		numfieldPressureOutA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		numfieldVelocityOutA.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF));
		numfieldSetTimeOutA.setEnabled(iCoreControlOutA == CORE_CTRL_OUT_TIME
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF)));
		numfieldSetCountOutA.setEnabled(iCoreControlOutA == CORE_CTRL_OUT_COUNT
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeA != CORE_TYPE_OFF)));

		// trigger repaint
		coreControlPanelA.repaint();
		coreSettingsPanelA.repaint();
	}

	private void handleFieldStatesCoreB() {
		if (!bInitializedCoreB) {
			return;
		}
		// handle field states for core B
		// control fields
		chkBoxUseCoreB.setEnabled(!bEditorControlled);
		setCheckboxStateByIntValue(chkBoxUseCoreB, iCoreModeTypeB);
		numfieldPosMonitorInB.setEnabled(!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF
				&& iCoreModeInB == MODE_IN_DURING_CLOSE);
		numfieldPosActivateInB.setEnabled(!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF
				&& iCoreModeInB == MODE_IN_DURING_CLOSE);
		numfieldPosMonitorOutB.setEnabled(!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF
				&& iCoreModeOutB == MODE_OUT_DURING_OPEN);
		numfieldPosActivateOutB.setEnabled(!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF
				&& iCoreModeOutB == MODE_OUT_DURING_OPEN);
		selectListModeInB.setEnabled(!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF);
		selectListModeOutB.setEnabled(!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF);
		// settings fields
		selectListControlInB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		selectListControlOutB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		chkboxCoreHoldInB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		// core in objects
		numfieldPressureInB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		numfieldVelocityInB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		numfieldSetTimeInB.setEnabled(iCoreControlInB == CORE_CTRL_IN_TIME
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF)));
		numfieldSetCountInB.setEnabled(iCoreControlInB == CORE_CTRL_IN_COUNT
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF)));
		// core out objects
		numfieldPressureOutB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		numfieldVelocityOutB.setEnabled(bEditorControlled
				|| (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF));
		numfieldSetTimeOutB.setEnabled(iCoreControlOutB == CORE_CTRL_OUT_TIME
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF)));
		numfieldSetCountOutB.setEnabled(iCoreControlOutB == CORE_CTRL_OUT_COUNT
				&& (bEditorControlled || (!bEditorControlled && iCoreModeTypeB != CORE_TYPE_OFF)));

		// trigger repaint
		coreControlPanelB.repaint();
		coreSettingsPanelB.repaint();
	}

	/**
	 * @see com.keba.kemro.plc.event.ValueChangedListener#valueChanged(com.keba.kemro.plc.event.ValueChangedEvent)
	 */
	public void valueChanged(ValueChangedEvent event) {
		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
			return;
		}
		try {
			KVariable kvar = event.getVariable();
			int value = kvar.getIntValue();
			if (kvar.equals(kvarCoreModeInA)) {
				iCoreModeInA = value;
				handleFieldStatesCoreA();
			} else if (kvar.equals(kvarCoreModeOutA)) {
				iCoreModeOutA = value;
				handleFieldStatesCoreA();
			} else if (kvar.equals(kvarCoreModeTypeA)) {
				iCoreModeTypeA = value;
				setCheckboxStateByIntValue(chkBoxUseCoreA, iCoreModeTypeA);
				handleFieldStatesCoreA();
			} else if (kvar.equals(kvarCoreControlInA)) {
				iCoreControlInA = value;
				handleFieldStatesCoreA();
			} else if (kvar.equals(kvarCoreControlOutA)) {
				iCoreControlOutA = value;
				handleFieldStatesCoreA();
			} else if (kvar.equals(kvarCoreHoldA)) {
				setCheckboxStateByIntValue(chkboxCoreHoldInA, value);
			} else if (kvar.equals(kvarCoreModeInB)) {
				iCoreModeInB = value;
				handleFieldStatesCoreB();
			} else if (kvar.equals(kvarCoreModeOutB)) {
				iCoreModeOutB = value;
				handleFieldStatesCoreB();
			} else if (kvar.equals(kvarCoreModeTypeB)) {
				iCoreModeTypeB = value;
				setCheckboxStateByIntValue(chkBoxUseCoreB, iCoreModeTypeB);
				handleFieldStatesCoreB();
			} else if (kvar.equals(kvarCoreControlInB)) {
				iCoreControlInB = value;
				handleFieldStatesCoreB();
			} else if (kvar.equals(kvarCoreControlOutB)) {
				iCoreControlOutB = value;
				handleFieldStatesCoreB();
			} else if (kvar.equals(kvarCoreHoldB)) {
				setCheckboxStateByIntValue(chkboxCoreHoldInB, value);
			}
		} catch (Exception ex) {
		}
	}

	public void itemStateChanged(ItemEvent e) {

		if (e.getSource().equals(chkBoxUseCoreA)) {
			// change was in core A
			if (bEditorControlled)
				return;

			Object value = null;
			if (chkBoxUseCoreA.getState()) {
				value = new Integer(1);
			} else {
				value = new Integer(0);
			}
			try {
				hmiService.writeValue(kvarCoreModeTypeA, value);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else if (e.getSource().equals(chkboxCoreHoldInA)) {
			Object value = null;
			if (chkboxCoreHoldInA.getState()) {
				value = new Integer(1);
			} else {
				value = new Integer(0);
			}
			try {
				hmiService.writeValue(kvarCoreHoldA, value);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else if (e.getSource().equals(chkBoxUseCoreB)) {
			// change was in core B
			if (bEditorControlled)
				return;

			Object value = null;
			if (chkBoxUseCoreB.getState()) {
				value = new Integer(1);
			} else {
				value = new Integer(0);
			}
			try {
				hmiService.writeValue(kvarCoreModeTypeB, value);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else if (e.getSource().equals(chkboxCoreHoldInB)) {
			Object value = null;
			if (chkboxCoreHoldInB.getState()) {
				value = new Integer(1);
			} else {
				value = new Integer(0);
			}
			try {
				hmiService.writeValue(kvarCoreHoldB, value);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	private void setCheckboxStateByIntValue(KvsCheckBox checkbox, int value) {
		checkbox.setState(value != CORE_TYPE_OFF);
		if (checkbox.isShowing()) {
			checkbox.repaint();
		}
	}

	public void sequenceControlChanged(SequenceControlChangedEvent event) {
		bEditorControlled = event.isEditorControlled();
		handleFieldStatesCoreA();
		handleFieldStatesCoreB();
	}
}
