// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carstore/product/utilities/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Numbers extends Equatable with IDModel, BaseFirebaseModel<Numbers> {
  Numbers({
    this.number,
  });

  final String? number;
  @override
  String? id = '';

  Numbers copyWith({
    String? number,
  }) {
    return Numbers(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  @override
  Numbers fromJson(Map<String, dynamic> json) {
    return Numbers(
      number: json['number'] as String?,
    );
  }

  @override
  List<Object?> get props => [number];
}
