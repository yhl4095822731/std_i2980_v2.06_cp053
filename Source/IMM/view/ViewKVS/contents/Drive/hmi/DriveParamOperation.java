package Drive.hmi;

import java.io.IOException;

import com.keba.kemro.kvs.keplast.drive.IDriveParamOperation;
import com.keba.kemro.plc.catalog.KCatAxisObj;
import com.keba.kemro.plc.network.NetworkException;
import com.keba.kemro.plc.service.AxisResult;
import com.keba.kemro.plc.service.CoEAxisResult;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;

/**
 * Implementation of operation for drive parameter set transfer and save/reset operation.
 * 
 * @author steg
 * 
 */
public class DriveParamOperation implements IDriveParamOperation {

   protected HmiVariableService service = HmiVariableService.getService();
   protected static final String SV_NAME_KHW_Servo = "sv_KHW_Servo";
   protected static final int DRIVE_PARAM_OPERATION_WRITE = 0;
   protected static final int DRIVE_PARAM_OPERATION_READ = 1;
   protected static final int DRIVE_PARAM_OPERATION_SAVE_AND_RESET = 2;

   /**
    * Communication to IEC for triggering parameter set download (PLC -> Drive)
    * 
    * @param axis
    *           Selected axis
    */
   protected void write(KCatAxisObj axis) {
      try {
         KVariable bPLCToDrive = service.getVariable(getCommVarName(axis) + ".bDownload");
         service.writeValue(bPLCToDrive, Boolean.TRUE, false);
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   /**
    * Communication to IEC for triggering parameter set upload (Drive -> PLC)
    * 
    * @param axis
    *           Selected axis
    */
   protected void read(KCatAxisObj axis) {
      try {
         KVariable bDriveToPLC = service.getVariable(getCommVarName(axis) + ".bUpload");
         service.writeValue(bDriveToPLC, Boolean.TRUE, false);
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   /**
    * Communication to IEC for triggering drive Save/Reset
    * 
    * @param axis
    *           Selected axis
    */
   protected void saveAndReset(KCatAxisObj axis) {
      try {
         KVariable bSaveAndReset = service.getVariable(getCommVarName(axis) + ".bSaveAndReset");
         service.writeValue(bSaveAndReset, Boolean.TRUE, false);
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   /**
    * Start reading of parameter set from drive to PLC.
    */
   public AxisResult axisReadParamSet(KCatAxisObj axis, String fileName)
         throws NetworkException, IOException {
      read(axis);

      CoEAxisResult result = new CoEAxisResult();
      result.setDone(false);
      result.setError(false);
      result.setErrorID(0);
      return result;
   }

   /**
    * Start writing of parameter set from PLC to drive.
    */
   public AxisResult axisWriteParamSet(KCatAxisObj axis, String fileName)
         throws NetworkException, IOException {
      write(axis);

      CoEAxisResult result = new CoEAxisResult();
      result.setDone(false);
      result.setError(false);
      result.setErrorID(0);
      return result;
   }

   /**
    * Start saving written parameters to drive and reset it afterwards.
    */
   public AxisResult axisSaveAndReset(KCatAxisObj axis) {
      saveAndReset(axis);

      CoEAxisResult result = new CoEAxisResult();
      result.setDone(false);
      result.setError(false);
      result.setErrorID(0);
      return result;
   }

   /**
    * Check read/write operation done.
    * 
    * @param operation
    *           <code>DRIVE_PARAM_OPERATION_WRITE</code> for checking running write operation.
    *           <code>DRIVE_PARAM_OPERATION_READ</code> for checking running read operation.
    *           <code>DRIVE_PARAM_OPERATION_SAVE_AND_RESET</code> for checking running save/reset
    *           operation.
    * @param sCommVar
    *           Communication variable HMI <--> IEC
    * @return Result of operation
    */
   protected CoEAxisResult checkDone(int operation, String sCommVar) {
      CoEAxisResult result = new CoEAxisResultErrCode();
      result.setError(true);
      result.setDone(false);

      try {
         KVariable kVarDone = service.getVariable(sCommVar + ".bDone");
         KVariable kVarError = service.getVariable(sCommVar + ".iError");
         KVariable kVarActive = null;

         switch (operation) {
         case DRIVE_PARAM_OPERATION_READ:
            kVarActive = service.getVariable(sCommVar + ".bUpload");
            break;
         case DRIVE_PARAM_OPERATION_WRITE:
            kVarActive = service.getVariable(sCommVar + ".bDownload");
            break;
         case DRIVE_PARAM_OPERATION_SAVE_AND_RESET:
            kVarActive = service.getVariable(sCommVar + ".bSaveAndReset");

         }

         service.readValues(new KVariable[] { kVarDone, kVarError, kVarActive });

         int err = kVarError.getIntValue();
         boolean done = kVarDone.getBooleanValue();
         boolean active = kVarActive.getBooleanValue();

         if (err != 0) {
            result.setDone(true);
            result.setError(true);
            result.setErrorID(err);
         } else if (done || !active) {
            // Command done or
            // not active any more (reset by IEC (save/reset operation) or e.g. because of
            // "transfer not allowed" alarm).
            result.setDone(true);
            result.setError(false);
            result.setErrorID(0);
         } else {
            result.setDone(false);
            result.setError(false);
            result.setErrorID(0);
         }

      } catch (Exception e) {
         e.printStackTrace();
      }

      return result;
   }

   /**
    * Get result of drive parameter set read operation. This method is called cyclically!
    */
   public AxisResult getAxisReadParamState(KCatAxisObj axis, String fileName)
         throws NetworkException, IOException {
      return checkDone(DRIVE_PARAM_OPERATION_READ, getCommVarName(axis));
   }

   /**
    * Get result of drive parameter set write operation. This method is called cyclically!
    */
   public AxisResult getAxisWriteParamState(KCatAxisObj axis, String fileName)
         throws NetworkException, IOException {
      return checkDone(DRIVE_PARAM_OPERATION_WRITE, getCommVarName(axis));
   }

   /**
    * Get result of drive save and reset operation. This method is called cyclically!
    */
   public AxisResult getAxisSaveAndResetState(KCatAxisObj axis) {
      return checkDone(DRIVE_PARAM_OPERATION_SAVE_AND_RESET, getCommVarName(axis));
   }

   /**
    * Get communication variable name specified by catalog axis object.
    * 
    * @param axis
    *           Catalog axis object
    * @return Communication variable name
    */
   protected String getCommVarName(KCatAxisObj axis) {
      // Servo name (e.g. "Injection1.sv_KHW_ServoInject")
      String servoName = axis.getLongName();

      // FU name (e.g. "Injection1");
      int idxDot = servoName.indexOf('.');
      String fuName = servoName.substring(0, idxDot);

      // Suffix (e.g. "Inject")
      String suffix = "";
      int idxSuffix = idxDot + 1 + SV_NAME_KHW_Servo.length();
      if (idxSuffix < servoName.length()) {
         suffix = servoName.substring(idxSuffix);
      }

      // Communication var name (e.g. ("Injection1.sv_DriveMonHMICommInject")
      String commVarName = fuName + ".sv_DriveMonHMIComm" + suffix;

      return commVarName;
   }

   /**
    * Axis result with specific error texts.
    * 
    * @author steg
    * 
    */
   protected class CoEAxisResultErrCode extends CoEAxisResult {
      public String getErrorKey() {
         String key = "errorAxisUnknown";
         switch (getErrorID()) {
         case 0:
            break;
         case 1:
            key = "errorAxiInvalidFile";
            break;
         default:
            key = "errorAxiGeneralError";
            break;
         }
         return key;
      }
   }
}
