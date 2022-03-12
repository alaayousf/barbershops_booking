import 'dart:developer';

import 'package:barbershops_booking/blocs/auth_Event.dart';
import 'package:barbershops_booking/blocs/auth_State.dart';
import 'package:barbershops_booking/repository/userRepository.dart';
import 'package:barbershops_booking/screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Login.dart';
import 'package:barbershops_booking/blocs/auth_bloc.dart';
import 'package:bloc/bloc.dart';

enum genratedGrube { male, female }

class SignUp extends StatefulWidget {
  @override
  _SignUpSeccrne createState() => _SignUpSeccrne();
}

class _SignUpSeccrne extends State<SignUp> {
  genratedGrube _valuegender = genratedGrube.male;

  FirebaseAuth auth = FirebaseAuth.instance;

  late String firstName;
  late String emaile;
  late String password;
  late String phoneNumper;

  setEmaile(var inputemaile) {
    this.emaile = inputemaile;
  }

  setFirstName(var inputemaile) {
    this.firstName = inputemaile;
  }

  setpassword(var inputpassword) {
    this.password = inputpassword;
  }

  setphoneNumper(var phoneNumper) {
    this.phoneNumper = phoneNumper;
  }

  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  valedationEmaile(value) {
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
  }

  valedFirstName(value) {
    if (value.toString() == "") return 'invalid name';
  }

  saveForstName(newvalue) {
    setFirstName(newvalue);
  }

  saveEmaile(newvalue) {
    setEmaile(newvalue);
  }

  savePassworde(newvalue) {
    setpassword(newvalue);
  }

  savephoneNumper(newvalue) {
    setphoneNumper(newvalue);
  }

  valedetphoneNumper(value) {
    if (value.toString().length != 10) return 'invalid phone numper';
  }

  valedationPassworde(value) {
    if (value.toString().length < 4) return 'invalid passworde';
  }

  valedationConfirmPassworde(value) {
    if (value != this.password) return 'Passwords do not match';
  }

  UserRepository? _userRepository;

  Widget snakpar() {
    return SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          children: <Widget>[
            Text(
              "Raised Button",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.favorite,
              color: Colors.red,
            )
          ],
        ));
  }

  GlobalKey<FormState> globalKey = GlobalKey();

  svaeFormeKey() {
    globalKey.currentState!.validate();
    globalKey.currentState!.save();
  }


  
 AuthenticationBloc? bloc;
   @override
  void initState() {
    bloc = BlocProvider.of(context);
    super.initState();
  }


  /* */

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      return Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: (LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF829593),
                    Color(0xFF6F8583),
                    Color(0xFF526C6A),
                    Color(0xFF3D5A58),
                  ],
                  stops: [
                    0.1,
                    0.4,
                    0.7,
                    0.9
                  ])),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Form(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    new Text(
                      "Create account",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontFamily: 'OpenSans'),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Full name",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontFamily: 'OpenSans',
                                    )),
                                SizedBox(height: 10.0),
                                TextFormField(
                                    validator: (value) =>
                                        valedFirstName(value!),
                                    onSaved: (newvalue) =>
                                        saveForstName(newvalue),
                                    //عدم اضهار النص
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        fillColor: Color(0xFF3D5A58),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white30),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            top: 20,
                                            right: 15,
                                            bottom: 20),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Enter your Full name")),
                              ]),
                          SizedBox(height: 30.0),
                          Text(
                            "Emaile",
                            style: TextStyle(
                              color: Colors.white54,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            validator: (value) => valedationEmaile(value!),
                            onSaved: (newvalue) => saveEmaile(newvalue),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xFF3D5A58),
                              filled: true,
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.white30),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, top: 20, right: 15, bottom: 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter your Emaile",
                            ),
                          )
                        ]),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[


                          
                          BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (BuildContext context, state) {
                          if (state is AuthenticationCreateSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        },
                        child: Center()),



                          Text("Password",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              )),
                          SizedBox(height: 10.0),
                          TextFormField(
                              validator: (value) => valedationPassworde(value!),
                              onSaved: (newvalue) => savePassworde(newvalue),
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  fillColor: Color(0xFF3D5A58),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)),
                                  hintStyle: TextStyle(
                                      fontSize: 14.0, color: Colors.white30),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 20, right: 15, bottom: 20),
                                  hintText: "Enter your password")),
                        ]),

                    SizedBox(
                      height: 30.0,
                    ),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Phone numper",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              )),
                          SizedBox(height: 10.0),
                          TextFormField(
                              validator: (value) => valedetphoneNumper(value!),
                              onSaved: (newvalue) => savephoneNumper(newvalue),
                              //عدم اضهار النص

                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  fillColor: Color(0xFF3D5A58),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)),
                                  hintStyle: TextStyle(
                                      fontSize: 14.0, color: Colors.white30),
                                  prefixIcon: Icon(
                                    Icons.phone_android_rounded,
                                    color: Colors.white,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 20, right: 15, bottom: 20),
                                  hintText: "Enter your Phone numper")),
                        ]),

                    SizedBox(
                      height: 30,
                    ),

                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gender",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              )),
                          Row(
                            children: [
                              Expanded(
                                  child: RadioListTile(
                                      activeColor: Color(0xFFFF6F3D),
                                      title: const Text(
                                        "male",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                      value: genratedGrube.male,
                                      groupValue: _valuegender,
                                      onChanged: (genratedGrube? val) {
                                        setState(() {
                                          _valuegender = val!;
                                        });
                                      })),
                              Expanded(
                                  child: RadioListTile(
                                      activeColor: Color(0xFFFF6F3D),
                                      selectedTileColor: Color(0xFFFF6F3D),
                                      title: const Text(
                                        "female",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                      value: genratedGrube.female,
                                      groupValue: _valuegender,
                                      onChanged: (genratedGrube? val) {
                                        setState(() {
                                          _valuegender = val!;
                                        });
                                      }))
                            ],
                          ),
                        ],
                      ),
                    ),

        

                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Row(children: [
                        // Checkbox(
                        //     value: _ischeck,
                        //     activeColor: Colors.white,
                        //     checkColor: Colors.blue,
                        //     onChanged: (newValue) {
                        //       onChanged(newValue!);
                        //     }),

                        // Text(
                        //   "rempur my",
                        //   textDirection: TextDirection.ltr,
                        //   style: TextStyle(
                        //     color: Colors.white54,
                        //     fontFamily: 'OpenSans',
                        //   ),
                        // )
                      ]),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: RaisedButton(
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Color(0xFF526C6A)),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5.0,
                          padding: EdgeInsets.all(15),
                          onPressed: () async {
                            svaeFormeKey();
                            log(this.emaile);
                            log(password);
                            log(phoneNumper);
                            log(firstName);
                            setState(() {
                              
                            });

                            if (emaile.isNotEmpty &&
                                password.isNotEmpty &&
                                phoneNumper.isNotEmpty &&
                                firstName.isNotEmpty) {

                            if(emaile.isNotEmpty&&password.isNotEmpty &&phoneNumper.isNotEmpty&&firstName.isNotEmpty){
                              if(_valuegender==genratedGrube.male){
                            bloc!.add(AuthenticationSingUpEvent(emaile,password,phoneNumper,firstName,true));
                              }else{
                            bloc!.add(AuthenticationSingUpEvent(emaile,password,phoneNumper,firstName,false));
                              }
                              
                            }
                           
                               

                     
                            }
                          }),
                    ),
                    Text(
                      "-OR-",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Sing in whid",
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'OpenSans',
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.filter_vintage,
                            color: Colors.red[300],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.gesture,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogIn()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "I Have Accounr?",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }));
  }
}
