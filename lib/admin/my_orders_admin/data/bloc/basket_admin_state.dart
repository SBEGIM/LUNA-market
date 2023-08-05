import '../../../../features/basket/data/models/basket_show_model.dart';
import '../models/basket_admin_order_model.dart';

abstract class BasketAdminState {}

class InitState extends BasketAdminState {}

class LoadingState extends BasketAdminState {}

class OrderState extends BasketAdminState {}

class LoadedState extends BasketAdminState {
  List<BasketShowModel> basketShowModel;
  LoadedState(this.basketShowModel);
}

class LoadedOrderState extends BasketAdminState {
  List<BasketAdminOrderModel> basketOrderModel;
  LoadedOrderState(this.basketOrderModel);
}

class LoadedOrderRealFbsState extends BasketAdminState {
  List<BasketAdminOrderModel> basketOrderModel;
  LoadedOrderRealFbsState(this.basketOrderModel);
}

class LoadedOrderEndState extends BasketAdminState {
  List<BasketAdminOrderModel> basketOrderModel;
  LoadedOrderEndState(this.basketOrderModel);
}

class ErrorState extends BasketAdminState {
  String message;
  ErrorState({required this.message});
}
