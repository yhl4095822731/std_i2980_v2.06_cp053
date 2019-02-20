package Core.hmi;

import com.ibm.log4j.Category;
import com.keba.kemro.plc.variable.KBoolean;
import com.keba.keplast.general.util.KPVisibilityChangedHandler;

/**
 * Visibility controller for checking editing of core parameters allowed.
 * Additional check <code>"system.sv_bOverrideCoreSafety"</code> state.
 * Controller will allow edition if variables value is <code>true</code>.
 * 
 * @see Core.hmi.CoreProgrammedVisControl#isEnabled()
 * @author hzl
 * 
 */
public class CoreProgAllCoreSafeVisControl extends CoreProgrammedVisControl {

	private static final Category LOG = Category.getInstance(CoreProgAllCoreSafeVisControl.class.getName());
	private KBoolean kboolOverrideCoreSafety = null;

	public CoreProgAllCoreSafeVisControl() {
		try {
			kboolOverrideCoreSafety = (KBoolean) KPVisibilityChangedHandler
					.getInstance().registerVariable("system.sv_bOverrideCoreSafety");
		} catch (Exception ex) {
			LOG.warn("Could not register variable!", ex);
		}
	}

	/**
	 * Checks if <code>"system.sv_bOverrideCoreSafety"</code> is available and
	 * it's value is <code>true</code>; Then the returned result is
	 * <code>true</code>, otherwise the <code>super.isEnabled()</code> is
	 * called.
	 * 
	 * @see Core.hmi.CoreProgrammedVisControl#isEnabled()
	 */
	public boolean isEnabled() {
		if (kboolOverrideCoreSafety != null
				&& kboolOverrideCoreSafety.getBooleanValue()) {
			return true;
		}
		return super.isEnabled();
	}
}
