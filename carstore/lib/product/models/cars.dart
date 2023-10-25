import 'package:carstore/product/utilities/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Cars extends Equatable with IDModel, BaseFirebaseModel<Cars> {
  Cars({
    this.category,
    this.categoryId,
    this.title,
    this.backgroundImage,
    this.backgroundImage2,
    this.backgroundImage3,
    this.description,
    this.id,
    this.price,
  });

  final String? category;
  final String? categoryId;
  final String? title;
  final String? backgroundImage;
  final String? backgroundImage2;
  final String? backgroundImage3;
  final String? description;
  final String? price;
  @override
  final String? id;

  @override
  List<Object?> get props => [
        category,
        categoryId,
        title,
        backgroundImage,
        id,
        backgroundImage2,
        backgroundImage3,
        description,
        price,
      ];

  Cars copyWith({
    String? category,
    String? categoryId,
    String? title,
    String? backgroundImage,
    String? backgroundImage2,
    String? backgroundImage3,
    String? description,
    String? price,
    String? id,
  }) {
    return Cars(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      backgroundImage2: backgroundImage2 ?? this.backgroundImage2,
      backgroundImage3: backgroundImage3 ?? this.backgroundImage3,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      description: description ?? this.description,
      id: id ?? this.id,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryId': categoryId,
      'title': title,
      'backgroundImage': backgroundImage,
      'backgroundImage2': backgroundImage2,
      'backgroundImage3': backgroundImage3,
      'description': description,
      'id': id,
      'price': price,
    };
  }

  @override
  Cars fromJson(Map<String, dynamic> json) {
    return Cars(
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      title: json['title'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      backgroundImage2: json['backgroundImage2'] as String?,
      backgroundImage3: json['backgroundImage3'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      price: json['price'] as String?,
    );
  }
}
