#include <Wire.h>

int8_t answer;
int onModulePin= 2;

char data[100];
int data_size;

char aux_str[200];
char aux;
int x = 0;
char N_S,W_E;

char url[ ]="http://www.vehicleproject.epizy.com";
char frame[200];
char apn[]="mobile.o2.co.uk";
char user_name[]="o2web";
char password[]="password";

char latitude[15];// Store latitude values
char longitude[15];// Store longitude values
char altitude[6];// Store altitude values
char date[16];// Store date values
char time[7];// Store time values
char satellites[3];// Store satellites values
char speedOTG[10];// Store speedOTG values
char course[10];// Store course values

const int MPU_addr=0x68;// MPU address 

void setup() {
  
    pinMode(onModulePin, OUTPUT);
    Serial.begin(115200);    

    Serial.println("Starting 'Vehicle Project'");
    
    powerOn();
    powerOnGPS();
    
    delay(5000);//Delay for 5 seconds
    
    setModule();//Initialise module
    initiateMPU();//Initialise MPU
}

void loop() {
  
    // gets GPS data
    getGPS();
    // get Acceleration
    getAcceleromter();
    // sends GPS data to the script
    send_HTTP();

    delay(5000);
}

void powerOn(){

    uint8_t ans=0;

    // checks if the module is started
    ans = sendCommand("AT", "OK", 2000);
    if (ans == 0)
    {
        // power on pulse
        digitalWrite(onModulePin,HIGH);
        delay(3000);
        digitalWrite(onModulePin,LOW);

        // waits for module's answer
        while(ans == 0){  
            // AT command is sent every 2 seconds and then waits 
            ans = sendCommand("AT", "OK", 2000);    
        }
    }
}

void powerOnGPS(){

    uint8_t ans=0;

    // checks if the module is started
    ans = sendCommand("AT", "OK", 2000);
    if (ans == 0)
    {
        // power on pulse
        digitalWrite(onModulePin,HIGH);
        delay(3000);
        digitalWrite(onModulePin,LOW);

        //Waits for module's answer
        while(ans == 0){  
            // AT command is sent every 2 seconds and then waits  
            ans = sendCommand("AT", "OK", 2000);    
        }
    }

}

void setModule(){
      
    //Sim card's password set up
    sendCommand("AT+CPIN?", "OK", 2000);  
  
    delay(3000);  
    //Enable +CLIP notification
    sendCommand("AT+CLIP=1", "OK", 1000); 

    //Set GPS location
    while ( startGPS() == 0);

    //Set Network
    while (sendCommand("AT+CREG?", "+CREG: 0,1", 2000) == 0);

    // sets APN , user name and password
    sendCommand("AT+SAPBR=3,1,\"Contype\",\"GPRS\"", "OK", 2000);
    //AT+SAPBR=3,1,"Contype","GPRS"
    snprintf(aux_str, sizeof(aux_str), "AT+SAPBR=3,1,\"APN\",\"%s\"", apn);
    //AT+SAPBR=3,1,"APN","mobile.o2.co.uk"
    sendCommand(aux_str, "OK", 2000);   
    snprintf(aux_str, sizeof(aux_str), "AT+SAPBR=3,1,\"USER\",\"%s\"", user_name);
    //AT+SAPBR=3,1,"USER","o2web"
    sendCommand(aux_str, "OK", 2000);
    snprintf(aux_str, sizeof(aux_str), "AT+SAPBR=3,1,\"PWD\",\"%s\"", password);
    //AT+SAPBR=3,1,"PWD","password"
    sendCommand(aux_str, "OK", 2000);
    
    
    // gets the GPRS bearer
    while (sendCommand("AT+SAPBR=1,1", "OK", 20000) == 0)
    {
        delay(5000);
    }

    delay(1000);
    
    while(Serial.available() != 0)
    {
      Serial.read();  
    }
}

