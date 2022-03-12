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