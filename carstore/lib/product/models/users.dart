// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carstore/product/utilities/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

class Users with EquatableMixin, BaseFirebaseModel<Users>, IDModel {
  Users({
    this.createdAt,
    this.uid,
    this.email,
    this.name,
    this.password,
    this.profilePhoto,
    this.id,
  });

  final String? createdAt;
  final String? uid;
  final String? email;
  final String? name;
  final String? password;
  final String? profilePhoto;
  @override
  // ignore: overridden_fields
  final String? id;

  @override
  List<Object?> get props =>
      [createdAt, email, name, password, profilePhoto, uid, id];

  Users copyWith({
    String? createdAt,
    String? email,
    String? name,
    String? password,
    String? profilePhoto,
    String? uid,
    String? id,
  }) {
    return Users(
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'email': email,
      'name': name,
      'password': password,
      'uid': uid,
      'profilePhoto': profilePhoto,
      'id': id,
    };
  }

  @override
  Users fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
    );
  }
}
