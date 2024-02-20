import 'package:eshoes_clean_arch/core/constant/strings.dart';
import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/data/models/user/delivery_info_model.dart';
import 'package:http/http.dart' as http;

abstract class DeliveryInfoRemoteDataSource {
  Future<List<DeliveryInfoModel>> getDeliveryInfo(String token);
  Future<DeliveryInfoModel> addDeliveryInfo(
      DeliveryInfoModel params, String token);
  Future<DeliveryInfoModel> editDeliveryInfo(
      DeliveryInfoModel params, String token);
}

class DeliveryInfoRemoteDataSourceImpl implements DeliveryInfoRemoteDataSource {
  DeliveryInfoRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<List<DeliveryInfoModel>> getDeliveryInfo(token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/delivery-info'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return deliveryInfoModelListFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DeliveryInfoModel> addDeliveryInfo(params, token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/users/delivery-info'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: deliveryInfoModelToJson(params),
    );

    if (response.statusCode == 200) {
      return deliveryInfoModelFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DeliveryInfoModel> editDeliveryInfo(
      DeliveryInfoModel params, String token) async {
    final response =
        await client.post(Uri.parse('$baseUrl/users/delivery-info'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: deliveryInfoModelToJson(params));

    if (response.statusCode == 200) {
      return deliveryInfoModelFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
