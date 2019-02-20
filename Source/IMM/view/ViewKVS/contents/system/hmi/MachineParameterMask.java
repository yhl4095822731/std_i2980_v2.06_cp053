/*-------------------------------------------------------------------------
 *                         (c) 2010 by KEBA AG
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project      : IMM - View.Standard Visualization
 *    Date         : 22.11.2010
 *    Archive      : system.hmi
 *--------------------------------------------------------------------------*/

package system.hmi;

import java.awt.Cursor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import com.ibm.log4j.Category;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.util.KvToolkit;
import com.keba.kemro.kv.util.KvUtilities;
import com.keba.kemro.kv.widgets.event.KvVirtualKeyboardListener;
import com.keba.kemro.kvs.widgets.KvsInputLogService;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.keplast.test.util.TestUtils;
import com.keba.util.KChangeEvent;

public class MachineParameterMask extends MachineParameterMask_generated {

   private static final long serialVersionUID = 1L;

   public MachineParameterMask() throws Exception {
      super();
      CAT = Category.getInstance("MachineParameterMask");
      try {
         initComponents();
      } catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   protected void tabPanelPlast1_Tab2_onTabShow() {
      showReCalibWarning();
   }

   protected void tabPanelPlast1_Tab6_onTabShow() {
      fillQuickSetValues();
   }

   private void initComponents() {
      // Modify visibility controllers of quick set widgets,
      // to get the same "read only / write permission" behaviour as the widgets with variables.
      cbQuickUse.getVisiController().setVariableExists(true);
      nfQuickLength.getVisiController().setVariableExists(true);
      nfQuickDiameter.getVisiController().setVariableExists(true);
      nfQuickCrossSection.getVisiController().setVariableExists(true);
      btnOkQuickSet.getVisiController().setVariableExists(true);

      btnOkQuickSet.setActionCommand("btnOkQuickSet_Command");
      btnOkQuickSet.removeActionListener(this);
      btnOkQuickSet.addActionListener(new ActionListener() {

         public void actionPerformed(ActionEvent e) {
            btnOkQuickSetClicked();
         }
      });

      nfQuickDiameter.addVirtualKeyboardListener(new KvVirtualKeyboardListener() {

         public void stateChanged(KChangeEvent e) {
            nfQuickDiameterChanged();
         }
      });
      nfQuickCrossSection.addVirtualKeyboardListener(new KvVirtualKeyboardListener() {

         public void stateChanged(KChangeEvent e) {
            nfQuickCrossSectionChanged();
         }
      });
   }

   private void btnOkQuickSetClicked() {
      HmiVariableService service;
      Boolean useQuick;
      Double lengthQuick, crossSectionQuick;

      KvToolkit.setCursor(Cursor.WAIT_CURSOR);
      try {
         useQuick = (cbQuickUse.getState() ? Boolean.TRUE : Boolean.FALSE);
         lengthQuick = new Double(nfQuickLength.getDoubleValue());
         crossSectionQuick = new Double(nfQuickCrossSection.getDoubleValue());

         service = HmiVariableService.getService();

         service.writeValidValue(nfCableLenthTI0.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI0.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI0.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI1.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI1.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI1.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI2.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI2.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI2.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI3.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI3.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI3.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI4.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI4.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI4.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI5.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI5.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI5.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI6.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI6.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI6.getKVariable(), useQuick);

         service.writeValidValue(nfCableLenthTI7.getKVariable(), lengthQuick);
         service.writeValidValue(nfCrossSectionTI7.getKVariable(), crossSectionQuick);
         service.writeValidValue(cbUseTI7.getKVariable(), useQuick);
      } catch (Exception ex) {
         CAT.error("btnOkQuickSetClicked: ", ex);
      }
      KvToolkit.setCursor(Cursor.DEFAULT_CURSOR);
   }

   private void nfQuickDiameterChanged() {
      double crossSectionValue;
      double diameterValue;

      diameterValue = nfQuickDiameter.getDoubleValue();
      KvsInputLogService.log("MachineParameterMask: nfQuickDiameter clicked: " + diameterValue);
      crossSectionValue = diameterValue * diameterValue * Math.PI / 4;
      nfQuickCrossSection.setValue(crossSectionValue);
   }

   private void nfQuickCrossSectionChanged() {
      double diameterValue;

      KvsInputLogService.log("MachineParameterMask: nfQuickCrossSection clicked: " + nfQuickCrossSection.getText());
      diameterValue = Math.sqrt(4 * nfQuickCrossSection.getDoubleValue() / Math.PI);
      nfQuickDiameter.setValue(diameterValue);
   }

   private void fillQuickSetValues() {
      try {
         cbQuickUse.setState(cbUseTI0.getState());
         nfQuickLength.setValue(nfCableLenthTI0.getKVariable().getDoubleValue());
         nfQuickDiameter.setValue(nfWireDiameterTI0.getKVariable().getDoubleValue());
         nfQuickCrossSection.setValue(nfCrossSectionTI0.getKVariable().getDoubleValue());
      } catch (Exception ex) {
         CAT.error("fillQuickSetValues: ", ex);
      }
   }

   protected void tabPanelPlast1_Tab4_onTabShow() {
      showReCalibWarning();
   }

   protected void showReCalibWarning() {
      if (!TestUtils.isAnyAutomaticTestRunning() && MachineEquipment.hasAnyPump()) {
         KvUtilities.invokeLater(new Runnable() {
            public void run() {
               KvMessageDialog.showWarningMessage(textBundle.getString("warnMessageDialogHelperMessage.setTextAttribute"),
                     textBundle.getString("warnMessageDialogHelperTitle.setTextAttribute"), true, null);
            }
         });
      }
   }
}
