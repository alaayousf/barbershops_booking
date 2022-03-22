import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationSingUpEvent extends AuthenticationEvent {
    String email;
    String passwrde;
    String name;
    String phoneNumperl;
    bool gender;

  AuthenticationSingUpEvent(this.email,this.passwrde,this.phoneNumperl,this.name,this.gender);
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  String email;
  String passworde;
  AuthenticationLoginEvent(this.email,this.passworde);

  
}


class GetALLServeis extends AuthenticationEvent {}
