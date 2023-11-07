import 'package:carstore/feauture/auth/network/abstract/base_firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClass extends BaseFirebaseService {
  FirebaseAuth kauth = FirebaseAuth.instance;

  @override
  bool isUserLoggedIn() {
    if (kauth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    final userCredentials =
        kauth.signInWithEmailAndPassword(email: email, password: password);
    return userCredentials;
  }

  @override
  void signOutUser() {
    kauth.signOut();
  }

  @override
  Future<UserCredential> signUpUserWithFirebase(
      String email, String password, String name) {
    final userCredential =
        kauth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
