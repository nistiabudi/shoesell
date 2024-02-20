import 'package:bloc/bloc.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/clear_local_order_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/get_cached_orders_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/get_remote_orders_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/order/order_details.dart';

part 'order_fetch_state.dart';

class OrderFetchCubit extends Cubit<OrderFetchState> {
  final GetRemoteOrdersUseCase _getRemoteOrdersUseCase;
  final GetCachedOrdersUseCase _getCachedOrdersUseCase;
  final ClearLocalOrderUseCase _clearLocalOrderUseCase;
  OrderFetchCubit(
    this._clearLocalOrderUseCase,
    this._getCachedOrdersUseCase,
    this._getRemoteOrdersUseCase,
  ) : super(const OrderFetchInitial([]));

  void getOrders() async {
    try {
      emit(OrderFetchLoading(state.orders));
      final cachedResult = await _getCachedOrdersUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (orders) => emit(OrderFetchSuccess(orders)),
      );
      final remoteResult = await _getRemoteOrdersUseCase(NoParams());
      remoteResult.fold(
        (failure) => emit(OrderFetchFail(state.orders)),
        (orders) => emit(OrderFetchSuccess(orders)),
      );
    } catch (e) {
      emit(OrderFetchFail(state.orders));
    }
  }

  void clearLocalOrders() async {
    try {
      emit(OrderFetchLoading(state.orders));
      final cachedResult = await _clearLocalOrderUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (result) => emit(const OrderFetchInitial([])),
      );
    } catch (e) {
      emit(OrderFetchFail(state.orders));
    }
  }
}
