import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/cart/cart_item.dart';
import 'package:eshoes_clean_arch/domain/repositories/cart_repository.dart';

import '../../../core/error/failures.dart';

class SyncCartUseCase implements UseCase<List<CartItem>, NoParams> {
  SyncCartUseCase({required this.repository});
  final CartRepository repository;

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.syncCart();
  }
}
