package system.hmi;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ResourceBundle;
import java.util.Locale;

import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.kemro.plc.variable.KVariable;
import com.keba.kemro.kv.dialog.KvMessageDialog;
import com.keba.kemro.kv.dialog.KvProgressMonitor;
import com.keba.kemro.plc.service.HmiSystemService;
import com.keba.kemro.plc.network.StaRepState;
import com.keba.util.Worker;

public class Scope extends Scope_generated {
	private static final long serialVersionUID = 1L;
	
   private final static int cSCOPE_CMD_LOAD = 0;
   private final static int cSCOPE_CMD_LISTFILES = 1;	
	
	private final static String cSCOPE_HMI_CMD = "Scope.sv_ScopeHmiCmd";
	private final static String cSCOPE_HMI_FILELIST = "Scope.sv_ScopeConfigFileList";
	private final static String cSCOPE_HMI_CURRCONFIG = "Scope.sv_sConfigName";
	private final static String cSCOPE_MEASURESTATE = "Scope.sv_iMeasureState";	
	private final static int cSCOPE_CFG_MAXFILES = 20;
	
   protected KVariable kVarCmdCtrl = null;
   protected KVariable kVarCmdSel = null;
   protected KVariable kVarCmdOpt = null;
   protected KVariable kVarCmdRet = null;
   protected KVariable kVarCurrConfig = null;
   protected KVariable kVarMeasureState = null;
   protected KVariable kVarFileCnt = null;
   protected KVariable[][] kVarFileList = new KVariable[2][cSCOPE_CFG_MAXFILES];
   
