/*-------------------------------------------------------------------------
 *                   (c) 2010 by KEBA Ges.m.b.H & Co
 *                            Linz/AUSTRIA
 *                         All rights reserved
 *--------------------------------------------------------------------------
 *    Projekt   : hmi.kvs_UnitChange_dev
 *    Datum     : 21.01.2010
 *    Archive   : InjectionGeneral.hmi
 *------------------------------------------------------------------------*/

package InjectionGeneral.hmi;

import com.ibm.log4j.Category;

import system.hmi.AbsTrnsRelativeBasedSingleSV;

/**
 * 
 */
public class TrnsMaxPlastPressureRel extends AbsTrnsRelativeBasedSingleSV {

	private static final long serialVersionUID = 4116337943591806375L;

	private static final Category LOG = Category.getInstance(TrnsMaxPlastPressureRel.class
			.getName());

	/**
    * 
    */
	public TrnsMaxPlastPressureRel() {
		setVariableName("Injection1.sv_rMaxPressurePlast");
	}

	/**
	 * @see com.keba.kemro.plc.variable.IAbsRelConverterPlast#setRelativeSubName(java.lang.String)
	 */
	public void setRelativeSubName(String sSubName) {
		// ignore
	}

	/**
	 * @see system.hmi.AbsTrnsRelativeBasedSingleSV#getLogger()
	 */
	protected Category getLogger() {
		return LOG;
	}

	/**
	 * @return <code><b>0</b></code>
	 */
	public int calcPostKommaImperial(int isoPostkomma) {
		return 0;
	}

	/**
	 * @return <code><b>0</b></code>
	 */
	public int calcPostKommaIso(int isoPostkomma) {
		return 0;
	}

}
