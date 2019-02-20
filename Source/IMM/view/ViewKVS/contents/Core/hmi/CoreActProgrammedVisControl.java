/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   :
 *    Datum     : 27.11.2009
 *    Archive   : Core.hmi
 *--------------------------------------------------------------------------  *
 */
package Core.hmi;

import com.ibm.log4j.Category;

import com.keba.kemro.plc.variable.KBoolean;
import com.keba.keplast.general.util.KPVisibilityChangedHandler;

import system.hmi.ODCEditDisabledController;

/**
 *
 * chad(CR_0039604) - change of critical/dangerous paramters
 * should be prohibited in autocycle
 *
 */
public class CoreActProgrammedVisControl extends ODCEditDisabledController {

   private static final Category LOG = Category.getInstance(CoreProgrammedVisControl.class.getName());
   private KBoolean kboolAutoCycleRunning = null;
   /**
    *
    */
   public CoreActProgrammedVisControl() {
      try{
         kboolAutoCycleRunning = (KBoolean)KPVisibilityChangedHandler.getInstance().registerVariable("system.sv_bAutoCycleRunning");
      } catch(Exception ex){
         LOG.warn("Could not register variable!", ex);
      }
   }

   /**
    * @see system.hmi.ODCEditDisabledController()
    */
   public boolean isEnabled() {
      if (kboolAutoCycleRunning != null && kboolAutoCycleRunning.getBooleanValue()){
         return false;
      }
      return super.isEnabled();
   }

}
