import 'dart:developer';
import 'package:barbershops_booking/blocs/GetDataBloc/Getonedatabloc.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
//import 'package:barbershops_booking/providers/ListTimeProvider.dart';
import 'package:barbershops_booking/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
//import 'package:provider/provider.dart';

class Reservation extends StatefulWidget {
  QueryDocumentSnapshot<Map<String, dynamic>> servic;
  QueryDocumentSnapshot<Map<String, dynamic>> barbers;

  Reservation({required this.barbers, required this.servic});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  GetOneDataBluc? bloc;
  List numTime = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7];
  List<int> timeintLit = [];
  int selectedindex = -1;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    DateTime now = DateTime.now();

    bloc!.add(GetOneServeis('${widget.barbers.id}', now));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var info = Provider.of<ListTimeProvider>(context, listen: true);

    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Barber Shop')
        .doc(widget.barbers.id)
        .collection('Reservation')
        .where('day',
            isGreaterThanOrEqualTo:
                DateTime(_start.year, _start.month, _start.day, 0, 0))
        .where('day',
            isLessThanOrEqualTo:
                DateTime(_end.year, _end.month, _end.day, 23, 59, 59))
        .snapshots();

    return Scaffold(
      appBar: AppBar(title:const Text("your Order")),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(widget.barbers)),
                );
              },
              child: Container(
                  color: const Color.fromARGB(255, 166, 0, 255),
                  padding:const EdgeInsets.all(15),
                  child: Text("${widget.barbers.get('shopName')}")),
            ),
            const SizedBox(height: 12),
            Container(
                color: const Color.fromARGB(255, 77, 255, 0),
                padding:const EdgeInsets.all(15),
                child: Text("${widget.servic.get('ServicesImage')}")),
            Container(
              height: 150,
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.amber,
                selectedTextColor: Colors.white,
                daysCount: 7,
                onDateChange: (date) {
                  timeintLit = [];
                  selectedindex = -1;

                  bloc!.add(GetOneServeis('${widget.barbers.id}', date));

                  log("${date}");
                },
              ),
            ),
            BlocBuilder<GetOneDataBluc, GetDataState>(
                builder: (context, state) {
              if (state is ResevOneberberReservation) {
                var w = state.datas.length;
                var c = state.datas;

                for (var item in c) {
                  timeintLit.add((item.get('day') as Timestamp).toDate().hour);
                }

                //.get('time') as Timestamp;

                // List<Map<String, dynamic>> pointlist =
                //     List.from(state.datas.get('resinfo'));
                // log("${pointlist[0].runtimeType}");
                //return Text('${pointlist[0].values.last}');

                return Expanded(
                  child: Container(
                    color: Colors.red,
                    width: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 23,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (timeintLit.contains(index)) {
                              } else {
                                setState(() {
                                  selectedindex = index;
                                });
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.all(5),
                                width: 30,
                                height: 30,
                                color: selectedindex != index
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Colors.green,
                                child: timeintLit.contains(index)
                                    ? Text(
                                        'Boking $index',
                                        style: const TextStyle(
                                            backgroundColor: Colors.amber),
                                      )
                                    : Text('${index}:00 ${index + 1}:00')),
                          );
                        }),
                  ),
                );
              } else {
                return Text("Loding");
              }
            }),
            ElevatedButton(
                onPressed: () {
                  if (selectedindex != -1) {
                    var ind = selectedindex;
                    var idBerber = widget.barbers.id;
                    var Iduser = auth.currentUser!.uid;

                    var day = context.read<GetOneDataBluc>().newTime.day;
                    var month = context.read<GetOneDataBluc>().newTime.month;
                    var year = context.read<GetOneDataBluc>().newTime.year;

                    log('day/t $day $idBerber $Iduser $ind ');
                    DateTime(DateTime.now().year, day, ind);
                    var createday = DateTime(year, month, day, ind, 0);
                    //log('create time $createday');

                    //log('day time $time');
                    log(' hoer $createday');

                    bloc!.add(AddNewReservation(Iduser, idBerber, createday));
                  }
                },
                child: Text("Booking"))
          ],
        ),
      ),
    );
  }
}
