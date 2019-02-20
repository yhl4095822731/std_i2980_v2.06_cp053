/**
 * 
 */
package EjectorGeneral.hmi;

import com.ibm.log4j.Category;
import com.keba.kemro.plc.variable.KBoolean;
import com.keba.keplast.general.util.KPVisibilityChangedHandler;

/**
 * Visibility controller for checking editing of ejector parameters is allowed.
 * Additional check <code>"system.sv_bOverrideEjectorSafety"</code> state.
 * Controller will allow editing if variables value is <code>true</code>.
 * 
 * @see EjectorGeneral.hmi.EjectorFwdProgrammedVisControl#isEnabled()
 * @author hzl
 * 
 */
public class EjectorFwdProgSafetyVisControl extends
		EjectorFwdProgrammedVisControl {
	
	private static final Category LOG = Category.getInstance(EjectorFwdProgSafetyVisControl.class.getName());
	private KBoolean kboolOverrideEjectorSafety = null;

	/**
	 * 
	 */
	public EjectorFwdProgSafetyVisControl() {
		try {
			kboolOverrideEjectorSafety = (KBoolean) KPVisibilityChangedHandler
					.getInstance().registerVariable("system.sv_bOverrideEjectorSafety");
		} catch (Exception ex) {
			LOG.warn("Could not register variable!", ex);
		}
	}
	
	/**
	 * Checks if <code>"system.sv_bOverrideEjectorSafety"</code> is available and
	 * it's value is <code>true</code>; Then the returned result is
	 * <code>true</code>, otherwise the <code>super.isEnabled()</code> is
	 * called.
	 * 
	 * @see EjectorGeneral.hmi.EjectorFwdProgrammedVisControl#isEnabled()
	 */
	public boolean isEnabled() {
		if (kboolOverrideEjectorSafety != null
				&& kboolOverrideEjectorSafety.getBooleanValue()) {
			return true;
		}
		return super.isEnabled();
	}

}
