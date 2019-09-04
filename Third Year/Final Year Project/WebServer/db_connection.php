<?php

     // Details to connections
     $dbhost = "31.22.4.4";
     $dbuser = "vehiclep_frank";
     $dbpass = "sp^]{gst}=MV";
     $db = "vehiclep_vehpro";

     // Create connection
     $conn = mysqli_connect($dbhost, $dbuser, $dbpass, $db);
     // Check connection
     if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
     }
     //echo "Connected successfully db_connection file";
?>
