/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_dev_ODC
 *    Datum     : 27.01.2009
 *    Archive   : system.hmi
 *--------------------------------------------------------------------------  *
 */

package InjectionGeneral.hmi;

import com.ibm.log4j.Category;

import com.keba.kemro.plc.variable.KBoolean;
import com.keba.kemro.plc.variable.KNumber;
import com.keba.keplast.general.util.KPVisibilityChangedHandler;
import com.keba.util.VisibilityCtrlInterface2;

/**
 * Visibility controller for decompression, returns true if any decompression
 * mode is enabled.
 * 
 */
public class DecompressionUsedVisControl implements VisibilityCtrlInterface2 {

   protected final static Category CAT = Category.getInstance("DecompressionUsedVisControl");

   private KNumber knumberModeBeforePlast = null;
   private KNumber knumberModeAfterPlast = null;
   private KBoolean kbooleanDecompIntPosProgrammed = null;

   /**
    * Creates new instance of the {@link DecompressionUsedVisControl}.
    */
   public DecompressionUsedVisControl() {

   }

   /**
    * Is enabled, when mode of decompression before plast is not off or default.
    * 
    * @see com.keba.util.VisibilityCtrlInterface#isEnabled()
    */
   public boolean isEnabled() {
      if (knumberModeAfterPlast != null && knumberModeAfterPlast.getIntValue() > 0) {
         return true;
      }
      if (knumberModeBeforePlast != null && knumberModeBeforePlast.getIntValue() > 0) {
         return true;
      }
      if (kbooleanDecompIntPosProgrammed != null && kbooleanDecompIntPosProgrammed.getBooleanValue()) {
         return true;
      }
      return false;
   }

   /**
    * This controller always returns <code>true</code>
    * 
    * @see com.keba.util.VisibilityCtrlInterface#isVisible()
    */
   public boolean isVisible() {
      return true;
   }

   /**
    * @see com.keba.util.VisibilityCtrlInterface2#setFunctionUnit(java.lang.String)
    */
   public void setFunctionUnit(String fu) {
      try {
         knumberModeBeforePlast = (KNumber) KPVisibilityChangedHandler.getInstance().registerVariable(
               fu + ".sv_DecompBefPlastSettings.Mode");
         knumberModeAfterPlast = (KNumber) KPVisibilityChangedHandler.getInstance().registerVariable(
               fu + ".sv_DecompAftPlastSettings.Mode");
      } catch (Exception ex) {
         CAT.warn("Could not register variables!", ex);
      }
      // instantiat decompression
      try {
         kbooleanDecompIntPosProgrammed = (KBoolean) KPVisibilityChangedHandler.getInstance()
               .registerVariable(fu + ".sv_MoveDecompInterPos.bProgrammedInSequence");
      } catch (Exception ex) {
         CAT.warn("Could not register variables!", ex);
      }
   }
}
