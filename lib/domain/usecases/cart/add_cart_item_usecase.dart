import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/cart_repository.dart';

import '../../entities/cart/cart_item.dart';

class AddCartItemUseCase implements UseCase<void, CartItem> {
  AddCartItemUseCase({required this.repository});
  final CartRepository repository;

  @override
  Future<Either<Failure, void>> call(CartItem params) async {
    return await repository.addToCart(params);
  }
}
