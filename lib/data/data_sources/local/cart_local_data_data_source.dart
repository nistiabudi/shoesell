import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/data/models/cart/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataDataSource {
  Future<List<CartItemModel>> getCart();
  Future<void> saveCart(List<CartItemModel> cart);
  Future<void> saveCartItem(CartItemModel cartItem);
  Future<bool> clearCart();
}

const cachedCart = 'CACHED_CART';

class CartLocalDataDataSourceImpl implements CartLocalDataDataSource {
  CartLocalDataDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<void> saveCart(List<CartItemModel> cart) {
    return sharedPreferences.setString(
      cachedCart,
      cartItemModelToJson(cart),
    );
  }

  @override
  Future<void> saveCartItem(CartItemModel cartItem) {
    final jsonString = sharedPreferences.getString(cachedCart);
    final List<CartItemModel> cart = [];

    if (jsonString != null) {
      cart.addAll(cartItemModelListFromLocalJson(jsonString));
    }
    if (!cart.any((element) =>
        element.product.id == cartItem.product.id &&
        element.priceTag.id == cartItem.priceTag.id)) {
      cart.add(cartItem);
    }
    return sharedPreferences.setString(
      cachedCart,
      cartItemModelToJson(cart),
    );
  }

  @override
  Future<List<CartItemModel>> getCart() {
    final jsonString = sharedPreferences.getString(cachedCart);
    if (jsonString != null) {
      return Future.value(
        cartItemModelListFromLocalJson(jsonString),
      );
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<bool> clearCart() async {
    return sharedPreferences.remove(cachedCart);
  }
}
