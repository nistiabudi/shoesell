import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/order/order_details.dart';
import 'package:eshoes_clean_arch/domain/repositories/order_repository.dart';

class GetRemoteOrdersUseCase implements UseCase<List<OrderDetails>, NoParams> {
  GetRemoteOrdersUseCase({required this.repository});
  final OrderRepository repository;

  @override
  Future<Either<Failure, List<OrderDetails>>> call(NoParams params) async {
    return await repository.getRemoteOrders();
  }
}
