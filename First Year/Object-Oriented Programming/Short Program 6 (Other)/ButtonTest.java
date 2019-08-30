/*import java.awt.*;
import java.awt.event.*;

public class GuiTest extends Frame implements ActionListener{
    private static String title;
    public static void main(String []args){
        GuiTest f = new GuiTest("Vehicle Frame");
        f.pack();
        f.setVisible(true);
        f.addWindowListener(new WindowAdapter(){
            public void windowClosing(WindowEvent ev){
                System.exit(0);
            }
        });
    }
    
    public GuiTest(String title){
        super(title);
        Panel buttonPanel = new Panel();
        buttonPanel.setLayout(new GridLayout(3,3,50,30));
        Button sc = new Button("SportCar");
        Button van = new Button("Van");
        Button end = new Button ("End Program");
        buttonPanel.add(sc);
        buttonPanel.add(van);
        buttonPanel.add(end);
        sc.addActionListener(new ActionListener(){
            public  void actionPerformed(ActionEvent evt){
                Vehicle sc = new SportCar(200,1500,220);
                System.out.println("\nSport car : "+ sc.acceleration()+ " mph");
            }
        });
        van.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent evt){
                Vehicle van = new Van(100,3500,160.4);
                System.out.println("\nInstance of Van : "+ van.acceleration()+ " mph"); 
            }
        });
        end.addActionListener(this);
        Panel westPanel = new Panel();
        westPanel.setLayout(new FlowLayout());
        westPanel.add(buttonPanel);
        add("West",westPanel);
        
        setLayout(new FlowLayout());
        Label hp = new Label ("Horse Power");
        add(hp);
        TextArea tahp = new TextArea(1,5);
        add("East",tahp);
        Label ac = new Label ("Weight");
        add(ac);
        TextArea tac = new TextArea(1,5);
        add("East",tac);
        Label ts = new Label("Top Speed");
        add(ts);
        TextArea tats = new TextArea(1,5);
        add("East",tats);
        Label cw = new Label ("Carry Weight");
        add(cw);
        TextArea tacw = new TextArea(1,5);
        add("East",tacw);
    }
    public void actionPerformed(ActionEvent e){
        System.exit(0);
    }
}*/