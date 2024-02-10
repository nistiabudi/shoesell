import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/data/models/user/delivery_info_model.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';

class EditDeliveryInfoUseCase
    implements UseCase<DeliveryInfo, DeliveryInfoModel> {
  EditDeliveryInfoUseCase({required this.repository});
  final DeliveryInfoRepository repository;

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfoModel params) async {
    return await repository.editDeliveryInfo(params);
  }
}
