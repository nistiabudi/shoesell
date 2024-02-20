import 'dart:convert';

import 'package:eshoes_clean_arch/domain/entities/category/category.dart';

// List From Remote JSOn
List<CategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str)['data'].map((x) => CategoryModel.fromJson(x)));

// List From Local JSon
List<CategoryModel> categoryModelListFromLocalJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelListToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Category {
  const CategoryModel({
    required String id,
    required String image,
    required String name,
  }) : super(
          id: id,
          image: image,
          name: name,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        image: json["image"],
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "name": name,
      };

  factory CategoryModel.formEntity(Category entity) => CategoryModel(
        id: entity.id,
        image: entity.image,
        name: entity.name,
      );
}
