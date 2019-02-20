/*-------------------------------------------------------------------------
 *                   (c) 2009 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : keplast.hmi.kvs_0126_dev
 *    Datum     : 17.11.2009
 *    Archive   : InjectionGeneral.hmi
 *------------------------------------------------------------------------*/

package InjectionGeneral.hmi;

import com.ibm.log4j.Category;

import com.keba.kemro.plc.variable.KNumber;
import com.keba.keplast.general.util.KPVisibilityChangedHandler;
import com.keba.keplast.odc.panels.properties.IInstanceProperty;
import com.keba.util.VisibilityCtrlInterface2;

/**
 * 
 */
public class DecompIntPosPositionVisControl implements VisibilityCtrlInterface2, IInstanceProperty {

   private static final Category LOG = Category.getInstance(DecompIntPosPositionVisControl.class.getName());

   private KNumber kvarDecompMode = null;
   private int instance = 0;

   /**
    * @see com.keba.keplast.odc.panels.properties.IInstanceProperty#setPropertyInstance(int)
    */
   public void setPropertyInstance(int instance) {
      this.instance = instance;
   }

   /**
    * @see com.keba.util.VisibilityCtrlInterface2#setFunctionUnit(java.lang.String)
    */
   public void setFunctionUnit(String fu) {

      try {
         kvarDecompMode = (KNumber) KPVisibilityChangedHandler.getInstance().registerVariable(
               fu + ".sv_InstanceDataDecompInterPos[" + instance + "].Mode");
      } catch (Exception ex) {
         LOG.error("Error during registration of variable!", ex);
      }
   }

   /**
    * @see com.keba.util.VisibilityCtrlInterface#isEnabled()
    */
   public boolean isEnabled() {
      if (kvarDecompMode != null && kvarDecompMode.getIntValue() == 1) {
         // mode is position!
         return true;
      }
      return false;
   }

   /**
    * @see com.keba.util.VisibilityCtrlInterface#isVisible()
    */
   public boolean isVisible() {
      return true;
   }

}
