import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/cart/cart_item.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/add_cart_item_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/clear_item_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/get_cached_cart_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/sync_cart_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

abstract class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCachedUseCase _getCachedCartUseCase;
  final SyncCartUseCase _syncCartUseCase;
  final AddCartItemUseCase _addCartItemUseCase;
  final ClearItemUseCase _clearItemUseCase;

  CartBloc(this._getCachedCartUseCase, this._addCartItemUseCase,
      this._syncCartUseCase, this._clearItemUseCase)
      : super(const CartInitial(cart: [])) {
    on<GetCart>(_onGetCart);
    on<AddProduct>(_onAddToCart);
    on<ClearCart>(_onClearCart);
  }

  void _onGetCart(GetCart event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      final result = await _getCachedCartUseCase(NoParams());
      result.fold(
        (failure) => emit(CartError(failure: failure, cart: state.cart)),
        (cart) => emit(CartLoaded(cart: cart)),
      );
      final syncResult = await _syncCartUseCase(NoParams());
      emit(CartLoading(cart: state.cart));
      syncResult.fold(
        (failure) => emit(CartError(failure: failure, cart: state.cart)),
        (cart) => emit(CartLoaded(cart: cart)),
      );
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: state.cart));
    }
  }

  void _onAddToCart(AddProduct event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      List<CartItem> cart = [];
      cart.addAll(state.cart);
      cart.add(event.cartItem);
      var result = await _addCartItemUseCase(event.cartItem);
      result.fold(
        (failure) => emit(CartError(failure: failure, cart: state.cart)),
        (_) => emit(CartLoaded(cart: cart)),
      );
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: state.cart));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      emit(const CartLoading(cart: []));
      emit(const CartLoaded(cart: []));
      await _clearItemUseCase(NoParams());
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: const []));
    }
  }
}
