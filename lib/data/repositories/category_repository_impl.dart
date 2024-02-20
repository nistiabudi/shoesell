import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/network/network_info.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/category_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/category_remote_data_source.dart';
import 'package:eshoes_clean_arch/domain/repositories/category_repository.dart';

import '../../domain/entities/category/category.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Category>>> getRemoteCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProductss = await remoteDataSource.getCategories();
        localDataSource.saveCategories(remoteProductss);
        return Right(remoteProductss);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCachedCategories() async {
    try {
      final localProducts = await localDataSource.getCategories();
      return Right(localProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Category>>> filterCachedCategories(params) async {
    try {
      final cachedCategories = await localDataSource.getCategories();
      final categories = cachedCategories;
      final filteredCategories = categories
          .where((element) =>
              element.name.toLowerCase().contains(params.toLowerCase()))
          .toList();
      return Right(filteredCategories);
    } on CachedException {
      return Left(CacheFailure());
    }
  }
}
