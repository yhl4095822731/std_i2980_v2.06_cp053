/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_dev_ODC
 *    Datum     : 30.01.2009
 *    Archive   : AirValveGeneral.hmi
 *--------------------------------------------------------------------------  *
 */
package AirValveGeneral.hmi;

import system.hmi.ODCActiveAndAnyMoveController;

/**
 * Visibility controller for editor mode. System variables with this controller
 * will be only enabled in editor mode if:
 *
 * <code>*</code> Device is activated <code>*</code> Any movement of the
 * aggregate is programmed in sequence.
 * 
 * Checks for <code>sv_MoveStart.bProgrammedInSequence</code> and
 * <code>sv_MoveWaitForReady.bProgrammedInSequence</code>
 *
 */
public class AirValveProgrammedVisControl extends ODCActiveAndAnyMoveController {
   
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#getMovementNames()
    */
   public String[] getMovementNames() {
      return new String[] {"sv_MoveStart", "sv_MoveStartAndWait"};
   }
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#initialize()
    */
   public void initialize() {
   }

}
