/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_dev_ODC
 *    Datum     : 30.01.2009
 *    Archive   : Core.hmi
 *--------------------------------------------------------------------------  *
 */
package Core.hmi;

import com.ibm.log4j.Category;

import com.keba.kemro.plc.variable.KBoolean;
import com.keba.keplast.general.util.KPVisibilityChangedHandler;

import system.hmi.ODCActiveAndAnyMoveController;

/**
 * Visibilitycontroller for editor mode. Systemvariables with this controller
 * will be only enabled in editor mode if:
 *
 * <code>*</code> Device is activated <code>*</code> Any movement of the
 * aggregate is programmed in sequence.
 * 
 * Checks for <code>sv_MoveOut.bProgrammedInSequence</code>
 *
 */
public class CoreOutProgrammedVisControl extends ODCActiveAndAnyMoveController {
   
   private static final Category LOG = Category.getInstance(CoreOutProgrammedVisControl.class.getName());
   private KBoolean kboolAutoCycleRunning = null;
   
   public CoreOutProgrammedVisControl() {
      try{
         kboolAutoCycleRunning = (KBoolean)KPVisibilityChangedHandler.getInstance().registerVariable("system.sv_bAutoCycleRunning");
      } catch(Exception ex){
         LOG.warn("Could not register variable!", ex);
      }      
   }
   
   /**
    * Checks for <code>sv_MoveOut.bProgrammedInSequence</code>
    * @see system.hmi.ODCActiveAndAnyMoveController#getMovementNames()
    */
   public String[] getMovementNames() {
      return new String[] {"sv_MoveOut"};
   }
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#initialize()
    */
   public void initialize() {
   }
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#isEnabled()
    */
   public boolean isEnabled() {
      if (kboolAutoCycleRunning != null && kboolAutoCycleRunning.getBooleanValue()){
         return false;
      }
      return super.isEnabled();
   }

}
