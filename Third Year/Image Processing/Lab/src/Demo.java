import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.TreeSet;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.*;
import javax.imageio.*;
import javax.swing.*;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
 
public class Demo extends Component implements ActionListener {
    
    //*****************************************************************
    // List of the options corresponding to the choose filter JCombox:
    //******************************************************************
  
    String descs[] = {
        "ORIGINAL", 
        "Negative",
        "Re-Scaling",
        "Shifting",
        "Shifting and Re-scalling",
        "Extra Question",
        "Bitwise NOT"
    };
    
    //**********************************************************************
    // List of the options corresponding to the Arithmetic Operations cases:
    //**********************************************************************
 
    String mathsOp[] = {
    	"ORIGINAL",	
    	"Addition",
    	"Substraction",
    	"Multiplication",
    	"Division"
    };
    
    //*********************************************************************
    // List of the options corresponding to the Bitwise Operations cases:
    //*********************************************************************
    String bitwiseOp [] = {
    	"ORIGINAL",
    	"AND",
    	"OR",
    	"XOR",
    };
    
    //*********************************************************************
    // List of the options corresponding to the Point Processing cases:
    //*********************************************************************
    String pointProcessing[] = {
    	"ORIGINAL",
    	"Negative Linear Transform",
    	"Logarithmic Function",
    	"Power-Law",
    	"Random Look-up Table - Logarithm",
    	"Random Look-up Table - Power",
    	"Bit-plane slicing",
    };
    
    //*********************************************************************
    // List of the options corresponding to the Histogram cases:
    //*********************************************************************
    
    String [] histogramArray = {
			"ORIGINAL",
			"Finding Histogram",
			"Histogram Normalisation",
			"Histogram Equalisation",
			"Histogram Displaying"
	};
    
    //*********************************************************************
    // List of the options corresponding to the Convolution cases:
    //*********************************************************************
    
	String[] convolutionArray = { 
			"ORIGINAL", 
			"Averaging", 
			"Weighted averaging", 
			"4-neighbour Laplacian",
			"8- neighbour Laplacian", 
			"4-neighbour Laplacian Enhancement", 
			"8-neighbour Laplacian Enhancement",
			"Roberts I",
			"Roberts II",
			"Sobel X", 
			"Sobel Y",
			"Gaussian",
			"Laplacian of Gaussian",
	};
	
    //*********************************************************************
    // List of the options corresponding to the Order Filtering cases:
    //*********************************************************************
	
	String [] orderFilteringArray = {
		"ORIGINAL",
		"Salt and Pepper",
		"Min Filtering",
		"Max Filtering",
		"MidPoint Filtering",
		"Median Filtering",
	};
	
    //*********************************************************************
    // List of the options corresponding to the Thresholding cases:
    //*********************************************************************
	
	String [] thresholdingArray = {
		"ORIGINAL",
		"Mean and STandard Deviation",
		"Simple Thresholding",
		"Automated Thresholding",
	};
    
    int opIndex;  //option index for 
    int lastOp;
    
    int mathsIndex;//Mathematics Operation Options
    int mathsLastIndex;
    
    int bitwiseIndex;//Bitwise Operation options
    int bitwiseLastIndex;
    
    int pointProIndex;// Point Processing options
    int pointProLastIndex;
    
    int histogramIndex;//Histogram options
    int histogramLastIndex;
    
	int convoluTionIndex; // Convolution Options
	int convolutionLastIndex;
	
	int orderFilteringIndex; // Order-Statistics Options
	int OrderLastIndex;
	
	int thresholdingIndex; // Thresholding Options
	int thresholdingLastIndex;
    
    //*********************************************************************
    // Static variables, other variables used in the Program
    //*********************************************************************
    static ArrayList<JPanel> object = new  ArrayList<JPanel>();;
    String path ="..\\..\\Images\\";
    static ArrayList<Demo> img = new  ArrayList<Demo>();
    static int ar=0;
    private BufferedImage bi, biFiltered;   // the input image saved as bi;/
    static Demo pd;
    int w, h;
    Map<Demo, BufferedImage> saveImage = new HashMap<>();
    int counter = 0;
    //*********************************************************************
    // List of the options corresponding to the Images list:
    //*********************************************************************
    
    static String [] images = {
    		"Baboon.bmp", "BaboonRGB.bmp","Barbara.bmp", 
    		"Cameraman.bmp", "Goldhill.bmp", "Lena.bmp", 
    		"LenaRGB.bmp", "PeppersRGB.bmp","blackWhite.png",
    		"whiteBlack.png","twoWhite.png","twoBlack.png","grayscale.jpg"};
    
    //*********************************************************************
    // Constructor
    //*********************************************************************
        
    public Demo() {
        try {
            bi = ImageIO.read(new File(path + images[ar]));
            w = bi.getWidth(null);
            h = bi.getHeight(null);
            //System.out.println(bi.getType());
            if (bi.getType() != BufferedImage.TYPE_INT_RGB) {
            	BufferedImage bi2 = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
                Graphics big = bi2.getGraphics();
                big.drawImage(bi, 0, 0, null);
                biFiltered = bi = bi2;
            }
        }catch (NullPointerException e){
    		System.out.println("Tiff, Raw Images");
        } catch (IOException e) {// deal with the situation that th image has problem;/
            System.out.println("Image could not be read");

            System.exit(1);
        }
    }
    
    
    public BufferedImage getBufferedImage() {
    	return biFiltered;
    }
 
    public Dimension getPreferredSize() {
        return new Dimension(w, h);
    }
    
    //*********************************************************************
    // String Arrays containing the list of their respective values
    //*********************************************************************
    String [] getImage() {
    	return images;
    }

    String[] getDescriptions() {
        return descs;
    }
    
    String[] getMathsOperations() {
    	return mathsOp;
    }
    
    String []getBitwiseOperations(){
    	return bitwiseOp;
    }
    
    String [] getPointProcessing() {
    	return pointProcessing;
    }
    
    String [] getHistogram() {
    	return histogramArray;
    }
    
	String[] getConvolution() {
		return convolutionArray;
	}
	String [] getOrderFiltering() {
		return orderFilteringArray;
	}
	String [] getThresholding() {
		return thresholdingArray;
	}

    //*********************************************************************
    //Return the formats sorted alphabetically and in lower case
    //*********************************************************************
	
    public String[] getFormats() {
        String[] formats = {"bmp","gif","jpeg","jpg","png"};
        TreeSet<String> formatSet = new TreeSet<String>();
        for (String s : formats) {
            formatSet.add(s.toLowerCase());
        }
        return formatSet.toArray(new String[0]);
    }
 
    public int compareSize(int x1,int x2) {
    	int x;
        if(x1>x2) {
        	x = x2;
        }else {
        	x = x1;
        }
    	return x;
    }

    //*********************************************************************
    //	Methods storing the index value after click
    //*********************************************************************
    
    void setOpIndex(int i) {
        opIndex = i;
    }
    
    void setMathsIndex(int i) {
        mathsIndex = i;
    }
    
    void setBitwiseIndex(int i) {
    	bitwiseIndex =i;
    }
    
    void setPointProIndex(int i) {
    	pointProIndex = i;
    }
    
    void setHistogramIndex(int i) {
    	histogramIndex = i;
    }
    
	void setConvolutionIndex(int i) {
		convoluTionIndex = i;
	}
	
    void setOrderFilteringIndex(int i) {
    	orderFilteringIndex = i;
    }
    
    void setThresholdingIndex(int i) {
    	thresholdingIndex = i;
    }
    //*********************************************************************
    //Repaint will call this function so the image will change.
    //*********************************************************************
    public void paint(Graphics g) { 
        filterImage();      

        g.drawImage(biFiltered, 0, 0, null);
    }

    //************************************
    //  Convert the Buffered Image to Array
    //************************************
    private static int[][][] convertToArray(BufferedImage image){
      int width = image.getWidth();
      int height = image.getHeight();

      int[][][] result = new int[width][height][4];

      for (int y = 0; y < height; y++) {
         for (int x = 0; x < width; x++) {
            int p = image.getRGB(x,y);
            int a = (p>>24)&0xff;
            int r = (p>>16)&0xff;
            int g = (p>>8)&0xff;
            int b = p&0xff;

            result[x][y][0]=a;
            result[x][y][1]=r;
            result[x][y][2]=g;
            result[x][y][3]=b;
         }
      }
      return result;
    }

    //************************************
    //  Convert the  Array to BufferedImage
    //************************************
    public BufferedImage convertToBimage(int[][][] TmpArray){

        int width = TmpArray.length;
        int height = TmpArray[0].length;

        BufferedImage tmpimg=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);

        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
                int a = TmpArray[x][y][0];
                int r = TmpArray[x][y][1];
                int g = TmpArray[x][y][2];
                int b = TmpArray[x][y][3];
                
                //set RGB value

