import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';

class GetSelectedDeliveryInfoUseCase
    implements UseCase<DeliveryInfo, NoParams> {
  GetSelectedDeliveryInfoUseCase({required this.repository});
  final DeliveryInfoRepository repository;

  @override
  Future<Either<Failure, DeliveryInfo>> call(NoParams params) async {
    return await repository.getSelectedDeliveryInfo();
  }
}
