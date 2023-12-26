import 'package:carstore/product/utilities/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tag with EquatableMixin, IDModel, BaseFirebaseModel<Tag> {
  Tag({
    this.name,
    this.active,
    this.id,
  });

  final String? name;
  final bool? active;
  @override
  // ignore: overridden_fields
  final String? id;

  @override
  List<Object?> get props => [name, active];

  Tag copyWith({
    String? name,
    bool? active,
  }) {
    return Tag(
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'active': active,
    };
  }

  @override
  Tag fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] as String?,
      active: json['active'] as bool?,
    );
  }
}
