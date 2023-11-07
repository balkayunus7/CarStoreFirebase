// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState());

  User? getUserDetails() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser;
    }
    return null;
  }
}

class ProfileState extends Equatable {
  ProfileState({this.user});
  final User? user;

  @override
  List<Object?> get props => [user];

  ProfileState copyWith({
    User? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }
}
