import 'dart:developer';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

class GetOneDataBluc extends Bloc<GetDataEvent, GetDataState> {
  late DateTime newTime;
  GetOneDataBluc() : super(GetALLInitial()) {


    on<GetDataEvent>((event, emit) async {
      if (event is GetOneServeis) {
        QuerySnapshot<Map<String, dynamic>> users;
        // DocumentReference<Map<String, dynamic>> datas;

        emit(LodingGertSevic());

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
        var datas =
            await FirebaseFirestore.instance.collection('ALLReservation');

        datas.where('IDPerson', isEqualTo: event.iDPerson).get().then((value) {
          log('if found ${value.docs.length}');

          if (value.docs.isEmpty) {
            return datas
                .add({
                  'IDPerson': event.iDPerson,
                  'IDberBer': event.iDberBer,
                  'day': event.day,
                  'r': 10
                })
                .then((value) => log("add succsess ALLReservation"))
                .catchError(
                    (error) => print("Failed to add ALLReservation: $error"));
          } else {
            log("يوجدحجز مسبق");
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



          }


    });
  }
}
