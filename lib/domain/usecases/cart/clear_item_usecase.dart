import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/cart_repository.dart';

import '../../../core/error/failures.dart';

class ClearItemUseCase implements UseCase<bool, NoParams> {
  ClearItemUseCase({required this.repository});
  final CartRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearCart();
  }
}
