// export 'screens/welcom.dart';
// import 'screens/welcom.dart';
import 'dart:developer';
import 'package:barbershops_booking/blocs/auth_Event.dart';
import 'package:barbershops_booking/blocs/auth_State.dart';
import 'package:barbershops_booking/blocs/auth_bloc.dart';
import 'package:barbershops_booking/providers/selctedProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Service extends StatefulWidget {
  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  AuthenticationBloc? bloc; 
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc!.add(GetALLServeis());
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<SelctedProvider>(context, listen: true);



  return  BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
   if(state is ResevALLServis){
 
      
     return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.datas.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                info.setArray(index,state.datas[index]);
              },
              child: Container(
                padding: info.indexs == index? EdgeInsets.all(8.0) :EdgeInsets.all(0),
               
                color: Colors.amber,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        width: 150,
                        height: 150,
                        image: CachedNetworkImageProvider(
                            '${state.datas[index].get('ServicesImage')}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    info.indexs == index
                        ? Text('${state.datas[index].get('ServicesName')}')
                        : const Text("data"),
                  ],
                ),
              ));
        });
      }else{
    return Text("Loding");
      }   

       
    });





  }
}
