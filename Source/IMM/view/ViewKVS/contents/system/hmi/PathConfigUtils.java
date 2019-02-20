package system.hmi;

import java.util.Locale;

import com.keba.kemro.jni.SystemInfo;
import com.keba.kemro.kvs.util.KvsConfig;
import com.keba.kemro.plc.service.HmiSystemService;

/**
 * Utility class for initializing path configuration, depending on OS of client (HMI) and server
 * (CP).<br>
 * <br>
 * NOTE: This class replaces the static path configuration from applCfg.properties.<br>
 * IMPORTANT: This dynamic configuration does NOT override a static config entry in
 * applCfg.properties!!! see {@link KvsConfig#putDefault(Object, Object)}
 * 
 * @since KePlast.HMI.KVS_01.42
 * @author steg
 * 
 */
public class PathConfigUtils {
   private final static String REL_PATH_PROT_SCREENSHOTS = "protocol/screenshots|screenshots";
   private final static String REL_PATH_PROT_PDP = "protocol/ms_data/pdp|pdp path";
   private final static String REL_PATH_PROT_LOG = "protocol/log|log path";
   private final static String REL_PATH_PROT_STAREP = "protocol/statusreport|statusreport";
   private final static String REL_PATH_PROT_CRASHREP = "protocol/crashreport|crash report";
   private final static String REL_PATH_DATA_MOLDDATA = "workspace/data/molddata|mold data";
   private final static String REL_PATH_DATA_MACHINEDATA = "workspace/data/machinedata|machine data";
   private final static String REL_PATH_PERSIST_DRIVES = "drives";
   private final static String REL_PATH_PERSIST_SWO = "swo|swo";
   private final static int MAX_NR_USB_PORTS = 4;

   /**
    * Initializes all path settings, depending on OS of client (HMI) and server (CP)
    */
   public static void initPaths() {
      // ########## Client paths (HMI) ##########

      // Printer & Screenshots
      KvsConfig.getInstance().putDefault("PrintSaveRoots",
            createAbsProtocolPath(REL_PATH_PROT_SCREENSHOTS) + ";" + getAllUSBPaths(false));
      KvsConfig.getInstance().putDefault("PrintImgDir", createAbsProtocolPath(REL_PATH_PROT_SCREENSHOTS));

      // Explorer
      String explorerRoots = getApplDiskPath();
      if (!getMasterDiskPath().equals(getApplDiskPath())) {
         explorerRoots = explorerRoots + getMasterDiskPath();
      }
      explorerRoots = explorerRoots + getAllUSBPaths(false);
      KvsConfig.getInstance().putDefault("ExplorerRoots", explorerRoots);
      KvsConfig.getInstance().putDefault("ExplorerDefaultDrive",
            getApplDiskPath());

      // PDP/SPC
      KvsConfig.getInstance().putDefault("PdpSaveRoots",
            createAbsProtocolPath(REL_PATH_PROT_PDP) + ";" + getAllUSBPaths(false));

      // Inject graph
      KvsConfig.getInstance().putDefault("InjectSaveRoots", getAllUSBPaths(false));

      // Sw Oszi
      KvsConfig.getInstance().putDefault("SwoSaveRoots", getAllUSBPaths(false));
      KvsConfig.getInstance().putDefault("SwoSaveSetup", createAbsPersistencePath(REL_PATH_PERSIST_SWO) + ";" + getAllUSBPaths(false));

      // Infolog
      KvsConfig.getInstance().putDefault("InfologSaveRoots", createAbsProtocolPath(REL_PATH_PROT_LOG) + ";" + getAllUSBPaths(false));

      // USB ports
      KvsConfig.getInstance().putDefault("UsbDirectoryList", getAllUSBPaths(false));

      // ########## Server paths (CP) ##########
      // Additional server drives for recipe masks ("local" is added by default)
      KvsConfig.getInstance().putDefault("RecipeDrivesServer", getAllUSBPaths(true));

      // Status report
      KvsConfig.getInstance().putDefault("StarepSaveRoots", createAbsStaRepProtocolPath(REL_PATH_PROT_STAREP) + ";" + getAllUSBPaths(true));

      // Drivemonitor
      KvsConfig.getInstance().putDefault("DriveMonCfg", createAbsPersistencePath(REL_PATH_PERSIST_DRIVES) + "/deviceconf.xml");
      KvsConfig.getInstance().putDefault("SharedDriveNames", createAbsPersistencePath(REL_PATH_PERSIST_DRIVES));
   }

