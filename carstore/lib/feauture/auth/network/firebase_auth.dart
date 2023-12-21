import 'package:carstore/feauture/auth/network/abstract/base_firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define FirebaseAuthClass which extends BaseFirebaseService
class FirebaseAuthClass extends BaseFirebaseService {
  // Initialize FirebaseAuth instance
  FirebaseAuth kauth = FirebaseAuth.instance;

  // Override isUserLoggedIn method
  @override
  bool isUserLoggedIn() {
    // Check if current user is not null
    if (kauth.currentUser != null) {
      // If not null, return true
      return true;
    } else {
      // If null, return false
      return false;
    }
  }

  // Override loginUserWithFirebase method
  @override
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    // Sign in user with email and password
    final userCredentials =
        kauth.signInWithEmailAndPassword(email: email, password: password);
    // Return user credentials
    return userCredentials;
  }

  // Override signOutUser method
  @override
  void signOutUser() {
    // Sign out user
    kauth.signOut();
  }

  // Override signUpUserWithFirebase method
  @override
  Future<UserCredential> signUpUserWithFirebase(
      String email, String password, String name) {
    // Create user with email and password
    final userCredential =
        kauth.createUserWithEmailAndPassword(email: email, password: password);
    // Return user credentials
    return userCredential;
  }
}