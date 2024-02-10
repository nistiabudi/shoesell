import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/cart/cart_item.dart';
import 'package:eshoes_clean_arch/domain/repositories/cart_repository.dart';

class GetCachedUseCase implements UseCase<List<CartItem>, NoParams> {
  GetCachedUseCase({required this.repository});
  final CartRepository repository;

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.getCachedCart();
  }
}
