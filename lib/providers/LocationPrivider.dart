// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class LocationProvider extends ChangeNotifier{
//   LatLng myLocation;

// LocationProvider({required this.myLocation});


// void setMyLocation() async {
 
//     Location location = new Location();

//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationData = await location.getLocation();

//     print('location data ${_locationData.latitude}');

//     location.onLocationChanged.listen((LocationData currentLocation) {
      

//    myLocation =LatLng(currentLocation.latitude!,currentLocation.longitude!);

//       notifyListeners();
//     });
//   }

// }