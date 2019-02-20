package composite.DriveReferencingPanel;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.util.Locale;

import com.keba.kemro.kv.dialog.KvDialogInfoInterface;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.widgets.KvPanel;
import com.keba.kemro.kvs.keplast.general.util.KPResourceBundle;
import com.keba.kemro.kvs.keplast.widgets.special.KTwoNumFieldText;
import com.keba.kemro.kvs.widgets.KvsNumField;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KBoolean;
import com.keba.util.LanguageManager;

public class DriveReferencingPanel extends DriveReferencingPanel_generated implements ValueChangedListener {
   private static final long serialVersionUID = 1L;

   protected static final String RESOURCE_BUNDLE_ADD = "composite.DriveReferencingPanel.text.DriveReferencingPanel_texts";

   protected KBoolean kvarRefStartRequest = null;
   protected String iconNameStart = null; // Start icon
   protected String iconNameStop = "composite/DriveReferencingPanel/images/stop16.gif"; // Stop icon

   public DriveReferencingPanel() throws Exception {
      super();
      iconNameStart = btnRef.getIconName();
      if (iconNameStart == null) {
         // Use default start icon
         iconNameStart = "composite/DriveReferencingPanel/images/start16.gif";
      }
   }

   public void setVariableRefStartRequestComp(String varName) {
      super.setVariableRefStartRequestComp(varName);

      if (varName == null) {
         if (kvarRefStartRequest != null) {
            kvarRefStartRequest.remove(ValueChangedListener.class, this);
            kvarRefStartRequest = null;
         }
      } else {
         try {
            kvarRefStartRequest = (KBoolean) HmiVariableService.getService().getVariable(varName);
            HmiVariableService.registerVariable(varName, this);
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      btnRef.getVisiController().init(kvarRefStartRequest);
   }

   public void setVariableRefOffsetPosComp(String varName) {
      createRefOffsetWidgets();
      super.setVariableRefOffsetPosComp(varName);
   }

   public void setVariableRefOffsetMotorComp(String varName) {
      createRefOffsetWidgets();
      super.setVariableRefOffsetMotorComp(varName);
   }

   /**
    * Action command for referencing button.
    */
   public void btnRef_Command() {
      // CR_0049961: show confirm dialog
      if (!kvarRefStartRequest.getBooleanValue()) {
         Locale locale = LanguageManager.sharedInstance().getLanguage().getLocale();
         KPResourceBundle textBundleAdditional = KPResourceBundle.getBundle(RESOURCE_BUNDLE_ADD, locale);
         // START requested
         KvMessageDialog.showConfirmDialog(textBundleAdditional.getString("sConfirmDialogText"),
               textBundleAdditional.getString("sConfirmDialogTitle"), KvMessageDialog.QUESTION_MESSAGE, false,
               new KvDialogInfoInterface() {
                  public boolean getPressedOption(int option) {
                     if (option == KvDialogInfoInterface.YES) {
                        // OK -> Start referencing
                        writeRefRequest(true);
                     } else if (option == KvDialogInfoInterface.NO) {
                        // Cancelled -> Set start icon for button
                        setButtonIcon(true);
                     }
                     return true;
                  }
               });
      } else {
         // STOP requested
         writeRefRequest(false);
      }
   }

   public void valueChanged(ValueChangedEvent event) {
      if (event.getReason() != ValueChangedEvent.VALUE_CHANGED) {
         return;
      }

      // Value of start request SV has changed -> Set correct button icon depending on value
      if (kvarRefStartRequest != null) {
         setButtonIcon(!kvarRefStartRequest.getBooleanValue());
      }
   }

   /**
    * Set the icon of the referencing button
    * 
    * @param start
    *           <code>true</code> for setting start icon. <code>false</code> for setting stop icon.
    */
   protected void setButtonIcon(boolean start) {
      if (start) {
         btnRef.setIconName(iconNameStart);
      } else {
         btnRef.setIconName(iconNameStop);
      }

      btnRef.invalidate();
      Container c = btnRef.getParent();
      if (c != null) {
         c.validate();
      }
      btnRef.repaint();
   }

   /**
    * Write start/stop request to SV
    * 
    * @param start
    *           <code>true</code> to start referencing. <code>false</code> to stop referencing.
    */
   protected void writeRefRequest(boolean start) {
      try {
         HmiVariableService.getService().writeValidValue(kvarRefStartRequest,
               new Boolean(start));
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   /**
    * Create widgets for reference offsets.<br>
    * NOTE: "Create" dynamic function of generated code will always result to <code>false</code> ->
    * Create widgets dynamically when passing variables.
    */
   protected void createRefOffsetWidgets() {
      if (panelRefOffset == null) {
         panelRefOffset = new KvPanel();
         panelRefOffset.setLayout(null);
         panelRefOffset.setPreferredSize(new Dimension(425, 29));

         nfRefOffsetMotor = new KvsNumField();
         nfRefOffsetMotor.setEditable(false);
         nfRefOffsetMotor.setBounds((panelRefOffset.getPreferredSize().width - 235), 0, 96, panelRefOffset.getPreferredSize().height);
         panelRefOffset.add(nfRefOffsetMotor, null);

         twoNfRefOffset = new KTwoNumFieldText();
         twoNfRefOffset.setEditableLeft(false);
         twoNfRefOffset.setBounds(0, 0, panelRefOffset.getPreferredSize().width, panelRefOffset.getPreferredSize().height);
         panelRefOffset.add(twoNfRefOffset, null);

         panelRef.add(panelRefOffset, BorderLayout.EAST);
      }
   }
}