   /**
    * Create absolute protocol path depending on OS of client (HMI)
    * 
    * @param relPath
    *           Relative path + name (separated by "|")
    * @return Absolute path
    */
   public static String createAbsProtocolPath(String relPath) {
      if (SystemInfo.getOSType() == SystemInfo.OS_LINUX) {
         return "/workspace/" + relPath;
      } else {
         // VxWorks and Windows are treated equally
         return "/" + relPath;
      }
   }

   /**
    * Create absolute status report protocol path depending on OS of server (CP)
    * 
    * @param relPath
    *           Relative path + name (separated by "|")
    * @return Absolute path
    */
   public static String createAbsStaRepProtocolPath(String relPath) {
      int osType = com.keba.keplast.utils.SystemInfo.getInstance().getOSName().toLowerCase(Locale.ENGLISH).equals("linux")
            ? SystemInfo.OS_LINUX
            : SystemInfo.OS_VX_WORKS;
      if (osType == SystemInfo.OS_LINUX) {
         return "/masterdisk/" + relPath;
      } else {
         // VxWorks and Windows are treated equally
         return "/" + relPath;
      }
   }

   /**
    * Create absolute persistence path depending on OS of server (CP)
    * 
    * @param relPath
    *           Relative path
    * @return Absolute path
    */
   public static String createAbsPersistencePath(String relPath) {
      return HmiSystemService.getService().getPersitencePath() + relPath;
   }

   /**
    * Get absolute path of application disk of client (HMI)
    * 
    * @return Application disk path
    */
   public static String getApplDiskPath() {
      if (SystemInfo.getOSType() == SystemInfo.OS_LINUX) {
         return "/appldisk;";
      } else {
         return "/harddisk0;";
      }
   }

   /**
    * Get absolute path of master disk of client (HMI)
    * 
    * @return Master disk path
    */
   public static String getMasterDiskPath() {
      if (SystemInfo.getOSType() == SystemInfo.OS_LINUX) {
         return "/masterdisk;";
      } else {
         return "/harddisk0;";
      }
   }

   /**
    * Returns the default relative status report path
    * 
    * @return the default relative status report path
    */
   public static String getDefaultStarepPathRel() {
      return REL_PATH_PROT_STAREP.substring(0, REL_PATH_PROT_STAREP.indexOf('|'));
   }

   /**
    * Returns the default relative screenshot path
    * 
    * @return the default relative screenshot path
    */
   public static String getDefaultScreenShotPathRel() {
      return REL_PATH_PROT_SCREENSHOTS.substring(0, REL_PATH_PROT_SCREENSHOTS.indexOf('|'));
   }

   /**
    * Returns the default relative crash report path
    * 
    * @return the default relative crash report path
    */
   public static String getDefaultCrashReportPathRel() {
      return REL_PATH_PROT_CRASHREP.substring(0, REL_PATH_PROT_CRASHREP.indexOf('|'));
   }

   /**
    * Returns the default relative machine data path
    * 
    * @return the default relative machine data path
    */
   public static String getDefaultMachineDataPathRel() {
      return REL_PATH_DATA_MACHINEDATA.substring(0, REL_PATH_DATA_MACHINEDATA.indexOf('|'));
   }

   /**
    * Returns the default relative mold data path
    * 
    * @return the default relative mold data path
    */
   public static String getDefaultMoldDataPathRel() {
      return REL_PATH_DATA_MOLDDATA.substring(0, REL_PATH_DATA_MOLDDATA.indexOf('|'));
   }

