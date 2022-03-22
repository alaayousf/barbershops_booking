import 'package:barbershops_booking/blocs/GetDataBloc/Getonedatabloc.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_bloc.dart';
import 'package:barbershops_booking/providers/listTimeProvider.dart';
import 'package:barbershops_booking/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'export.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/signUp.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
 import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart';
import 'repository/userRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

 



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  FirebaseAuth auth = FirebaseAuth.instance;
 



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [

            BlocProvider(
          create: (context) => AuthenticationBloc(userRepository:UserRepository(firebaseAuth:auth))),
       
       
            BlocProvider(
          create: (context) => GetAllDataBloc()),

          BlocProvider(
          create: (context) => GetOneDataBluc()),

          
       
        ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:auth.currentUser==null?SignUp():const Home()
      ),
    );
  }
} 

 
/*
 AuthenticationBloc(userRepository:UserRepository(firebaseAuth:auth ),
*/





 



