package system.hmi;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.ResourceBundle;

import com.ibm.log4j.Category;
import com.keba.kemro.jni.NativeSystem;
import com.keba.kemro.kv.control.KvMask;
import com.keba.kemro.kvs.keplast.control.user.KUserLogin;
import com.keba.kemro.kvs.keplast.control.util.AlarmMaskFooler;
import com.keba.kemro.kvs.widgets.KvsMaskChangeButton;
import com.keba.kemro.plc.catalog.KCatSInt32Obj;
import com.keba.kemro.plc.event.ExceptionListener;
import com.keba.kemro.plc.service.HmiIOService;
import com.keba.kemro.plc.service.HmiSystemService;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.keplast.simulation.Simulation;
import com.keba.keplast.utils.SystemInfo;
import com.keba.keplast.widgets.menu.MainMenuBar;
import com.keba.util.UserManager;

import Dialogs.hmi.KeySelectorDialog;

public abstract class AbsMainBaseKVS extends AbsMainBase {

   private static Category CAT = Category.getInstance(AbsMainBaseKVS.class.getName());

   protected MainMenuBar mainMenu = MainMenuBar.getInstance();

   private String mTextIdWarningLabel;

   private static long initStartTime;

   private static StartupState startupState;
   private static KVariable startupStateHMIVar;
   private static HmiVariableService hmiService;

   static {
      trace("Initializing HMI.KVS application ...");
      initStartTime = System.currentTimeMillis();
      startupState = new StartupState(StartupState.RUNNING);

      // Initialize (Non-Productive) System test
      try {
         Class systemTestClass = Class.forName("system.hmi.test.system.SystemTest");
         Method systemTestInitMethod = systemTestClass.getMethod("init", null);
         systemTestInitMethod.invoke(null, null);
         hmiService = HmiVariableService.getService();
         startupStateHMIVar = hmiService.getTempVariable("SystemTest.sv_StartupStateHMI", null, false);
         HmiVariableService.addExceptionListener(new StartupExceptionListener());
      } catch (Exception e) {
         // Nothing to do, if SystemTest does not exist
      }
   }