   /**
    * Returns the default relative PDP log path
    * 
    * @return the default relative PDP log path
    */
   public static String getDefaultPdpPathRel() {
      return REL_PATH_PROT_PDP.substring(0, REL_PATH_PROT_PDP.indexOf('|'));
   }

   /**
    * Create the absolute path(s) (and optionally name(s), separated by a "|") of a USB mount,
    * depending on OS.
    * 
    * @param usbPort
    *           Number of port
    * @param fromServer
    *           <code>true</code> if paths from server should be used
    * @param withName
    *           <code>true</code> if name of USB port should be added to path
    * @return Path (and name)
    */
   public static String createUSBPath(int usbPort, boolean fromServer, boolean withName) {
      int osType = SystemInfo.OS_VX_WORKS;
      if (fromServer) {
         osType = com.keba.keplast.utils.SystemInfo.getInstance().getOSName().toLowerCase(Locale.ENGLISH).equals("linux")
               ? SystemInfo.OS_LINUX : osType;
      } else {
         osType = SystemInfo.getOSType();
      }

      if (osType == SystemInfo.OS_LINUX) {
         String usbName = withName ? "|USB" + usbPort + ";" : "|";
         return "/run/usbmount/topo/usb" + usbPort + usbName;
      } else {
         if (usbPort == 0) {
            if (withName) {
               return ("/usbmassstorage.0|USB0;/usbmassstorage.0.0|USB0;/usbmassstorage.0.1|USB0;/usbmassstorage.0.0.1|USB0;/usbmassstorage.0.0.0|USB0;/usbmassstorage.0.1.1|USB0;/usbmassstorage.0.1.0|USB0;");
            } else {
               return ("usbmassstorage.0|usbmassstorage.0.0|usbmassstorage.0.1|usbmassstorage.0.0.1|usbmassstorage.0.0.0|usbmassstorage.0.1.1|usbmassstorage.0.1.0|");
            }
         } else if (usbPort == 1) {
            if (withName) {
               return ("/usbmassstorage.1|USB1;/usbmassstorage.1.0|USB1;/usbmassstorage.1.1|USB1;/usbmassstorage.1.0.1|USB1;/usbmassstorage.1.0.0|USB1;/usbmassstorage.1.1.1|USB1;/usbmassstorage.1.1.0|USB1;");
            } else {
               return ("usbmassstorage.1|usbmassstorage.1.0|usbmassstorage.1.1|usbmassstorage.1.0.1|usbmassstorage.1.0.0|usbmassstorage.1.1.1|usbmassstorage.1.1.0|");
            }
         }
      }

      return "";
   }

   /**
    * Create the absolute path(s) and name(s) (separated by a "|") of a USB mount, depending on OS.
    * 
    * @param usbPort
    *           Number of port
    * @param fromServer
    *           <code>true</code> if paths from server should be used
    * @return Path (and name)
    */
   public static String createUSBPath(int usbPort, boolean fromServer) {
      return createUSBPath(usbPort, fromServer, true);
   }

   /**
    * Get all USB paths (and optionally names, separated by a "|")
    * 
    * @param fromServer
    *           <code>true</code> if paths from server should be used
    * @param withName
    *           <code>true</code> if name of USB ports should be added to paths
    * 
    * @return All USB paths (and names)
    */
   public static String getAllUSBPaths(boolean fromServer, boolean withName) {
      String usbPaths = "";
      for (int i = 0; i < MAX_NR_USB_PORTS; i++) {
         usbPaths = usbPaths + createUSBPath(i, fromServer, withName);
      }

      return usbPaths;
   }

   /**
    * Get all USB paths and names (separated by a "|").
    * 
    * @param fromServer
    *           <code>true</code> if paths from server should be used
    * 
    * @return All USB paths and names
    */
   public static String getAllUSBPaths(boolean fromServer) {
      return getAllUSBPaths(fromServer, true);
   }

}
