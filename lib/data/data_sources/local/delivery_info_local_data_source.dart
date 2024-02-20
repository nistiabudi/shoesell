import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/data/models/user/delivery_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DeliveryInfoLocalDataSource {
  Future<List<DeliveryInfoModel>> getDeliveryInfo();
  Future<DeliveryInfoModel> getSelectedDeliveryInfo();
  Future<void> saveDeliveryInfo(List<DeliveryInfoModel> params);
  Future<void> updateDeliveryInfo(DeliveryInfoModel params);
  Future<void> clearLocalDeliveryInfo();
}

const cachedDeliveryInfo = 'CACHED_DELIVERY_INFO';
const cachedSelectedDeliveryInfo = 'CACHED_SELECTED_DELIVERY_INFO';

class DeliveryInfoLocalDataSourceImpl implements DeliveryInfoLocalDataSource {
  DeliveryInfoLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<List<DeliveryInfoModel>> getDeliveryInfo() {
    final jsonString = sharedPreferences.getString(cachedDeliveryInfo);
    if (jsonString != null) {
      return Future.value(
        deliveryInfoModelListFromLocalJson(jsonString),
      );
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<DeliveryInfoModel> getSelectedDeliveryInfo() {
    final jsonString = sharedPreferences.getString(cachedSelectedDeliveryInfo);
    if (jsonString != null) {
      return Future.value(
        deliveryInfoModelFromLocalJson(jsonString),
      );
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveDeliveryInfo(List<DeliveryInfoModel> params) {
    return sharedPreferences.setString(
      cachedDeliveryInfo,
      deliveryInfoModelListToJson(params),
    );
  }

  @override
  Future<void> updateDeliveryInfo(DeliveryInfoModel params) {
    final jsonString = sharedPreferences.getString(cachedSelectedDeliveryInfo);
    late List<DeliveryInfoModel> data;

    if (jsonString != null) {
      data = deliveryInfoModelListFromLocalJson(jsonString);
      if (data.any((deliveryInfo) => deliveryInfo == params)) {
        data[data.indexWhere((deliveryInfo) => deliveryInfo == params)] =
            params;
      } else {
        data.add(params);
      }
    } else {
      data = [params];
    }
    return sharedPreferences.setString(
      cachedDeliveryInfo,
      deliveryInfoModelListToJson(data),
    );
  }

  @override
  Future<void> clearLocalDeliveryInfo() async {
    await sharedPreferences.remove(cachedDeliveryInfo);
    await sharedPreferences.remove(cachedSelectedDeliveryInfo);
    return;
  }
}
