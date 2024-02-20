part of 'delivery_info_action_cubit.dart';

@immutable
abstract class DeliveryInfoActionState {}

class DeliveryInfoActionInitial extends DeliveryInfoActionState {}

class DeliveryInfoActionLoading extends DeliveryInfoActionState {}

class DeliveryInfoAddActionSuccess extends DeliveryInfoActionState {
  DeliveryInfoAddActionSuccess(this.deliveryInfo);
  final DeliveryInfo deliveryInfo;
}

class DeliveryInfoEditActionSuccess extends DeliveryInfoActionState {
  DeliveryInfoEditActionSuccess(this.deliveryInfo);
  final DeliveryInfo deliveryInfo;
}

class DeliveryInfoSelectActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoSelectActionSuccess(this.deliveryInfo);
}

class DeliveryInfoActionFail extends DeliveryInfoActionState {}
