/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_dev2
 *    Datum     : 12.10.2009
 *    Archive   : MoldGeneral.hmi
 *------------------------------------------------------------------------*/

package MoldGeneral.hmi;

import system.hmi.ODCActiveAndAnyMoveController;

/**
 *
 */
public class MoldCloseProgrammedVisControl extends ODCActiveAndAnyMoveController {

   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#getMovementNames()
    */
   public String[] getMovementNames() {
      return new String[] {"sv_MoveClose", "sv_MoveCloseInterPos"};
   }
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#initialize()
    */
   public void initialize() {
   }

}
