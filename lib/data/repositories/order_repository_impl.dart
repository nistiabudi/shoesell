import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/network/network_info.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/order_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/user_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/order_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/models/order/order_details_model.dart';
import 'package:eshoes_clean_arch/domain/entities/order/order_details.dart';
import 'package:eshoes_clean_arch/domain/repositories/order_repository.dart';

import '../../core/error/failures.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.userLocalDataSource,
      required this.networkInfo});
  final OrderLocalDataSource localDataSource;
  final OrderRemoteDataSource remoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.addOrder(
        OrderDetailsModel.formEntity(params),
        token,
      );
      return Right(remoteProduct);
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders() async {
    if (await networkInfo.isConnected) {
      if (await userLocalDataSource.isTokenAvailable()) {
        try {
          final String token = await userLocalDataSource.getToken();
          final remoteProduct = await remoteDataSource.getOrders(
            token,
          );
          await localDataSource.saveOrders(remoteProduct);
          return Right(remoteProduct);
        } on Failure catch (failure) {
          return Left(failure);
        }
      } else {
        return Left(AuthenticationFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getCachedOrders() async {
    try {
      final localOrders = await localDataSource.getOrders();
      return Right(localOrders);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalOrders() async {
    try {
      await localDataSource.clearOrder();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
