import 'dart:convert';

import 'package:eshoes_clean_arch/core/constant/strings.dart';
import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/data/models/cart/cart_item_model.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token);
  Future<List<CartItemModel>> syncCart(List<CartItemModel> cart, String token);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  CartRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/users/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(cartItem.toBodyJson()));
    if (response.statusCode == 200) {
      Map<String, dynamic> val = jsonDecode(response.body)['data'];
      return CartItemModel.fromJson(val);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CartItemModel>> syncCart(
      List<CartItemModel> cart, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/user/cart/sync'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "data": cart
              .map((e) => {
                    "product": e.product.id,
                    "priceTag": e.priceTag.id,
                  })
              .toList()
        }));
    if (response.statusCode == 200) {
      var list = cartItemModelListFromRemoteJson(response.body);
      return list;
    } else {
      throw ServerException();
    }
  }
}
