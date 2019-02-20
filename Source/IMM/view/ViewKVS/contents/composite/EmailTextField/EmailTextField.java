package composite.EmailTextField;

import java.util.Locale;
import com.ibm.log4j.Category;
import com.keba.kemro.kv.widgets.InputPanelTitle;
import com.keba.kemro.kv.widgets.event.KvVirtualKeyboardListener;
import com.keba.kemro.plc.event.ValueChangedEvent;
import com.keba.kemro.plc.event.ValueChangedListener;
import com.keba.kemro.plc.service.HmiVariableService;
import com.keba.util.KChangeEvent;

public class EmailTextField extends EmailTextField_generated implements KvVirtualKeyboardListener {
   private static final long serialVersionUID = 1L;
   private Category CAT;
   private String m_strPart1, m_strPart2;

   public EmailTextField() throws Exception {
      super();
      CAT = Category.getInstance(getClass().getName());
      try {
         initComponents();
      }
      catch (Exception ex) {
         CAT.error("Constructor: ", ex);
      }
   }

   private void initComponents() {
      tfEMail.addVirtualKeyboardListener(this);
   }

   public void setVariablePart1Comp(final String varPath) {
      super.setVariablePart1Comp(varPath);
      varFieldPart1.getKVariable().addListener(new ValueChangedListener() {

         public void valueChanged(ValueChangedEvent event) {
            valuePart1Changed(event.getVariable().getStringValue());
         }
      });
      tfEMail.setInputLevel(varFieldPart1.getInputLevel());
      tfEMail.setDisplayLevel(varFieldPart1.getDisplayLevel());
      tfEMail.setHelpID(varFieldPart1.getHelpID());
      tfEMail.setDescription(InputPanelTitle.createInputPanelTitle(varFieldPart1.getKVariable()));
   }

   public void setVariablePart2Comp(final String varPath) {
      super.setVariablePart2Comp(varPath);
      varFieldPart2.getKVariable().addListener(new ValueChangedListener() {

         public void valueChanged(ValueChangedEvent event) {
            valuePart2Changed(event.getVariable().getStringValue());
         }
      });
   }

   public void stateChanged(KChangeEvent e) {
      String newText;
      int pos;
      HmiVariableService varService;

      newText = tfEMail.getText();
      varService = HmiVariableService.getService();
      pos = newText.indexOf('@');
      try {
         if (pos == -1) {
            varService.writeValue(varFieldPart1.getKVariable(), newText);
         }
         else {
            m_strPart1 = newText.substring(0, pos);
            m_strPart2 = newText.substring(pos + 1);
            varService.writeValue(varFieldPart1.getKVariable(), m_strPart1);
            varService.writeValue(varFieldPart2.getKVariable(), m_strPart2);
         }
      }
      catch (Exception ex) {
         CAT.error("stateChanged: ", ex);
      }
   }

   private void valuePart1Changed(String strPart1) {
      String newText;

      m_strPart1 = strPart1;
      newText = m_strPart1 + "@" + m_strPart2;
      tfEMail.setText(newText);
      tfEMail.repaint();
   }

   private void valuePart2Changed(String strPart2) {
      String newText;

      m_strPart2 = strPart2;
      newText = m_strPart1 + "@" + m_strPart2;
      tfEMail.setText(newText);
      tfEMail.repaint();
   }

   public void changeLocale(Locale locale) {
      try {
         super.changeLocale(locale);
         tfEMail.setDescription(InputPanelTitle.createInputPanelTitle(varFieldPart1.getKVariable()));
      }
      catch (Exception ex) {
         CAT.error("changeLocale: ", ex);
      }
   }
}
