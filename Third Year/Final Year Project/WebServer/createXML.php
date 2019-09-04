<?php
    include 'db_connection.php';
    //Start XML file
    $dom = new DOMDocument("1.0");
    $node = $dom->createElement("vehicles");
    $parnode = $dom->appendChild($node);

    $sql =  "SELECT * FROM vehicle WHERE 1";// Select elements from vehicle table
    $result = mysqli_query($conn,$sql);// Quering the code, send this to the database and run it

    if(!$result){
        die('Invalid query: ' . mysqli_error());
    }

    header("Content-type: text/xml");

    while ($row = @mysqli_fetch_assoc($result)) {
        $node =  $dom->createElement("vehicle");
        $newnode = $parnode->appendChild($node);
        $newnode->setAttribute("id",$row['id']);
        $newnode->setAttribute("latitude",$row['latitude']);
        $newnode->setAttribute("longitude",$row['longitude']);
        $newnode->setAttribute("time",$row['time']);
        $newnode->setAttribute("satellites",$row['satellites']);
        $newnode->setAttribute("speedOTG",$row['speedOTG']);
        $newnode->setAttribute("course",$row['course']);
    }
    echo $dom->saveXML();
    $dom ->asXML('vehicleXML.xml');
?>
