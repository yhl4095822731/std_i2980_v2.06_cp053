/*-------------------------------------------------------------------------
 *                   (c) 2006 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : KePlast view.standard HMI
 *    Datum     : 06.06.2006
 *    Archive   : system.hmi
 *--------------------------------------------------------------------------  *
 */

package system.hmi;

import java.awt.BorderLayout;
import java.util.Locale;

import com.keba.kemro.kv.widgets.scroll.KvScrollPanel;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;

/**
 * 
 */
public class ProfileSettingsMask extends ProfileSettingsMask_generated implements ValueChangedListener {

	private static final long serialVersionUID = 1L;

	public ProfileSettingsMask() throws Exception {
		super();
		// move tab 1 panel to scroll panel
//		tabPanelPlast1_Tab1.add(containerWrapProfiles1, BorderLayout.CENTER);
		KvScrollPanel scrollPanelProfiles1 = new KvScrollPanel(containerWrapProfiles1, false);
		tabPanelPlast1_Tab1.add(scrollPanelProfiles1, BorderLayout.CENTER);
		HmiVariableService.registerVariable("Mold1.sv_MoldFwdProfVisSrc.Profile.iNoOfPoints", this);
		
	}
	protected void changeLocale(Locale locale) {

		super.changeLocale(locale);
		try {
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	public void valueChanged(ValueChangedEvent event) {

		if (event.getReason() != ValueChangedEvent.VALUE_CHANGED)
			return;

		try {
			String sVariableStart = "Mold1.sv_MoldFwdProfVisSrc.Profile.Points["
				+ (20-event.getVariable().getIntValue()) + "].rVelRamp";
			String sVariableMiddle =  "Mold1.sv_MoldFwdProfVisSrc.Profile.Points["
				+ (20-event.getVariable().getIntValue() + 1) + "].rVelRamp";
			
			rampAdjustFields2MoldClose.setVariableStart(sVariableStart);
			rampAdjustFields2MoldClose.setVariableMiddle(sVariableMiddle);
		} catch (Exception ex) {
		}
	}

}
