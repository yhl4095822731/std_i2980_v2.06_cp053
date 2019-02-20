package viewedit.function;

import com.ibm.log4j.Category;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KNumber;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.plc.variable.VartypeException;
import com.keba.keplast.general.functiontypes.DeviceName;
import com.keba.keplast.general.functiontypes.JavaResultFromString;
import com.keba.keplast.general.functiontypes.MachineOptionID;
import com.keba.keplast.general.functiontypes.VariableAsString;

import system.hmi.MachineEquipment;

/***********************************************************************************
 * 
 * User functions for the Dynamic -----------------------------
 * 
 * This file offers you the possibility to create self made functions, which you can use for the
 * Dynamic of Widgets.
 * 
 ***********************************************************************************/

public class UserFunctions {

   /********************************************************************************
    * Example: ***************************************************************** ************* //
    * Unique static public Function with the return type boolean // and at least one Variable as
    * Parameter. public static boolean P1_And_P2GreaterP3(KVariable p1, int p2, KVariable p3) {
    * 
    * try { if ((p1.getIntValue() + p2) > p3.getIntValue()) { return true; } } catch
    * (VartypeException e) { e.printStackTrace(); return false; }
    * 
    * return false; }
    * 
    * // The following function is needed for every variable parameter. // The name is the upper
    * function + "_Var" + the count of the Parameter. // The return value is a string array with the
    * data types which are allowed for this Parameter. public static String[]
    * P1_And_P2GreaterP3_Var1() { return new String[] { "INT", "DINT" }; }
    * 
    * public static String[] P1_And_P2GreaterP3_Var2() { return new String[] { "INT" }; }
    */

   /**
    * Checks if the given device exists on machine.
    * 
    * @see MachineEquipment#doesDeviceExist(DeviceName)
    * @param deviceName
    * @return <code>true</code> if given device exists, otherwise <code>false</code>
    */
   public static boolean doesDeviceExist(DeviceName deviceName) {
      return MachineEquipment.doesDeviceExist(deviceName);
   }

   /**
    * Checks if the given device1 or the given device2 exists on machine.
    * 
    * @param deviceName1
    * @param deviceName2
    * @return <code>true</code> if device1 or device2 exists, otherwise <code>false</code>
    */
   public static boolean doesDeviceExist_OR_doesDeviceExist(DeviceName deviceName1, DeviceName deviceName2) {
      return MachineEquipment.doesDeviceExist(deviceName1) || MachineEquipment.doesDeviceExist(deviceName2);
   }

   /**
    * Check if variable already exists on machine.
    * 
    * @see MachineEquipment#doesVariableExist(VariableAsString)
    * @param variableName
    * @return <code>true</code> if variable exists, otherwise <code>false</code>
    */
   public static boolean doesVariableExist(VariableAsString variableName) {
      return MachineEquipment.doesVariableExist(variableName);
   }

   /**
    * Checks if both given variables are existing system variables on machine.
    * 
    * @see MachineEquipment#doesVariableExist(VariableAsString)
    * @param variable1
    * @param variable2
    * @return <code>true</code> if both variables exist, otherwise <code>false</code>
    */
   public static boolean doesVariableExist_AND_doesVariableExist(VariableAsString variable1, VariableAsString variable2) {
      return MachineEquipment.doesVariableExist(variable1) && MachineEquipment.doesVariableExist(variable2);
   }

   /**
    * Checks if one of the given variables exists as system variable on machine.
    * 
    * @see MachineEquipment#doesVariableExist(VariableAsString)
    * @param variable1
    * @param variable2
    * @return <code>true</code> if one of the variables exist, otherwise <code>false</code>
    */
   public static boolean doesVariableExist_OR_doesVariableExist(VariableAsString variable1, VariableAsString variable2) {
      return MachineEquipment.doesVariableExist(variable1) || MachineEquipment.doesVariableExist(variable2);
   }

   /**
    * Checks if given machine option for given device is available on machine.
    * 
    * @see MachineEquipment#hasOption(DeviceName, MachineOptionID)
    * 
    * @param deviceName
    * @param machineOption
    * @return <code>true</code> if device has given option, otherwise <code>false</code>
    */
   public static boolean hasOption(DeviceName deviceName, MachineOptionID machineOption) {
      return MachineEquipment.hasOption(deviceName, machineOption);
   }

   /**
    * Checks if both given machine options for given device are available on machine.
    * 
    * @see MachineEquipment#hasOption(String, MachineOptionID)
    * 
    * @param deviceName
    * @param machineOption1
    * @param machineOption2
    * @return <code>true</code> if device has both given options, otherwise <code>false</code>
    */
   public static boolean hasOption_AND_hasOption(DeviceName deviceName, MachineOptionID machineOption1, MachineOptionID machineOption2) {
      return MachineEquipment.hasOption(deviceName, machineOption1) && MachineEquipment.hasOption(deviceName, machineOption2);
   }

