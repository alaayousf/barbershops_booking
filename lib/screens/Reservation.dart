import 'dart:developer';
import 'package:barbershops_booking/blocs/GetDataBloc/Getonedatabloc.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:barbershops_booking/screens/myRservation.dart';

//import 'package:barbershops_booking/providers/ListTimeProvider.dart';
import 'package:barbershops_booking/screens/profile.dart';
import 'package:barbershops_booking/screens/second_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import '../utils/color.dart';
import '../widget/card_widget_1.dart';
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
      backgroundColor: ColorConst.containerColor,
      appBar: AppBar(
        backgroundColor: ColorConst.containerColor,
        elevation: 0,
        title: const Text('Order'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyRservation()),
                  );
                },
                icon: Icon(
                  Icons.account_circle,
                  size: 48,
                  color: ColorConst.imageColor,
                )),
          ),
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Search()),
          //       );
          //     },
          //     icon: Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your order ',
              style: TextStyle(
                fontSize: 24,
                color: ColorConst.white,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: CachedNetworkImage(
                                  imageUrl: widget.servic.get('ServicesImage'),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.servic.get('ServicesName'),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConst.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            widget.servic.get('descService'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: ColorConst.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Profile(widget.barbers)),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondProfile(widget.barbers)),
                        );
                      },
                      child: CardWidgets(
                        isViewRating: true,
                        isSearch: false,
                        barbers: widget.barbers,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => Profile(widget.barbers)),
            //     );
            //   },
            //   child: Container(
            //       color: const Color.fromARGB(255, 166, 0, 255),
            //       padding:const EdgeInsets.all(15),
            //       child: Text("${widget.barbers.get('shopName')}")),
            // ),
            const SizedBox(height: 12),
            // Container(
            //     color: const Color.fromARGB(255, 77, 255, 0),
            //     padding: const EdgeInsets.all(15),
            //     child: Text("${widget.servic.get('ServicesImage')}")),
            Container(
              height: 100,
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
            const SizedBox(
              height: 20,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              crossAxisCount: 4),
                      itemBuilder: (_, index) {
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: selectedindex != index
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Colors.green,
                              ),
                              // margin: EdgeInsets.all(5),

                              child: timeintLit.contains(index)
                                  ? Center(
                                      child: Text(
                                        'Booking $index',
                                        style: const TextStyle(
                                            backgroundColor: Colors.amber),
                                      ),
                                    )
                                  : Center(
                                      child:
                                          Text('${index}:00 ${index + 1}:00'))),
                        );
                      },
                      itemCount: 23,
                    ),
                  ),
                );
              } else if (state is Loding) {
                return Text("Loding");
              } else if (state is Success) {
                return Text("Success");
              } else if (state is Filde) {
                return Text(
                    "يوجد حجز مسبق لايمكن حجز اكتر من مرة في نفس الوقت ");
              } else {
                return Text("retry");
              }
            }),
            Center(
              child: MaterialButton(
                color: ColorConst.imageColor,
                minWidth: 159,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(27),
                        topLeft: Radius.circular(27),
                      ),
                    ),
                    builder: (context) => SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConst.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.barbers.get('logo'),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, _, i) =>
                                          Container(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    widget.barbers.get('shopName'),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConst.imageColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  'Do you want to book a time in the \nbarbershop from 9:00-10:00pm\n Please stick to my appointment time',
                                  style: TextStyle(
                                    fontFamily: 'SFProText-Regular',
                                    fontSize: 15,
                                    // color: const Color(0xff113260),
                                    color: Colors.blueGrey,
                                    letterSpacing: -0.6428571624755859,
                                    height: 1.0555555555555556,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Add a Note',
                                  style: TextStyle(
                                    fontFamily: 'SFProText-Regular',
                                    fontSize: 14,
                                    color: Color(0xff6d89af),
                                    letterSpacing: -0.5000000152587891,
                                    height: 1.3571428571428572,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Write here…',
                                    // hintStyle: TextStyle,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: ColorConst.imageColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Color(0xffD8E1EC)),
                                    ),
                                  ),
                                  // controller: noteController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      color: ColorConst.imageColor,
                                      minWidth: 159,
                                      height: 50,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        if (selectedindex != -1) {
                                          var ind = selectedindex;
                                          var idBerber = widget.barbers.id;
                                          var Iduser = auth.currentUser!.uid;

                                          var day = context
                                              .read<GetOneDataBluc>()
                                              .newTime
                                              .day;
                                          var month = context
                                              .read<GetOneDataBluc>()
                                              .newTime
                                              .month;
                                          var year = context
                                              .read<GetOneDataBluc>()
                                              .newTime
                                              .year;

                                          log('day/t $day $idBerber $Iduser $ind ');
                                          DateTime(
                                              DateTime.now().year, day, ind);
                                          var createday = DateTime(
                                              year, month, day, ind, 0);
                                          //log('create time $createday');

                                          //log('day time $time');
                                          log(' hoer $createday');

                                          bloc!.add(AddNewReservation(
                                              Iduser, idBerber, createday));
                                        }

                                        Navigator.pop(context, 'OK');
                                      },
                                      child: Text(
                                        'Booking Now',
                                        style: TextStyle(
                                          color: ColorConst.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      color: ColorConst.containerColor,
                                      minWidth: 159,
                                      height: 50,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: ColorConst.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Booking',
                  style: TextStyle(
                    color: ColorConst.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: ElevatedButton(
            //       onPressed: () {
            //         showDialog<String>(
            //           context: context,
            //           builder: (BuildContext context) => AlertDialog(
            //             title: const Text('AlertDialog Title'),
            //             content: const Text('AlertDialog description'),
            //             actions: <Widget>[
            //               TextButton(
            //                 onPressed: () => Navigator.pop(context, 'Cancel'),
            //                 child: const Text('Cancel'),
            //               ),
            //               TextButton(
            //                 onPressed: () {
            //                   if (selectedindex != -1) {
            //                     var ind = selectedindex;
            //                     var idBerber = widget.barbers.id;
            //                     var Iduser = auth.currentUser!.uid;
            //
            //                     var day =
            //                         context.read<GetOneDataBluc>().newTime.day;
            //                     var month =
            //                         context.read<GetOneDataBluc>().newTime.month;
            //                     var year =
            //                         context.read<GetOneDataBluc>().newTime.year;
            //
            //                     log('day/t $day $idBerber $Iduser $ind ');
            //                     DateTime(DateTime.now().year, day, ind);
            //                     var createday =
            //                         DateTime(year, month, day, ind, 0);
            //                     //log('create time $createday');
            //
            //                     //log('day time $time');
            //                     log(' hoer $createday');
            //
            //                     bloc!.add(AddNewReservation(
            //                         Iduser, idBerber, createday));
            //                   }
            //
            //                   Navigator.pop(context, 'OK');
            //                 },
            //                 child: const Text('OK'),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //       child: Text("Booking")),
            // ),
            const SizedBox(
              height: 30,
            ),

            // BlocConsumer<GetOneDataBluc, GetDataState>(
            //     listener: (context, state) {
            //       if(state is Loding){
            //         log('Loding');
            //       }else{
            //         log('Success');
            //
            //
            //
            //         setState(() {
            //
            //         });
            //       }
            //     },
            //     builder: (context, state) {
            //
            //       if(state is Loding){
            //         return Container(
            //           width: 10,
            //           height: 10,
            //           color: Colors.red,
            //         );
            //       }else{
            //
            //         return Container(
            //           width: 10,
            //           height: 10,
            //           color: Colors.teal,
            //         );
            //       }
            //
            //     }
            // )
          ],
        ),
      ),
    );
  }

  void bottomSheet() {}
}
