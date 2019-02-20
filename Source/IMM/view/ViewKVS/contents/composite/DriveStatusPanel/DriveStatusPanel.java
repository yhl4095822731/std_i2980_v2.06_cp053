package composite.DriveStatusPanel;

import com.keba.kemro.kv.util.KvConstants;

public class DriveStatusPanel extends DriveStatusPanel_generated {
   private static final long serialVersionUID = 1L;

   private static final int TXT_FIELD_WIDTH = 520;

   private boolean removeDriveInfoAnalogBarPosition = true;
   private boolean removeDriveInfoAnalogBarBrakeResPow = true;
   private boolean initDone = false;

   public DriveStatusPanel() throws Exception {
      super();

      // Text alignment of numfields like text alignment of textfields
      numFieldStatusWord.getNumfield().setJustification(KvConstants.VMIDDLE | KvConstants.HLEFT);
      numFieldControlMode.getNumfield().setJustification(KvConstants.VMIDDLE | KvConstants.HLEFT);
      numFieldPackage.getNumfield().setJustification(KvConstants.VMIDDLE | KvConstants.HLEFT);
   }

   public void setVariableDriveNameComp(String varName) {
      super.setVariableDriveNameComp(varName);

      // Workaround: Wrong field size
      textFieldDriveName.setPreferredSizeField(TXT_FIELD_WIDTH, 29);
   }

   public void setVariableFwVersionComp(String varName) {
      super.setVariableFwVersionComp(varName);

      // Workaround: Wrong field size
      textFieldFwVersion.setPreferredSizeField(TXT_FIELD_WIDTH, 29);
   }

   public void setVariableControlModeComp(String varName) {
      super.setVariableControlModeComp(varName);
      numFieldControlMode.setVisible(true);
   }

   public void setVariablePLCVersionComp(String varName) {
      super.setVariablePLCVersionComp(varName);
      textFieldPLCVersion.setVisible(true);

      // Workaround: Wrong field size
      textFieldPLCVersion.setPreferredSizeField(TXT_FIELD_WIDTH, 29);
   }

   public void setVariablePackageComp(String varName) {
      super.setVariablePackageComp(varName);
      numFieldPackage.setVisible(true);
   }

   public void setVariableActPositionComp(String varName) {
      super.setVariableActPositionComp(varName);
      removeDriveInfoAnalogBarPosition = false;
   }

   public void setVariableActBrakeResPowerComp(String varName) {
      super.setVariableActBrakeResPowerComp(varName);
      removeDriveInfoAnalogBarBrakeResPow = false;
   }

   public void onShow() {
      super.onShow();

      if (!initDone) {
         if (removeDriveInfoAnalogBarPosition) {
            panelActValues.remove(driveInfoAnalogBarPosition);
         }
         if (removeDriveInfoAnalogBarBrakeResPow) {
            panelActValues.remove(driveInfoAnalogBarBrakeResPow);
         }
         initDone = true;
      }

   }
}
