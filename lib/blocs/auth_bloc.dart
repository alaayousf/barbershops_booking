import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_Event.dart';
import 'auth_State.dart';
import 'package:barbershops_booking/repository/userRepository.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({UserRepository? userRepository})
      : _userRepository = userRepository!,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      // _mapAuthenticationLoggedInToState();

      if (event is AuthenticationSingUpEvent) {
        log("${(event as AuthenticationSingUpEvent).email}");

        try {
          
      var  currentUser = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email.toString().trim(),
                  password: event.passwrde.toString().trim());


                     if (currentUser.user!=null) {
                  addUser(name: event.name,phoneNumper: event.phoneNumperl,gender: event.gender);
                  return emit(AuthenticationCreateSuccess(currentUser));
                     }
               
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
          }
        }
      } else if (event is AuthenticationLoginEvent) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email.toString().trim(),
                  password: event.passworde.toString().trim());

          return emit(AuthenticationSuccess(userCredential));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
          }
        }

        
      }else if(event is GetALLServeis){
      
 QuerySnapshot<Map<String, dynamic>>  users;
 List<QueryDocumentSnapshot<Map<String, dynamic>>> datas;
    emit(LodingGertSevic());
    users=  await FirebaseFirestore.instance.collection('Services').get();
    datas=users.docs;
    return emit(ResevALLServis(datas));
        
      }
    });
  }





 
  Stream<AuthenticationState> eefrg() async* {

    Future<QuerySnapshot<Map<String, dynamic>>>  users;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> datas;

    users= FirebaseFirestore.instance.collection('Services').get();

    yield LodingGertSevic();

 
    
  }



  // @override
  // Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
  //   if (event is AuthenticationStarted) {
  //   //  yield* _mapAuthenticationStartedToState();
  //   } else if (event is AuthenticationLoggedIn) {
  //     _mapAuthenticationLoggedInToState();

  //   } else if (event is AuthenticationLoggedOut) {
  //   //  yield* _mapAuthenticationLoggedOutInToState();
  //   }

  //  }

  //AuthenticationLoggedOut
  // Stream<AuthenticationState> _mapAuthenticationLoggedOutInToState() async* {
  //   yield AuthenticationFailure();
  //   _userRepository.signOut();
  // }

  //AuthenticationLoggedIn
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await _userRepository
        .createUserWithEmailAndPassword("uuee51014@gmail.com", "2299722997"));
  }

  // AuthenticationStarted
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    // final isSignedIn = await _userRepository.isSignedIn();
    //   if (isSignedIn) {
    //     final firebaseUser = await _userRepository.getUser();
    //     yield AuthenticationSuccess(firebaseUser);
    //   } else {
    //     yield AuthenticationFailure();
    //   }
    // }
  }

  // Future<void> addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   return users
  //       .add({
  //         'full_name': fullName, // John Doe
  //         'company': company, // Stokes and Sons
  //         'age': age // 42
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }


 Future<void> addUser({String? name,String? phoneNumper,bool? gender}) {
      // Call the user's CollectionReference to add a new user
        CollectionReference users = FirebaseFirestore.instance.collection('users');

      return users
          .add({
            'name': name,
            'phoneNumper': phoneNumper,
            'gender': gender

          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
}
