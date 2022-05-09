import 'dart:developer';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

class GetOneDataBluc extends Bloc<GetDataEvent, GetDataState> {
  late DateTime newTime;
  GetOneDataBluc() : super(GetALLInitial()) {


    on<GetDataEvent>((event, emit) async {
      if (event is GetOneServeis) {
        QuerySnapshot<Map<String, dynamic>> users;
        // DocumentReference<Map<String, dynamic>> datas;

        emit(Loding());

        newTime = event.time;
        var _now = event.time;

        DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
        DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);

        var datas = await FirebaseFirestore.instance
            .collection('ALLReservation')
            .where('day', isGreaterThanOrEqualTo: _start)
            .where('day', isLessThanOrEqualTo: _end)
            //datas.where('r', isGreaterThanOrEqualTo: 1);
            .where('IDberBer', isEqualTo: event.id);
        await datas.get().then((value) {
          try {
            emit(ResevOneberberReservation(value.docs));
          } catch (e) {
            emit(LodingGertSevic());
          }
        });

        // var datas = await FirebaseFirestore.instance
        //     .collection('ALLReservation')
        //     .where('IDberBer',isEqualTo:event.id)
        //     .where('time', isGreaterThanOrEqualTo: _start)
        //     .where('time', isLessThanOrEqualTo: _end)
        //     .get()
        //     .then((value) {
        //       log("wwwwwwww $value");

        //   try {
        //     emit(ResevOneberberReservation(value.docs));
        //   } catch (e) {
        //     emit(LodingGertSevic());
        //   }
        // });

      } else if (event is AddNewReservation) {
        emit(Loding());
        var datas =
            await FirebaseFirestore.instance.collection('ALLReservation');

        await datas.where('IDPerson', isEqualTo: event.iDPerson).get().then((value) {
          log('if found ${value.docs.length}');

          if (value.docs.isEmpty) {
            return datas
                .add({
                  'IDPerson': event.iDPerson,
                  'IDberBer': event.iDberBer,
                  'day': event.day,
                  'r': 10
                })
                .then((value) {
              emit(Success());
            })
                .catchError(
                    (error){
                      emit(Filde());
                    });
          } else {
            log("يوجدحجز مسبق");
            emit(Filde());

          }
        });


        //Get my resrvation
      }else if (event is GetMyReservation){


        var datas =
        await FirebaseFirestore.instance.collection('ALLReservation');

        await datas.where('IDPerson', isEqualTo: event.iDPerson).get().then((value) {
          log('if found ${value.docs.length}');

          if (value.docs.isNotEmpty) {
            log(value.docs.first.get('IDPerson'));
            emit(GetMyReservationState(value.docs.first));
          }else{
            log("يوجدحجز مسبق");
            emit(NOGetMyReservationState());
          }



        });






            //delete my resrvation
          }else if(event is DeleteMyReservation){

        log(" event DeleteMyReservation");
        var datas =
        await FirebaseFirestore.instance.collection('ALLReservation');

        await datas.doc(event.iDPerson)
          .delete()
          .then((value){
            log('after then');

          emit((DeleteState()));

          })
          .catchError((error) => print("Failed to delete user: $error"));





        //get berber search
          }else if(event is SarchEvetn){

        log('this is SarchEvetn evnet');


        emit(LodingSaech());

        QuerySnapshot<Map<String, dynamic>> users;
        List<QueryDocumentSnapshot<Map<String, dynamic>>> barbers;


        log(event.sarshKey);



        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) async{

         log("ssrrerererererer ${position.latitude}");
         log('ssrrerererererer ${position.longitude}');

         await FirebaseFirestore.instance.collection('Barber Shop')
             .where("shopName", isGreaterThanOrEqualTo: event.sarshKey).get().then((value){

           log('after then');


           barbers = value.docs;
           emit(SearchState(barbers,LatLng(position.latitude,position.longitude)));
         });


        });









          }


    });
  }
}
