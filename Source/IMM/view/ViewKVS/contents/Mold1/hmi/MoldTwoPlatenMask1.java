
package Mold1.hmi;

public class MoldTwoPlatenMask1 extends MoldTwoPlatenMask1_generated {
   private static final long serialVersionUID = 1L;
   private static final String sRESOURCE_BUNDLE = "Mold1.hmi.text.MoldMask_texts";

   public MoldTwoPlatenMask1() throws Exception {
      super();

      customizeProfileMoldClose();
      customizeProfileMoldOpen();
   }

   private void customizeProfileMoldClose() {
      // do not show the hi pressure stage of the mold close profile
      profileMold1_MoldFwdProfVisSrc.setHideLastStage(true);
      profileMold1_MoldFwdProfVisSrc.setShowCustomMarkColumn(false);

      // Tiebar target stage
      profileMold1_MoldFwdProfVisSrc.addStageBottom(
            sRESOURCE_BUNDLE, "lTiebarTarget", null,
            "TieBars1.sv_TieBarTargetConst.Pressure.Output.rOutputValue",
            "TieBars1.sv_TieBarTargetConst.Velocity.Output.rOutputValue",
            null);

      // Nuts fwd stage
      profileMold1_MoldFwdProfVisSrc.addStageBottom(
            sRESOURCE_BUNDLE, "lNutsFwd", null,
            "MoldNuts1.sv_ConstCloseNutsVis.Pressure.Output.rOutputValue",
            "MoldNuts1.sv_ConstCloseNutsVis.Velocity.Output.rOutputValue",
            "MoldNuts1.sv_bNutsClosed");

      // Hi press. 1 stage
      profileMold1_MoldFwdProfVisSrc.addStageBottom(
            sRESOURCE_BUNDLE, "lHiPres1", null,
            "TieBars1.sv_HighPressBuildUpStage1.Pressure.Output.rOutputValue",
            "TieBars1.sv_HighPressBuildUpStage1.Velocity.Output.rOutputValue",
            null);

      // Hi press. 2 stage
      profileMold1_MoldFwdProfVisSrc.addStageBottom(
            sRESOURCE_BUNDLE, "lHiPres2", null,
            "TieBars1.sv_HighPressBuildUpStage2.Pressure.Output.rOutputValue",
            "TieBars1.sv_HighPressBuildUpStage2.Velocity.Output.rOutputValue",
            null);

      profileMold1_MoldFwdProfVisSrc.refreshProfile();
   }

   private void customizeProfileMoldOpen() {
      // Tiebar bwd stage
      profileMold1_MoldBwdProfVis.addStageTop(
            sRESOURCE_BUNDLE, "lTiebarBwd", null, null,
            "TieBars1.sv_TieBarTargetConst.Pressure.Output.rOutputValue",
            "TieBars1.sv_TieBarTargetConst.Velocity.Output.rOutputValue",
            "TieBars1.sv_rTieBarBwdPosition", true, true, true, false);

      // Nuts bwd stage
      profileMold1_MoldBwdProfVis.addStageTop(
            sRESOURCE_BUNDLE, "lNutsBwd", null,
            "MoldNuts1.sv_ConstOpenNutsVis.Pressure.Output.rOutputValue",
            "MoldNuts1.sv_ConstOpenNutsVis.Velocity.Output.rOutputValue",
            "MoldNuts1.sv_bNutsOpen");

      profileMold1_MoldBwdProfVis.refreshProfile();
   }

}