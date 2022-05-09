import 'dart:developer';
import 'dart:ffi';

import 'package:barbershops_booking/blocs/GetDataBloc/Getonedatabloc.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_bloc.dart';
import 'package:barbershops_booking/screens/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:geolocator/geolocator.dart';

class berSearch extends StatefulWidget {
  @override
  State<berSearch> createState() => _berSearchState();
}

class _berSearchState extends State<berSearch> {
  final CollectionReference<Map<String, dynamic>> _usersStream =
  FirebaseFirestore.instance.collection('Barber Shop');


  GetAllDataBloc? bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    _determinePosition();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {






    return  BlocBuilder<GetOneDataBluc, GetDataState>(
        builder: (context, state) {



          if(state is SearchState){

         state.barbers.removeWhere((element) {
          var val= element.get('logation') as GeoPoint;

          log('berbser position${val.latitude}');
          log('my position ${state.position.latitude}');


           if(calculateDistance(val.latitude,val.longitude,state.position.latitude,state.position.longitude)<1000){
             return false;

           }else{
             return true;

           }
         });


            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.barbers.length,
                itemBuilder: (BuildContext context, int index) {

                  List<dynamic> arrayvalue = state.barbers[index].get('rater') as List<dynamic>;


                  return GestureDetector(
                    onTap: () {


                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile( state.barbers[index]),
                      )
                      );




                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              width: 150,
                              height: 150,
                              image: CachedNetworkImageProvider(state.barbers[index].get('logo')),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(state.barbers[index].get('shopName')),


                          Text(
                              'Stars \t ${(state.barbers[index].get('ratings')as num) / arrayvalue.length}'),
                        ],
                      ),
                    ),
                  );
                });

          }else{
            return Text("قم بي ادخال النص لي البحت علي الصالون بستخدام اسم الصالوم "
                "ويمكنك ايضن تقييد منقت البحت الجغرافية");
          }


        });

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


//calculate distans between to gioPoint
double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p)/2 +
      c(lat1 * p) * c(lat2 * p) *
          (1 - c((lon2 - lon1) * p))/2;
  return 12742 * asin(sqrt(a));
}


getMyLocation(){

}













//  StreamBuilder<QuerySnapshot>(
//   stream: _usersStream.snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.hasError) {
//       return Text('Something went wrong');
//     }

//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Text("Loading");
//     }

//     return ListView(
//       scrollDirection: Axis.vertical,
//       children: snapshot.data!.docs.map((DocumentSnapshot document) {



//         // var c = _usersStream
//         //     .doc(document.id)
//         //     .collection('Ratings')
//         //     .doc('LCPDxGtPsnzhaK83gLu4')
//         //     .get()
//         //     .then((DocumentSnapshot documentSnapshot) {
//         //   if (documentSnapshot.exists) {
//         //     log('${(documentSnapshot.data() as Map<String, dynamic>)['rater'] }');
//         //   }
//         // });


//         Map<String, dynamic> data =
//             document.data()! as Map<String, dynamic>;

//         List<dynamic> arrayvalue = data['rater'] as List<dynamic>;
//         log('ddddd ${arrayvalue.length}');

//         return GestureDetector(
//           onTap: () {
//             if(info.indexs!=-1){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Reservation()),
//             );
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image(
//                     width: 150,
//                     height: 150,
//                     image: CachedNetworkImageProvider(data['logo']),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 Text(data['shopName']),
//                 Text(
//                     'Stars \t ${(data['ratings'] as num) / arrayvalue.length}'),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   },
// );




 