   /**
    * Checks if one option is available and the other is NOT available for given device.
    * 
    * @see MachineEquipment#hasOption(DeviceName, MachineOptionID)
    * 
    * @param deviceName
    * @param machineOption1
    * @param machineOption2
    * @return <code>true</code> if machineOption1 is available and machineOption2 not, otherwise
    *         <code>false</code>
    */
   public static boolean hasOption_AND_NOT_hasOption(DeviceName deviceName, MachineOptionID machineOption1,
         MachineOptionID machineOption2) {
      return MachineEquipment.hasOption(deviceName, machineOption1) && !MachineEquipment.hasOption(deviceName, machineOption2);
   }

   /**
    * Checks if given option is available on machine and also given variable exists on machine. The
    * variable can also exist in other deivce.
    * 
    * @see MachineEquipment#hasOption(DeviceName, MachineOptionID)
    * @see MachineEquipment#doesVariableExist(VariableAsString)
    * 
    * @param deviceName
    * @param machineOption
    * @param variable
    * @return <code>true</code> if device has option and variable exists on machine, otherwise
    *         <code>false</code>
    */
   public static boolean hasOption_AND_doesVariableExist(DeviceName deviceName, MachineOptionID machineOption, VariableAsString variable) {
      return MachineEquipment.hasOption(deviceName, machineOption) && MachineEquipment.doesVariableExist(variable);
   }

   /**
    * Checks if one of the given machine options for given device is available on machine.
    * 
    * @see MachineEquipment#hasOption(String, MachineOptionID)
    * 
    * @param deviceName
    * @param machineOption1
    * @param machineOption2
    * @return <code>true</code> if device has one of the given options, otherwise <code>false</code>
    */
   public static boolean hasOption_OR_hasOption(DeviceName deviceName, MachineOptionID machineOption1, MachineOptionID machineOption2) {
      return MachineEquipment.hasOption(deviceName, machineOption1) || MachineEquipment.hasOption(deviceName, machineOption2);
   }

   /**
    * Checks if given device has one option or has not the second option on machine.
    * 
    * @see MachineEquipment#hasOption(DeviceName, MachineOptionID)
    * 
    * @param deviceName
    * @param machineOption1
    * @param machineOption2
    * @return <code>true</code> if machineOption1 is available or machineOption2 not, otherwise
    *         <code>false</code>
    */
   public static boolean hasOption_OR_NOT_hasOption(DeviceName deviceName, MachineOptionID machineOption1, MachineOptionID machineOption2) {
      return MachineEquipment.hasOption(deviceName, machineOption1) || !MachineEquipment.hasOption(deviceName, machineOption2);
   }

   /**
    * Checks if given option is available on machine or given variable exists on machine. The
    * variable can also exist in other deivce.
    * 
    * @see MachineEquipment#hasOption(DeviceName, MachineOptionID)
    * @see MachineEquipment#doesVariableExist(VariableAsString)
    * 
    * @param deviceName
    * @param machineOption
    * @param variable
    * @return <code>true</code> if device has option or variable exists on machine, otherwise
    *         <code>false</code>
    */
   public static boolean hasOption_OR_doesVariableExist(DeviceName deviceName, MachineOptionID machineOption, VariableAsString variable) {
      return MachineEquipment.hasOption(deviceName, machineOption) || MachineEquipment.doesVariableExist(variable);
   }

   /**
    * Checks if machine has any available motor device.
    * 
    * @see MachineEquipment#hasAnyMotor()
    * @return <code>true</code> if any motor device is available, otherwise <code>false</code>
    */
   public static boolean hasAnyMotor() {
      return MachineEquipment.hasAnyMotor();
   }

   /**
    * Checks if machine has any servo drive.
    * 
    * @see MachineEquipment#hasServoDrives()
    * @return <code>true</code> if any servo drive is available, otherwise <code>false</code>
    */
   public static boolean hasServoDrives() {
      return MachineEquipment.hasServoDrives();
   }

   /**
    * Checks if machine has any available pump device.
    * 
    * @see MachineEquipment#hasAnyPump()
    * @return <code>true</code> if any pump device is available, otherwise <code>false</code>
    */
   public static boolean hasAnyPump() {
      return MachineEquipment.hasAnyPump();
   }

   /**
    * Check if a speedpump is configured
    * 
    * @return <code>true</code> if a speedpump is configured.
    */
   public static boolean hasSpeedPump() {
      return MachineEquipment.hasSpeedPump();
   }

