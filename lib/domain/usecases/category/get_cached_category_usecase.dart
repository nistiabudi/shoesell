import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/category_repository.dart';

import '../../entities/category/category.dart';

class GetCachedCategoryUseCase implements UseCase<List<Category>, NoParams> {
  GetCachedCategoryUseCase({required this.repository});
  final CategoryRepository repository;
  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getCachedCategories();
  }
}
