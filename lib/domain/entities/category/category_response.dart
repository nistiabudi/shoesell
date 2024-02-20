import 'package:eshoes_clean_arch/domain/entities/category/category.dart';

class CategoryResponse {
  CategoryResponse({required this.categories});
  final List<Category> categories;
}