   /**
    * Checks if at least one slave is configured for the speedpump.
    * 
    * @see MachineEquipment#hasSpeedPumpAndOneSlave()
    * @return <code>true</code> if at least one slave is configured.
    */
   public static boolean hasSpeedPumpAndOneSlave() {
      return MachineEquipment.hasSpeedPumpAndOneSlave();
   }

   /**
    * Checks if at least two slaves are configured for the speedpump.
    * 
    * @see MachineEquipment#hasSpeedPumpAndTwoSlaves()
    * @return <code>true</code> if at least two slaves are configured.
    */
   public static boolean hasSpeedPumpAndTwoSlaves() {
      return MachineEquipment.hasSpeedPumpAndTwoSlaves();
   }

   /**
    * Checks if inject or system pressure sensor are available and machine has no speed pump.
    * 
    * @return <code>true</code> if machine has an inject or system pressure sensor and has no speed
    *         pump.
    */
   public static boolean hasInjectOrSysPressSensor_AND_hasNoSpeedPump() {
      return (MachineEquipment.doesVariableExist("Injection1.ai_Pressure") || MachineEquipment
            .doesVariableExist("Injection1.ai_SysPressure")) && !MachineEquipment.hasSpeedPump();
   }

   /**
    * Checks if machine is ODC system and have machine sequecer option. <b>Note:</b> teach mode
    * allowed is not checked with this function!
    * 
    * @see MachineEquipment#hasMachineSequenzer()
    * @return <code>true</code> if machine sequencer is available, otherwise <code>false</code>
    */
   public static boolean hasMachineSequenzer() {
      return MachineEquipment.hasMachineSequenzer();
   }

   /**
    * Checks if machine has safety editor.
    * 
    * @see MachineEquipment#hasSafetyEditor()
    * 
    * @return <code>true</code> if safety editor is available, otherwise <code>false</code>
    */
   public static boolean hasSafetyEditor() {
      return MachineEquipment.hasSafetyEditor();
   }

   /**
    * Checks if given device by name is an hydraulic controlled device.
    * 
    * @see MachineEquipment#isDeviceHydraulic(DeviceName)
    * 
    * @param deviceName
    * @return <code>true</code> if device is hydraulic controlled, otherwise <code>false</code>
    */
   public static boolean isDeviceHydraulic(DeviceName deviceName) {
      return MachineEquipment.isDeviceHydraulic(deviceName);
   }

   /**
    * Checks if given device by name is an electric controlled device.
    * 
    * @see MachineEquipment#isDeviceElectric(DeviceName)
    * 
    * @param deviceName
    * @return <code>true</code> if device is electric controlled, otherwise <code>false</code>
    */
   public static boolean isDeviceElectric(DeviceName deviceName) {
      return MachineEquipment.isDeviceElectric(deviceName);
   }

   /**
    * Checks if machine is ODC system.
    * 
    * @see MachineEquipment#isODCSystem()
    * @return <code>true</code> if machine is ODC system, otherwise <code>false</code>
    */
   public static boolean isODCSystem() {
      return MachineEquipment.isODCSystem();
   }

   /**
    * Special function which interprets the given string as java code and generates a "real" code in
    * mask.
    * 
    * @param function
    * @return boolean result from function
    */
   public static boolean spezialCodeFunction(JavaResultFromString function) {
      return function.getResult();
   }

   /**
    * Check if the string variable is null or empty (length = 0).
    * 
    * @param variableName
    * @return <code>true</code> if variable is null or empty, otherwise <code>false</code>
    */
   public static boolean isStringVariableEmpty(KVariable variable) {
      HmiVariableService hmiService;
      String varValue;

      try {
         hmiService = HmiVariableService.getService();
         if (variable == null) {
            return true;
         }
         hmiService.readValue(variable);
         varValue = variable.getStringValue();
         if (varValue == null) {
            return true;
         }
         if (varValue.length() == 0) {
            return true;
         }
      } catch (Exception ex) {
         Category.getInstance("UserFunctions").error("isStringVariableEmpty: ", ex);
      }
      return false;
   }

   /**
    * @param device1
    *           that needs to exist
    * @param machineOption
    *           that needs to exist
    * @return true if device1 with machineOption exists.
    */
   public static boolean doesDeviceExist_AND_hasOption(DeviceName device1, MachineOptionID machineOption) {
      if (MachineEquipment.doesDeviceExist(device1) && MachineEquipment.hasOption(device1, machineOption)) {
         return true;
      } else
         return false;
   }

