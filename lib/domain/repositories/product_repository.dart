import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product_response.dart';
import 'package:eshoes_clean_arch/domain/usecases/product/get_product_usecase.dart';

import '../../core/error/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> getProducts(
      FliterProductParams params);
}