                int p = (a<<24) | (r<<16) | (g<<8) | b;
                tmpimg.setRGB(x, y, p);

            }
        }
        return tmpimg;
    }


    //************************************
    //  Example:  Image Negative
    //************************************
    public BufferedImage ImageNegative(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array

        // Image Negative Operation:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
                ImageArray[x][y][1] = 255-ImageArray[x][y][1];  //r
                ImageArray[x][y][2] = 255-ImageArray[x][y][2];  //g
                ImageArray[x][y][3] = 255-ImageArray[x][y][3];  //b
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }


    //************************************
    //  Re-Scaling pixel values
    //************************************
    public BufferedImage reScaling(BufferedImage timg) {
    	int width = timg.getWidth();
        int height = timg.getHeight();
        
        double rmin, rmax;
        double gmin, gmax;
        double bmin, bmax;

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array
        
        Random resc = new Random();
        double s = resc.nextDouble()*2;
                
        rmin = s*(ImageArray[0][0][1]); rmax = rmin;
        gmin = s*(ImageArray[0][0][2]); gmax = gmin;
        bmin = s*(ImageArray[0][0][3]); bmax = bmin;
        
        for(int y=0;y<height;y++) {
        	for(int x=0; x< width; x++) {
        		
        		ImageArray [x][y][1] = (int) s*(ImageArray[x][y][1]); // red
        		ImageArray [x][y][2] = (int) s*(ImageArray[x][y][2]); // green
        		ImageArray [x][y][3] = (int) s*(ImageArray[x][y][3]); // blue
        		
        		if(rmin > ImageArray[x][y][1]) { rmin = ImageArray[x][y][1]; }
        		if(gmin > ImageArray[x][y][2]) { gmin = ImageArray[x][y][2]; }
        		if(bmin > ImageArray[x][y][3]) { bmin = ImageArray[x][y][3]; }
        		
        		if(rmax < ImageArray[x][y][1]) { rmax = ImageArray[x][y][1]; }
        		if(gmax < ImageArray[x][y][2]) { gmax = ImageArray[x][y][2]; }
        		if(bmax < ImageArray[x][y][3]) { bmax = ImageArray[x][y][3]; }
        	}
        }
        
        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		ImageArray[x][y][1] = (int)(255*(ImageArray[x][y][1]-rmin)/(rmax-rmin));
        		ImageArray[x][y][2] = (int)(255*(ImageArray[x][y][2]-rmin)/(rmax-rmin));
        		ImageArray[x][y][3] = (int)(255*(ImageArray[x][y][3]-rmin)/(rmax-rmin));
        	}
        }
        
    	return convertToBimage(ImageArray);
    }
    
    //************************************
    //  Shifting pixel values
    //************************************
    public BufferedImage shifTing(BufferedImage timg) {
    	int width = timg.getWidth();
        int height = timg.getHeight();
        
        double rmin, rmax;
        double gmin, gmax;
        double bmin, bmax;

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array
        
        Random resc = new Random();
        double t = resc.nextDouble()*10;
        
        rmin = ImageArray[0][0][1]+t; rmax = rmin;
        gmin = ImageArray[0][0][2]+t; gmax = gmin;
        bmin = ImageArray[0][0][3]+t; bmax = bmin;
        
        for(int y=0;y<height;y++) {
        	for(int x=0; x< width; x++) {
        		
        		ImageArray [x][y][1] = (int) (ImageArray[x][y][1]+t); // red
        		ImageArray [x][y][2] = (int) (ImageArray[x][y][2]+t); // green
        		ImageArray [x][y][3] = (int) (ImageArray[x][y][3]+t); // blue
        		
        		if(rmin > ImageArray[x][y][1]) { rmin = ImageArray[x][y][1]; }
        		if(gmin > ImageArray[x][y][2]) { gmin = ImageArray[x][y][2]; }
        		if(bmin > ImageArray[x][y][3]) { bmin = ImageArray[x][y][3]; }
        		
        		if(rmax < ImageArray[x][y][1]) { rmax = ImageArray[x][y][1]; }
        		if(gmax < ImageArray[x][y][2]) { gmax = ImageArray[x][y][2]; }
        		if(bmax < ImageArray[x][y][3]) { bmax = ImageArray[x][y][3]; }
        	}
        }
        
        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		ImageArray[x][y][1] = (int)(255*(ImageArray[x][y][1]-rmin)/(rmax-rmin));
        		ImageArray[x][y][2] = (int)(255*(ImageArray[x][y][2]-rmin)/(rmax-rmin));
        		ImageArray[x][y][3] = (int)(255*(ImageArray[x][y][3]-rmin)/(rmax-rmin));
        	}
        }
        
    	return convertToBimage(ImageArray);
    }
    
    
    //************************************
    //  Re-scaling and Shifting pixel values
    //************************************
    public BufferedImage reScalingAndShifting(BufferedImage timg) {
    	int width = timg.getWidth();
        int height = timg.getHeight();
        
        int [][][] ImageArray = convertToArray(timg);
    
        
        Random resc = new Random();
        double s = resc.nextDouble()*2;
        double t = resc.nextDouble()*10;
        double sign = resc.nextDouble();
        
        if(sign<0.5) {s=s*-1;}
        

        double rmin = s*(ImageArray[0][0][1]+ t);  double rmax=rmin; //r
        double gmin = s*(ImageArray[0][0][2]+ t);  double gmax=gmin; //g
        double bmin = s*(ImageArray[0][0][3]+ t);  double bmax=bmin; //b
               
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){

                ImageArray[x][y][1] = (int)(s*(ImageArray[x][y][1]+ t));  //r
                ImageArray[x][y][2] = (int)(s*(ImageArray[x][y][2]+ t));  //g
                ImageArray[x][y][3] =(int)(s*(ImageArray[x][y][3]+ t));  //b

                if(rmin>ImageArray[x][y][1]) {rmin = ImageArray[x][y][1]; }
                if(gmin>ImageArray[x][y][2]) {gmin = ImageArray[x][y][2]; }
                if(bmin>ImageArray[x][y][3]) {bmin = ImageArray[x][y][3]; }
                
                if(rmax<ImageArray[x][y][1]) {rmax = ImageArray[x][y][1]; }
                if(gmax<ImageArray[x][y][2]) {gmax = ImageArray[x][y][2]; }
                if(bmax<ImageArray[x][y][3]) {bmax = ImageArray[x][y][3]; }
            }
        }
        
        for(int y=0; y<height;y++){
            for(int x=0;x<width;x++){
                ImageArray[x][y][1] = (int)(255*(ImageArray[x][y][1]- rmin)/(rmax-rmin));  //r
                ImageArray[x][y][2] = (int)(255*(ImageArray[x][y][2]- gmin)/(gmax-gmin));  //g
                ImageArray[x][y][3] = (int)(255*(ImageArray[x][y][3]- bmin)/(bmax-bmin));  //b
            }
        }
    	return convertToBimage(ImageArray); 
    }

    //************************************
    //  Extra Question pixel values
    //************************************
    public BufferedImage extraQuestion(BufferedImage timg) {
    	int width = timg.getWidth();
        int height = timg.getHeight();
        
        double rmin, rmax;
        double gmin, gmax;
        double bmin, bmax;
        
        int [][][] ImageArray = convertToArray(timg);     

        // Makes the images dark
        double s = 2.0;
        double s2 =0.5;
        
        rmin = s*(ImageArray[0][0][1]); rmax = rmin;
        gmin = s*(ImageArray[0][0][2]); gmax = gmin;
        bmin = s*(ImageArray[0][0][3]); bmax = bmin;
        
        for(int y=0;y<height;y++) {
        	for(int x=0; x< width; x++) {
        		
        		ImageArray [x][y][1] = (int) s*(ImageArray[x][y][1]); // red
        		ImageArray [x][y][2] = (int) s*(ImageArray[x][y][2]); // green
        		ImageArray [x][y][3] = (int) s*(ImageArray[x][y][3]); // blue
        		
        		ImageArray [x][y][1] = (int) s2*(ImageArray[x][y][1]); // red
        		ImageArray [x][y][2] = (int) s2*(ImageArray[x][y][2]); // green
        		ImageArray [x][y][3] = (int) s2*(ImageArray[x][y][3]); // blue
        		
        		if(rmin > ImageArray[x][y][1]) { rmin = ImageArray[x][y][1]; }
        		if(gmin > ImageArray[x][y][2]) { gmin = ImageArray[x][y][2]; }
        		if(bmin > ImageArray[x][y][3]) { bmin = ImageArray[x][y][3]; }
        		
        		if(rmax < ImageArray[x][y][1]) { rmax = ImageArray[x][y][1]; }
        		if(gmax < ImageArray[x][y][2]) { gmax = ImageArray[x][y][2]; }
        		if(bmax < ImageArray[x][y][3]) { bmax = ImageArray[x][y][3]; }
        	}
        }
        
        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		ImageArray[x][y][1] = (int)(255*(ImageArray[x][y][1]-rmin)/(rmax-rmin));
        		ImageArray[x][y][2] = (int)(255*(ImageArray[x][y][2]-rmin)/(rmax-rmin));
        		ImageArray[x][y][3] = (int)(255*(ImageArray[x][y][3]-rmin)/(rmax-rmin));
        	}
        }
    	return convertToBimage(ImageArray); 
    }

    //************************************
    // BitwiseNot
    //************************************
    public BufferedImage BitwiseNot(BufferedImage timg){
        /*Although results are the same, the calculation is different*/
        int width = timg.getWidth();
        int height = timg.getHeight();

        int [][][] ImageArray = convertToArray(timg);

        for(int y=0;y<height;y++){
            for(int x=0;x<width;x++){
                int r = ImageArray[x][y][1]; //r
                int g = ImageArray[x][y][2]; //g
                int b = ImageArray[x][y][3]; //b

                ImageArray[x][y][1] = (~r)&0xff; //r
                ImageArray[x][y][2] = (~g)&0xff; //g
                ImageArray[x][y][3] = (~b)&0xff; //b
            }
        }

        return convertToBimage(ImageArray);
    }


    //******************************************
    //  Filter Image
    //*****************************************
    public void filterImage() {
 
        if (opIndex == lastOp) {
            return;
        }

        lastOp = opIndex;
        switch (opIndex) {
        case 0: biFiltered = bi; /* original */
                return; 
        case 1: biFiltered = ImageNegative(bi); /* Image Negative */
                return;
        case 2: biFiltered = reScaling(bi); /* Re-scaling */
        		return;
        case 3: biFiltered = shifTing(bi);/* Shifting */
        		return;
        case 4: biFiltered = reScalingAndShifting(bi);/* Re-scaling and Shifting */
        		return;
        case 5: biFiltered = extraQuestion(bi);/* Extra Question */
        		return;
        case 6: biFiltered = BitwiseNot(bi);/* Bitwise */
        		return;
        }
    }
    
    
    //************************************
    //  Addition Function
    //************************************
    public BufferedImage Addition() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);
        
        int rmin = ImageArray[0][0][1]; int rmax = rmin;
        int gmin = ImageArray[0][0][2]; int gmax = gmin;
        int bmin = ImageArray[0][0][3]; int bmax = bmin;


        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		tempArray[x][y][1] = ImageArray[x][y][1]+ ImageArray2[x][y][1];
        		tempArray[x][y][2] = ImageArray[x][y][2]+ ImageArray2[x][y][2];
        		tempArray[x][y][3] = ImageArray[x][y][3]+ ImageArray2[x][y][3];
        		
        		//Setting values greater than 255 to 255
        		if(tempArray[x][y][1] > 255) {tempArray[x][y][1] = 255;}
        		if(tempArray[x][y][2] > 255) {tempArray[x][y][2] = 255;}
        		if(tempArray[x][y][3] > 255) {tempArray[x][y][3] = 255;}
        	}
        }
        
    	return convertToBimage(tempArray); 
 
    } 
    
    //************************************
    //  Subtraction Function
    //************************************
    public BufferedImage Subtraction() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);
        
        int rmin = 0; int rmax = rmin;
        int gmin = 0; int gmax = gmin;
        int bmin = 0; int bmax = bmin; 

        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		tempArray[x][y][1] = ImageArray[x][y][1]- ImageArray2[x][y][1];
        		tempArray[x][y][2] = ImageArray[x][y][2]- ImageArray2[x][y][2];
        		tempArray[x][y][3] = ImageArray[x][y][3]- ImageArray2[x][y][3];
        		
        		//Setting values less than 0 to 0
        		if(tempArray[x][y][1] < 0) {tempArray[x][y][1] = 0;}
        		if(tempArray[x][y][2] < 0) {tempArray[x][y][2] = 0;}
        		if(tempArray[x][y][3] < 0) {tempArray[x][y][3] = 0;}
        		
        		if(rmax < tempArray[x][y][1]) {rmax = tempArray[x][y][1];}
        		if(gmax < tempArray[x][y][2]) {gmax = tempArray[x][y][2];}
        		if(bmax < tempArray[x][y][3]) {bmax = tempArray[x][y][3];}
        		
        	}
        }
        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		tempArray[x][y][1] = (int)(255*(tempArray[x][y][1] -rmin)/(rmax-rmin));
        		tempArray[x][y][2] = (int)(255*(tempArray[x][y][2] -gmin)/(gmax-gmin));
        		tempArray[x][y][3] = (int)(255*(tempArray[x][y][3] -bmin)/(bmax-bmin));

        	}
        }
        
    	return convertToBimage(tempArray); 
 
    } 
    
    //************************************
    //  Multiplication Function
    //************************************
    public BufferedImage Multiplication() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);


        int rmin = ImageArray[0][0][1]; int rmax = rmin;
        int gmin = ImageArray[0][0][2]; int gmax = gmin;
        int bmin = ImageArray[0][0][3]; int bmax = bmin;


        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		tempArray[x][y][1] = ImageArray[x][y][1]*ImageArray2[x][y][1];
        		tempArray[x][y][2] = ImageArray[x][y][2]*ImageArray2[x][y][2];
        		tempArray[x][y][3] = ImageArray[x][y][3]*ImageArray2[x][y][3];
        		
        		// Second method : Finding the min and max
        		if(rmin > tempArray[x][y][1]) {rmin = tempArray[x][y][1];}
        		if(gmin > tempArray[x][y][2]) {rmin = tempArray[x][y][2];}
        		if(bmin > tempArray[x][y][3]) {rmin = tempArray[x][y][3];}
        		
        		if(rmax < tempArray[x][y][1]) {rmax = tempArray[x][y][1];}
        		if(gmax < tempArray[x][y][2]) {gmax = tempArray[x][y][2];}
        		if(bmax < tempArray[x][y][3]) {bmax = tempArray[x][y][3];}

        	}
        }
        // Continuous second method : Spreading values
        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		tempArray[x][y][1] = (int)(255*(tempArray[x][y][1] -rmin)/(rmax-rmin));
        		tempArray[x][y][2] = (int)(255*(tempArray[x][y][2] -gmin)/(gmax-gmin));
        		tempArray[x][y][3] = (int)(255*(tempArray[x][y][3] -bmin)/(bmax-bmin));

        	}
        }
        
    	return convertToBimage(tempArray); 
 
    }
    
    //************************************
    //  Division Function
    //************************************
    public BufferedImage Division() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);

        int factor = 1;
        
        int rmin = 0; int rmax = rmin;
        int gmin = 0; int gmax = gmin;
        int bmin = 0; int bmax = bmin;
        

        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		if(ImageArray2[x][y][1]== 0) {
        			ImageArray2[x][y][1] = factor;
        		}
        		if(ImageArray2[x][y][2]== 0) {
        			ImageArray2[x][y][2] = factor;
        		}
        		if(ImageArray2[x][y][3] == 0) {
        			ImageArray2[x][y][3] = factor;
        		}
        	
        		tempArray[x][y][1] = ImageArray[x][y][1]/ ImageArray2[x][y][1];
        		tempArray[x][y][2] = ImageArray[x][y][2]/ ImageArray2[x][y][2];
        		tempArray[x][y][3] = ImageArray[x][y][3]/ ImageArray2[x][y][3];
      
        		
        		// Second method : Finding the min and max
        		if(rmin > tempArray[x][y][1]) {rmin = tempArray[x][y][1];}
        		if(gmin > tempArray[x][y][2]) {gmin = tempArray[x][y][2];}
        		if(bmin > tempArray[x][y][3]) {bmin = tempArray[x][y][3];}
        		
        		if(rmax < tempArray[x][y][1]) {rmax = tempArray[x][y][1];}
        		if(gmax < tempArray[x][y][2]) {gmax = tempArray[x][y][2];}
        		if(bmax < tempArray[x][y][3]) {bmax = tempArray[x][y][3];}
        		
        	}
        }

        // Continous second method : Spreading values
        for(int y = 0; y< height; y++) {
        	for(int x = 0; x< width; x++) {
        		tempArray[x][y][1] = (int)(255*(tempArray[x][y][1] -rmin)/(rmax-rmin));
        		tempArray[x][y][2] = (int)(255*(tempArray[x][y][2] -gmin)/(gmax-gmin));
        		tempArray[x][y][3] = (int)(255*(tempArray[x][y][3] -bmin)/(bmax-bmin));

        	}
        }
        
    	return convertToBimage(tempArray); 

    }
    
    
    //************************************
    // Mathematics Operations
    //************************************
    public void setMathOperation() {
    	choicesMathOperation();
    } 
    
    public void choicesMathOperation() {

    	mathsLastIndex = mathsIndex;
    	switch(mathsIndex) {
			case 0: biFiltered = bi;
				return;
	    	case 1: biFiltered = Addition();
	    		return;
	    	case 2: biFiltered = Subtraction();
    			return;
	    	case 3: biFiltered = Multiplication();
    			return;
	    	case 4: biFiltered = Division();
				return;
    	}
    }

    //************************************
    //  Bitwise AND function
    //************************************
    public BufferedImage ANDbitwise() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);
        
        for(int y=0;y<height;y++){
            for(int x=0;x<width;x++){
                int r = ImageArray[x][y][1]; //r
                int g = ImageArray[x][y][2]; //g
                int b = ImageArray[x][y][3]; //b
                
                int r2 = ImageArray2[x][y][1]; //r
                int g2 = ImageArray2[x][y][2]; //g
                int b2 = ImageArray2[x][y][3]; //b
                
                tempArray[x][y][1] = (r&0xff)&(r2&0xff); //r
                tempArray[x][y][2] = (g&0xff)&(g2&0xff); //g
                tempArray[x][y][3] = (b&0xff)&(b2&0xff); //b
            }
        }
        
    	return convertToBimage(tempArray); 
    	
    }
    
    //************************************
    //  Bitwise OR function
    //************************************
    public BufferedImage ORbitwise() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);

        for(int y=0;y<height;y++){
            for(int x=0;x<width;x++){
            	int r = ImageArray[x][y][1]; //r
                int g = ImageArray[x][y][2]; //g
                int b = ImageArray[x][y][3]; //b
                
                int r2 = ImageArray2[x][y][1]; //r
                int g2 = ImageArray2[x][y][2]; //g
                int b2 = ImageArray2[x][y][3]; //b
                
                tempArray[x][y][1] = (r&0xff)|(r2&0xff); //r
                tempArray[x][y][2] = (g&0xff)|(g2&0xff); //g
                tempArray[x][y][3] = (b&0xff)|(b2&0xff); //b
            }
        }

        return convertToBimage(ImageArray);
    	
    }
    
    //************************************
    //  Bitwise XOR function
    //************************************
    public BufferedImage XORbitwise() {
    	int width1 = img.get(0).getBufferedImage().getWidth();
        int height1 = img.get(0).getBufferedImage().getHeight();
        
    	int width2 = img.get(1).getBufferedImage().getWidth();
        int height2 = img.get(1).getBufferedImage().getHeight();
        
        int [][][] ImageArray = convertToArray(img.get(0).getBufferedImage());
        int [][][] ImageArray2 = convertToArray(img.get(1).getBufferedImage());
    	int [][][] tempArray = ImageArray;
        
        int width = compareSize(width1,width2);
        int height = compareSize(height1, height2);

        for(int y=0;y<height;y++){
            for(int x=0;x<width;x++){
            	int r = ImageArray[x][y][1]; //r
                int g = ImageArray[x][y][2]; //g
                int b = ImageArray[x][y][3]; //b
                
                int r2 = ImageArray2[x][y][1]; //r
                int g2 = ImageArray2[x][y][2]; //g
                int b2 = ImageArray2[x][y][3]; //b
                
                tempArray[x][y][1] = (r&0xff)^(r2&0xff); //r
                tempArray[x][y][2] = (g&0xff)^(g2&0xff); //g
                tempArray[x][y][3] = (b&0xff)^(b2&0xff); //b
            }
        }

        return convertToBimage(ImageArray);
    	
    }
    
    //************************************
    // Set Bitwise functions
    //************************************
    public void setBitwiseOperations(){
    	choicesBitwise();
    }
    
    public void choicesBitwise() {

    	bitwiseLastIndex = bitwiseIndex;
    	switch(bitwiseIndex) {
			case 0: biFiltered = bi;
				return;
	    	case 1: biFiltered = ANDbitwise();
	    		return;
	    	case 2: biFiltered = ORbitwise();
	    		return;
	    	case 3: biFiltered =  XORbitwise();
	    		return;
	    	}
    }
 
    //************************************
    //  Image Negative: s = (L -1) -r
    //					s = 255 - r
    //************************************
    public BufferedImage LinearTransform(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array

        // Image Negative Operation:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
                ImageArray[x][y][1] = 255-ImageArray[x][y][1];  //r
                ImageArray[x][y][2] = 255-ImageArray[x][y][2];  //g
                ImageArray[x][y][3] = 255-ImageArray[x][y][3];  //b
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }
    
    //************************************
    //  Logarithm Function s= c log(1+r)
    //************************************
    public BufferedImage LogarithmFunction(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg); //  Convert the image to array

        double c = 255.0/Math.log(256);// Constant
        
        // Logarithm function:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
                ImageArray[x][y][1] = (int) (c*Math.log(1+ImageArray[x][y][1]));  //r
                ImageArray[x][y][2] =(int) (c*Math.log(1+ImageArray[x][y][2]));  //g
                ImageArray[x][y][3] =(int) (c*Math.log(1+ImageArray[x][y][3]));  //b 
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }
    
    //************************************
    //  Power-Law function s= c(r^y)
    //************************************
    public BufferedImage PowerLaw(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg);//  Convert the image to array

        double gamma = Math.random()*25;
        double c = Math.pow(255, 1-gamma);// Constant
        
        // Logarithm function:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	ImageArray[x][y][1] = (int) (c*Math.pow(ImageArray[x][y][1],gamma ));  //r
                ImageArray[x][y][2] =(int) (c*Math.pow(ImageArray[x][y][2], gamma));  //g
                ImageArray[x][y][3] =(int) (c*Math.pow(ImageArray[x][y][3], gamma));  //b
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }

    //****************************************************
    //  Random Look-up Table function for Logarithm: s =T(r) = T(f(x,y))
    //****************************************************
    public BufferedImage LookUpTableLog(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array
               
        int LUT [] = new int [256];

        /*Using Logarithm functions*/

        double c = 255.0/Math.log(256);// Constant
        
        for(int k=0; k<=255;k++) {// Generating a LUT of 256 levels for logarithm functions
        	LUT[k]= (int)(Math.log(1+k)*c);
        	System.out.println(LUT[k]);
        }
        
        
        // Logarithm function:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	ImageArray[x][y][1] = LUT[ImageArray[x][y][1]];  //r
                ImageArray[x][y][2] = LUT[ImageArray[x][y][2]];  //g
                ImageArray[x][y][3] = LUT[ImageArray[x][y][3]];  //b
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }

    //****************************************************
    //  Random Look-up Table function for Logarithm: s =T(r) = T(f(x,y))
    //****************************************************
    public BufferedImage LookUpTablePower(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array
               
        int LUT [] = new int [256];
       
        /*Using Power function*/
        
        int gamma = (int) (Math.random()*25);
        double c = Math.pow(255, 1-gamma);// Constant
        
        for(int k=0; k<=255;k++) {// Generating a LUT of 256 levels for logarithm functions
        	LUT[k]= (int)(c*Math.pow(k, gamma));
        }

        // Logarithm function:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	ImageArray[x][y][1] = LUT[ImageArray[x][y][1]];  //r
                ImageArray[x][y][2] = LUT[ImageArray[x][y][2]];  //g
                ImageArray[x][y][3] = LUT[ImageArray[x][y][3]];  //b
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }

    //************************************
    //  Bit Plane Slicing
    //************************************
    public BufferedImage BitPlane(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array

        int k = 7;// Bit to change
        int r = 0;
        int g = 0;
        int b = 0;
        // Logarithm function:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	r = ImageArray[x][y][1];
            	g =ImageArray[x][y][2];
            	b =ImageArray[x][y][3];
            	ImageArray[x][y][1] = (r>>k)&1;  //r
                ImageArray[x][y][2] = (g>>k)&1;  //g
                ImageArray[x][y][3] = (b>>k)&1;  //b
                if(ImageArray[x][y][1] == 1) {
                	ImageArray[x][y][1] = 255;
                }
                if(ImageArray[x][y][2] == 1) {
                	ImageArray[x][y][2] = 255;
                }
                if(ImageArray[x][y][3] == 1) {
                	ImageArray[x][y][3] = 255;
                }
                
            }
        }
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }
    
    //************************************
    //  Set Point Processing function
    //************************************
    public void setPointPrOperations() {
    	choicesPointProcessing();
   	 	repaint();
    }
    //************************************
    //  Choices for Point Processing function
    //************************************
    
    public void choicesPointProcessing() {
    	
    	pointProLastIndex = pointProIndex;
    	
    	switch(pointProIndex) {
    		case 0: biFiltered = bi;
    			return;
    		case 1: biFiltered = LinearTransform(bi);
    			return;
    		case 2: biFiltered = LogarithmFunction(bi);
    			return;
    		case 3: biFiltered = PowerLaw(bi);
    			return;
    		case 4: biFiltered = LookUpTableLog(bi);
    			return;
    		case 5: biFiltered = LookUpTablePower(bi);
    			return;
    		case 6: biFiltered = BitPlane(bi);
    			return;
    	}
    }
    
    //********************************************
    // Histogram Method : it used external library
    // Creates Histogram using integer values
    //********************************************
    
    public void createHistogram(int []HistogramR, String title) {
    	DefaultCategoryDataset dataset =  new DefaultCategoryDataset();
		
        for(int k=0;k<=255;k++) {
        	dataset.setValue(HistogramR[k], "", Integer.toString(k));
        }
		
		JFreeChart chart = ChartFactory.createBarChart(title, "", "Accumulate", dataset, PlotOrientation.VERTICAL,false,true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.BLUE);
		
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.white);
		ChartFrame frame = new ChartFrame("",chart);
		frame.setVisible(true);
		frame.setSize(1200,800);
    }
    
    //********************************************
    // Histogram Method : it used external library
    // Creates Histogram using double values
    //********************************************

    public void createDoubleHistogram(double []HistogramR, String title) {
    	DefaultCategoryDataset dataset =  new DefaultCategoryDataset();
		
        for(int k=0;k<=255;k++) {
        	dataset.setValue(HistogramR[k], "", Integer.toString(k));
        }
		
		JFreeChart chart = ChartFactory.createBarChart(title, "", "Accumulate", dataset, PlotOrientation.VERTICAL,false,true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.BLUE);
		
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.white);
		ChartFrame frame = new ChartFrame("",chart);
		frame.setVisible(true);
		frame.setSize(1200,800);
    }
    
    //************************************
    //  Finding Histogram values
    //************************************
    public BufferedImage FindHistogram(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();
        String title = "Histogram Values";

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array

        int HistogramR[] = new int[256];
        int HistogramG[] = new int[256];
        int HistogramB[] = new int[256];

        int r= 0;
        int g =0;
        int b =0;
        
        for(int k=0;k<=255;k++) {
        	HistogramR[k]=0;
        	HistogramG[k]=0;
        	HistogramB[k]=0;
        }
        
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	r = ImageArray[x][y][1];
            	g = ImageArray[x][y][2];
            	b = ImageArray[x][y][3];
            	HistogramR[r]++;  //r
            	HistogramG[g]++;  //g
            	HistogramB[b]++;  //b
            }
        }
        
        createHistogram(HistogramR, title);
		
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }
    
    
    //************************************
    // Histogram Normalisation
    //************************************
    public BufferedImage Normalisation(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();
        String title =  "Normalisation";
        
        int totalPixels = width*height;

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array

        double HistogramR[] = new double[256];
        double HistogramG[] = new double[256];
        double HistogramB[] = new double[256];

        int r= 0;
        int g =0;
        int b =0;
        
        for(int k=0;k<=255;k++) {
        	HistogramR[k]=0;
        	HistogramG[k]=0;
        	HistogramB[k]=0;
        }
        
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	r = ImageArray[x][y][1];
            	g = ImageArray[x][y][2];
            	b = ImageArray[x][y][3];
            	HistogramR[r]++;  //r
            	HistogramG[g]++;  //g
            	HistogramB[b]++;  //b
            }
        }
        
        // For loop to normalise the histogram
        for(int k=0;k<=255;k++) {
        	HistogramR[k]/=totalPixels;
        	HistogramG[k]/=totalPixels;
        	HistogramB[k]/=totalPixels;
        }

        createDoubleHistogram(HistogramR, title);
        
        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }
    
    //************************************
    // Histogram Equalisation
    //************************************
    public BufferedImage Equalization(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();
        String title =  "Equalization";
   
        int totalPixels = width*height;

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array

        float HistogramR[] = new float[256]; // r
        float HistogramG[] = new float[256]; // g
        float HistogramB[] = new float[256]; // b
        
        int tempR[] = new int[256];// temp r
        int tempG[] = new int[256];// temp g
        int tempB[] = new int[256];// temp b

        int r= 0;
        int g =0;
        int b =0;
        
        for(int k=0;k<=255;k++) {
        	HistogramR[k]=0;
        	HistogramG[k]=0;
        	HistogramB[k]=0;
        	
        	tempR[k]=0;
        	tempG[k]=0;
        	tempB[k]=0;
        }//Initialise values
        
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	r = ImageArray[x][y][1];
            	g = ImageArray[x][y][2];
            	b = ImageArray[x][y][3];
            	HistogramR[r]++;  //r
            	HistogramG[g]++;  //g
            	HistogramB[b]++;  //b
            }
        }// Increases values of the Histogram array corresponding to the ImageArray Value
        
        // For loop to normalise the histogram
        for(int k=0;k<=255;k++) {
        	HistogramR[k]/=totalPixels;
        	HistogramG[k]/=totalPixels;
        	HistogramB[k]/=totalPixels;
        }
        
        // For loop to find the accumulative distribution
        for(int k=1;k<=255;k++) {
        	HistogramR[k]= (HistogramR[k-1]+HistogramR[k]);
        	HistogramG[k]= (HistogramG[k-1]+HistogramG[k]);
        	HistogramB[k]= (HistogramB[k-1]+HistogramB[k]);
        }
        
        // Accumulative multiplied by the pixel length = 255
        for(int k=1;k<=255;k++) {
        	tempR[k]= (int) (255*HistogramR[k]);
        	tempG[k]= (int) (255*HistogramG[k]);
        	tempB[k]= (int) (255*HistogramB[k]);
        }       
        createHistogram(tempR, title);

        return convertToBimage(ImageArray);  // Convert the array to BufferedImage
    }
    

    //************************************
    // Histogram Display
    //************************************
    public BufferedImage Display(BufferedImage timg){
        int width = timg.getWidth();
        int height = timg.getHeight();
        String title = "New Histogram values";
        
        int totalPixels = width*height;

        int[][][] ImageArray = convertToArray(timg);          //  Convert the image to array
        
        int [][][] ImageArray2 =  ImageArray;

        float HistogramR[] = new float[256]; // r
        float HistogramG[] = new float[256]; // g
        float HistogramB[] = new float[256]; // b
        
        int tempR[] = new int[256];// temp r
        int tempG[] = new int[256];// temp g
        int tempB[] = new int[256];// temp b

        int r= 0;
        int g =0;
        int b =0;
        
        for(int k=0;k<=255;k++) {
        	HistogramR[k]=0;
        	HistogramG[k]=0;
        	HistogramB[k]=0;
        	
        	tempR[k]=0;
        	tempG[k]=0;
        	tempB[k]=0;
        }
        
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	r = ImageArray[x][y][1];
            	g = ImageArray[x][y][2];
            	b = ImageArray[x][y][3];
            	HistogramR[r]++;  //r
            	HistogramG[g]++;  //g
            	HistogramB[b]++;  //b
            }
        }
        
        // For loop to normalise the histogram
        for(int k=0;k<=255;k++) {
        	HistogramR[k]/=totalPixels;
        	HistogramG[k]/=totalPixels;
        	HistogramB[k]/=totalPixels;
        }
        
        // For loop to find the accumulative distribution
        for(int k=1;k<=255;k++) {
        	HistogramR[k]= (HistogramR[k-1]+HistogramR[k]);
        	HistogramG[k]= (HistogramG[k-1]+HistogramG[k]);
        	HistogramB[k]= (HistogramB[k-1]+HistogramB[k]);
        }
        
        // Accumulative multiplied by the pixel length = 255
        for(int k=0;k<=255;k++) {
        	tempR[k]= (int) (255*HistogramR[k]);
        	tempG[k]= (int) (255*HistogramG[k]);
        	tempB[k]= (int) (255*HistogramB[k]);

        }
        
        // Spreading out:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	ImageArray2[x][y][1] = tempR[ImageArray2[x][y][1]];  //r
                ImageArray2[x][y][2] = tempG[ImageArray2[x][y][2]];  //g
                ImageArray2[x][y][3] = tempB[ImageArray2[x][y][3]];  //b
            }
        }
        
        //Getting histogram values
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	r = ImageArray2[x][y][1];
            	g = ImageArray2[x][y][2];
            	b = ImageArray2[x][y][3];
            	tempR[r]++;  //r
            	tempG[g]++;  //g
            	tempB[b]++;  //b
            }
        }
        createHistogram(tempR, title);
        
        return convertToBimage(ImageArray2);  // Convert the array to BufferedImage
    }
    
    //********************************************
	// Histogram set Method
    //********************************************
    
    public void setHistogramOperations() {
    	choicesHistogram();
    	repaint();
    }
    
    //********************************************
	// CHoices Method for the histogram cases
    //********************************************
    public void choicesHistogram() {

    	histogramLastIndex = histogramIndex;
    	
    	switch(histogramIndex) {
    		case 0: biFiltered = bi;
    			return;
    		case 1: biFiltered = FindHistogram(biFiltered);
    			return;
    		case 2: biFiltered = Normalisation(biFiltered);
    			return;
    		case 3: biFiltered = Equalization(biFiltered);
    			return;
    		case 4: biFiltered = Display(biFiltered);
    			return;
    	}
    }
    
 // ************************************
 	// Averaging : 1/9 [1 1 1 ]
 	// 					[1 1 1 ]
 	// 					[1 1 1 ]
 	// ************************************
 	public BufferedImage Averaging(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();

 		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg);


 		int[][] Mask = new int[3][3];

 		int r;
 		int g;
 		int b;

 		// Initial Mask
 		for (int y = 0; y < 3; y++) {
 			for (int x = 0; x < 3; x++) {
 				Mask[x][y] = 1;
 			}
 		}

 		for (int y = 1; y < height - 1; y++) {
 			for (int x = 1; x < width - 1; x++) {
 				r = 0; g = 0; b = 0;
 				for (int s = -1; s <= 1; s++) {
 					for (int t = -1; t <= 1; t++) {
 						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
 						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
 						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
 					}

 				}

 				ImageArray2[x][y][1] = (int) (r / 9);
 				ImageArray2[x][y][2] = (int) (g / 9);
 				ImageArray2[x][y][3] = (int) (b / 9);
 			}
 		}

 		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
 	}
 	
	// ************************************
	// Weighted Averaging : 1/16[1 2 1 ]
	// 							[2 4 2 ]
	// 							[1 2 1 ]
	// ************************************
	public BufferedImage WeightAveraging(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();

		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg);

		float[][] Mask = { { 1, 2, 1 }, { 2, 4, 2 }, { 1, 2, 1 } };

		float r;
		float g;
		float b;
		
 		// Initial Mask
 		for (int y = 0; y < 3; y++) {
 			for (int x = 0; x < 3; x++) {
 				Mask[x][y] = Mask[x][y]/16;
 			}
 		}

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}

				}

				ImageArray2[x][y][1] = (int) (r);
				ImageArray2[x][y][2] = (int) (g);
				ImageArray2[x][y][3] = (int) (b);
			}
		}

		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// ************************************
	// 4-Neighbour Laplacian : [0 -1 0 ]
	// 							[-1 4 -1 ]
	// 							[0 -1 0 ]
	// ************************************
	public BufferedImage FourNeigLaplacian(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();

		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); 

		int[][] Mask = { { 0, -1, 0 }, { -1, 4, -1 }, { 0, -1, 0 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				
				ImageArray2[x][y][1] = truncate(r);
				ImageArray2[x][y][2] = truncate(g);
				ImageArray2[x][y][3] = truncate(b);
			
			}
		}
		
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// **************************************
	// 8-Neighbour Laplacian : 	 [-1 -1 -1 ]
	//							 [-1 8 -1 ]
	// 							 [-1 -1 -1 ]
	// **************************************
	public BufferedImage EightNeigLaplacian(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();

		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

		int[][] Mask = { { -1, -1, -1 }, { -1, 8, -1 }, { -1, -1, -1 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(r);
				ImageArray2[x][y][2] = truncate(g);
				ImageArray2[x][y][3] = truncate(b);
			}
		}

		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// ***********************************************
	// 4-Neighbour Laplacian Enhancement : [0 -1 0 ]
	//									   [-1 5 -1 ]
	// 									   [0 -1 0 ]
	// ************************************************
	
	public BufferedImage FourNeigLaplaEnhancement(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();

		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

		int[][] Mask = { { 0, -1, 0 }, { -1, 5, -1 }, { 0, -1, 0 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(b));
			
			}
		}
		

		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// ****************************************************
	// 8-Neighbour Laplacian Enhancement : [-1 -1 -1 ]
	//									   [-1 9 -1 ]
	// 									   [-1 -1 -1 ]
	// ****************************************************
	
	public BufferedImage EightNeighLaplaEnhancement(BufferedImage timg) {
			
		int width = timg.getWidth();
		int height = timg.getHeight();

		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array
		int[][] Mask = { { -1, -1, -1 }, { -1, 9, -1 }, { -1,-1, -1 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(b));
			}
		}
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
		
	// ************************************
	// Roberts I : 	[0 0 0 ]
	// 				[0 0 -1]
	// 				[0 1 0 ]
	// ************************************
	public BufferedImage RobertsI(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array
		int[][] Mask = { { 0, 0, 0 }, { 0, 0, -1 }, { 0, 1, 0 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(b));
			}
		}
			
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// ************************************
	// Roberts I : 	[0 0 0 ]
	// 				[0 -1 0]
	// 				[0 0 -1 ]
	// ************************************
	
	public BufferedImage RobertsII(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array
		int[][] Mask = { { 0, 0, 0 }, { 0, -1, 0 }, { 0, 0, 1 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(b));
			}
		}
			
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// ************************************
	// Sobel X : 	[-1 0 1]
	// 				[-2 0 2]
	// 				[-1 0 1]
	// ************************************
	
	public BufferedImage SobelX(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array
		int[][] Mask = { { -1, 0, 1 }, { -2, 0, 2 }, { -1, 0, 1 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(r));
			}
		}
			
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// ************************************
	// Sobel X : 	[-1 -2 -1]
	// 				[ 0 0 0]
	// 				[1 2 1]
	// ************************************
	
	public BufferedImage SobelY(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array
		
		int[][] Mask = { { -1,-2,-1 }, { 0, 0, 0 }, { 1, 2, 1 } };

		int r;
		int g;
		int b;

		for (int y = 1; y < height - 1; y++) {
			for (int x = 1; x < width - 1; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -1; s <= 1; s++) {
					for (int t = -1; t <= 1; t++) {
						r = r + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[1 - s][1 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(r));
			}
		}
				
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// **************************************
	// Gaussian : 	 [1  4 7  4  1]
	//				 [4 16 26 16 4]
	// 				 [7 26 41 26 7]
	//				 [4 16 26 16 4]
	//				 [1  4 7  4  1]
	// **************************************
	public BufferedImage Gaussian(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();

		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

		float [][] Mask = { { 1, 4, 7, 4, 1 }, { 4, 16, 26, 16, 4 }, { 7, 26, 41, 26, 7 }, { 4, 16, 26, 16, 4 }, { 1, 4, 7, 4, 1 } };

		float r;
		float g;
		float b;

 		// Initial Mask
 		for (int y = 0; y < 5; y++) {
 			for (int x = 0; x < 5; x++) {
 				Mask[x][y] = Mask[x][y]/273;
 			}
 		}
 		
		for (int y = 2; y < height - 2; y++) {
			for (int x = 2; x < width - 2; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -2; s <=2; s++) {
					for (int t = -2; t <= 2; t++) {
						r = r + (Mask[2 - s][2 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[2 - s][2 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[2 - s][2 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = (int) r;
				ImageArray2[x][y][2] = (int) g;
				ImageArray2[x][y][3] = (int) b;
			}
		}
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
	
	// **************************************
	// Laplacian Of Gaussian : 	 [0  0 -1 0  0]
	//							 [0 -1 -2 -1 0]
	// 				 			 [-1 -2 16 -2 -1]
	//				 			 [0 -1 -2 -1 0]
	//							 [0  0 -1 0  0]
	// **************************************
	public BufferedImage LaplacianOfGaussian(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array
		
		int [][] Mask = { { 0, 0, -1, 0, 0 }, {0, -1, -2, -1, 0}, {-1, -2, 16, -2, -1}, {0, -1, -2, -1, 0}, { 0, 0, -1, 0, 0 } };

		int r;
		int g;
		int b;
	 		
		for (int y = 2; y < height - 2; y++) {
			for (int x = 2; x < width - 2; x++) {
				r = 0;
				g = 0;
				b = 0;
				for (int s = -2; s <=2; s++) {
					for (int t = -2; t <= 2; t++) {
						r = r + (Mask[2 - s][2 - t]) * (ImageArray[x + s][y + t][1]); // r
						g = g + (Mask[2 - s][2 - t]) * (ImageArray[x + s][y + t][2]); // g
						b = b + (Mask[2 - s][2 - t]) * (ImageArray[x + s][y + t][3]); // b
					}
				}
				ImageArray2[x][y][1] = truncate(Math.abs(r));
				ImageArray2[x][y][2] = truncate(Math.abs(g));
				ImageArray2[x][y][3] = truncate(Math.abs(r));
			}
		}
		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
	}
    //********************************************
	// Truncate function returning values 
	// depending on the integer i.
    //********************************************
	public int truncate(int i) {
		if(i>255) {
			i= 255;
		}
		else if(i<0) {
			i=0;
		}
		return i;
	}
	
    //********************************************
	// Convolution method
    //********************************************
	
	public void setConvolutionOp() {
		choicesConvolution();
		repaint();
	}
	
    //********************************************
	// Choices for convolution cases
    //********************************************
	
    private void choicesConvolution() {
    	convolutionLastIndex = convoluTionIndex;
    	
    	switch (convoluTionIndex) {
			case 0: biFiltered = bi;
				return;
			case 1: biFiltered = Averaging(bi);
				return;
			case 2: biFiltered = WeightAveraging(bi);
				return;
			case 3: biFiltered = FourNeigLaplacian(bi);
				return;
			case 4: biFiltered = EightNeigLaplacian(bi);
				return;
			case 5: biFiltered = FourNeigLaplaEnhancement(bi);
				return;
			case 6: biFiltered = EightNeighLaplaEnhancement(bi);
				return;
			case 7: biFiltered = RobertsI(bi);
				return;
			case 8: biFiltered = RobertsII(bi);
				return;
			case 9: biFiltered = SobelX(bi);
				return;
			case 10: biFiltered = SobelY(bi);
				return;
			case 11: biFiltered = Gaussian(bi);
				return;
			case 12: biFiltered = LaplacianOfGaussian(bi);
				return;
    	}
	}
    
    // ************************************
    //	Salt and Pepper	
 	// ************************************
 	public BufferedImage SaltAndPepper(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();
 		
 		int[][][] ImageArray = convertToArray(timg); // Convert the image to array

        int rand;
        int media = 10;

        // Image Negative Operation:
        for(int y=0; y<height; y++){
            for(int x =0; x<width; x++){
            	rand = (int) (Math.random()*media + 1);
            	if(rand == 1) {//Salt Noise / For removing this use MIN FILTERING
	                ImageArray[x][y][1] = 255;  //r
	                ImageArray[x][y][2] = 255;  //g
	                ImageArray[x][y][3] = 255;  //b
            	}
            	if(rand == 2){//Pepper noise // For removing this use MAX FILTERING
	                ImageArray[x][y][1] = 0;  //r
	                ImageArray[x][y][2] = 0;  //g
	                ImageArray[x][y][3] = 0;  //b
            	}
            }//However, Median Filtering is also a good filtering that removes almost all noise
        }
        
 		return convertToBimage(ImageArray); // Convert the array to BufferedImage
 	}
 	
    // ************************************
    //	Min Filtering
 	// ************************************
 	public BufferedImage MinFiltering(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();
 		
 		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
 		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

 		
 		int[] rWindow = new int [9];
 		int[] gWindow = new int [9];
 		int[] bWindow = new int [9];
 		int k;

 		// for Window of size 3x3
 		for(int y=1; y<height-1; y++){
 			for(int x=1; x<width-1; x++){
 				k = 0;
 				for(int s=-1; s<=1; s++){
 					for(int t=-1; t<=1; t++){
				 		rWindow[k] = ImageArray[x+s][y+t][1]; //r
				 		gWindow[k] = ImageArray[x+s][y+t][2]; //g
				 		bWindow[k] = ImageArray[x+s][y+t][3]; //b
				 		k++;
 					}
 				}
		 		Arrays.sort(rWindow);
		 		Arrays.sort(gWindow);
		 		Arrays.sort(bWindow);
		 		ImageArray2[x][y][1] = rWindow[0]; //r
		 		ImageArray2[x][y][2] = gWindow[0]; //g
		 		ImageArray2[x][y][3] = bWindow[0]; //b
 			}
 		}
        
 		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
 	}
 	
    // ************************************
    //	Max Filtering
 	// ************************************
 	public BufferedImage MaxFiltering(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();
 		
 		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
 		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

 		
 		int[] rWindow = new int [9];
 		int[] gWindow = new int [9];
 		int[] bWindow = new int [9];
 		int k;

 		// for Window of size 3x3
 		for(int y=1; y<height-1; y++){
 			for(int x=1; x<width-1; x++){
 				k = 0;
 				for(int s=-1; s<=1; s++){
 					for(int t=-1; t<=1; t++){
				 		rWindow[k] = ImageArray[x+s][y+t][1]; //r
				 		gWindow[k] = ImageArray[x+s][y+t][2]; //g
				 		bWindow[k] = ImageArray[x+s][y+t][3]; //b
				 		k++;
 					}
 				}
		 		Arrays.sort(rWindow);
		 		Arrays.sort(gWindow);
		 		Arrays.sort(bWindow);
		 		ImageArray2[x][y][1] = rWindow[8]; //r
		 		ImageArray2[x][y][2] = gWindow[8]; //g
		 		ImageArray2[x][y][3] = bWindow[8]; //b
 			}
 		}
        
 		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
 	}
 	
    // ************************************
    //	Midpoint Filtering
 	// ************************************
 	public BufferedImage MidPointFiltering(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();
 		
 		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
 		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

 		
 		int[] rWindow = new int [9];
 		int[] gWindow = new int [9];
 		int[] bWindow = new int [9];
 		int k;

 		// for Window of size 3x3
 		for(int y=1; y<height-1; y++){
 			for(int x=1; x<width-1; x++){
 				k = 0;
 				for(int s=-1; s<=1; s++){
 					for(int t=-1; t<=1; t++){
				 		rWindow[k] = ImageArray[x+s][y+t][1]; //r
				 		gWindow[k] = ImageArray[x+s][y+t][2]; //g
				 		bWindow[k] = ImageArray[x+s][y+t][3]; //b
				 		k++;
 					}
 				}
		 		Arrays.sort(rWindow);
		 		Arrays.sort(gWindow);
		 		Arrays.sort(bWindow);
		 		ImageArray2[x][y][1] = (rWindow[0] + rWindow[8])/2; //r
		 		ImageArray2[x][y][2] = (gWindow[0] + gWindow[8])/2; //g
		 		ImageArray2[x][y][3] = (bWindow[0] + bWindow[8])/2; //b
 			}
 		}
        
 		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
 	}
 	
    // ************************************
    //	Median Filtering
 	// ************************************
 	public BufferedImage MedianFiltering(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();
 		
 		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
 		int[][][] ImageArray2 = convertToArray(timg); // Convert the image to array

 		
 		int[] rWindow = new int [9];
 		int[] gWindow = new int [9];
 		int[] bWindow = new int [9];
 		int k;

 		// for Window of size 3x3
 		for(int y=1; y<height-1; y++){
 			for(int x=1; x<width-1; x++){
 				k = 0;
 				for(int s=-1; s<=1; s++){
 					for(int t=-1; t<=1; t++){
				 		rWindow[k] = ImageArray[x+s][y+t][1]; //r
				 		gWindow[k] = ImageArray[x+s][y+t][2]; //g
				 		bWindow[k] = ImageArray[x+s][y+t][3]; //b
				 		k++;
 					}
 				}
		 		Arrays.sort(rWindow);
		 		Arrays.sort(gWindow);
		 		Arrays.sort(bWindow);
		 		ImageArray2[x][y][1] = rWindow[4]; //r
		 		ImageArray2[x][y][2] = gWindow[4]; //g
		 		ImageArray2[x][y][3] = bWindow[4]; //b
 			}
 		}
        
 		return convertToBimage(ImageArray2); // Convert the array to BufferedImage
 	}
 	
    //************************************
    //  Order Filtering method
    //************************************
    
	public void setOrderFiltering() {
		choicesFiltering();
		repaint();
	}
	
    //************************************
    //  Choices for Order filtering
    //************************************
    private void choicesFiltering() {

    	OrderLastIndex = orderFilteringIndex;
    	
    	switch (orderFilteringIndex) {
    		case 0: biFiltered = bi;
    			return;
			case 1: biFiltered = SaltAndPepper(biFiltered);
				return;	
			case 2: biFiltered = MinFiltering(biFiltered);
				return;	
			case 3: biFiltered = MaxFiltering(biFiltered);
				return;	
			case 4: biFiltered = MidPointFiltering(biFiltered);
				return;
			case 5: biFiltered = MedianFiltering(biFiltered);
				return;
    	}
	}
    
     /************************************
    	Mean and Standard Deviation
 	 ************************************/ 	
 	public BufferedImage MeanAndStdrDeviaton(BufferedImage timg) {
 		int width = timg.getWidth();
 		int height = timg.getHeight();
        
        int totalPixels = width*height;

        int[][][] ImageArray = convertToArray(timg);        //  Convert the image to array

        double meanR, meanG,meanB;
        
        double deviationR, deviationG, deviationB;
        
      /******************************
        	Calculating the mean
       *******************************/
      double r =0; double g = 0; double b =0;

      for(int y=0; y<height; y++){
        for(int x =0; x<width; x++){
        	r = r + ImageArray[x][y][1];
           	g = g + ImageArray[x][y][2];
           	b = b + ImageArray[x][y][3];
        }
      }
      meanR= r/totalPixels;
      meanG= g/totalPixels;
      meanB= b/totalPixels;

      System.out.println("meanR :" + meanR);
      System.out.println("meanG :" + meanG);
      System.out.println("meanB :" + meanB);

      /****************************************
       * Calculating Standard deviation
       ***************************************/
      r =0; g = 0; b =0;
      for(int y=0; y<height; y++){
          for(int x =0; x<width; x++){
        	  r = r + Math.pow(ImageArray[x][y][1] - meanR, 2);
              g = g + Math.pow(ImageArray[x][y][2] - meanG, 2);
              b = b + Math.pow(ImageArray[x][y][3] - meanB, 2);
          }
      }
      
      deviationR= Math.sqrt(r/totalPixels);
      deviationG= Math.sqrt(g/totalPixels);
      deviationB= Math.sqrt(b/totalPixels);
      
      System.out.println("\ndeviationR :" +deviationR);
      System.out.println("deviationG :" +deviationG);
      System.out.println("deviationB :" +deviationB);

      return convertToBimage(ImageArray); // Convert the array to BufferedImage

 	}
 	
    /************************************
   		Simple Thresholding
	 ************************************/
	public BufferedImage simpleThresholding(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		int thresholdValue = 125;
		
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array

		int r,g,b;
		/**************************************
		   Setting thresholding on image pixels
		***************************************/
		for(int y=0; y<height; y++){
			for(int x =0; x<width; x++){
				
	        	r = ImageArray[x][y][1];
	            g = ImageArray[x][y][2];
	            b = ImageArray[x][y][3];
	            
	            ImageArray[x][y][1] = thresholdFunction(r, thresholdValue);
	            ImageArray[x][y][2] = thresholdFunction(g, thresholdValue);
	            ImageArray[x][y][3] = thresholdFunction(b, thresholdValue);
		   }
		}
	    return convertToBimage(ImageArray); // Convert the array to BufferedImage
	}
	
    /************************************
		Automated Thresholding
	 ************************************/
	public BufferedImage automatedThresholding(BufferedImage timg) {
		int width = timg.getWidth();
		int height = timg.getHeight();
		int[][][] ImageArray = convertToArray(timg); // Convert the image to array
		
        int totalPixels = width*height;
        
        int currentThresholding =0;
        int Thresholding=0;
        int nextThresholding=0;
        int difThresholding=0;
        
		int object =0;
		int backGround;
		int sum= 0;// Sum1 hold values of the sum of all pixels
				
		int r,g,b;
		
		for(int y=0; y<height; y++){
	        for(int x =0; x<width; x++){
	        	r = ImageArray[x][y][1];
	            g = ImageArray[x][y][2];
	            b = ImageArray[x][y][3];
	            sum+=r;
	        }  
	    }
	    
		int bgr = ImageArray[0][0][1]+ImageArray[0][511][1]+ImageArray[511][0][1]+ImageArray[511][511][1];
		backGround = (int)(bgr)/4;
		
		object =(int)(sum-bgr)/(totalPixels-4);
		
	    /********************************
	     * Calculating new Thresholding
	     ********************************/
	    Thresholding =(int)(backGround+object)/2;
	    
		while(true) {
		    for(int y=0; y<height; y++){
		        for(int x =0; x<width; x++){
		        	r = ImageArray[x][y][1];
		            g = ImageArray[x][y][2];
		            b = ImageArray[x][y][3];
		            sum+=r;
		        }  
		    }
		    
			bgr = ImageArray[0][0][1]+ImageArray[0][511][1]+ImageArray[511][0][1]+ImageArray[511][511][1];
			backGround = (int)(bgr)/4;
			
			object =(int)(sum-bgr)/(totalPixels-4);
			
		    /********************************
		     * Calculating new Thresholding
		     ********************************/
		    nextThresholding =(int)(backGround+object)/2;
		    
		    /************************************
		     * Calculating intermediate threshold
		     *************************************/
		    
		    difThresholding = Math.abs(nextThresholding - currentThresholding);
		    		    
		    if(difThresholding<Thresholding) {
		    	break;
		    }else {
		    	//Thresholding = currentThresholding;
		    	currentThresholding = nextThresholding;
		    }
		    System.out.println(Thresholding);
		}
		/**************************************
		   Setting thresholding on image pixels
		***************************************/
		for(int y=0; y<height; y++){
			for(int x =0; x<width; x++){
				
	        	r = ImageArray[x][y][1];
	            g = ImageArray[x][y][2];
	            b = ImageArray[x][y][3];
	            
	            ImageArray[x][y][1] = thresholdFunction(r, Thresholding);
	            ImageArray[x][y][2] = thresholdFunction(g, Thresholding);
	            ImageArray[x][y][3] = thresholdFunction(b, Thresholding);
		   }
		}

		System.out.println(Thresholding);
	    return convertToBimage(ImageArray); // Convert the array to BufferedImage
	    
	}
	
	/**************************************
	  ThreshholdFunction returns value depending 
	  of the threshold value.
	***************************************/
	
	public int thresholdFunction(int value, int thresholdValue) {
		if(value>= thresholdValue) {
			return 255;
		}
		return 0;
	}
	
	/**************************************
	   Threshold set function
	***************************************/
	
    public void setThresholdingOpt() {
    	choicesThresholding();
    	repaint();
    }
    
	/**************************************
	   Choices for Threshold cases
	***************************************/
    
    private void choicesThresholding() {

    	thresholdingLastIndex = thresholdingIndex;
    	
    	switch (thresholdingIndex) {
    		case 0: biFiltered = bi;
    			return;
			case 1: biFiltered = MeanAndStdrDeviaton(biFiltered);
				return;	
			case 2: biFiltered = simpleThresholding(biFiltered);
				return;	
			case 3: biFiltered = automatedThresholding(biFiltered);
				return;	
    	}
	}
    
    
	public void addImage(BufferedImage ting) {
		saveImage.put(pd, biFiltered);
		counter++;
	}//Add Class to HashMap
	public void removeImage(BufferedImage ting) {
		if(counter > 0) {
			saveImage.remove(biFiltered);
			counter --;
		}
	}//Remove Class from HashMap
    
    public void actionPerformed(ActionEvent e) {
    	
    	Object so = e.getSource();
   	 
   	 	if(so instanceof JButton) {
	   		 JButton jb = (JButton)so;
	   		 
	   		 if(jb.getActionCommand().equals("Undo")) {
	   			 removeImage(biFiltered);
	   			 repaint();
	   		 }
	   		 
	   	 }else if(so instanceof JComboBox) {
            JComboBox cb = (JComboBox)so;             
             if (cb.getActionCommand().equals("SetFilter")) {
                 setOpIndex(cb.getSelectedIndex());
                 repaint();
                 addImage(biFiltered);
             } else if (cb.getActionCommand().equals("Formats")) {
                 String format = (String)cb.getSelectedItem();
                 File saveFile = new File("savedimage."+format);
                 JFileChooser chooser = new JFileChooser();
                 chooser.setSelectedFile(saveFile);
                 int rval = chooser.showSaveDialog(cb);
                 if (rval == JFileChooser.APPROVE_OPTION) {
                     saveFile = chooser.getSelectedFile();
                     try {
                         ImageIO.write(biFiltered, format, saveFile);
                     } catch (IOException ex) {
                     }
                 }
             } else if(cb.getActionCommand().equals("Images")) {
            	 
            	 String im = (String)cb.getSelectedItem();
            	             	 
            	 try {
                     bi = ImageIO.read(new File(path + im));
                     w = bi.getWidth(null);
                     h = bi.getHeight(null);
                     //System.out.println(bi.getType());
                     if (bi.getType() != BufferedImage.TYPE_INT_RGB) {
                         BufferedImage bi2 = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
                         Graphics big = bi2.getGraphics();
                         big.drawImage(bi, 0, 0, null);
                         biFiltered = bi = bi2;
                     }
                 }catch (NullPointerException exception){
                	 
                     System.out.println("Second Tif image");
                 } catch (IOException exception) {      // deal with the situation that th image has problem;/
                     System.out.println("Image could not be read");

                     System.exit(1);
                 }
            	 
            	 repaint();
            	 
             }else if (cb.getActionCommand().equals("ArithmeticOperations")) {
            	 setMathsIndex(cb.getSelectedIndex());
            	 
                 setMathOperation(); 
 	           
                 if(cb.getSelectedIndex() != 0) {
                	 
                	 JFrame f =  new JFrame(mathsOp[mathsIndex]);
             		 f.getContentPane().setLayout(null);
             		 
             		 JPanel panel = new JPanel();
             		 panel.setBounds(0, 10, 650, 580);
             		 f.getContentPane().add(panel);

                     panel.add(pd);
                     f.add(panel);
             		 f.setBounds(450, 250, 670, 600);
                     f.setVisible(true);
                     
                 }
            	 
             }else if (cb.getActionCommand().equals("BitwiseOperations")) {
            	 setBitwiseIndex(cb.getSelectedIndex());
            	 
            	 setBitwiseOperations(); 
 	           
                 if(cb.getSelectedIndex() != 0) {
                	 
                	 JFrame f =  new JFrame(bitwiseOp[bitwiseIndex]);
             		 f.getContentPane().setLayout(null);
             		 
             		 JPanel panel = new JPanel();
             		 panel.setBounds(0, 10, 650, 580);
             		 f.getContentPane().add(panel);

                     panel.add(pd);
                     f.add(panel);
             		 f.setBounds(450, 250, 670, 600);
                     f.setVisible(true);
                     
                 }
            	 
             }else if (cb.getActionCommand().equals("PointProcessing")) {
            	 setPointProIndex(cb.getSelectedIndex());
            	 setPointPrOperations(); 
             }else if (cb.getActionCommand().equals("Histogram")) {
            	 setHistogramIndex(cb.getSelectedIndex());
            	 setHistogramOperations(); 
             }else if(cb.getActionCommand().equals("Convolution")) {
            	 setConvolutionIndex(cb.getSelectedIndex());
            	 setConvolutionOp();
             }else if(cb.getActionCommand().equals("OrderFiltering")) {
            	 setOrderFilteringIndex(cb.getSelectedIndex());
            	 setOrderFiltering();
             }else if(cb.getActionCommand().equals("Thresholding")) {
            	 setThresholdingIndex(cb.getSelectedIndex());
            	 setThresholdingOpt();
             }
	   	 }
             
    };

    
    public static void main(String s[]) {
        JFrame f = new JFrame("Image Processing Demo");
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {System.exit(0);}
        });
		f.getContentPane().setLayout(null);
		int numberToDisplay = 2;
		int x = 0;
		while(ar<numberToDisplay) {
        	Demo de = new Demo();
            
            JPanel panel = new JPanel();
    		panel.setBounds(x+30, 42, 800, 800);
    		f.getContentPane().add(panel);

    		JComboBox ima = new JComboBox(de.getImage());
            ima.setActionCommand("Images");
            ima.addActionListener(de);
    		
            JComboBox choices = new JComboBox(de.getDescriptions());
            choices.setActionCommand("SetFilter");
            choices.addActionListener(de);
            
            JComboBox pointPro = new JComboBox(de.getPointProcessing());
            pointPro.setActionCommand("PointProcessing");
            pointPro.addActionListener(de);
            
            JComboBox histogram = new JComboBox(de.getHistogram());
            histogram.setActionCommand("Histogram");
            histogram.addActionListener(de);
            
			JComboBox convolution = new JComboBox(de.getConvolution());
			convolution.setActionCommand("Convolution");
			convolution.addActionListener(de);
			
			JComboBox orderFiltering = new JComboBox(de.getOrderFiltering());
			orderFiltering.setActionCommand("OrderFiltering");
			orderFiltering.addActionListener(de);
			
			JComboBox thresholding = new JComboBox(de.getThresholding());
			thresholding.setActionCommand("Thresholding");
			thresholding.addActionListener(de);
            
            JComboBox formats = new JComboBox(de.getFormats());
            formats.setActionCommand("Formats");
            formats.addActionListener(de);
            
    		JButton btnNewButton = new JButton("Undo");
    		btnNewButton.setActionCommand("Undo");
    		btnNewButton.addActionListener(de);
            
            panel.add(new JLabel("Choose Image"));
            panel.add(ima);
            panel.add(new JLabel("Set Filter"));
            panel.add(choices);
            panel.add(new JLabel("Point Processing"));
            panel.add(pointPro);
            panel.add(new JLabel("Histogram"));
            panel.add(histogram);
			panel.add(new JLabel("Convolution"));
			panel.add(convolution);
			panel.add(new JLabel("Order-Statistics"));
			panel.add(orderFiltering);
			panel.add(new JLabel("Thresholding"));
            panel.add(thresholding);
			panel.add(new JLabel("Save As"));
            panel.add(formats);
    		panel.add(btnNewButton);

            
            panel.add(de);
            
            img.add(ar, de);

            object.add(ar, panel);
            
            ar++;
            x+=830;
		}
		
		pd = new Demo();
        
		JPanel panel2 = new JPanel();
		panel2.setBounds(0, 0, x, 50);
		f.getContentPane().add(panel2);
		
        JComboBox arithOp = new JComboBox(pd.getMathsOperations());
		arithOp.setActionCommand("ArithmeticOperations");
		arithOp.addActionListener(pd);
		
        panel2.add(new JLabel("Arithmetic Operations"));
        panel2.add(arithOp);
        
        JComboBox bitWise = new JComboBox(pd.getBitwiseOperations());
        bitWise.setActionCommand("BitwiseOperations");
        bitWise.addActionListener(pd);
		
        panel2.add(new JLabel("Bitwise Operations"));
        panel2.add(bitWise);
        
		f.getContentPane().add(panel2);
		f.setBounds(100, 100, x+70, 750);
        f.setVisible(true);
    }
}