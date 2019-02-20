/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_0126_dev
 *    Datum     : 19.10.2009
 *    Archive   : Core.hmi
 *------------------------------------------------------------------------*/

package Core.hmi;

/**
 * Constants for core types of IEC.
 * 
 */
public interface ICoreModes {

   /**
    * Core OFF
    */
   public static final int CORE_TYPE_OFF = 0;
   /**
    * Core ON
    */
   public static final int CORE_TYPE_ON = 1;

   public static final int MODE_IN_BEFORE_CLOSE = 0;
   public static final int MODE_IN_DURING_CLOSE = 1;
   public static final int MODE_IN_AFTER_CLOSE = 2;

   public static final int MODE_OUT_BEFORE_OPEN = 0;
   public static final int MODE_OUT_DURING_OPEN = 1;
   public static final int MODE_OUT_AFTER_OPEN = 2;

   public static final int CORE_CTRL_IN_COUNT = 0;
   public static final int CORE_CTRL_IN_TIME = 1;
   public static final int CORE_CTRL_IN_LIMIT = 2;

   public static final int CORE_CTRL_OUT_COUNT = 0;
   public static final int CORE_CTRL_OUT_TIME = 1;
   public static final int CORE_CTRL_OUT_LIMIT = 2;

}
