import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/network/network_info.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/product_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/product_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/models/product/product_response_model.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product_response.dart';
import 'package:eshoes_clean_arch/domain/repositories/product_repository.dart';
import 'package:eshoes_clean_arch/domain/usecases/product/get_product_usecase.dart';

typedef _ConcreteOrProductChooser = Future<ProductResponse> Function();

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, ProductResponse>> getProducts(
      FliterProductParams params) async {
    return await _getProduct(() {
      return remoteDataSource.getProducts(params);
    });
  }

  Future<Either<Failure, ProductResponse>> _getProduct(
    _ConcreteOrProductChooser getConcreteOrProducts,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await getConcreteOrProducts();
        localDataSource.saveProducts(remoteProducts as ProductResponseModel);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CachedException {
        return Left(CacheFailure());
      }
    }
  }
}
