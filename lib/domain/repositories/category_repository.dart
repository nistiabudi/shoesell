import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';

import '../entities/category/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getRemoteCategories();

  Future<Either<Failure, List<Category>>> getCachedCategories();

  Future<Either<Failure, List<Category>>> filterCachedCategories(
      String keyword);
}
