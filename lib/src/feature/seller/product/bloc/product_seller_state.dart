import '../data/models/product_seller_model.dart';

abstract class ProductAdminState {}

class InitState extends ProductAdminState {}

class LoadingState extends ProductAdminState {}

class ChangeState extends ProductAdminState {}

class StoreState extends ProductAdminState {}

class LoadedState extends ProductAdminState {
  List<ProductSellerModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends ProductAdminState {
  String message;

  ErrorState({required this.message});
}
