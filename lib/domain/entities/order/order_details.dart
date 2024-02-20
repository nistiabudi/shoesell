import 'package:equatable/equatable.dart';
import 'package:eshoes_clean_arch/domain/entities/order/order_item.dart';
import 'package:eshoes_clean_arch/domain/entities/user/delivery_info.dart';

class OrderDetails extends Equatable {
  const OrderDetails(
      {required this.id,
      required this.orderItems,
      required this.deliveryInfo,
      required this.discount});
  final String id;
  final List<OrderItem> orderItems;
  final DeliveryInfo deliveryInfo;
  final num discount;

  @override
  List<Object?> get props => [
        id,
      ];
}
