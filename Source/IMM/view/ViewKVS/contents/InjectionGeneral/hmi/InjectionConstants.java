/*-------------------------------------------------------------------------
 *                   (c) 2007 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : KePlast.HMI.KVS_ESGM
 *    Datum     : 05.04.2007
 *    Archive   : MoldGeneral.hmi
 *--------------------------------------------------------------------------  *
 */
package InjectionGeneral.hmi;

import com.keba.kemro.plc.service.HmiVariableService;


/**
 * Supports constants for injection unit
 *
 */
public class InjectionConstants {
	
	/**
	 * Injection unit 1 is driven by servo drive
	 * Checked variable is <code>Injection1.sv_ServoInject.iID</code>
	 */
	public static boolean bINJECTION_1_ELECTRIC;	
	/**
	 * Plasticizing of injection unit 1 is driven by servo drive
	 * Checked variable is <code>Injection1.sv_ServoPlast.iID</code>
	 */
	public static boolean bPLAST_1_ELECTRIC;	
	/**
	 * Injection unit 2 is driven by servo drive
	 * Checked variable is <code>Injection2.sv_ServoInject.iID</code>
	 */
	public static boolean bINJECTION_2_ELECTRIC;	
	/**
	 * Plasticizing of injection unit 2 is driven by servo drive
	 * Checked variable is <code>Injection2.sv_ServoPlast.iID</code>
	 */
	public static boolean bPLAST_2_ELECTRIC;
	
	static {
		checkForEquipment();
	}
	
	
	/**
	 * checks for the available injection equipment
	 */
	private static void checkForEquipment() {
		
		// check for injection 1 electric
		try {
			HmiVariableService.getService().getVariable("Injection1.sv_ServoInject.iID");
			bINJECTION_1_ELECTRIC = true;
		} catch (Exception ex) {
		}
		
		// check for plast 1 electric
		try {
			HmiVariableService.getService().getVariable("Injection1.sv_ServoPlast.iID");
			bPLAST_1_ELECTRIC = true;
		} catch (Exception ex) {
		}
		
		// check for injection 2 electric
		try {
			HmiVariableService.getService().getVariable("Injection2.sv_ServoInject.iID");
			bINJECTION_2_ELECTRIC = true;
		} catch (Exception ex) {
		}
		
		//	 check for plast 2 electric
		try {
			HmiVariableService.getService().getVariable("Injection2.sv_ServoPlast.iID");
			bPLAST_2_ELECTRIC = true;
		} catch (Exception ex) {
		}
		
	}

}
