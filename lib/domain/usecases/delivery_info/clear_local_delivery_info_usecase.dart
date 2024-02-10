import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';

class ClearLocalDeliveryInfoUseCase implements UseCase<NoParams, NoParams> {
  ClearLocalDeliveryInfoUseCase({required this.repository});
  final DeliveryInfoRepository repository;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.clearLocalDeliveryInfo();
  }
}
