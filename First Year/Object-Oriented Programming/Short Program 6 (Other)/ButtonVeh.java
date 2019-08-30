import java.awt.*;
import java.awt.event.*;
public class ButtonVeh extends Frame{
    private static String title;
    public static void main(String arg[]){
        ButtonVeh f = new ButtonVeh(title);
        f.setSize(500,100);
        f.setVisible(true);
        f.addWindowListener(new WindowAdapter(){
            public void windowClosing(WindowEvent evt){
                System.exit(0);
            }
        });
    }  
    public ButtonVeh(String title){
        super("GUI - Vehicle");
        Button veh = new Button("Vehicle");
        add(veh);
        //MyButtonListener listener = new MyButtonListener();
        //veh.addActionListener(listener);
    }
    
    /*class MyButtonListener implements ActionListener{
        public void actionPerformed(ActionEvent evt){
            ButtonVeh s = new ButtonVeh("GUI - VAN /SPORT CAR");
            s.setSize(500,100);
            s.setVisible(true);
            dispose();
        }
    }*/
}