   /**
    * @param n1
    *           variable to check
    * @param p1
    *           first value to check
    * @param p2
    *           second value to check
    * @return true if the variable n1 equals p1 or p2
    * 
    * @todo add more convenient function to ViewEdit to cover arbitrary number of doubles
    */
   public static boolean n1_EQ_p1_OR_p2(KVariable n1, double p1, double p2) {

      if (n1 instanceof KNumber) {
         try {
            return (n1.getDoubleValue() == p1 || n1.getDoubleValue() == p2);
         } catch (VartypeException e) {
            Category.getInstance("UserFunctions").error("n1_EQ_p1_OR_p2: ", e);
            return false;
         }
      }
      return false;
   }

   /**
    * @param n1
    *           variable to check
    * @param p1
    *           first value to check
    * @param p2
    *           second value to check
    * @param p3
    *           third value to check
    * @return true if the variable n1 equals p1 or p2 or p3
    * 
    * @todo add more convenient function to ViewEdit to cover arbitrary number of doubles
    */
   public static boolean n1_EQ_p1_OR_p2_OR_p3(KVariable n1, double p1, double p2, double p3) {

      if (n1 instanceof KNumber) {
         try {
            return (n1.getDoubleValue() == p1 || n1.getDoubleValue() == p2 || n1.getDoubleValue() == p3);
         } catch (VartypeException e) {
            Category.getInstance("UserFunctions").error("n1_EQ_p1_OR_p2_OR_p3: ", e);
            return false;
         }
      }
      return false;
   }

   /**
    * Check if b1 or b2 is true or the string variable is null or empty (length = 0)
    * 
    * @param b1
    *           boolean variable1
    * @param b2
    *           boolean variable2
    * @param stringVar
    *           string variable which is checked, if it is empty
    * @return <code>true</code> if b1 or b2 is <code>true</code> or string variable is null or empty
    *         , otherwise <code>false</code>
    */
   public static boolean b1_OR_b2_OR_isStringVariableEmpty(KVariable b1, KVariable b2, KVariable stringVar) {
      return (ViewEditFunctions.b1_OR_b2(b1, b2) || isStringVariableEmpty(stringVar));
   }

   /**
    * Checks if Device1 exists or if Device2 is electric
    * 
    * @param deviceName1
    *           Device1
    * @param deviceName2
    *           Device2
    * @return <code>true</code> if Device1 exists or Device2 is electric, otherwise
    *         <code>false</code>
    */
   public static boolean doesDeviceExist_OR_isDeviceElectric(DeviceName deviceName1, DeviceName deviceName2) {
      return (doesDeviceExist(deviceName1) || isDeviceElectric(deviceName2));
   }

   /**
    * Checks if Variable exists or if Device is electric
    * 
    * @param variableName
    *           Variable
    * @param deviceName
    *           Device
    * @return <code>true</code> if Variable exists or Device is electric, otherwise
    *         <code>false</code>
    */
   public static boolean doesVariableExist_OR_isDeviceElectric(VariableAsString variableName, DeviceName deviceName) {
      return (doesVariableExist(variableName) || isDeviceElectric(deviceName));
   }

   /**
    * Checks if Variable exists or if Device is electric or speed pump is configured.
    * 
    * @param variableName
    *           Variable
    * @param deviceName
    *           Device
    * @return <code>true</code> if Variable exists or Device is electric, otherwise
    *         <code>false</code>
    */
   public static boolean doesVariableExist_OR_isDeviceElectric_OR_hasSpeedPump(VariableAsString variableName, DeviceName deviceName) {
      return doesVariableExist_OR_isDeviceElectric(variableName, deviceName) || hasSpeedPump();
   }

   /**
    * Checks if n1 is greater than p1 or n2 is greater than p2.
    * 
    * @param n1
    *           numeric variable1
    * @param p1
    *           constant value1
    * @param n2
    *           numeric variable2
    * @param p2
    *           constant value2
    * @return <code>true</code> if <code>n1 > p1 || n2 > p2</code>
    */
   public static boolean n1_GT_const1_OR_n2_GT_const2(KVariable n1, double p1, KVariable n2, double p2) {
      return ViewEditFunctions.n1_GT_const(n1, p1) || ViewEditFunctions.n1_GT_const(n2, p2);
   }

   /**
    * Checks if machine has any available pump device and value of n1 >= p1
    * 
    * @param n1
    *           numeric variable1
    * @param p1
    *           constant value1
    * @return
    */
   public static boolean hasAnyPump_AND_n1_GE_const(KVariable n1, double p1) {
      return hasAnyPump() && ViewEditFunctions.n1_GE_const(n1, p1);
   }

   /**
    * Checks if the current package is a test-version
    * 
    * @return <code>true</code> if package is a test-version <code>false</code>
    */
   public static boolean displayTestVersionWarningLabel() {
      return MachineEquipment.isTestVersion() || MachineEquipment.isApplPatched();
   }
}
