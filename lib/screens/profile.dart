import 'dart:developer';
import 'dart:io';

import 'package:barbershops_booking/screens/maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {

   QueryDocumentSnapshot<Map<String, dynamic>> salonedata;
   Profile(this.salonedata);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Profile")),
      body:  SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('${widget.salonedata.get('logo')}'),
            Text('${widget.salonedata.get('shopName')}'),
            ElevatedButton(
          
          
              //Location handeling 
              onPressed: (){




                var geoporint=widget.salonedata.get('logation') as GeoPoint;
                
          
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Maps(geoporint)),
                );

            }, child: Icon(Icons.location_on_rounded,color: Color.fromARGB(255, 255, 255, 255),))
          ],
        ),
      ),
    );
  }
}