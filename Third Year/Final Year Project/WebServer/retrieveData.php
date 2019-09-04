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

     $query =  "SELECT * FROM vehicle;";

     $result = mysqli_query($conn,$query);

     $response = array();

     while($row = mysqli_fetch_array($result)){
         array_push($response, array("latitude"=>$row['latitude'], "longitude"=>$row['longitude'],"time"=>$row['time']));
     }

     mysqli_close($conn);

     echo json_encode(array('server_response'=>$response));
?>
