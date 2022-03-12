import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Barbers extends StatefulWidget {
  @override
  State<Barbers> createState() => _BarbersState();
}

class _BarbersState extends State<Barbers> {
  final CollectionReference<Map<String, dynamic>> _usersStream =
      FirebaseFirestore.instance.collection('Barber Shop');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          scrollDirection: Axis.vertical,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            var c = _usersStream
                .doc(document.id)
                .collection('Ratings')
                .doc('LCPDxGtPsnzhaK83gLu4')
                .get()
                .then((DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                log('${(documentSnapshot.data() as Map<String, dynamic>)['rater'] }');
              }
            });

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
                      image: CachedNetworkImageProvider(data['logo']),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(data['shopName']),
               
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
