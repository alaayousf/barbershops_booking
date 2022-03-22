import 'dart:developer';

import 'package:barbershops_booking/export.dart';
import 'package:barbershops_booking/providers/ListTimeProvider.dart';
import 'package:barbershops_booking/providers/selctedProvider.dart';
import 'package:barbershops_booking/widget/barbers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:barbershops_booking/widget/service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  
            MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (BuildContext context) => SelctedProvider(-1)),
      
              ],
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity, height: 200, child: Service()),
               Expanded(child: Barbers())
                ],
              ),
            ),
           
          
      ),
    );
  }
}



















/*

Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signOut()
                          .then((value) {

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>LogI()),
                            );

                          });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        log('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        log('Wrong password provided for that user.');
                      }
                    }
                  },
                  child: Text("Log out")),
              Center(child: Text('${auth.currentUser!.email}')),
            ],
          ),

 */



// class DemoApp extends StatefulWidget {
//   @override
//   _DemoAppState createState() => _DemoAppState();
// }

// class _DemoAppState extends State<DemoApp> {

//   List<int> data = [
//     10,9,8,7,6,5,4,3,2,1
//   ];

//   Widget _buildItemList(BuildContext context, int index){
//     if(index == data.length)
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     return Container(
//       width: 150,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             color: Colors.yellow,
//             width: 150,
//             height: 200,
//             child: Center(
//               child: Text('${data[index]}',style: TextStyle(fontSize: 50.0,color: Colors.black),),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Horizontal list',style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//                 child: ScrollSnapList(
//                     itemBuilder: _buildItemList,
//                     itemSize: 150,
//                   dynamicItemSize: true,
//                   onReachEnd: (){
//                       print('Done!');
//                   },
//                   itemCount: data.length,
//                 )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









