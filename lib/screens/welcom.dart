import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barbershops_booking/test.dart';
class Welcom extends StatefulWidget {
  @override
  _WelcomState createState() => _WelcomState();
}



class _WelcomState extends State<Welcom> {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  FirebaseAuth auth = FirebaseAuth.instance;


void signInWithFacebook() async {


    try {


final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'public_profile',
        'email',
        'pages_show_list',
        'pages_messaging',
        'pages_manage_metadata'
      ],
    );

      log('1 ${result.message}');
      final   d = await FacebookAuth.instance.getUserData();
      log('2 ${d.isEmpty}');
 
      final AuthCredential facebookCredential =
      FacebookAuthProvider.credential(result.accessToken!.token);
      log('3 ${facebookCredential.token}');

      final userCredential =
      await auth.signInWithCredential(facebookCredential);

      log('4 ${userCredential}');



    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          googleSignIn.currentUser != null
              ? Text('${auth.currentUser!.displayName}')
              : Text('no account'),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                signInWithGoogle(context: context, googleSignIn: googleSignIn);
              },
              child: Row(
                children: [
                  const Icon(Icons.golf_course),
                  const Text("Login using googel"),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {

                 signInWithFacebook();
             //   auth.signOut();
              },
              child: const Text("Log in using fase book"),
            ),
          ),

        ],
      )),
    );
  }
}






Future<User?> signInWithGoogle(
    {required BuildContext context, required GoogleSignIn googleSignIn}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  //final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
  }

  return user;
}


