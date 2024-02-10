import 'package:equatable/equatable.dart';
import '../product/price_tag.dart';
import '../product/product.dart';

class CartItem extends Equatable {
  const CartItem({required this.product, required this.priceTag, this.id});
  final String? id;
  final Product product;
  final PriceTag priceTag;

  @override
  List<Object?> get props => [
        id,
      ];
}
