import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/cart_local_data_data_source.dart';
import 'package:eshoes_clean_arch/data/models/user/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();
  Future<UserModel> getUser();
  Future<void> saveToken(String token);
  Future<void> saveUser(UserModel user);
  Future<void> clearCache();
  Future<bool> isTokenAvailable();
}

const cachedToken = 'TOKEN';
const cachedUser = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(
      {required this.flutterSecureStorage, required this.sharedPreferences});
  final FlutterSecureStorage flutterSecureStorage;
  final SharedPreferences sharedPreferences;

  @override
  Future<String> getToken() async {
    String? token = await flutterSecureStorage.read(key: cachedToken);
    if (token != null) {
      return Future.value(token);
    } else {
      throw CachedException();
    }
  }

  @override
  Future<UserModel> getUser() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      await flutterSecureStorage.deleteAll();
      sharedPreferences.setBool('first_run', false);
    }
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(userModelFromJson(jsonString));
    } else {
      throw CachedException();
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await flutterSecureStorage.write(key: cachedToken, value: token);
  }

  @override
  Future<void> saveUser(UserModel user) {
    return sharedPreferences.setString(
      cachedUser,
      userModelToJson(user),
    );
  }

  @override
  Future<void> clearCache() async {
    await flutterSecureStorage.deleteAll();
    await sharedPreferences.remove(cachedCart);
    await sharedPreferences.remove(cachedUser);
  }

  @override
  Future<bool> isTokenAvailable() async {
    String? token = await flutterSecureStorage.read(key: cachedToken);
    return Future.value((token != null));
  }
}
