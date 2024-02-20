import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';

class SelectDeliveryInfoUseCase implements UseCase<DeliveryInfo, DeliveryInfo> {
  SelectDeliveryInfoUseCase(this.repository);
  final DeliveryInfoRepository repository;

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfo params) async {
    return await repository.selectDeliveryInfo(params);
  }
}
