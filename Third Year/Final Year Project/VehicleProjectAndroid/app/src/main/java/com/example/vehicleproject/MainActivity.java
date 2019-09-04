package com.example.vehicleproject;

import android.app.Notification;
import android.os.Bundle;

import android.support.v4.app.FragmentManager;
import android.support.design.widget.NavigationView;
import android.support.v4.app.NotificationCompat;
import android.support.v4.app.NotificationManagerCompat;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {


    private RequestQueue requestQueue;
    private MapFragment mapFragment;
    private FragmentManager manager;

    private NotificationManagerCompat notificationManager;
    private String title;
    private String message;

    private String vehicleLatitude;
    private String vehicleLongitude;

    private String lastLatitude;
    private String lastLongitude;

    private boolean updateValues;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        //Deal with my Position and Vehicle's Position
        supportMapFragment();

        //Notifications
        notificationManager = NotificationManagerCompat.from(this);

        updateValues = true;
        lastLatitude = "0";
        lastLongitude = "0";
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.nav_update) {

            supportMapFragment();

        } else if (id == R.id.nav_set_alarm) {

            setAlarm();
            supportMapFragment();
            lastLocation();

        } else if (id == R.id.nav_cancel_alarm) {

            disableAlarm();
            deleteVehiclePosition();
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    public void PARSEDATA() {
        String URL = "http://www.vehicleproject.epizy.com/retrieveData.php";
        final JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET, URL, null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            JSONArray jsonarray = response.getJSONArray("server_response");

                            for (int i = 0; i < jsonarray.length(); i++) {
                                JSONObject data = jsonarray.getJSONObject(i);

                                String lat = data.getString("latitude");
                                String lon = data.getString("longitude");
                                String time = data.getString("time");

                                Bundle bundle = new Bundle();

                                bundle.putString("lat", lat);
                                bundle.putString("lon",lon);
                                bundle.putString("time",time);

                                mapFragment.setArguments(bundle);
                                manager.beginTransaction().replace(R.id.mainLayout, mapFragment).commit();

                            }

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                error.printStackTrace();
            }
        });
        requestQueue.add(request);
    }

    public void supportMapFragment(){
        mapFragment = new MapFragment();
        manager = getSupportFragmentManager();
        requestQueue = Volley.newRequestQueue(this);
        PARSEDATA();
    }
    private void setAlarm(){
        title = "ALARM SET";
        message = "Vehicle's position saved";
        Notification notification = new NotificationCompat.Builder(this, ScreenNotification.CHANEL_1_ID)
                .setSmallIcon(R.drawable.ic_set_alarm)
                .setContentTitle(title)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setCategory(NotificationCompat.CATEGORY_MESSAGE)
                .setVibrate(new long[]{100000})
                .build();
        notificationManager.notify(1,notification);
    }

    private void disableAlarm(){
        title = "ALARM DISABLED";
        message = "No vehicle's position saved";
        Notification notification = new NotificationCompat.Builder(this, ScreenNotification.CHANEL_2_ID)
                .setSmallIcon(R.drawable.ic_cancel_alarm)
                .setContentTitle(title)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setCategory(NotificationCompat.CATEGORY_MESSAGE)
                .setVibrate(new long[]{100000})
                .build();

        notificationManager.notify(2,notification);
    }
    public void lastLocation(){


        if(updateValues = true){
            lastLatitude = vehicleLatitude;
            lastLongitude = vehicleLongitude;
            updateValues= false;
        }

        System.out.println("Compare lastLatitude "+ lastLatitude);
        System.out.println("Compare lastLongitude "+ lastLongitude);
        System.out.println("Compare vehicleLatitude "+ vehicleLatitude);
        System.out.println("Compare vehicleLongitude "+ vehicleLongitude);
    }
    public void storeVehiclePosition(String lat, String lon){

        vehicleLatitude = lat;
        vehicleLongitude = lon;

    }

    public void comparePositions(){

        float  previousLat = Float.parseFloat(lastLatitude);
        float  previousLon = Float.parseFloat(lastLongitude);
        float  currentLat = Float.parseFloat(vehicleLatitude);
        float  currentLon = Float.parseFloat(vehicleLongitude);

        if(previousLat != currentLat && previousLon != currentLon && updateValues == false){
            sendEmergencyAlert();
        }
    }
    public void sendEmergencyAlert(){
        title = "VEHICLE EMERGENCY";
        message = "VEHICLE POSITION CHANGE";
        Notification notification = new NotificationCompat.Builder(this, ScreenNotification.CHANEL_3_ID)
                .setSmallIcon(R.drawable.ic_warning_alarm)
                .setContentTitle(title)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setCategory(NotificationCompat.CATEGORY_MESSAGE)
                .setVibrate(new long[]{100000,100000,100000,100000,100000,100000})
                .build();

        notificationManager.notify(3,notification);
    }

    public void deleteVehiclePosition(){

        updateValues= true;

        lastLatitude = "0";
        lastLongitude = lastLatitude;
        vehicleLatitude = lastLongitude;
        vehicleLongitude = vehicleLatitude;

    }
}