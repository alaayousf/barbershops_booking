import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<List<void>> signOut() async {
    
  return Future.wait([
    _firebaseAuth.signOut()
  ]);
}

Future<bool> isSignedIn() async {
  final currentUser = await _firebaseAuth.currentUser;
  return currentUser != null;
}



Future<User?> getUser() async {
  return (await _firebaseAuth.currentUser);
}

}
