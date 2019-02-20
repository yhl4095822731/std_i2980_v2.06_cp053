/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_dev2
 *    Datum     : 12.10.2009
 *    Archive   : MoldGeneral.hmi
 *------------------------------------------------------------------------*/

package EjectorGeneral.hmi;

import system.hmi.ODCActiveAndAnyMoveController;

/**
 *
 */
public class EjectorFwdProgrammedVisControl extends ODCActiveAndAnyMoveController {

   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#getMovementNames()
    */
   public String[] getMovementNames() {
      return new String[] {"sv_MoveFwd"};
   }
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#initialize()
    */
   public void initialize() {
   }
}
