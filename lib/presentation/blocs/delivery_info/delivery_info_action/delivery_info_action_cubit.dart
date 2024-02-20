import 'package:bloc/bloc.dart';

import 'package:eshoes_clean_arch/data/models/user/delivery_info_model.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/add_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/select_delivery_info_usecase.dart';
import 'package:flutter/cupertino.dart';

part 'delivery_info_action_state.dart';

class DeliveryInfoActionCubit extends Cubit<DeliveryInfoActionState> {
  final AddDeliveryInfoUseCase _addDeliveryInfoUseCase;
  final EditDeliveryInfoUseCase _editDeliveryInfoUseCase;
  final SelectDeliveryInfoUseCase _selectDeliveryInfoUseCase;
  DeliveryInfoActionCubit(
    this._addDeliveryInfoUseCase,
    this._editDeliveryInfoUseCase,
    this._selectDeliveryInfoUseCase,
  ) : super(DeliveryInfoActionInitial());

  void addDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _addDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoAddActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void editDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _editDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoAddActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void selectDeliveryInfo(DeliveryInfo params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _selectDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoSelectActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }
}
