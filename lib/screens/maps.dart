import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


enum PermissionGroup {

  locationAlways,


  locationWhenInUse
}
 
class Maps extends StatefulWidget {
  GeoPoint geoPoint;
  Maps(this.geoPoint);

  @override
  State<Maps> createState() => MapsState();
}

class MapsState extends State<Maps> {



   Set<Marker> markers = {};
   late Completer<GoogleMapController> _controller;

  @override
  void initState() {
 
    _controller = Completer();
    Marker quds_marke = Marker(
        markerId: const MarkerId('1'),
        position: LatLng(widget.geoPoint.latitude, widget.geoPoint.longitude),
        icon: BitmapDescriptor.defaultMarker);
    markers.add(quds_marke);
     
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.geoPoint.latitude, widget.geoPoint.longitude),
          zoom: 10.4746,
        ),

        onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
        markers: markers,
      ),



      floatingActionButton: FloatingActionButton(
      child:const Icon(Icons.local_activity),
        onPressed: () async{


          //  هاد الكو\ لي طلب ال Pirmition 
         Map<Permission, PermissionStatus> statuses = await [
          Permission.locationAlways,
          Permission.locationWhenInUse,
        ].request();




           await getLocation();

          
          // await _determinePosition().then((value) {
          //    log('location value $value');

          //  });
        },
        backgroundColor: Color.fromARGB(255, 0, 140, 255),
        
      ),
    );
  }



  getLocation() async {
    _determinePosition();
   log('tttttttttttrrrrrrrrr');
   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   log("ssrrerererererer ${position.latitude}");
   log('ssrrerererererer ${position.longitude}');


    Marker myMark = Marker(
        markerId: const MarkerId('my'),
        position:  LatLng(position.latitude,position.longitude),
        icon: BitmapDescriptor.defaultMarker);
    setState(() {
      markers.add(myMark);

    });



    CameraPosition _kLake = CameraPosition(
        //bearing: 192.8334901395799,
        target: LatLng(position.latitude,position.longitude),
        tilt: 59.440717697143555,
        zoom: 14);


    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));





    
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 





  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

 
}

