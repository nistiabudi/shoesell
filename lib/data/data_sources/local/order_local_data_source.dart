import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/data/models/order/order_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderDetailsModel>> getOrders();
  Future<void> saveOrders(List<OrderDetailsModel> params);
  Future<void> clearOrder();
}

const cachedOrders = 'CACHED_ORDERS';

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  OrderLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<List<OrderDetailsModel>> getOrders() {
    final jsonString = sharedPreferences.getString(cachedOrders);
    if (jsonString != null) {
      return Future.value(
        orderDetailsModelListFromLocalJson(jsonString),
      );
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveOrders(List<OrderDetailsModel> params) {
    return sharedPreferences.setString(
      cachedOrders,
      orderModelListToJson(params),
    );
  }

  @override
  Future<void> clearOrder() async {
    await sharedPreferences.remove(cachedOrders);
    return;
  }
}
