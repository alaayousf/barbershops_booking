


import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Services').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          scrollDirection:Axis.horizontal,

  
          

          children: snapshot.data!.docs.map((DocumentSnapshot document) {

           
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                    child: Image(
                      width: 150,
                      height: 150,
                      image: CachedNetworkImageProvider(data['ServicesImage']),
                      fit: BoxFit.fill,
                     
                    ),
                  ),
                  Text(data['ServicesName']),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

