package com.example.vehicleproject;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;


public class MapFragment extends Fragment implements OnMapReadyCallback {


    GoogleMap mMap;

    LocationManager locationManager;
    LocationListener locationListener;

    String lat;
    String lon;

    MainActivity mainActivity;

    public void listeningLocation(){
        if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {

            locationManager.requestLocationUpdates(locationManager.GPS_PROVIDER, 0, 0, locationListener);
        }
    }

    public void updateLocation(Location location){

        mMap.setMapType(GoogleMap.MAP_TYPE_TERRAIN);

        LatLng vehicleLocation = new LatLng(location.getLatitude(), location.getLongitude());

        //Clear existing marks and update to a new onw
        mMap.clear();
        mMap.addMarker(new MarkerOptions().position(vehicleLocation).title("My Position"));
        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(vehicleLocation,13));//Zoom in

    }


    public MapFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_map, container, false);

        Bundle b = getArguments();
        lat = b.getString("lat");
        lon = b.getString("lon");

        mainActivity = (MainActivity) getActivity();
        mainActivity.storeVehiclePosition(lat,lon);
        mainActivity.comparePositions();

        return v;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        SupportMapFragment mapFragment = (SupportMapFragment)getChildFragmentManager().findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);


    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        locationManager = (LocationManager) getActivity().getSystemService(Context.LOCATION_SERVICE);

        locationListener =  new LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                updateLocation(location);
                mainActivity.supportMapFragment();
                xmlPosition();
            }

            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {

            }

            @Override
            public void onProviderEnabled(String provider) {

            }

            @Override
            public void onProviderDisabled(String provider) {

            }
        };

        // To check if SDK version is less than 23
        if(Build.VERSION.SDK_INT < 23){

            listeningLocation();

        }
        else{ // We have permission

            // /*ContextCompat --> It will make us app compatible to the versions of Android
            if(ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED){

                //Requesting permission, RequestCode: it can be any number.
                ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.ACCESS_FINE_LOCATION},1);
            }
            else{

                locationManager.requestLocationUpdates(locationManager.GPS_PROVIDER,30000,0,locationListener);

                Location location =  locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);

                if(location != null){
                    updateLocation(location);
                    xmlPosition();
                }
            }
        }

    }

    public void xmlPosition(){

        float latitude = Float.parseFloat(lat);
        float longitude =  Float.parseFloat(lon);

        LatLng london = new LatLng(latitude, longitude);
        mMap.addMarker(new MarkerOptions().position(london).title("Vehicle Position").icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_BLUE)));
    }

}
