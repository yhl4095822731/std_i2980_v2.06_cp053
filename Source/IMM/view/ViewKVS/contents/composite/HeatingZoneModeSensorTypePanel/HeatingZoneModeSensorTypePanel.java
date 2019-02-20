package composite.HeatingZoneModeSensorTypePanel;

import com.ibm.log4j.Category;
import com.keba.kemro.kvs.keplast.heating.IHeatingConstants;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.network.SvPlaus;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.heating.general.IHeatingZoneMode;

public class HeatingZoneModeSensorTypePanel extends HeatingZoneModeSensorTypePanel_generated implements IHeatingZoneMode,
      ValueChangedListener {
   private static final long serialVersionUID = 1L;

   private static final Category CAT = Category.getInstance(HeatingZoneModeSensorTypePanel.class.getName());
   private static HmiVariableService hmiService = HmiVariableService.getService();

   private int iZoneId = -1;

   private ZoneOperationModeListener listenerZoneOperationMode;
   private ZoneTypeListener listenerZoneType;

   private KVariable kvarZoneOpMode;
   private KVariable kvarZoneType;
   private SvPlaus svplausConstValVis;
   private long[] aiModePlaus = new long[] { 0, -1, -1, -1, -1, -1, -1, -1 };

   public HeatingZoneModeSensorTypePanel() throws Exception {
      super();
      listenerZoneOperationMode = new ZoneOperationModeListener();
      listenerZoneType = new ZoneTypeListener();
   }

   public void setZoneVariableComp(String sZoneDataPath) {
      iZoneId = Integer.parseInt(sZoneDataPath.substring(sZoneDataPath.indexOf("[") + 1, sZoneDataPath.indexOf("]")));
      selectListMode.setVariable(sZoneDataPath + ".DataRetain^.ModeVis");
      selectListSensorType.setVariable(sZoneDataPath + ".DataRetain^.SensorTypeVis");
      numfieldSetterValue.setVariable(sZoneDataPath + ".DataRetain^.rConstValVis");
      selectListZoneType.setVariable(sZoneDataPath + ".DataRetain^.bIsHotrunner");
      symbolDisplayZoneType.setVariable(sZoneDataPath + ".DataRetain^.ZoneType");
      numFieldMaxEvapPwr.setVariable(sZoneDataPath + ".DataRetain^.rSoftstartPower");

      // At the moment hardcoded check for "HeatingMold1" FU necessary, because power is calculated
      // in system FU
      if (sZoneDataPath.startsWith("HeatingMold1")) {
         numFieldPwr.setVariable("HeatingMold1.sv_ActHeatingPower[" + iZoneId + "]");
      }
      else {
         numFieldPwr.setVisible(false);
      }

      selectListSensorType.setShowInvalidValues(false);

      // check for plausibility
      boolean bTempSensorOK = false;
      boolean b_prOutHeatTO = false;
      boolean b_pbOutHeatDO = false;
      boolean b_prOutCoolTO = false;
      boolean b_pbOutCoolDO = false;
      boolean b_prOutHeatPO = false;
      boolean bPID2Possible = false;
      boolean bPID3Possible = false;
      boolean bSetterPossible = false;

      try {
         bTempSensorOK = hmiService.getTempVariable(sZoneDataPath + ".Data^.bSensorOK", null, false).getBooleanValue();

         setComboItemPlaus(iZONE_OPMODE_MEASURE, bTempSensorOK);
         setComboItemPlaus(iZONE_OPMODE_CONSTANT, hmiService.getTempVariable(sZoneDataPath + ".Data^.bOutputOK", null, false)
               .getBooleanValue());
         kvarZoneOpMode = hmiService.getVariable(sZoneDataPath + ".DataRetain^.ModeVis");
         HmiVariableService.registerVariable(kvarZoneOpMode.getName(), listenerZoneOperationMode);
         kvarZoneType = hmiService.getVariable(sZoneDataPath + ".DataRetain^.bIsHotrunner");
         HmiVariableService.registerVariable(kvarZoneType.getName(), listenerZoneType);
      }
      catch (Exception ex) {
         CAT.warn(ex.getLocalizedMessage());
      }

      try {
         hmiService.getTempVariable(sZoneDataPath + ".Data^.prOutHeatTO^", null, false);
         b_prOutHeatTO = true;
      }
      catch (Exception ex) {
      }

      try {
         hmiService.getTempVariable(sZoneDataPath + ".Data^.pbOutHeatDO^", null, false);
         b_pbOutHeatDO = true;
      }
      catch (Exception ex) {
      }
      
      try {
         hmiService.getTempVariable(sZoneDataPath + ".Data^.prOutHeatPO^", null, false);
         b_prOutHeatPO = true;
      }
      catch (Exception ex) {
      }       

      try {
         hmiService.getTempVariable(sZoneDataPath + ".Data^.prOutCoolTO^", null, false);
         b_prOutCoolTO = true;
      }
      catch (Exception ex) {
      }

      try {
         hmiService.getTempVariable(sZoneDataPath + ".Data^.pbOutCoolDO^", null, false);
         b_pbOutCoolDO = true;
      }
      catch (Exception ex) {
      }

      bPID2Possible = bTempSensorOK && (b_prOutHeatTO || b_pbOutHeatDO || b_prOutCoolTO || b_pbOutCoolDO || b_prOutHeatPO);
      bPID3Possible = bTempSensorOK && (b_prOutHeatTO || b_pbOutHeatDO) && (b_prOutCoolTO || b_pbOutCoolDO);
      setComboItemPlaus(iZONE_OPMODE_PID_2PT, bPID2Possible);
      setComboItemPlaus(iZONE_OPMODE_PID_2PT_EMERGENCY, bPID2Possible);
      setComboItemPlaus(iZONE_OPMODE_PID_3PT, bPID3Possible);
      setComboItemPlaus(iZONE_OPMODE_PID_3PT_EMERGENCY, bPID3Possible);

      if ((b_prOutHeatTO || b_pbOutHeatDO) && (b_prOutCoolTO || b_pbOutCoolDO)) {
         svplausConstValVis = IHeatingConstants.svplausNEG100_TO_100;
      }
      else if (b_prOutCoolTO || b_pbOutCoolDO) {
         svplausConstValVis = IHeatingConstants.svplausNEG100_TO_0;
      }
      else {
         svplausConstValVis = IHeatingConstants.svplaus0_TO_100;
      }

      numfieldSetterValue.setPlausibilityRanges(svplausConstValVis);

      selectListMode.setPlausibilityRanges(new SvPlaus(aiModePlaus, aiModePlaus));

      // check for number of zones
      String sZoneDeviceName = sZoneDataPath.substring(0, sZoneDataPath.indexOf("."));
      try {
         HmiVariableService.registerVariable(sZoneDeviceName + ".sv_iZonesAvailable", this);
      }
      catch (Exception ex) {
         CAT.error(ex);
      }
   }

   public void valueChanged(ValueChangedEvent event) {
      if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
         return;
      }
      try {
         if (event.getVariable().getName().endsWith(".sv_iZonesAvailable")) {
            setVisible(event.getVariable().getIntValue() >= iZoneId);
         }
      }
      catch (Exception ex) {
         CAT.warn(ex);
      }
   }

   private void setComboItemPlaus(int iItem, boolean bVisible) {
      aiModePlaus[iItem] = bVisible ? iItem : -1;
   }

   /**
    * listener for the actual operation mode of the zone
    * 
    * 
    */
   private class ZoneOperationModeListener implements ValueChangedListener {

      public void valueChanged(ValueChangedEvent ev) {
         if (ev.getReason() != ValueChangedEvent.VALUE_CHANGED)
            return;

         try {
            int iValue = ev.getVariable().getIntValue();
            numfieldSetterValue.setEnabled(iValue == iZONE_OPMODE_CONSTANT);
            if (numfieldSetterValue.isShowing()) {
               numfieldSetterValue.repaint();
            }

         }
         catch (Exception ex) {
            CAT.warn(ex.getLocalizedMessage());
         }
      }
   }

   /**
    * listener for the actual operation mode of the zone
    * 
    * 
    */
   private class ZoneTypeListener implements ValueChangedListener {

      public void valueChanged(ValueChangedEvent ev) {
         if (ev.getReason() != ValueChangedEvent.VALUE_CHANGED)
            return;

         KVariable kvar = ev.getVariable();
         try {
            boolean bSetterPossible = !(kvar.getBooleanValue());
            setComboItemPlaus(iZONE_OPMODE_CONSTANT, bSetterPossible);
            selectListMode.setPlausibilityRanges(new SvPlaus(aiModePlaus, aiModePlaus));
         }
         catch (Exception ex) {
            CAT.warn(ex.getLocalizedMessage());
         }
      }
   }

   public void onShow() {
      super.onShow();

      try {
         int iValue = kvarZoneOpMode.getIntValue();
         boolean isEnabled = (iValue == iZONE_OPMODE_CONSTANT);
         numfieldSetterValue.setEnabled(isEnabled);
      }
      catch (Exception ex) {
         CAT.error("onShow: ", ex);
      }
   }
}