   public AbsMainBaseKVS() throws Exception {
      super();
      try {
         // waits for initialization done in simulation mode, otherwise the heating and
         // movement icons does not work right.
         Simulation.getInstance().waitForInitializationOnSimulation();
         initialize();

         // add mouse listener for panel overlay (quick username/password input)
         glassPanelUserData.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent evt) {
               UserManager.getSharedInstance().showUserDialog();
            }
         });

         KeySelectorDialog keySelectorDialog = new KeySelectorDialog();
         keySelectorDialog.initialize();
      } catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   public void Init_Generated() throws Exception {
      super.Init_Generated();

      if (MachineEquipment.isTestVersion())
         mTextIdWarningLabel = "TestVersionLabel";

      if (MachineEquipment.isApplPatched())
         mTextIdWarningLabel = "PatchedAppl";

      changeLocale(Locale.getDefault());
   }

   void initialize() throws Exception {
      super.initialize();

      // activate alarmmaskfooler
      AlarmMaskFooler.activate();

      // systemvariable to write userlevel
      KUserLogin.setUserLevelVariable("system.sv_UserLevel");

      // enable auto login
      KUserLogin.activateKeySwitch();

      // load simulation panel
      Simulation.getInstance().loadSimulation();

      // Init menu
      setBackButton(backButton);

      mainMenu.setMainButtons(new KvsMaskChangeButton[] { maskButtonOverview, maskButtonMold, maskButtonEjector, maskButtonCore,
            maskButtonInjection, maskButtonPlasticize, maskButtonNozzle, maskButtonHeating, maskButtonOperation, maskButtonAlarm });
      mainMenu.setContextButtonsPanel(contextMenu1);
      MainMenuCustomizer.customizeMenu(mainMenu);
      mainMenu.updateContextPane(maskButtonOverview);

      if (HmiSystemService.getService().isLocalStation()) {
         try {
            new MoldDataSetCommand("HostCommunication.sv_HostHmi.dataSet");
         } catch (Exception e) {
            CAT.warn("Feature MoldDataSetCommand(\"HostCommunication.sv_HostHmi.dataSet\") not available");
         }
      }

      new StartupInfo().showIfAvailable();
      new StartupAutoLoad().autoLoad();
   }

   /*
    * (non-Javadoc)
    * 
    * @see system.hmi.AbsMainBase#onShowInitMask()
    */
   protected void onShowInitMask() {
      super.onShowInitMask();

      // Measure startup durations
      long hmiStartupTime = System.currentTimeMillis() - initStartTime;
      trace("Initializing HMI.KVS application done - " + hmiStartupTime + " ms");
      long systemStartupTime = NativeSystem.currentTimeMillis();
      trace("Initializing system done - " + systemStartupTime + " ms");

      // Check startup state
      if (startupState.getCode() == StartupState.RUNNING) {
         startupState.setCode(StartupState.OK);
      }
      trace("HMI.KVS startup state: " + startupState.getCode() + " (" + startupState.toString() + ")");

      if (SystemInfo.getInstance().isLocalStation()) {
         writeStartupValueToCatalog("startupTime", (int) hmiStartupTime);
         writeStartupValueToCatalog("systemStartupTime", (int) systemStartupTime);
         writeStartupState();
      } else {
         // Nothing to do
      }
   }

   /*
    * (non-Javadoc) show mask from KvFrame. Updates the context menu pane.
    * 
    * @see com.keba.kemro.kv.control.KvFrame#showMask(com.keba.kemro.kv.control.KvMask)
    */
   public void showMask(KvMask mask) {
      super.showMask(mask);

      if (mainMenu != null) {
         mainMenu.updateContextPane(mask.getID());
      }
   }

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);
      try {
         textBundle = ResourceBundle.getBundle("system.hmi.text.systemtx",
               locale);

         if (lblTestversion != null) {
            lblTestversion.setLabel(textBundle.getString(mTextIdWarningLabel));
         }
      } catch (Exception ex) {
         ex.printStackTrace();
      }
   }

   protected void maskConstructorFailed() {
      super.maskConstructorFailed();
      startupState.addCode(StartupState.MASK_CREATION_FAILED);
   }

   private static void trace(String line) {
      String prefix = "";
      DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
      prefix = "KVS      " + dateFormat.format(new java.util.Date()) + "| ";
      String str = prefix + line;
      System.out.println(str);
   }

   private void writeStartupState() {
      writeStartupValueToCatalog("startupState", startupState.getCode());
      if (startupStateHMIVar != null) {
         try {
            hmiService.writeValue(startupStateHMIVar, new Integer(startupState.getCode()), false);
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
   }

   private void writeStartupValueToCatalog(String catEntryName, int value) {
      HmiIOService catService = HmiIOService.getService();
      catEntryName = "Application.KePlast.HMI.KVS." + catEntryName;
      KCatSInt32Obj catStartupDurationObj = null;
      try {
         catStartupDurationObj = (KCatSInt32Obj) catService.getIOItem(0, catEntryName);
      } catch (Exception ex) {
         // Catalog node does not exist -> Nothing to do
         return;
      }

      if (catStartupDurationObj != null) {
         try {
            catStartupDurationObj.setValue(value);
            catService.writeIOItem(catStartupDurationObj);
         } catch (Exception ex) {
            CAT.error("writeStartupValueToCatalog: " + catEntryName, ex);
         }
      }
   }

   /**
    * Startup state.
    * 
    * <ul>
    * <li>0: Running</li>
    * <li>1: OK</li>
    * <li>-1: Mask creation failed</li>
    * <li>-2: SV loading failed</li>
    * </ul>
    * 
    * @author steg
    *
    */
   private static class StartupState {
      private static final int RUNNING = 0;
      private static final int OK = 1;
      private static final int MASK_CREATION_FAILED = -0x01;
      private static final int SV_LOADING_FAILED = -0x02;

      private int code;

      public StartupState(int code) {
         setCode(code);
      }

      public void setCode(int code) {
         this.code = code;
      }

      public void addCode(int code) {
         if ((-this.code & -code) == 0) {
            this.code = this.code + code;
         } else {
            // Code already added -> Nothing to do
         }
      }

      public int getCode() {
         return code;
      }

      public String toString() {

         if (code == RUNNING) {
            return "RUNNING";
         } else if (code == OK) {
            return "OK";
         } else {
            String result = "";
            if ((-code & -MASK_CREATION_FAILED) != 0) {
               result = result + "MASK_CREATION_FAILED, ";
            }
            if ((-code & -SV_LOADING_FAILED) != 0) {
               result = result + "SV_LOADING_FAILED, ";
            }

            if (result.length() > 0) {
               return result.substring(0, result.length() - 2);
            } else {
               return "UNKNOWN";
            }
         }
      }
   };

   private static class StartupExceptionListener implements ExceptionListener {

      public void exceptionOccured(String serviceName, String message, Throwable exception, boolean showError, boolean modal) {
         startupState.addCode(StartupState.SV_LOADING_FAILED);
      }

   };
}