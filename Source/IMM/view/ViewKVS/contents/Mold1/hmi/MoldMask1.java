package Mold1.hmi;

import java.util.Locale;

import com.keba.kemro.kvs.keplast.general.util.KPResourceBundle;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;

import system.hmi.MachineEquipment;

public class MoldMask1 extends MoldMask1_generated implements ValueChangedListener {

   private static final long serialVersionUID = 1L;
   protected static String sRESOURCE_BUNDLE = "Mold1.hmi.text.MoldMask_texts";
   protected KPResourceBundle textBundleOLD = KPResourceBundle.getBundle(sRESOURCE_BUNDLE);

   public MoldMask1() throws Exception {
      super();

      if (MachineEquipment.doesVariableExist("Mold1.ai_ClampPress")) {
         actSetNumFieldText.setVariable("Mold1.sv_ClampForce.rSetClampForce");
         actSetNumFieldText.setVariableAct("Mold1.sv_rClampForceAct");
      } else if (MachineEquipment.doesVariableExist("Mold1.ai_ClampPress") == false && MachineEquipment.hasOption("Mold1",
            MachineEquipment.SUB_OPTION_MOLD_DIRECTLOCK)) {
         actSetNumFieldText.setVariable("Mold1.sv_ClampForceBuildUpTimeSet");
         actSetNumFieldText.setVariableAct("Mold1.sv_ClampForceBuildUpTimeAct");
      } else {
         actSetNumFieldText.getParent().remove(actSetNumFieldText);
      }
      HmiVariableService.registerVariable(profileMold1_MoldBwdProfVis.getVariableNOFStages(), this);
   }

   protected void changeLocale(Locale locale) {

      super.changeLocale(locale);
      try {
         textBundleOLD = KPResourceBundle.getBundle(sRESOURCE_BUNDLE, locale);

         if (MachineEquipment.doesDeviceExist("MotionProtectMold1")) {
            numfieldProtectFromTo.setText(textBundleOLD.getString("lProtectRange"));
         } else {
            numfieldProtectFromTo.setText(textBundleOLD.getString("lProtectRangeHydr"));
         }
      } catch (Exception ex) {
         ex.printStackTrace();
      }
   }

   public void valueChanged(ValueChangedEvent event) {

      if (event.getReason() != ValueChangedEvent.VALUE_CHANGED)
         return;

      try {
         // refresh the upper limit for the mold close profile, when the number of
         // stages has changed in the mold close profile
         String sVariableLastStage = "Mold1.sv_MoldBwdProfVis.Profile.Points["
               + (event.getVariable().getIntValue() + 1) + "].rStartPos";
         profileMold1_MoldFwdProfVisSrc.setVariableUpperLimit(sVariableLastStage);
         profileMold1_MoldFwdProfVisSrc.setVariablePositionMaxScale(sVariableLastStage);
         profileMold1_MoldFwdProfVisSrc.refreshProfile();

      } catch (Exception ex) {
      }
   }

}
