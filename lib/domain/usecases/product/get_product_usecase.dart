import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product_response.dart';

import '../../../core/error/failures.dart';
import '../../entities/category/category.dart';
import '../../repositories/product_repository.dart';

class GetProductUseCase
    implements UseCase<ProductResponse, FliterProductParams> {
  GetProductUseCase(this.repository);
  final ProductRepository repository;

  @override
  Future<Either<Failure, ProductResponse>> call(
      FliterProductParams params) async {
    return await repository.getProducts(params);
  }
}

class FliterProductParams {
  const FliterProductParams({
    this.categories = const [],
    this.minPrice = 0,
    this.maxPrice = 10000,
    this.keyword = '',
    this.limit = 0,
    this.pageSize = 10,
  });
  final String? keyword;
  final List<Category> categories;
  final double minPrice;
  final double maxPrice;
  final int? limit;
  final int? pageSize;

  FliterProductParams copyWith({
    int? skip,
    String? keyword,
    List<Category>? categories,
    double? minPrice,
    double? maxPrice,
    int? pageSize,
    int? limit,
  }) =>
      FliterProductParams(
        keyword: keyword ?? this.keyword,
        categories: categories ?? this.categories,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        pageSize: pageSize ?? this.pageSize,
        limit: limit ?? this.limit,
      );
}
