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
      backgroundColor: Colors.teal,
      appBar: AppBar(title: const Text("Profile")),
      body: SafeArea(



          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('${widget.salonedata.get('logo')}',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width),

              Text('${widget.salonedata.get('shopName')}'),

              //go to Location
              ElevatedButton(

                  //Location handeling
                  onPressed: () {



                    var geoporint = widget.salonedata.get('logation') as GeoPoint;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Maps(geoporint)),
                    );
                  },
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),


              //delete image From array in Firestore

              ElevatedButton(onPressed: () async{

                log(widget.salonedata.id);
                List<dynamic> pods= widget.salonedata.get('post');
                List<dynamic> remoedArra=[];
                remoedArra.add(pods[0]);
                var clientCollection = FirebaseFirestore.instance.collection("Barber Shop");
                 await clientCollection.doc(widget.salonedata.id).update({
                  "post" : FieldValue.arrayRemove(remoedArra),
                }).then((_) {
                  print("success!");
                });
              }, child: Text('deleet item')),
              //end code delete




              //List image Salone
              Flexible(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.salonedata.get('post').length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child:Image.network(widget.salonedata.get('post')[index]),
                      );
                    }
                ),

              )






            ],
          ),
        ),

    );
  }
}


