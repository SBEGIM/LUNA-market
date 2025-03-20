import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_show_model.dart';

abstract class BasketState {}

class InitState extends BasketState {}

class LoadingState extends BasketState {}

class OrderState extends BasketState {}

class NoDataState extends BasketState {}

class LoadedState extends BasketState {
  List<BasketShowModel> basketShowModel;
  LoadedState(this.basketShowModel);
}

class LoadedOrderState extends BasketState {
  List<BasketOrderModel> basketOrderModel;
  LoadedOrderState(this.basketOrderModel);
}

class ErrorState extends BasketState {
  String message;
  ErrorState({required this.message});
}
