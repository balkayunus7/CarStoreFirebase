import 'package:carstore/feauture/auth/network/firebase_auth.dart';
import 'package:carstore/feauture/auth/network/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  UserCredential? _userCredential;
  Map<String, dynamic> _userData = {};
  FirebaseAuthClass _fAuth = FirebaseAuthClass();
  FirestoreService _fstore = FirestoreService();

  bool get isLoading => _isLoading;
  UserCredential? get userCredential => _userCredential;
  Map<String, dynamic> get userData => _userData;

  // * Login User
  Future<UserCredential> loginUserWithFirebase(
      String email, String password) async {
    _setLoader(true);
    try {
      _userCredential = await _fAuth.loginUserWithFirebase(email, password);
      return _userCredential!;
    } catch (e) {
      _setLoader(false);
      return Future.error(e);
    }
  }

  // * Sign Up User
  Future<UserCredential> signUpUserWithFirebase(
      String email, String password, String name) async {
    var isSuccessful = false;
    _setLoader(true);
    _userCredential =
        await _fAuth.signUpUserWithFirebase(email, password, name);
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'uid': _userCredential!.user!.uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'bio': '',
      'profilePhoto': '',
    };

    String uid = _userCredential!.user!.uid;
    isSuccessful = await addUserToDatabase(data, 'User', uid);
    if (isSuccessful) {
      return _userCredential!;
    } else {
      throw Exception('Error while adding user to database');
    }
  }

  // * Add User to Database
  Future<bool> addUserToDatabase(
      Map<String, dynamic> data, String collectionName, String docName) async {
    var value = false;
    try {
      await _fstore.addToFirestore(data, collectionName, docName);
      value = true;
    } catch (e) {
      value = false;
    }
    return value;
  }

  void _setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }
}

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
