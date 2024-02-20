import 'dart:convert';

import 'package:eshoes_clean_arch/core/constant/strings.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/data/models/product/product_response_model.dart';
import 'package:eshoes_clean_arch/domain/usecases/product/get_product_usecase.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts(FliterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<ProductResponseModel> getProducts(params) => _getProductFromUrl(
      '$baseUrl/products?keyword=${params.keyword}&pageSize=${params.pageSize}&page=${params.limit}&category=${jsonEncode(params.categories.map((e) => e.id).toList())}');
  Future<ProductResponseModel> _getProductFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return productResponseModelFromJson(response.body);
    } else {
      throw ServerFailure();
    }
  }
}
