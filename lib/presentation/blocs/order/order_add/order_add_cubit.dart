import 'package:bloc/bloc.dart';
import 'package:eshoes_clean_arch/domain/entities/order/order_details.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/add_order_usecase.dart';

part 'order_add_state.dart';

class OrderAddCubit extends Cubit<OrderAddState> {
  OrderAddCubit(this._addOrderUseCase) : super(OrderAddIntial());
  final AddOrderUseCase _addOrderUseCase;

  void addOrder(OrderDetails params) async {
    try {
      emit(OrderAddLoading());
      final result = await _addOrderUseCase(params);
      result.fold(
        (failure) => emit(OrderAddFail()),
        (order) => emit(OrderAddSuccess(order)),
      );
    } catch (e) {
      emit(OrderAddFail());
    }
  }
}
