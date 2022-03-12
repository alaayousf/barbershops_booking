import 'package:barbershops_booking/blocs/auth_Event.dart';
import 'package:barbershops_booking/blocs/auth_State.dart';
import 'package:barbershops_booking/blocs/auth_bloc.dart';
import 'package:barbershops_booking/repository/userRepository.dart';
import 'package:barbershops_booking/screens/home.dart';
import 'package:barbershops_booking/screens/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late String emaile;
  late String password;

  setEmaile(var inputemaile) {
    this.emaile = inputemaile;
  }

  setpassword(var inputpassword) {
    this.password = inputpassword;
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

  saveEmaile(newvalue) {
    setEmaile(newvalue);
  }

  savePassworde(newvalue) {
    setpassword(newvalue);
  }

  valedationPassworde(value) {
    if (value.toString().length < 4) return 'invalid passworde';
  }

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

  /* */

  AuthenticationBloc? bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);

    super.initState();
  }

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
                      "Log in",
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
                            print(emaile);
                            print(password);

                            if (emaile.isNotEmpty && password.isNotEmpty) {
                              bloc!.add(
                                  AuthenticationLoginEvent(emaile, password));
                            }
                          }),
                    ),


                    
                    BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (BuildContext context, state) {
                          if (state is AuthenticationSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        },
                        child: Center()),



                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                      //                         if (state is AuthenticationSuccess) {
                      //   WidgetsBinding.instance?.addPersistentFrameCallback((timeStamp) {
                      //     Navigator.push(
                      //                           context,
                      //                           MaterialPageRoute(builder: (context) => Home()),
                      //                         );

                      //   });
                      // }

                      return Center();

                      //return state is AuthenticationSuccess?Text("${state.firebaseUser!.user!.email}"):Text("erorr");
                    }),
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
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "I dount Have Accounr?",
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
