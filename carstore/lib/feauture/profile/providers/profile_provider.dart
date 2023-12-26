import 'package:carstore/feauture/auth/network/firestore_service.dart';
import 'package:carstore/product/models/users.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:carstore/product/utilities/firebase/firebase_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileNotifier extends StateNotifier<ProfileState> with FirebaseUtility {
  ProfileNotifier() : super(const ProfileState());

  // Method to update profile photo
  Future<void> updateProfilePhoto(String newProfilePhoto) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      // Updating profile photo in Firestore
      await FirebaseFirestore.instance.collection(FirebaseCollections.users.name).doc(userUid).update(
        {'profilePhoto': newProfilePhoto},
      );
      // Updating state
      state = state.copyWith(newProfilePhoto: newProfilePhoto);
    }
  }

  // Method to pick image from gallery
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Updating profile photo with picked image
      await updateProfilePhoto(image.path);
      state = state.copyWith(newProfilePhoto: image.path);
    }
  }

  // Method to get current user
  Future<void> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument = await FirebaseFirestore.instance
          .collection(FirebaseCollections.users.name)
          .doc(userUid)
          .get();

      if (userDocument.exists) {
        final item = Users().fromJson(userDocument.data()!);
        state = state.copyWith(currentUser: item);
      } else {
        return;
      }
    }
  }

  // Method to change password
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    final fstore=FirestoreService();

    if (user != null) {
      try {
        // Updating password in Firebase Auth
        await user.updatePassword(newPassword);
        final userUid = user.uid;
        // Updating password in Firestore
        fstore.updateDataToFirestore({'password': newPassword},FirebaseCollections.users.name, userUid);

      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e.message);
        }
      }
    }
  }

  // Method to change username
  Future<void> changeUsername(String name,String bio) async {
    final user = FirebaseAuth.instance.currentUser;
    final fstore=FirestoreService();
    if (user != null) {
      try {
        final userUid = user.uid;
        // Updating username and bio in Firestore
        fstore.updateDataToFirestore({'name': name,'bio':bio},FirebaseCollections.users.name, userUid); 
      } catch (e) {
        if (kDebugMode) {
          print(e);
        } 
      }   
    }
  }
}

// ProfileState class extends Equatable
class ProfileState extends Equatable {
  const ProfileState({this.currentUser, this.newProfilePhoto});

  final Users? currentUser;
  final String? newProfilePhoto;

  // Overriding props method for Equatable
  @override
  List<Object?> get props => [currentUser, newProfilePhoto];

  // Method to copy ProfileState with new values
  ProfileState copyWith({
    Users? currentUser, 
    String? newProfilePhoto,
  }) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
      newProfilePhoto: newProfilePhoto ?? this.newProfilePhoto,
    );
  }
}