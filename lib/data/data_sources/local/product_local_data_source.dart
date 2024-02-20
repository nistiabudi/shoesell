import 'dart:convert';

import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/data/models/product/product_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<ProductResponseModel> getLastProducts();
  Future<void> saveProducts(ProductResponseModel productsToCache);
}

const cachedProducts = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<ProductResponseModel> getLastProducts() {
    final jsonString = sharedPreferences.getString(cachedProducts);
    if (jsonString != null) {
      return Future.value(productResponseModelFromJson(jsonDecode(jsonString)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> saveProducts(ProductResponseModel productsToCache) {
    return sharedPreferences.setString(cachedProducts,
        jsonEncode(productResponseModelToJson(productsToCache)));
  }
}