void initiateMPU(){
  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B); // Writting to the Register 6B -- Power Management
  Wire.write(0b00000000); // SLEEP mode register to 0
  Wire.endTransmission();
  Wire.beginTransmission(MPU_addr);//0x68 Accessing Address of the MPU
  Wire.write(0x1B);// Accessing register 1B - Gyroscope Configurarion
  Wire.write(0x00000000);//Setting Gyro to full scale +/- 250 degrees
  Wire.endTransmission();
  Wire.beginTransmission(MPU_addr);//0x68 Accessing Address of the MPU
  Wire.write(0x1C);//Accessing register 1C -- Acceleremoter configuration
  Wire.write(0b00000000);// Accelerometer set to +/- 2g
  Wire.endTransmission();

}
int8_t startGPS(){
  
     unsigned long prev;

    prev = millis();
    
    // starts the GPS
    sendCommand("AT+CGPSPWR=1", "OK", 2000); // Turn on GPS power supply
    sendCommand("AT+CGPSRST=0", "OK", 2000); // Reset GPS on Cold mode

    while( ((sendCommand("AT+CGPSSTATUS?", "2D Fix", 5000) || sendCommand("AT+CGPSSTATUS?", "3D Fix", 5000)) == 0 ));
}

int8_t getGPS(){

    int8_t counter, ans;
    long prev;

    // First get the NMEA string
    // Clean the input buffer
    while( Serial.available() > 0) Serial.read();
     
    // request Basic string
    sendCommand("AT+CGPSINF=0", "AT+CGPSINF=0\r\n\r\n", 2000);

    counter = 0;
    ans = 0;
    memset(frame, '\0', 100);    // Initialize the string
    prev = millis();
    // this loop waits for the NMEA string
    do{

        if(Serial.available() != 0){    
            frame[counter] = Serial.read();
            counter++;
            // check answer
            if (strstr(frame, "OK") != NULL)    
            {
                ans = 1;
            }
        }
     //Time out and restars
    }
    while((ans == 0) && ((millis() - prev) < 2000));  

    frame[counter-3] = '\0'; 
    
    // Parses the string 
    strtok(frame, ",");
    strcpy(longitude,strtok(NULL, ",")); // Gets longitude value
    strcpy(latitude,strtok(NULL, ",")); // Gets latitude value
    strcpy(altitude,strtok(NULL, ".")); // Gets altitude  value
    strtok(NULL, ",");    
    strcpy(date,strtok(NULL, ".")); // Gets date value
    strtok(NULL, ",");
    strtok(NULL, ",");  
    strcpy(satellites,strtok(NULL, ",")); // Gets satellites value
    strcpy(speedOTG,strtok(NULL, ",")); // Gets speed over ground. Unit is knots.
    strcpy(course,strtok(NULL, "\r")); // Gets course value

    // COnverting latitude value
    convertLatLon2Degrees(latitude);
    convertLatLon2Degrees(longitude);
    
    return ans;
}

void getAcceleromter(){
    Wire.beginTransmission(MPU_addr);
    Wire.write(0x3B);// Starts Acceleremoter 
    Wire.endTransmission();
    Wire.requestFrom(MPU_addr,6); //Requesting Acceleromter Register 3B - 40
    
    while(Wire.available()<6);
    accX = Wire.read()<<8|Wire.read();//First two bytes
    accY = Wire.read()<<8|Wire.read();// Middle two bytes
    accZ = Wire.read()<<8|Wire.read();// Last two bytes

    convertingAccelValues();
}

