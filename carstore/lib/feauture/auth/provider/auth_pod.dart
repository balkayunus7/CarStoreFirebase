import 'package:carstore/feauture/auth/network/firebase_auth.dart';
import 'package:carstore/feauture/auth/network/firestore_service.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define AuthProvider which extends ChangeNotifier
class AuthProvider extends ChangeNotifier {
  // Define private variables
  bool _isLoading = false;
  UserCredential? _userCredential;
  final Map<String, dynamic> _userData = {};
  final FirebaseAuthClass _fAuth = FirebaseAuthClass();
  final FirestoreService _fstore = FirestoreService();

  // Define getters for private variables
  bool get isLoading => _isLoading;
  UserCredential? get userCredential => _userCredential;
  Map<String, dynamic> get userData => _userData;

  // Define method to login user with Firebase
  Future<UserCredential> loginUserWithFirebase(
      String email, String password) async {
    _setLoader(true);
    try {
      _userCredential = await _fAuth.loginUserWithFirebase(email, password);
      return _userCredential!;
    } catch (e) {
      _setLoader(false);
      throw Exception('Email or password is wrong');
    }
  }

  void errorMessage(BuildContext context, e, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorConstants.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: WidgetSizeConstants.borderRadiusNormal,
        ),
        showCloseIcon: true,
        onVisible: () {
          Future.delayed(const Duration(seconds: 5), () {
            ScaffoldMessenger.of(context).clearSnackBars();
          });
        },
      ),
    );
  }

  // Define method to sign up user with Firebase
  Future<UserCredential> signUpUserWithFirebase(
      String email, String password, String name) async {
    var isSuccessful = false;
    String bio = ' ';
    _setLoader(true);
    _userCredential =
        await _fAuth.signUpUserWithFirebase(email, password, name);
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'bio': bio,
      'uid': _userCredential!.user!.uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'profilePhoto':
          'https://firebasestorage.googleapis.com/v0/b/car-store-615be.appspot.com/o/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg?alt=media&token=26c87683-835b-4e81-9ceb-00738dfb24fe',
    };

    String uid = _userCredential!.user!.uid;
    isSuccessful = await addUserToDatabase(data, 'users', uid);
    if (isSuccessful) {
      return _userCredential!;
    } else {
      throw Exception('Please enter your e-mail address correctly');
    }
  }

  // Define method to add user to database
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

  // Define private method to set loader
  void _setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }
}

// Define provider for AuthProvider
final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
