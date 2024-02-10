import 'package:eshoes_clean_arch/data/models/product/price_tag_model.dart';
import 'package:eshoes_clean_arch/data/models/product/product_model.dart';
import 'package:eshoes_clean_arch/domain/entities/order/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required String id,
    required ProductModel product,
    required PriceTagModel priceTag,
    required num price,
    required num quantity,
  }) : super(
          id: id,
          product: product,
          price: price,
          priceTag: priceTag,
          quantity: quantity,
        );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": (product as ProductModel).toJson(),
        "priceTag": (priceTag as PriceTagModel).toJson(),
        "price": priceTag,
        "quantity": quantity,
      };

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
      id: json["id"],
      product: ProductModel.fromJson(json["product"]),
      priceTag: PriceTagModel.fromJson(json["priceTag"]),
      price: json["price"],
      quantity: json["quantity"]);

  Map<String, dynamic> toJsonBody() => {
        "_id": id,
        "product": product.id,
        "priceTag": priceTag.id,
        "price": price,
        "quantity": quantity,
      };

  factory OrderItemModel.formEntity(OrderItem entity) => OrderItemModel(
      id: entity.id,
      product: ProductModel.formEntity(entity.product),
      priceTag: PriceTagModel.formEntity(entity.priceTag),
      price: entity.price,
      quantity: entity.quantity);
}
