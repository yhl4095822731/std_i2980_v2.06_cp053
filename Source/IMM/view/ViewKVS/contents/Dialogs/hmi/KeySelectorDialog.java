package Dialogs.hmi;

import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.Locale;
import java.util.ResourceBundle;

import com.ibm.log4j.Category;
import com.keba.kemro.kv.dialog.KvDialog;
import com.keba.kemro.kv.util.KvConstants;
import com.keba.kemro.kv.widgets.KvButton;
import com.keba.kemro.kv.widgets.KvPanel;
import com.keba.kemro.kv.widgets.KvTextField;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.util.EventQueue;
import com.keba.util.LanguageManager;

import system.hmi.MachineEquipment;

/**
 * (29.08.2013) This class has been developed because of CR_0050721: Integrate OP362-LD/C-6006 in
 * KePLast branch system. After calling the initialize method on this class the selector buttons for
 * the cores and the airValves are enabled.
 * 
 * IMPORTANT: It is not possible to use the selector functionality from inside the simulation since
 * it only works on VX_WORKS.
 * 
 * @author hdm
 * 
 */
public class KeySelectorDialog {

   Category CAT;

   // Constants
   private final int MIN_WIDTH_DIALOG = 123;

   // Key variables
   public final int KEY_CODE_CORE = 67;
   public final int KEY_CODE_AIRVALVE = 65;

   // Core variables
   final private int MAX_CNT_CORES = 8;

   private KvDialog dialogCore;
   private int selectionCore = -1;
   private int selectionCoreLast = -1;
   private boolean dialogCoreIsOpen = false;
   private KvButton[] listCoreSelectionButtons;
   final private String sv_CoreSelector = "CoreSelector.sv_iSelector";

   // AirValve variables
   final private int MAX_CNT_AIRVALVES = 8;

   private KvDialog dialogAirValve;
   private int selectionAirValve = -1;
   private int selectionAirValveLast = -1;
   private boolean dialogAirValveIsOpen = false;
   private KvButton[] listAirValveSelectionButtons;
   final private String sv_AirValveSelector = "AirValveSelector.sv_iSelector";

   private static final String RESOURCE_BUNDLE = "Dialogs.hmi.text.KeySelectorDialog";

   private static KeySelectorDialog instance;

   public static KeySelectorDialog getInstance() {
      if (instance != null) {
         return instance;
      } else {
         instance = new KeySelectorDialog();
         instance.initialize();
         return instance;
      }
   }

   /**
    * Enables selection buttons for the Core dialog and the AirValve dialog.
    */
   public void initialize() {
      CAT = Category.getInstance(getClass().getName());
      EventQueue eventQueue = com.keba.util.EventQueue.getInstance();
      eventQueue.addKeyListener(new KeyAdapter() {

         public void keyReleased(KeyEvent e) {
            Object keyEventSource = e.getSource();
            if (keyEventSource != null && keyEventSource instanceof KvTextField) {
               // Do not react on input on text fields (e.g. during entering password,...)
               return;
            }

            createKeyEventFunctionality(e.getKeyCode());
         }

      });
   }

