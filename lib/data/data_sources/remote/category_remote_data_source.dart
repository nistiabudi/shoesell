import 'package:eshoes_clean_arch/core/constant/strings.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:http/http.dart' as http;

import 'package:eshoes_clean_arch/data/models/category/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<List<CategoryModel>> getCategories() =>
      _getCategoryFromUrl('$baseUrl/categories');

  Future<List<CategoryModel>> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return categoryModelListFromRemoteJson(response.body);
    } else {
      throw ServerFailure();
    }
  }
}
