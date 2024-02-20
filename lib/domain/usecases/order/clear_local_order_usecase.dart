import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/order_repository.dart';

import '../../../core/error/failures.dart';

class ClearLocalOrderUseCase implements UseCase<NoParams, NoParams> {
  ClearLocalOrderUseCase({required this.repository});
  final OrderRepository repository;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.clearLocalOrders();
  }
}
