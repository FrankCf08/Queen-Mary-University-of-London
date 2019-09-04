package com.example.vehicleproject;

import android.app.Application;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.os.Build;

public class ScreenNotification extends Application {

    public static final String CHANEL_1_ID = "Chanel1";
    public static final String CHANEL_2_ID = "Chanel2";
    public static final String CHANEL_3_ID = "Chanel3";


    @Override
    public void onCreate() {
        super.onCreate();

        createNoticationChannel();
    }

    private void createNoticationChannel() {

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            NotificationChannel channel1 = new NotificationChannel(
                    CHANEL_1_ID,
                    "channel 1",
                    NotificationManager.IMPORTANCE_HIGH
            );
            channel1.setDescription("VEHICLE ALERT");
            channel1.setVibrationPattern( new long[]{1000});

            NotificationChannel channel2 = new NotificationChannel(
                    CHANEL_2_ID,
                    "chanel 2",
                    NotificationManager.IMPORTANCE_HIGH
            );
            channel2.setDescription("VEHICLE ALERT");
            channel2.setVibrationPattern( new long[]{1000});


            NotificationChannel channel3 = new NotificationChannel(
                    CHANEL_3_ID,
                    "channel 3",
                    NotificationManager.IMPORTANCE_HIGH
            );
            channel3.setDescription("VEHICLE ALERT");
            channel3.setVibrationPattern( new long[]{1000,1000,1000,1000,1000,1000,1000,1000});

            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel1);
            manager.createNotificationChannel(channel2);
            manager.createNotificationChannel(channel3);

        }
    }
}
