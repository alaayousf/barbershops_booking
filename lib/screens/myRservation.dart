import 'dart:developer';
import 'package:barbershops_booking/blocs/GetDataBloc/Getonedatabloc.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MyRservation extends StatefulWidget {
  @override
  State<MyRservation> createState() => _MyRservationState();
}

class _MyRservationState extends State<MyRservation> {

  GetOneDataBluc? bloc;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc!.add(GetMyReservation(auth.currentUser!.uid));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children:[
            const Text("My Rservation"),


    BlocBuilder<GetOneDataBluc, GetDataState>(
    builder: (context, state)  {

      // if(state is DeleteState){
      //   setState(() {
      //
      //   });
      // }

      if(state is GetMyReservationState){
        return Container(
          margin:const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          color: Colors.teal,
            padding:const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('${state.myReservationState.get('IDPerson')}'),
                    Text('${ (state.myReservationState.get('day')as Timestamp).toDate()}'),
                  ],
                ),
                IconButton(onPressed: (){

                  log('befor send event to delete${state.myReservationState.id}');


                  bloc!.add(DeleteMyReservation(state.myReservationState.id));


                }, icon:const Icon(Icons.delete,color: Colors.red,))


              ],
            ));
      }else{
        return Text('لا يوجد حجز مسبق');

      }



    })

          ],
        ),
      ),
    );
  }
}
