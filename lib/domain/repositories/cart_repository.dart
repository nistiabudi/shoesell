import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/domain/entities/cart/cart_item.dart';

import '../../core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCachedCart();
  Future<Either<Failure, List<CartItem>>> syncCart();
  Future<Either<Failure, CartItem>> addToCart(CartItem params);
  Future<Either<Failure, bool>> deleteFormCart();
  Future<Either<Failure, bool>> clearCart();
}
