package Dialogs.hmi;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.util.Vector;

import com.keba.kemro.kv.dialog.KvDialog;
import com.keba.kemro.kv.util.KvConstants;
import com.keba.kemro.kv.widgets.KvLabel;
import com.keba.kemro.kv.widgets.KvPanel;
import com.keba.kemro.kvs.widgets.KvsAnalogBar;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;

/**
 * Progress monitor dialog class with analogbar for showing a variable value in %.
 * 
 * @author steg
 * 
 */
public class ProgressMonitorDialog extends KvDialog {

   private final static String COM_GRP = "ProgressMonitorDialog";
   private Integer comGroupId;
   private KvsAnalogBar analogBar;

   /**
    * Creates a progress monitor dialog
    * 
    * @param title
    *           Title of dialog
    */
   public ProgressMonitorDialog(String title, String message) {
      super(KvDialog.NONE, title, true);
      analogBar = new AnalogBar();
      KvPanel contentPane = getContent();
      contentPane.setLayout(new GridLayout(message == null ? 1 : 2, 1));
      if (message != null) {
         contentPane.add(new KvLabel(message, null, KvConstants.LEFT_MIDDLE));
      }
      contentPane.add(analogBar);
      pack();
   }

   /**
    * Set the variable to be shown in the analogbar.
    * 
    * @param variable
    */
   public void setVariable(String variable) {
      analogBar.setVariable(variable);
      try {
         KVariable kVarProgress = HmiVariableService.getService().getVariable(variable);
         Vector vars = new Vector(1);
         vars.addElement(kVarProgress);
         comGroupId = HmiVariableService.getService().addGroup(COM_GRP, vars);
         HmiVariableService.getService().activateGroup(comGroupId);
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   public void close() {
      if (analogBar != null) {
         analogBar.setVariable(null);
         getContent().remove(analogBar);
      }
      try {
         HmiVariableService.getService().removeGroup(comGroupId);
      } catch (Exception e) {
         e.printStackTrace();
      }
      super.close();
   }

   private static class AnalogBar extends KvsAnalogBar {
      public AnalogBar() {
         super();
         setOrientation(KvsAnalogBar.HORIZONTAL);
         setMinimum(0);
         setMaximum(100);
      }
   }
}
