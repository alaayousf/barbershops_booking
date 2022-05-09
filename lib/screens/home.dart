import 'dart:developer';

import 'package:barbershops_booking/export.dart';
import 'package:barbershops_booking/providers/ListTimeProvider.dart';
import 'package:barbershops_booking/providers/selctedProvider.dart';
import 'package:barbershops_booking/screens/myRservation.dart';
import 'package:barbershops_booking/screens/search.dart';
import 'package:barbershops_booking/widget/barbers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:barbershops_booking/widget/service.dart';
import 'package:provider/provider.dart';

import '../utils/color.dart';

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
      backgroundColor: ColorConst.containerColor,
      appBar: AppBar(
        backgroundColor: ColorConst.containerColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
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
      body: SafeArea(
        //design Home

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (BuildContext context) => SelctedProvider(-1)),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      enabled: false,
                      // controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorConst.imageColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorConst.imageColor),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorConst.imageColor),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConst.imageColor,
                        ),
                        hintText: 'Search here',
                        hintStyle: TextStyle(
                          color: ColorConst.imageColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Services',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 24,
                    color: ColorConst.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(width: double.infinity, height: 150, child: Service()),
                // SizedBox(
                //   height: 100,
                //   child: ListView.builder(
                //     primary: false,
                //     physics: const BouncingScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: 3,
                //     // images.length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         // height: 160,
                //         width: 80,
                //         child: Column(
                //           children: [
                //             CircleAvatar(
                //               maxRadius: 30,
                //               backgroundColor: ColorConst.circleColor,
                //               child: CachedNetworkImage(
                //                 imageUrl:
                //                     'https://cdn-icons-png.flaticon.com/512/2821/2821023.png',
                //                 width: 30,
                //                 height: 30,
                //                 // color: Colors.black,
                //               ),
                //             ),
                //             Text(
                //               'Hair Cut',
                //               style: TextStyle(
                //                 fontFamily: 'Segoe UI',
                //                 fontSize: 15,
                //                 color: ColorConst.white,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // const SizedBox(
                //    height: 20,
                //  ),
                Text(
                  'Available Barbers',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 24,
                    color: ColorConst.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Barbers(),
                ),
                // ListView.separated(
                //   itemCount: 5,
                //   shrinkWrap: true,
                //   physics: const BouncingScrollPhysics(),
                //   separatorBuilder: (context, i) => SizedBox(height: 10),
                //   itemBuilder: (context, index) {
                //     return Container(
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           color: ColorConst.white,
                //           borderRadius: BorderRadius.circular(15)),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           children: [
                //             CachedNetworkImage(
                //               height: 40,
                //               width: 40,
                //               imageUrl:
                //                   'https://cdn-icons.flaticon.com/png/512/1144/premium/1144709.png?token=exp=1646554117~hmac=cd6ad6b8f0863f4c6f834765f9e82e6d',
                //               errorWidget: (context, _, i) => Container(),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   'Bryan',
                //                   style: TextStyle(
                //                     color: ColorConst.imageColor,
                //                     fontSize: 17,
                //                     fontWeight: FontWeight.w600,
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 Text(
                //                   'euismod tcncidunt ut laoreet\ndolore magn ',
                //                   style: TextStyle(
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             const Spacer(),
                //             Column(
                //               children: [
                //                 Row(
                //                   children: [
                //                     const Icon(
                //                       Icons.star,
                //                       color: Colors.amber,
                //                       size: 25,
                //                     ),
                //                     Text(
                //                       '4.5',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.w600,
                //                         color: ColorConst.containerColor,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 Text(
                //                   '140 view',
                //                   style: TextStyle(
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w400,
                //                     color: ColorConst.imageColor,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),

        // child: MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(
        //         create: (BuildContext context) => SelctedProvider(-1)),
        //   ],
        //   child: Column(
        //     mainAxisAlignment:MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //
        //      const Text('Service'),
        //       SizedBox(width: double.infinity, height: 200, child: Service()),
        //       const Text('salone'),
        //       Expanded(child: Barbers())
        //     ],
        //   ),
        // ),
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
