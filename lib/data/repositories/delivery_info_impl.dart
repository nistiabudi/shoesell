import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/network/network_info.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/user_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/models/user/delivery_info_model.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';

class DeliveryInfoImpl implements DeliveryInfoRepository {
  DeliveryInfoImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo,
      required this.userLocalDataSource});
  final DeliveryInfoLocalDataSource localDataSource;
  final DeliveryInfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final UserLocalDataSource userLocalDataSource;

  @override
  Future<Either<Failure, List<DeliveryInfo>>> getRemoteDeliveryInfo() async {
    if (await networkInfo.isConnected) {
      if (await userLocalDataSource.isTokenAvailable()) {
        try {
          final String token = await userLocalDataSource.getToken();
          final result = await remoteDataSource.getDeliveryInfo(
            token,
          );
          await localDataSource.saveDeliveryInfo(result);
          return Right(result);
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
  Future<Either<Failure, List<DeliveryInfo>>> getCachedDeliveryInfo() async {
    try {
      final result = await localDataSource.getDeliveryInfo();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> getSelectedDeliveryInfo() async {
    try {
      final result = await localDataSource.getSelectedDeliveryInfo();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalDeliveryInfo() async {
    try {
      await localDataSource.clearLocalDeliveryInfo();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      try {
        final String token = await userLocalDataSource.getToken();
        final DeliveryInfoModel deliveryInfo =
            await remoteDataSource.addDeliveryInfo(
          params,
          token,
        );

        await localDataSource.updateDeliveryInfo(deliveryInfo);
        return Right(deliveryInfo);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> selectDeliveryInfo(
      DeliveryInfo params) async {
    try {
      await localDataSource
          .updateDeliveryInfo(DeliveryInfoModel.fromEntity(params));
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> editDeliveryInfo(
      DeliveryInfoModel params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      try {
        final String token = await userLocalDataSource.getToken();
        final DeliveryInfoModel deliveryInfo =
            await remoteDataSource.editDeliveryInfo(
          params,
          token,
        );

        return Right(deliveryInfo);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(AuthenticationFailure());
    }
  }
}
