/*-------------------------------------------------------------------------
 *                   (c) 2014 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Project  : Standstill reasons mask for EasyNet
 *    Author   : azb
 *    Date     : 01.05.2014
 *--------------------------------------------------------------------------  */

package EasyNet.hmi;

import java.util.Locale;
import java.util.ResourceBundle;

import com.keba.kemro.kvs.keplast.easynet.standstillreason.EasyNetStandstillTextsCtrl;
import com.keba.kemro.kvs.keplast.tig.TIG;
import com.keba.kemro.kvs.keplast.tig.standstillreason.TIGStandStillReasonMask;
import com.keba.keplast.general.PlastConstants;
import com.keba.util.LanguageManager;

public class StandstillReasonMask extends StandstillReasonMask_generated {

   private TIGStandStillReasonMask standStillPanel;

   public StandstillReasonMask() throws Exception {
      super();

      initCtrl();
      initView();
   }

   private void initView() {
      standStillPanel.setTabBackground(PlastConstants.COL_BG_PANEL);
      add(standStillPanel);
   }
   
   private void initCtrl() {
      EasyNetStandstillTextsCtrl ctrl = new EasyNetStandstillTextsCtrl();
      standStillPanel = new TIGStandStillReasonMask(ctrl.getDataModel());
      changeLocale(LanguageManager.sharedInstance().getLanguage().getLocale());
   }

   /**
    * called by language change event
    * 
    * @param loc
    */
   public void changeLocale(Locale loc) {
      ResourceBundle texts = ResourceBundle.getBundle(TIG.TEXTRESOURCE, loc);
      setTitle(texts.getString("TIGMAIN_MASKTITLE"));
      standStillPanel.changeLocale(texts);
   }

}
