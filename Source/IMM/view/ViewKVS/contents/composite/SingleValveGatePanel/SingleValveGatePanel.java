package composite.SingleValveGatePanel;

import java.awt.event.ActionEvent;
import system.hmi.MachineEquipment;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;

public class SingleValveGatePanel extends SingleValveGatePanel_generated implements ValueChangedListener {
   private static final long serialVersionUID = 1L;
   private int iValveGateID = -1;

   public SingleValveGatePanel() throws Exception {
      super();
   }

   public void setValveGateIDComp(int iID) {
      super.setValveGateIDComp(iID);

      this.iValveGateID = iID;

      // set variables to field
      labelID.setText(String.valueOf(iID));

      markOpen.setVariable("ValveGate1.sv_ValveGateState[" + iID + "]");

      checkBoxUse1.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bUsed");
      checkBoxUse2.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bUseSecond");
      checkBoxUseHold.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bActivOnHold");
      checkBoxForce.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bOpenManual");

      textSelectListModeOpen.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].OpenMode");
      textSelectListModeClose.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].CloseMode");

      numFieldOpenPos1.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].rStartPos");
      numFieldOpenDelay1.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].dStartDelay");
      numFieldClosePos1.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].rStopPos");
      numFieldCloseDelay1.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].dStopDelay");

      numFieldHoldDelay.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].dHoldDelay");
      numFieldHoldActive.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].dHoldActTime");

      numFieldOpenPos2.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].rStartPos2nd");
      numFieldOpenDelay2.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].dStartDelay2nd");
      numFieldClosePos2.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].rStopPos2nd");
      numFieldCloseDelay2.setVariable("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].dStopDelay2nd");

      try {
         HmiVariableService.registerVariable(("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].OpenMode"), this);
      } catch (Exception ex) {
      }

      try {
         HmiVariableService.registerVariable(("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].CloseMode"), this);
      } catch (Exception ex) {
      }

      try {
         HmiVariableService.registerVariable(("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bUsed"), this);
      } catch (Exception ex) {
      }

      try {
         HmiVariableService.registerVariable(("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bActivOnHold"), this);
      } catch (Exception ex) {
      }

      try {
         HmiVariableService.registerVariable(("ValveGate1.sv_ValveGateData.ValveGateDataArray[" + iID + "].bUseSecond"), this);
      } catch (Exception ex) {
      }

      try {
         HmiVariableService.registerVariable("ValveGate1.sv_bBistableValveGates", this);
      } catch (VartypeException e) {
      }
   }

   public void valueChanged(ValueChangedEvent event) {
      if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
         return;
      }
      KVariable kvar = event.getVariable();
      try {
         if (kvar.getName().endsWith(".OpenMode")) {
            numFieldOpenPos1.setEnabled(kvar.getIntValue() == 0);
            numFieldOpenPos2.setEnabled(kvar.getIntValue() == 0);
         }
         else if (kvar.getName().endsWith(".CloseMode")) {
            numFieldClosePos1.setEnabled(kvar.getIntValue() == 0);
            numFieldClosePos2.setEnabled(kvar.getIntValue() == 0);
         }
         else if (kvar.getName().endsWith(".bUsed")) {
            boolean enabled = kvar.getBooleanValue();

            checkBoxUse2.setEnabled(enabled);
            checkBoxUseHold.setEnabled(enabled);

            textSelectListModeOpen.setEnabled(enabled);
            textSelectListModeClose.setEnabled(enabled);

            numFieldOpenPos1.setEnabled(enabled);
            numFieldOpenDelay1.setEnabled(enabled);
            numFieldClosePos1.setEnabled(enabled);
            numFieldCloseDelay1.setEnabled(enabled);
         }
         else if (kvar.getName().equals("ValveGate1.sv_bBistableValveGates")) {
            boolean bVisible = false;
            if (kvar.getBooleanValue()) {
               // bistable
               bVisible = MachineEquipment.doesVariableExist("ValveGate1.do_ValveGate" + (iValveGateID * 2 - 1))
                     && MachineEquipment.doesVariableExist("ValveGate1.do_ValveGate" + (iValveGateID * 2));
            }
            else {
               // monostable
               bVisible = MachineEquipment.doesVariableExist("ValveGate1.do_ValveGate" + iValveGateID);
            }
            this.setVisible(bVisible);
         }
         else if (kvar.getName().endsWith(".bActivOnHold")) {
            boolean enabled = kvar.getBooleanValue();

            numFieldHoldDelay.setEnabled(enabled);
            numFieldHoldActive.setEnabled(enabled);
         }
         else if (kvar.getName().endsWith(".bUseSecond")) {
            boolean enabled = kvar.getBooleanValue();

            numFieldOpenPos2.setEnabled(enabled);
            numFieldOpenDelay2.setEnabled(enabled);
            numFieldClosePos2.setEnabled(enabled);
            numFieldCloseDelay2.setEnabled(enabled);
         }

      } catch (Exception e) {
         e.printStackTrace();
      }
      this.repaint();
   }
}