   private void createKeyEventFunctionality(int keyCode) {

      // CREATE CORE DIALOG FUNCTIONALITY
      if (keyCode == KEY_CODE_CORE) {

         if (dialogCoreIsOpen) {
            dialogCore.close();
            dialogCoreIsOpen = false;
            return;
         }

         // Get Core count
         int coreCount = 0;
         for (int i = 1; i <= MAX_CNT_CORES; i++) {
            if (MachineEquipment.doesDeviceExist("Core" + i)) {
               coreCount++;
            }
         }

         // Only open dialog if their are cores available
         if (coreCount == 0) {
            CAT.info("Since the core count is 0 the dialog for selecting a core is not opened");
            return;
         }

         // Get the core that was selected last time
         HmiVariableService hmiVarService = HmiVariableService.getService();
         KVariable kvarCoreSelector = null;
         try {
            kvarCoreSelector = hmiVarService.getVariable(sv_CoreSelector);
            hmiVarService.readValue(kvarCoreSelector);
            selectionCore = kvarCoreSelector.getIntValue();

            // In case the selected Core is no longer available on the machine set the selection to
            // Core 1.
            if (selectionCore > coreCount) {
               selectionCore = 0;
            }

         } catch (Exception e) {
            if (coreCount > 2) {
               CAT.error("Unable to load CoreSelector.sv_iSelector");
            }
         }

         listCoreSelectionButtons = new KvButton[coreCount];

         if (!dialogCoreIsOpen) {
            dialogCoreIsOpen = true;
            CAT.info("Core selection dialog requested.");

            // Create core selection dialog
            Locale locale = LanguageManager.sharedInstance().getLanguage().getLocale();
            ResourceBundle textBundle = ResourceBundle.getBundle(RESOURCE_BUNDLE, locale);
            dialogCore = new KvDialog(KvDialog.NONE, textBundle.getString("coreSelection"), false);

            // Create dialog content
            KvPanel panelContent = new KvPanel();
            panelContent.setLayout(new FlowLayout());

            // Create selection buttons
            for (int i = 0; i < coreCount; i++) {
               final int index = i;
               KvButton button = new KvButton(String.valueOf(i + 1));
               // button.setIcon(icon);

               button.addActionListener(new ActionListener() {

                  public void actionPerformed(ActionEvent e) {
                     boolean isDeviceReady = false;
                     KVariable kvarCurrentCore = null;

                     // While moving a core it is not possible to select
                     // another core
                     try {
                        HmiVariableService hmiVarService = HmiVariableService.getService();
                        if (selectionCoreLast == -1) {
                           kvarCurrentCore = hmiVarService.getVariable("Core" + selectionCore + ".sv_bDeviceReady");
                        } else {
                           kvarCurrentCore = hmiVarService.getVariable("Core" + selectionCoreLast + ".sv_bDeviceReady");
                        }

                        hmiVarService.readValue(kvarCurrentCore);
                        isDeviceReady = kvarCurrentCore.getBooleanValue();
                     } catch (Exception e1) {
                        CAT.error("Unable to read Core" + selectionCore + ".sv_bDeviceReady");
                     }

                     if (isDeviceReady) {

                        CAT.info("Clear selection");
                        for (int i = 0; i < listCoreSelectionButtons.length; i++) {
                           listCoreSelectionButtons[i].setBackground(null);
                        }

                        selectionCore = index;

                        // Write the selected button to the PLC
                        try {
                           int debugSelectionCore = selectionCore + 1;
                           CAT.info("Writing: " + debugSelectionCore + " to CoreSelector.sv_iSelector");

                           HmiVariableService hmiVarService = HmiVariableService.getService();
                           KVariable kvarCoreSelector = hmiVarService.getVariable(sv_CoreSelector);

                           hmiVarService.writeValue(kvarCoreSelector, new Integer(selectionCore + 1), false);
                           selectionCoreLast = selectionCore + 1;
                        } catch (Exception e1) {
                           CAT.error("Unable to write to CoreSelector.sv_iSelector");
                        }

                        listCoreSelectionButtons[selectionCore].setBackground(KvConstants.COL_FG_SELECTED);
                        CAT.info("Selected Core (Index): " + selectionCore);

                        dialogCore.repaint();
                     }

                  }
               });

               panelContent.add(button);

               // Store references to buttons inside an array
               listCoreSelectionButtons[i] = button;
            }

            dialogCore.getContent().add(panelContent);

            // Set the minimum size of the dialog
            if (dialogCore.getMinimumSize().width < MIN_WIDTH_DIALOG) {
               dialogCore.setContentInsets(10, 35, 10, 35);
            }

            dialogCore.pack();

            // Initialize the initial core
            try {
               listCoreSelectionButtons[selectionCore - 1].setBackground(KvConstants.COL_FG_SELECTED);
            } catch (ArrayIndexOutOfBoundsException e) {
               if (coreCount > 2) {
                  CAT.error(e.getMessage(), e);
               }

               return;
            }

            // Calculate dialog position and show dialog
            Dimension dimension = dialogCore.getSize();
            int dimWidth = dimension.width;
            dialogCore.showDialog(678 / 2 - dimWidth / 2, 250);
            dialogCore.requestFocus();
         }

         // CREATE AIRVALVE DIALOG FUNCTIONALITY
      } else if (keyCode == KEY_CODE_AIRVALVE) {

         if (dialogAirValveIsOpen) {
            dialogAirValve.close();
            dialogAirValveIsOpen = false;
            return;
         }

         // Get AirValve count
         int airValveCount = 0;
         for (int i = 1; i <= MAX_CNT_AIRVALVES; i++) {
            if (MachineEquipment.doesDeviceExist("AirValve" + i)) {
               airValveCount++;
            }
         }

         // Only open dialog if their are airValves available
         if (airValveCount == 0) {
            CAT.info("Since the airValce count is 0 the dialog for selecting an airValve is not opened");
            return;
         }

         // Get the airValve that was selected last time
         HmiVariableService hmiVarService = HmiVariableService.getService();
         KVariable kvarAirValveSelector = null;
         try {
            kvarAirValveSelector = hmiVarService.getVariable(sv_AirValveSelector);
            hmiVarService.readValue(kvarAirValveSelector);
            selectionAirValve = kvarAirValveSelector.getIntValue();
         } catch (Exception e) {

            if (airValveCount > 2) {
               CAT.error("Unable to load AirValveSelector.sv_iSelector");
            }
         }

         listAirValveSelectionButtons = new KvButton[airValveCount];

         if (!dialogAirValveIsOpen) {
            dialogAirValveIsOpen = true;
            CAT.info("AirValve selection dialog requested.");

            // Create air valve selection dialog
            Locale locale = LanguageManager.sharedInstance().getLanguage().getLocale();
            ResourceBundle textBundle = ResourceBundle.getBundle(RESOURCE_BUNDLE, locale);
            dialogAirValve = new KvDialog(KvDialog.NONE, textBundle.getString("airValveSelection"), false);

            // Create dialog content
            KvPanel panelContent = new KvPanel();
            panelContent.setLayout(new FlowLayout());

            // Create selection buttons
            for (int i = 0; i < airValveCount; i++) {
               final int index = i;
               KvButton button = new KvButton(String.valueOf(i + 1));

               button.addActionListener(new ActionListener() {

                  public void actionPerformed(ActionEvent e) {
                     boolean isDeviceReady = false;
                     KVariable kvarCurrentAirValve = null;

                     // While moving a airValve it is not possible to
                     // select another airValve
                     try {
                        HmiVariableService hmiVarService = HmiVariableService.getService();
                        if (selectionAirValveLast == -1) {
                           kvarCurrentAirValve = hmiVarService.getVariable("AirValve" + selectionAirValve + ".sv_bDeviceReady");
                        } else {
                           kvarCurrentAirValve = hmiVarService.getVariable("AirValve" + selectionAirValveLast + ".sv_bDeviceReady");
                        }

                        hmiVarService.readValue(kvarCurrentAirValve);
                        isDeviceReady = kvarCurrentAirValve.getBooleanValue();
                     } catch (Exception e1) {
                        CAT.error("Unable to read AirValve" + selectionAirValve + ".sv_bDeviceReady");
                     }

                     if (isDeviceReady) {

                        CAT.info("Clear selection");
                        for (int i = 0; i < listAirValveSelectionButtons.length; i++) {
                           listAirValveSelectionButtons[i].setBackground(null);
                        }

                        selectionAirValve = index;

                        // Write the selected button to the PLC
                        try {
                           int debugSelectionAirValve = selectionAirValve + 1;
                           CAT.info("Writing: " + debugSelectionAirValve + " to AirValveSelector.sv_iSelector");

                           HmiVariableService hmiVarService = HmiVariableService.getService();
                           KVariable kvarAirValveSelector = hmiVarService.getVariable(sv_AirValveSelector);

                           hmiVarService.writeValue(kvarAirValveSelector, new Integer(selectionAirValve + 1), false);
                           selectionAirValveLast = selectionAirValve + 1;
                        } catch (Exception e1) {
                           CAT.error("Unable to write to AirValveSelector.sv_iSelector");
                        }

                        listAirValveSelectionButtons[selectionAirValve].setBackground(KvConstants.COL_FG_SELECTED);
                        CAT.info("Selected AirValve (Index): " + selectionAirValve);

                        dialogAirValve.repaint();
                     }

                  }
               });

               panelContent.add(button);

               // Store references to buttons inside an array
               listAirValveSelectionButtons[i] = button;
            }

            dialogAirValve.getContent().add(panelContent);

            // Set the minimum size of the dialog
            if (dialogAirValve.getMinimumSize().width < MIN_WIDTH_DIALOG) {
               dialogAirValve.setContentInsets(10, 35, 10, 35);
            }

            dialogAirValve.pack();

            try {
               listAirValveSelectionButtons[selectionAirValve - 1].setBackground(KvConstants.COL_FG_SELECTED);
            } catch (ArrayIndexOutOfBoundsException e) {
               if (airValveCount > 2) {
                  CAT.error(e.getMessage(), e);
               }

               return;
            }

            // Calculate dialog position and show dialog
            Dimension dimension = dialogAirValve.getSize();
            int dimWidth = dimension.width;
            dialogAirValve.showDialog(678 / 2 - dimWidth / 2, 350);
            dialogAirValve.requestFocus();
         }

      }
   }

}