   protected KVariable kVarLoadFileName = null;
   private ResourceBundle mBundle;   
	private boolean mbInitDone = false;
	private boolean mbIsEditing = false;
	private int miCmdCtrl = 0;
	
  
	public Scope() throws Exception {
		super();
      try {
         mBundle = ResourceBundle.getBundle("system.hmi.text.Scope_texts");
         createKVariables();         
         selectList.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e) {
               if (!mbIsEditing) {
                  cmdLoadConfig();
               }
            }
         });         
         mbInitDone = true;
     } catch (Exception ex) {
         CAT.error("Could not init simple scope", ex);
     } 
	}
	
	public void onShow() {
	   cmdRun(cSCOPE_CMD_LISTFILES);
	}

   protected void createKVariables () throws Exception {
       kVarCmdSel = HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_CMD + ".iCmdSel");
       kVarCmdRet = HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_CMD + ".iCmdRet");
       kVarCmdOpt = HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_CMD + ".iCmdOpt");
       kVarCurrConfig = HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_CURRCONFIG);
       kVarCmdCtrl = HmiVariableService.registerVariable(Scope.cSCOPE_HMI_CMD + ".iCmdCtrl", new ValueChangedListener() {
         public void valueChanged (ValueChangedEvent e) {
             try {
                 miCmdCtrl = e.getVariable().getIntValue();
                 if ((mbInitDone) && ((miCmdCtrl%2) == 0)) {
                     cmdDone();
                 }
             } catch (Exception ex) {
                 ex.printStackTrace();
             }
         }
       });       

       kVarMeasureState = HmiVariableService.registerVariable(Scope.cSCOPE_MEASURESTATE, new ValueChangedListener() {
          public void valueChanged (ValueChangedEvent e) {
              try {                 
                 // show a simple starep progress dialog on export
                  if(e.getVariable().getIntValue() == 4 && 
                     HmiSystemService.getService().getStatusReportState().getState() != StaRepState.STA_FINISHED_OK)   {
                        showStarepDialog();
                  }
              } catch (Exception ex) {
                  ex.printStackTrace();
              }
          }
        }); 
       
       kVarFileCnt = HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_FILELIST + ".iFileCount");
       for (int i = 0; i < cSCOPE_CFG_MAXFILES; i++) {
           kVarFileList[0][i] = 
                 HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_FILELIST  + ".yFile[" + (i + 1) + "].sName");
           kVarFileList[1][i] = 
                 HmiVariableService.getService().getVariable(Scope.cSCOPE_HMI_FILELIST  + ".yFile[" + (i + 1) + "].sDevice");           
       }
       
   }
   
   protected void showInfoDialog(String key) {
      try {
         KvMessageDialog.showInfoMessage((Object)mBundle.getString(key), "", false, null);
      }
      catch (Exception e) {
         CAT.error("text not found", e);
      }      
   }     
   
   
   protected void showStarepDialog() {
      Worker worker = new Worker() {
         KvProgressMonitor proMon;
         public Object construct() {
            StaRepState state;
            proMon = new KvProgressMonitor(
                           mBundle.getString("MsgScopeStarepProgressTitle"),
                           mBundle.getString("MsgScopeStarepProgress"),
                           0, 101);
            proMon.hideCancelButton();
            proMon.setMillisToPopup(1);
            proMon.setMillisToDecideToPopup(1);
            proMon.setModal(false);                           
            try {                              
               do {
                  state = HmiSystemService.getService().getStatusReportState();
                  synchronized (this) {
                     try {
                        this.wait(100);
                                                               
                     } catch (Exception e) {
                        CAT.debug(null, e);
                     }                                 
                  }
                  proMon.setProgress(state.getProgress());
               }
               while(state.getState() == StaRepState.STA_WRITING);
            }
            catch(Exception ex) {
               
            }
            finished();
            return null;
         }

         public void finished() {                           
            if(proMon != null) {
               proMon.close();
            }
         }

      };
      worker.start();      
   }
   
   protected void cmdLoadConfig() {
      try {
         int idx = selectList.getSelectedIndex();
         if(idx >= 0) {
            HmiVariableService.getService().writeValue(kVarCmdSel, new Integer(0), false);
            HmiVariableService.getService().writeValue(kVarCmdOpt, new Integer(selectList.getSelectedIndex() + 1), false);
            cmdRun(Scope.cSCOPE_CMD_LOAD);
         }
      }
      catch(Exception ex) {
         CAT.error("Could not load scope configuration", ex);
      }
   }     
   
   
   protected void cmdDone () throws Exception {
      HmiVariableService.getService().readValue(kVarCmdRet);
      HmiVariableService.getService().readValue(kVarCmdSel);
      switch (kVarCmdSel.getIntValue()) {
          case cSCOPE_CMD_LOAD:
             switch(kVarCmdRet.getIntValue()) {
             case 0:
                // loading is successful
                break;
             case 1:
             case 3:
                showInfoDialog("MsgScopeLoadError");
                break;
             }
              break;
          case cSCOPE_CMD_LISTFILES:             
             mbIsEditing = true;
             switch(kVarCmdRet.getIntValue()) {
             case 2:
                showInfoDialog("MsgScopeTooManyFiles");
                break;
             }       
              
             HmiVariableService.getService().readValues(kVarFileList[0]);
             HmiVariableService.getService().readValues(kVarFileList[1]);
             HmiVariableService.getService().readValue(kVarFileCnt);
             HmiVariableService.getService().readValue(kVarCurrConfig);              
             // set current configuration from box
             selectList.getModel().removeAll();
             int selectIdx = -1;
             for (int i = 0; i < kVarFileCnt.getIntValue(); i++) {
                String currEntry = kVarFileList[0][i].getStringValue();
                if(currEntry.equals(kVarCurrConfig.getStringValue())) {
                   selectIdx = i;
                }
                if (kVarFileList[1][i].getStringValue().toLowerCase(Locale.ENGLISH).indexOf("usb") != -1) {
                   // usb drive marker
                   currEntry = "USB: " + currEntry;
                }
                selectList.getModel().addData(currEntry);
             }
             
             selectList.setSelectedIndex(selectIdx);
             mbIsEditing = false;
             break;
      }
  }


  protected void cmdRun (int cmd) {
      try {
          if ((miCmdCtrl%2) == 0) {
             HmiVariableService.getService().writeValue(kVarCmdSel, new Integer(cmd), false);            // select cmd
             HmiVariableService.getService().writeValue(kVarCmdCtrl, new Integer(miCmdCtrl + 1), false); // start cmd
          }
      } catch (Exception ex) {
          CAT.error("Could not run command id " + cmd, ex);
      }
  }

}

