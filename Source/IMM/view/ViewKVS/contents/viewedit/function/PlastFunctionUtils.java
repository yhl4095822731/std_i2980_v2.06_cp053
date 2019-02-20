/**
 * 
 */
package viewedit.function;

import com.keba.keplast.general.functiontypes.DeviceName;
import com.keba.keplast.general.functiontypes.JavaResultFromString;
import com.keba.keplast.general.functiontypes.VariableAsString;

/**
 * PlastFunctionUtils contains some helper functions for creation of dynamic code functions with ViewEdit.
 * Changes in this functions can result in male function of the application.
 * 
 * @since 01.32
 *
 */
public class PlastFunctionUtils {

	/*****************************************************************************
	 * Creation function for ViewEdit use in dynamic functions
	 ****************************************************************************/	

	/**
	 * Create <code>DeviceName</code> object for given device name string.
	 * @param sDeviceName
	 * @return
	 */
	public static DeviceName createDeviceName(String sDeviceName) {
		return new DeviceName(sDeviceName);
	}

	/**
	 * Create <code>VariableAsString</code> object for given variable name string.
	 * @param sVariableName
	 * @return
	 */
	public static VariableAsString createVariableString(String sVariableName) {
		return new VariableAsString(sVariableName);
	}

	/**
	 * Create <code>JavaResultFromString</code> object for given boolean result.
	 * @param bResult
	 * @return
	 */
	public static JavaResultFromString createJavaResult(boolean bResult) {
		return new JavaResultFromString(bResult);
	}

}
