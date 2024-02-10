import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import 'package:flutter/material.dart';

part 'delivery_info_fetch_state.dart';

class DeliveryInfoFetchCubit extends Cubit<DeliveryInfoFetchState> {
  final GetCachedDeliveryInfoUseCase _getCachedDeliveryInfoUseCase;
  final GetRemoteDeliveryInfoUsecase _getRemoteDeliveryInfoUsecase;
  final GetSelectedDeliveryInfoUseCase _getSelectedDeliveryInfoUseCase;
  final ClearLocalDeliveryInfoUseCase _clearLocalDeliveryInfoUseCase;

  DeliveryInfoFetchCubit(
      this._getCachedDeliveryInfoUseCase,
      this._getRemoteDeliveryInfoUsecase,
      this._getSelectedDeliveryInfoUseCase,
      this._clearLocalDeliveryInfoUseCase)
      : super(const DeliveryInfoFetchInitial(deliveryInformation: []));

  void fetchDeliveryInfo() async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: const [],
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      print("fetching");
      final cachedResult = await _getCachedDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(
            deliveryInformation: deliveryInfo,
            selectedDeliveryInformation: state.selectedDeliveryInformation)),
      );
      final selectedDeliveryInfo =
          await _getSelectedDeliveryInfoUseCase(NoParams());
      selectedDeliveryInfo.fold(
        (failure) => (),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: deliveryInfo,
        )),
      );
      final result = await _getRemoteDeliveryInfoUsecase(NoParams());
      result.fold(
        (failure) => emit(DeliveryInfoFetchFail(
            deliveryInformation: state.deliveryInformation)),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(
            deliveryInformation: deliveryInfo,
            selectedDeliveryInformation: state.selectedDeliveryInformation)),
      );
      print("done");
    } catch (e) {
      print(e);
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void addDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));

      final value = state.deliveryInformation;
      emit(DeliveryInfoFetchSuccess(
          deliveryInformation: value,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void editDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));

      final value = state.deliveryInformation;
      value[value.indexWhere((element) => element == deliveryInfo)] =
          deliveryInfo;
      emit(DeliveryInfoFetchSuccess(
          deliveryInformation: value,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void selectDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {}
  }

  void clearLocalDeliveryInfo() async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      final cachedResult = await _clearLocalDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(const DeliveryInfoFetchInitial(
            deliveryInformation: [], selectedDeliveryInformation: null)),
      );
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }
}
