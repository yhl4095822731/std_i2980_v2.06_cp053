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
public class TrnsMaxBackPressureRel extends AbsTrnsRelativeBasedSingleSV {

	private static final long serialVersionUID = 1L;

	private static final Category LOG = Category
			.getInstance(TrnsMaxBackPressureRel.class.getName());

	/**
	 * 
	 */
	public TrnsMaxBackPressureRel() {
		setVariableName("system.sv_rMaxBackPressure");
	}

	/**
	 * @see system.hmi.AbsTrnsRelativeBasedSingleSV#getLogger()
	 */
	protected Category getLogger() {
		return LOG;
	}

	/**
	 * @see com.keba.kemro.plc.variable.IAbsRelConverterPlast#setRelativeSubName(java.lang.String)
	 */
	public void setRelativeSubName(String sSubName) {
		// ignore
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
