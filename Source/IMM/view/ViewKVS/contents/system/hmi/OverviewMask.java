package system.hmi;

import java.util.Locale;

import com.keba.kemro.kv.control.KvMask;
import com.keba.kemro.kvs.keplast.general.BaseMachineEquipment;
import com.keba.keplast.widgets.menu.IPopupMask;

/**
 * OverviewMask
 */
public class OverviewMask extends OverviewMask_generated implements IPopupMask {

   private static final long serialVersionUID = 1L;

   public OverviewMask() throws Exception {
      super();
   }

   protected void changeLocale(Locale locale) {
      super.changeLocale(locale);
      if (isShowing()) {
         // unless this the mask header for this mask will not be updated
         // on changing the language during starting up
         updateHeader();
      }
   }

   public KvMask getMainMask() {
      if (BaseMachineEquipment.isVerticalPanel()) {
         // Don't show overview mask in portrait baselayout
         return null;
      }

      // Return the mask instance as default
      return this;
   }
}
