import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/category_repository.dart';

import '../../entities/category/category.dart';

class FilterCategoryUseCase implements UseCase<List<Category>, String> {
  FilterCategoryUseCase({required this.repository});
  final CategoryRepository repository;

  @override
  Future<Either<Failure, List<Category>>> call(String params) async {
    return await repository.filterCachedCategories(params);
  }
}
