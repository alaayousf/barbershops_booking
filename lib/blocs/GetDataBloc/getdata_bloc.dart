import 'dart:developer';

import 'package:barbershops_booking/blocs/GetDataBloc/getData_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barbershops_booking/repository/userRepository.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllDataBloc extends Bloc<GetDataEvent, GetDataState> {
  GetAllDataBloc() : super(GetALLInitial()) {
    on<GetDataEvent>((event, emit) async {
      // _mapAuthenticationLoggedInToState();
      if (event is GetALLBarbers) {
        log('bbbbbbbbbbbbbbbbbbbbbbb');

        QuerySnapshot<Map<String, dynamic>> users;
        List<QueryDocumentSnapshot<Map<String, dynamic>>> barbers;

        users =
            await FirebaseFirestore.instance.collection('Barber Shop').get();
        barbers = users.docs;
        emit(ResevALLBarbers(barbers));
         
      } else if (event is GetALLServeis) {
        log('ttttttttttttttttttttttttt');

        QuerySnapshot<Map<String, dynamic>> users;
        List<QueryDocumentSnapshot<Map<String, dynamic>>> datas;
        emit(LodingGertSevic());
        users = await FirebaseFirestore.instance.collection('Services').get();
        datas = users.docs;
        emit(ResevALLServis(datas));
      } else if (event is GetOneServeis) {
        QuerySnapshot<Map<String, dynamic>> users;
        // DocumentReference<Map<String, dynamic>> datas;
       // emit(LodingGertSevic());

        var datas = await FirebaseFirestore.instance
            .collection('Services')
            .doc(event.id)
            .get();

      //return  emit(ResevOneberberReservation(datas));
      }
    }); 
  }



}
