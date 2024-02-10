import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/network/network_info.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/cart_local_data_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/user_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/models/cart/cart_item_model.dart';
import 'package:eshoes_clean_arch/domain/entities/cart/cart_item.dart';
import 'package:eshoes_clean_arch/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.userLocalDataSource,
      required this.networkInfo});
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, CartItem>> addToCart(CartItem params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      await localDataSource.saveCartItem(CartItemModel.fromParent(params));
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.addToCart(
        CartItemModel.fromParent(params),
        token,
      );
      return Right(remoteProduct);
    } else {
      await localDataSource.saveCartItem(CartItemModel.fromParent(params));
      return Right(params);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFormCart() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCachedCart() async {
    try {
      final localProducts = await localDataSource.getCart();
      return Right(localProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> syncCart() async {
    if (await networkInfo.isConnected) {
      if (await userLocalDataSource.isTokenAvailable()) {
        List<CartItemModel> localCartItems = [];
        try {
          localCartItems = await localDataSource.getCart();
        } on Failure catch (_) {}
        try {
          final String token = await userLocalDataSource.getToken();
          final syncedResult = await remoteDataSource.syncCart(
            localCartItems,
            token,
          );
          await localDataSource.saveCart(syncedResult);
          return Right(syncedResult);
        } on Failure catch (failure) {
          return Left(failure);
        }
      } else {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> clearCart() async {
    bool result = await localDataSource.clearCart();
    if (result) {
      return Right(result);
    } else {
      return Left(CacheFailure());
    }
  }
}
