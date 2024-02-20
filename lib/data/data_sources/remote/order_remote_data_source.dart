import 'package:eshoes_clean_arch/core/constant/strings.dart';
import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/data/models/order/order_details_model.dart';
import 'package:http/http.dart' as http;

abstract class OrderRemoteDataSource {
  Future<OrderDetailsModel> addOrder(OrderDetailsModel params, String token);
  Future<List<OrderDetailsModel>> getOrders(String token);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<OrderDetailsModel> addOrder(params, token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: orderDetailsModelListToJson(params),
    );

    if (response.statusCode == 200) {
      return orderDetailsModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrderDetailsModel>> getOrders(String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return orderDetailsModelListFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
