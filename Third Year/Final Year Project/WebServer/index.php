<?php
    include 'db_connection.php';

    if (!empty($_GET['latitude']) && !empty($_GET['longitude']) &&
        !empty($_GET['time']) && !empty($_GET['satellites']) &&
        !empty($_GET['speedOTG']) && !empty($_GET['course'])) {

        function getParameter($par, $default = null){
            if (isset($_GET[$par]) && strlen($_GET[$par])) return $_GET[$par];
            elseif (isset($_POST[$par]) && strlen($_POST[$par])) return $_POST[$par];
            else return $default;
        }
        $lat = getParameter("latitude");
        $lon = getParameter("longitude");
        $time = getParameter("time");
        $sat = getParameter("satellites");
        $speed = getParameter("speedOTG");
        $course = getParameter("course");

        $sql = "INSERT INTO vehicle (latitude,longitude,time,satellites,speedOTG,course) VALUES ('".$lat."', '".$lon."', '".$time."', '".$sat."', '".$speed."', '".$course."' )";
        mysqli_query($conn, $sql);//It works

    }
    mysqli_close($conn);
?>
<!DOCTYPE html >
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title>Vehicle Project</title>
    <center>
          <h1>SIM908 GPRS+GP module</h1>
    </center>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        width:100%;
        margin: 0;
        padding: 0;
      }
      table{
          font-family: arial,sans-serif;
          border-collapse: collapse;
          width:100%;
      }
      tb,th,td{
          border:1px solid #dddddd;
          text-align: center;
          padding: 8px;
      }
    </style>

<html>
  <body>
    <table>
        <tr>
            <th>Latitude</th>
            <th>Longitude</th>
            <th>Time</th>
            <th>Satellites</th>
            <th>Speed OTG</th>
            <th>Course</th>
        </tr>
        <tr>
            <td id="tlat">0</td>
            <td id="tlon">0</td>
            <td id="ttime">0</td>
            <td id="tsat">0</td>
            <td id="tspeed">0</td>
            <td id="tcourse">0</td>
        </tr>
    </table>
    <br></br>

    <div id="map"></div>

    <script>

        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
              center: new google.maps.LatLng(51.5069825,-0.1194221),
              zoom: 16
            });
            setInterval('initMap()',60000);
            var infoWindow = new google.maps.InfoWindow;

            downloadUrl('http://www.vehicleproject.epizy.com/createXML.php', function(data){
              var xml = data.responseXML;
              var vehicles = xml.documentElement.getElementsByTagName('vehicle');
              Array.prototype.forEach.call(vehicles, function(markElement){
                  var id = markElement.getAttribute('id');
                  var time = markElement.getAttribute('time');
                  var sOTG =  markElement.getAttribute('speedOTG');
                  var crse = markElement.getAttribute('course');
                  var sat = markElement.getAttribute('satellites');
                  var lat = markElement.getAttribute('latitude');
                  var lon =  markElement.getAttribute('longitude');

                  var latlong = new google.maps.LatLng(
                      parseFloat(markElement.getAttribute('latitude')),
                      parseFloat(markElement.getAttribute('longitude'))
                  );
                  var info = document.createElement('div');

                  var lalon = document.createElement('strong');
                  lalon.textContent = lat + ', ' + lon;
                  info.appendChild(lalon);
                  info.appendChild(document.createElement('br'));

                  var text = document.createElement('text');
                  text.textContent =time;
                  info.appendChild(text);

                  var marker = new google.maps.Marker({
                      map: map,
                      position: latlong
                  });

                  map.setCenter(new google.maps.LatLng(lat,lon));

                  marker.addListener('click',function(){
                      infoWindow.setContent(info);
                      infoWindow.open(map, marker);
                  });
                  document.getElementById("tlat").innerHTML = lat;
                  document.getElementById("tlon").innerHTML = lon;
                  document.getElementById("ttime").innerHTML = time;
                  document.getElementById("tsat").innerHTML = sat;
                  document.getElementById("tspeed").innerHTML = sOTG;
                  document.getElementById("tcourse").innerHTML = crse;

              });
          });
        }

      function downloadUrl(url, callback) {
        var request = window.ActiveXObject ?
            new ActiveXObject('Microsoft.XMLHTTP') :
            new XMLHttpRequest;

        request.onreadystatechange = function() {
          if (request.readyState == 4) {
            request.onreadystatechange = doNothing;
            callback(request, request.status);
          }
        };

        request.open('GET', url, true);
        request.send(null);
      }

      function doNothing() {}
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCwQhY3uTSAzRgDVdOFpoRsTK2UXVaIgoY&callback=initMap">
    </script>
  </head>
  </body>
</html>
