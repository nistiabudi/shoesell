import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';

import '../../../core/error/failures.dart';

class GetCachedDeliveryInfoUseCase
    implements UseCase<List<DeliveryInfo>, NoParams> {
  GetCachedDeliveryInfoUseCase({required this.repository});
  final DeliveryInfoRepository repository;

  @override
  Future<Either<Failure, List<DeliveryInfo>>> call(NoParams params) async {
    return await repository.getCachedDeliveryInfo();
  }
}
