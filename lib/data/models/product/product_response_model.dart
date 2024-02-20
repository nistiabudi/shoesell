import 'dart:convert';

import 'package:eshoes_clean_arch/data/models/product/pagination_data_model.dart';
import 'package:eshoes_clean_arch/domain/entities/product/pagination_meta_data.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product_response.dart';

import '../../../domain/entities/product/product.dart';
import 'product_model.dart';

ProductResponseModel productResponseModelFromJson(String str) =>
    ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) =>
    json.encode(data.toJson());

class ProductResponseModel extends ProductResponse {
  ProductResponseModel({
    required PaginationMetaData meta,
    required List<Product> data,
  }) : super(
          paginationMetaData: meta,
          products: data,
        );

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        meta: PaginationMetaDataModel.fromJson(json["meta"]),
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": (paginationMetaData as PaginationMetaDataModel).toJson(),
        "data": List<dynamic>.from(
            (products as List<ProductModel>).map((x) => x.toJson())),
      };
}
