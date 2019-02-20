/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_dev2
 *    Datum     : 12.10.2009
 *    Archive   : MoldGeneral.hmi
 *------------------------------------------------------------------------*/

package NozzleGeneral.hmi;

import system.hmi.ODCActiveAndAnyMoveController;

/**
 *
 */
public class NozzleFwdProgrammedVisControl extends ODCActiveAndAnyMoveController {

   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#getMovementNames()
    */
   public String[] getMovementNames() {
      return new String[] {"sv_MoveFwdNozzle", "sv_MoveFwdContactF"};
   }
   /**
    * @see system.hmi.ODCActiveAndAnyMoveController#initialize()
    */
   public void initialize() {
   }
}
