part of 'order_add_cubit.dart';

abstract class OrderAddState {}

class OrderAddIntial extends OrderAddState {}

class OrderAddLoading extends OrderAddState {}

class OrderAddSuccess extends OrderAddState {
  OrderAddSuccess(this.order);
  final OrderDetails order;
}

class OrderAddFail extends OrderAddState {}
