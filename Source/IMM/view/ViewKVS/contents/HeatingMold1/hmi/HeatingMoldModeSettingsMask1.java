package HeatingMold1.hmi;

import java.awt.event.ActionEvent;
import java.util.Locale;

import com.keba.kemro.plc.variable.KVariable;

public class HeatingMoldModeSettingsMask1
		extends
			HeatingMoldModeSettingsMask1_generated {
	private static final long serialVersionUID = 1L;
	private String tabPanelPlastHeating1Index = "1-12";
	private String tabPanelPlastHeating2Index = "13-24";
	private String tabPanelPlastHeating3Index = "25-36";
	private String tabPanelPlastHeating4Index = "37-48";
	private String tabPanelPlastHeating5Index = "49-60";
	private String tabPanelPlastHeating6Index = "61-72";
	public HeatingMoldModeSettingsMask1() throws Exception {
		super();
		int iMaxZones = 72;
		String sMaxZones = "72";
		try {
			KVariable noZones = hmiService.getVariable("HeatingMold1.sv_iZonesAvailable");
			sMaxZones = noZones.getStringValue();
			iMaxZones = noZones.getIntValue();
		} catch (Exception ex) {
			CAT.warn(ex.getLocalizedMessage());
		}
		if (iMaxZones > 12) {
			tabPanelPlastHeating1Index = "1-12";
			if (iMaxZones > 24) {
				tabPanelPlastHeating2Index = "13-24";
				if (iMaxZones > 36) {
					tabPanelPlastHeating3Index = "25-36";
					if (iMaxZones > 48) {
						tabPanelPlastHeating4Index = "37-48";
						if(iMaxZones > 60) {
						   tabPanelPlastHeating5Index = "49-60";					   
						   tabPanelPlastHeating6Index = "61-" + sMaxZones;
						}
						else {
						   tabPanelPlastHeating5Index = "49-" + sMaxZones;
						}						 
					} else {
						tabPanelPlastHeating4Index = "37-" + sMaxZones;
					}
				} else {
					tabPanelPlastHeating3Index = "25-" + sMaxZones;
				}
			} else {
				tabPanelPlastHeating2Index = "13-" + sMaxZones;
			}
				
		} else {
			tabPanelPlastHeating1Index = "1-" + sMaxZones;
		}
		tabPanelPlastHeating1.setTitleAt(0, tabPanelPlastHeating1Index);
		tabPanelPlastHeating1.setTitleAt(1, tabPanelPlastHeating2Index);
		tabPanelPlastHeating1.setTitleAt(2, tabPanelPlastHeating3Index);
		tabPanelPlastHeating1.setTitleAt(3, tabPanelPlastHeating4Index);
		tabPanelPlastHeating1.setTitleAt(4, tabPanelPlastHeating5Index);
		tabPanelPlastHeating1.setTitleAt(5, tabPanelPlastHeating6Index);
		//Reaction on Component actions like pressed button
		//Todo: register component to react here
		//<component>.addActionListener(this);
	}
	/**
	 * This method reacts on action commands 
	 */
	public void actionPerformed(ActionEvent ev) {
		super.actionPerformed(ev);
		//if (ev.getSource() == <component>) {
		//Todo: add action here
		//}
	}
	
	protected void changeLocale(Locale locale) {
		super.changeLocale(locale);
		tabPanelPlastHeating1.setTitleAt(0, tabPanelPlastHeating1Index);
		tabPanelPlastHeating1.setTitleAt(1, tabPanelPlastHeating2Index);
		tabPanelPlastHeating1.setTitleAt(2, tabPanelPlastHeating3Index);
		tabPanelPlastHeating1.setTitleAt(3, tabPanelPlastHeating4Index);
		tabPanelPlastHeating1.setTitleAt(4, tabPanelPlastHeating5Index);
		tabPanelPlastHeating1.setTitleAt(5, tabPanelPlastHeating6Index);
	}
}
