import 'package:carstore/product/models/users.dart';
import 'package:carstore/product/utilities/firebase/firebase_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


class ProfileNotifier extends StateNotifier<ProfileState> with FirebaseUtility {
  ProfileNotifier() : super(ProfileState());


  Future<void> UpdateProfilePhoto(String newProfilePhoto) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      await FirebaseFirestore.instance.collection('users').doc(userUid).update(
        {'profilePhoto': newProfilePhoto},
      );
      state = state.copyWith(newProfilePhoto: newProfilePhoto);
    }
  }

  Future<void> PickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      await UpdateProfilePhoto(image.path);
      state = state.copyWith(newProfilePhoto: image.path);
    }
  }

  Future<void> GetCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      if (userDocument.exists) {
        final item = Users().fromJson(userDocument.data()!);
        state = state.copyWith(currentUser: item);
      } else {
        return null;
      }
    }
  }

  Future<void> ChangePassword(String oldPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {

        await user.updatePassword(newPassword);

        final userUid = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(userUid).update(
          {'password': newPassword},
        );
      } on FirebaseAuthException catch (e) {
        print('Şifre değiştirme hatası: ${e.message}');
      }
    }

    Future<void> ChangeUsername(String name) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final userUid = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(userUid).update(
          {'name': name},
        );
      } on FirebaseAuthException catch (e) {
        print('Username değiştirme hatası: ${e.message}');
      }
    }
  }
  }
}

class ProfileState extends Equatable {
  ProfileState({this.currentUser, this.newProfilePhoto});
    

  final Users? currentUser;
  final String? newProfilePhoto;

  @override
  List<Object?> get props => [currentUser, newProfilePhoto];

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
