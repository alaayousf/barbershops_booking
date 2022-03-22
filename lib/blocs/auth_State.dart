import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}



class AuthenticationSuccess extends AuthenticationState {
  final UserCredential? firebaseUser;

  AuthenticationSuccess(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser!];
}

class AuthenticationCreateSuccess extends AuthenticationState {
  final UserCredential? firebaseUser;

  AuthenticationCreateSuccess(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser!];
}



class AuthenticationSingUpevent extends AuthenticationState {}



class ResevALLServis extends AuthenticationState {

  final  List<QueryDocumentSnapshot<Map<String, dynamic>>> datas;

  ResevALLServis(this.datas);
}

class LodingGertSevic extends AuthenticationState {}