void send_HTTP(){
    
    uint8_t answer=0;
    // Initializes HTTP service
    answer = sendCommand("AT+HTTPINIT", "OK", 10000);
    if (answer == 1)
    {
        // Sets CID parameter
        answer = sendCommand("AT+HTTPPARA=\"CID\",1", "OK", 5000);
        //AT+HTTPPARA="CID",1
        if (answer == 1)
        {
            // Sets url 
            sprintf(aux_str, "AT+HTTPPARA=\"URL\",\"%s/?", url);
            Serial.print(aux_str);
            sprintf(frame, "latitude=%s&longitude=%s&altitude=%s&time=%s&satellites=%s&speedOTG=%s&course=%s",latitude, longitude, altitude, date, satellites, speedOTG, course);
            Serial.print(frame);
            answer = sendCommand("\"", "OK", 5000);
            if (answer == 1)
            {
                // Starts HTTP GET action
                answer = sendCommand("AT+HTTPACTION=0", "+HTTPACTION:0,200", 30000);
                if (answer == 1)
                {

                    Serial.println(F("Data Transmitted!"));
                }
                else
                {
                    Serial.println(F("Error getting URL"));
                }

            }
            else
            {
                Serial.println(F("Error setting the URL"));
            }
        }
        else
        {
            Serial.println(F("Error setting the CID"));
        }    
    }
    else
    {
        Serial.println(F("Error initializating"));
    }

    sendCommand("AT+HTTPTERM", "OK", 5000);
    
}

/*HOME: 23:02:22.621 -> 0,-7.961393,5126.079536,82.612068,20190410220223.000,73,9,0.000000,0.000000
  Library: 11:30:14.662 -> 0,-2.353705,5131.485725,2.673439,20190411103016.000,76,6,0.000000,0.000000
  Library: 11:57:50.515 -> 0,-2.334454,5131.495335,14.821151,20190411105748.000,1009,13,0.000000,0.000000
  Library: 12:49:49.494 -> 0,-2.376042,5131.495894,108.288048,20190411114950.000,124,10,0.000000,0.000000

*/
int8_t convertLatLon2Degrees(char* input){

    float deg;
    float minutes;
    bool neg = false;    

    //auxiliar variable
    char aux[10];

    if (input[0] == '-')
    {
        neg = true;
        strcpy(aux, strtok(input+1, "."));

    }
    else
    {
        strcpy(aux, strtok(input, "."));
    }

    // convert string to integer and add it to final float variable
    deg = atof(aux);

    strcpy(aux, strtok(NULL, "\0"));
    minutes=atof(aux);
    minutes/=1000000;
    if (deg < 100)
    {
        minutes += deg;
        deg = 0;
    }
    else
    {
        minutes += (int)deg % 100;
        deg = (int)deg / 100;    
    }

    // add minutes to degrees 
    deg=deg+minutes/60;


    if (neg == true)
    {
        deg*=-1.0;
    }

    neg = false;

    if( deg < 0 ){
        neg = true;
        deg*=-1;
    }
    
    float numberFloat=deg; 
    int intPart[10];
    int digit; 
    long newNumber=(long)numberFloat;  
    int size=0;
    
    while(1){
        size=size+1;
        digit=newNumber%10;
        newNumber=newNumber/10;
        intPart[size-1]=digit; 
        if (newNumber==0){
            break;
        }
    }
   
    int index=0;
    if( neg ){
        index++;
        input[0]='-';
    }
    for (int i=size-1; i >= 0; i--)
    {
        input[index]=intPart[i]+'0'; 
        index++;
    }

    input[index]='.';
    index++;

    numberFloat=(numberFloat-(int)numberFloat);
    for (int i=1; i<=6 ; i++)
    {
        numberFloat=numberFloat*10;
        digit= (long)numberFloat;          
        numberFloat=numberFloat-digit;
        input[index]=(char)digit+48;
        index++;
    }
    input[index]='\0';


}

int8_t sendCommand(char* ATcommand, char* expected_answer1, unsigned int timeout){

    uint8_t x=0,  ans=0;
    char response[100];
    unsigned long prev;

    memset(response, '\0', 100);    // Clear array response

    delay(100);

    //Buffer input is cleared
    while( Serial.available() > 0) Serial.read();    

    Serial.println(ATcommand);    // Send the AT command 


        x = 0;
    prev = millis();

    // Do/While loop
    do{
        if(Serial.available() != 0){    
            response[x] = Serial.read();
            x++;
            // check if the answer
            if (strstr(response, expected_answer1) != NULL)    
            {
                ans = 1;
            }
        }
     //   checks answer and timeout
    }while((ans == 0) && ((millis() - prev) < timeout));    

    return ans;
}
