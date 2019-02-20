package viewedit.function;

/***********************************************************************************
 * 
 * User functions for Actions
 * -----------------------------
 * 
 * This file offers you the possibility to create self made functions, which can 
 * be used for actions.
 * 
 * Only functions without return value are supported, so all functions must have 
 * return type 'void'.
 * 
 * Parameters can be used for each function, which can be set within the Action
 * editor. Parameter of following types are supported:
 * int, boolean, String, double, Integer, Boolean, Double, KVariable
 * 
 * Furthermore it is possible to assign a group to a user action.
 * User actions with the same group name will be grouped together in the Action
 * editor. If no group name is assigned the default group will be used.
 * 
 ***********************************************************************************/

public class UserActions {
   /********************************************************************************
    * Example:
    *******************************************************************************
   
   // Unique static public Function with the return type void 
   @Group(name = "MyGroupName")
   public static void NewUserAction(int i, boolean b, String str, double d)
   {

    }
   */
}
