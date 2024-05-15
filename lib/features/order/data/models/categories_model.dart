
import 'package:talabatee/features/order/domain/entities/categories.dart';

const String tableCategories = 'Categories';

/// table users column names
class CategoriesFields {
  static const all = [
    id,
    name,
  ];
  static const String id = 'ID';
  static const String name = 'Name';
}

class CategoriesModel extends Categories {
  const CategoriesModel({
    required id,
    required name,
  }) : super(
          id: id,
          name: name,
        );

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json[CategoriesFields.id],
      name: json[CategoriesFields.name] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
