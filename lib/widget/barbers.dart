import 'dart:developer';
import 'dart:ffi';

import 'package:barbershops_booking/blocs/GetDataBloc/getData_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_State.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_bloc.dart';
import 'package:barbershops_booking/providers/selctedProvider.dart';
import 'package:barbershops_booking/screens/Reservation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Barbers extends StatefulWidget {
  @override
  State<Barbers> createState() => _BarbersState();
}

class _BarbersState extends State<Barbers> {
  final CollectionReference<Map<String, dynamic>> _usersStream =
      FirebaseFirestore.instance.collection('Barber Shop');


GetAllDataBloc? bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc!.add(GetALLBarbers());
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    var info = Provider.of<SelctedProvider>(context, listen: true);
     
  return  BlocBuilder<GetAllDataBloc, GetDataState>(
        builder: (context, state) {
          
   if(state is ResevALLBarbers){

     return ListView.builder(
          scrollDirection: Axis.horizontal,
        itemCount: state.barbers.length,
        itemBuilder: (BuildContext context, int index) {

           List<dynamic> arrayvalue = state.barbers[index].get('rater') as List<dynamic>;
    //         log('ddddd ${arrayvalue.length}');

    

  
            return GestureDetector(
              onTap: () {
                if(info.indexs!=-1){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reservation(barbers:state.barbers[index], servic:info.servic!)),
                );


                }
                
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
    return Text("Loding");
      }   

       
    });

  }

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




 
