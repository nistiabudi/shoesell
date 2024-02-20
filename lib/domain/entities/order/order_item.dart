import 'package:equatable/equatable.dart';
import 'package:eshoes_clean_arch/domain/entities/product/price_tag.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product.dart';

class OrderItem extends Equatable {
  const OrderItem(
      {required this.id,
      required this.product,
      required this.priceTag,
      required this.price,
      required this.quantity});
  final String id;
  final Product product;
  final PriceTag priceTag;
  final num price;
  final num quantity;

  @override
  List<Object?> get props => [
        id,
      ];
}
