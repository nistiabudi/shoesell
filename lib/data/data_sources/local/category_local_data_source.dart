import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/data/models/category/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<void> saveCategories(List<CategoryModel> categoriesToCache);
}

const cachedCategories = "CACHED_CATEGORIES";

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<List<CategoryModel>> getCategories() {
    final jsonString = sharedPreferences.getString(cachedCategories);
    if (jsonString != null) {
      return Future.value(
        categoryModelListFromLocalJson(jsonString),
      );
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveCategories(List<CategoryModel> categoriesToCache) {
    return sharedPreferences.setString(
      cachedCategories,
      categoryModelListToJson(categoriesToCache),
    );
  }
}
