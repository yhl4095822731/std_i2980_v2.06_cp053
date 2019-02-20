/*-------------------------------------------------------------------------
 *                   (c) 2006 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : KePlast view.standard HMI
 *    Datum     : 06.09.2006
 *    Archive   : system.hmi
 *--------------------------------------------------------------------------  *
 */
package system.hmi;

import com.keba.kemro.kvs.keplast.general.BaseMachineEquipment;
import com.keba.keplast.general.functiontypes.MachineOptionID;

/**
 * The MachineEquipment collects the states of the avialable machine equipment and it provides these
 * information for the other classes, which are using this information
 * 
 */
public class MachineEquipment extends BaseMachineEquipment {

   /*****************************************************************************
    * actual equipment states
    ****************************************************************************/
   /**
    * Option constant for nozzle with asynchronus motor (value = <code>4 or 00000100</code>):
    */
   public static final MachineOptionID MAIN_OPTION_NOZZLE_ASM = new MachineOptionID(0x04);

   /**
    * Option constant mold height position input
    */
   public static final MachineOptionID SUB_OPTION_MOLDHEIGHT_IMPULSE_INPUT = new MachineOptionID(0x100);

   /**
    * Option constant Nozzle has transducer
    */
   public static final MachineOptionID SUB_OPTION_NOZZLE_TRANSDUCER = new MachineOptionID(0x100);

   /**
    * Option constant for 2 platen clamping mechanism
    */
   public static final MachineOptionID SUB_OPTION_MOLD_TWO_PLATEN = new MachineOptionID(0x400);

   /**
    * Option constant Rotary position
    */
   public static final MachineOptionID SUB_OPTION_ROTARY_POSITION = new MachineOptionID(0x100);

   /**
    * Option constant Rotary has transducer
    */
   public static final MachineOptionID SUB_OPTION_ROTARY_TRANSDUCER = new MachineOptionID(0x400);

   /**
    * Option constant electric injection with position balance control
    */
   public static final MachineOptionID SUB_OPTION_INJECTION_DRIVE_POS_BALANCE = new MachineOptionID(0x100);

   /**
    * Option constant electric injection with torque follower
    */
   public static final MachineOptionID SUB_OPTION_INJECTION_DRIVE_TORQUE_FOLLOW = new MachineOptionID(0x200);

   /**
    * Option constant electric injection with external pressure controller on drive
    */
   public static final MachineOptionID SUB_OPTION_INJECTION_DRIVE_EXT_PRESS_CTRL = new MachineOptionID(0x400);

}
