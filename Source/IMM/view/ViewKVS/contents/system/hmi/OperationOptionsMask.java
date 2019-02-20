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

import java.awt.Component;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.Locale;
import java.util.ResourceBundle;

import com.keba.kemro.kv.dialog.KvDialogInfoInterface;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.widgets.KvTabPanel;
import com.keba.kemro.kvs.control.KvsFrame;
import com.keba.kemro.kvs.keplast.tig.TIG;
import com.keba.kemro.kvs.keplast.tig.production.TIGCavities;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.general.PlastConstants;
import com.keba.keplast.general.unitsystem.UnitSetupDialog;
import com.keba.util.UserManager;

public class OperationOptionsMask extends OperationOptionsMask_generated {

   private static final long serialVersionUID = 1L;
   private String RESOURCE_BUNDLE_DLG = "system.hmi.text.OperationOptionsMask_texts";
   private ResourceBundle m_bundleDlg;

   public OperationOptionsMask() throws Exception {

      super();
      m_bundleDlg = ResourceBundle.getBundle(RESOURCE_BUNDLE_DLG);
      if (TIG.getInstance().isTIGExisting()) {
         try {
            KVariable kvar = hmiService.getVariable("system.sv_iCavities");
            kvar.setInputLevel(PlastConstants.LEVEL_UNREACHABLE);
            numfieldCavity.getNumfield().addMouseListener(
                  new TIGMouseAdapter());
            kvar = hmiService.getVariable("system.sv_iProdCounterSet");
            kvar.setInputLevel(PlastConstants.LEVEL_UNREACHABLE);
         } catch (Exception ex) {
            CAT.error("Could not find variable", ex);
         }
      }
   }

   public void cmdStartButtonMold() {
      try {
         KVariable kvar = hmiService
               .getVariable("Lubrication1.sv_bLubricateInjectionSide");
         hmiService.writeValue(kvar, Boolean.FALSE);
         kvar = hmiService
               .getVariable("Lubrication1.sv_bLubricationManualStart");
         hmiService.writeValue(kvar, Boolean.TRUE);
      } catch (Exception ex) {
         CAT.error("Could not write to IEC varibales!", ex);
      }
   }

   public void cmdStartButtonInject() {
      try {
         KVariable kvar = hmiService
               .getVariable("Lubrication1.sv_bLubricateInjectionSide");
         hmiService.writeValue(kvar, Boolean.TRUE);
         kvar = hmiService
               .getVariable("Lubrication1.sv_bLubricationManualStart");
         hmiService.writeValue(kvar, Boolean.TRUE);
      } catch (Exception ex) {
         CAT.error("Could not write to IEC varibales!", ex);
      }
   }

   public void cmdUnitSetup() {
      UnitSetupDialog dialog = new UnitSetupDialog();
      dialog.showDialog();
   }

   public void cmdUser() {
      UserManager.getSharedInstance().showUserDialog();
   }

   public void cmdResetShotCounter() {

      DlgInfoInterface info;
      String title, message;

      info = new DlgInfoInterface();
      try {
         title = m_bundleDlg.getString("resetProdCounterDialog.Title");
         message = m_bundleDlg.getString("resetProdCounterDialog.Message");
      } catch (Exception ex) {
         title = "Reset production counter";
         message = "Reset production counter + delete SPC?";
      }
      KvMessageDialog.showModal(message, KvMessageDialog.WARNING_MESSAGE, KvMessageDialog.OK_CANCEL, title, true, info);

   }

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);
      m_bundleDlg = ResourceBundle.getBundle(RESOURCE_BUNDLE_DLG, locale);
   }

   private class DlgInfoInterface implements KvDialogInfoInterface {

      public boolean getPressedOption(int option) {
         if (option == KvDialogInfoInterface.OK) {
            try {
               KVariable kvar = hmiService.getVariable("system.sv_bResetShotCounter");
               hmiService.writeValue(kvar, Boolean.TRUE, false);
            } catch (Exception ex) {
               CAT.error("Could not reset shot counter", ex);
            }
         }
         return true;
      }
   }

   protected class TIGMouseAdapter extends MouseAdapter {

      private KvTabPanel compTigTabPanel = null;
      private int iCavityPanelIndex = -1;

      public void mouseReleased(MouseEvent arg0) {

         try {
            KvsFrame.getInstance().showMask(TIG.MASK_TIGMAIN);
            // switch to cavity panel
            if (getTigTabPanel() != null && getTabPanelCavityIndex() > -1) {
               getTigTabPanel().setSelectedIndex(getTabPanelCavityIndex());
            }
         } catch (RuntimeException rtex) {
         }
      }

      private KvTabPanel getTigTabPanel() {

         if (compTigTabPanel == null) {
            // find tab panel
            Component c = KvsFrame.getInstance()
                  .getMaskInstance(TIG.MASK_TIGMAIN).getComponent(0);
            if (c instanceof KvTabPanel) {
               compTigTabPanel = (KvTabPanel) c;
            }
         }
         return compTigTabPanel;
      }

      private int getTabPanelCavityIndex() {

         if (iCavityPanelIndex < 0) {
            KvTabPanel tabpanel = getTigTabPanel();
            if (tabpanel != null) {
               // search from upside down, because the panel should be on
               // the
               // right
               // side
               Component c = null;
               for (int i = tabpanel.getComponentCount() - 1; i >= 0; i--) {
                  c = tabpanel.getComponent(i);
                  if (c instanceof TIGCavities) {
                     iCavityPanelIndex = i;
                     break;
                  }
               }
            }
         }
         return iCavityPanelIndex;
      }
   }
}
