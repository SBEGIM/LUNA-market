import '../models/basket_admin_order_model.dart';

abstract class BasketAdminState {}

class InitState extends BasketAdminState {}

class LoadingState extends BasketAdminState {}

class OrderState extends BasketAdminState {}

class LoadedState extends BasketAdminState {
  List<BasketAdminOrderModel> basketOrderModel;
  List<BasketAdminOrderModel> basketOrderRealFbsModel;
  List<BasketAdminOrderModel> basketEndOrderModel;
  LoadedState(this.basketOrderModel, this.basketOrderRealFbsModel, this.basketEndOrderModel);
}

// class LoadedOrderState extends BasketAdminState {
//   List<BasketAdminOrderModel> basketOrderModel;
//   LoadedOrderState(this.basketOrderModel);
// }

// class LoadedOrderRealFbsState extends BasketAdminState {
//   List<BasketAdminOrderModel> basketOrderRealFbsModel;
//   LoadedOrderRealFbsState(this.basketOrderRealFbsModel);
// }

// class LoadedOrderEndState extends BasketAdminState {
//   List<BasketAdminOrderModel> basketOrderModel;
//   LoadedOrderEndState(this.basketOrderModel);
// }

class ErrorState extends BasketAdminState {
  String message;
  ErrorState({required this.message});
}
