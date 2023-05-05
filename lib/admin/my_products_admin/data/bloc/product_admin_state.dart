import '../models/admin_products_model.dart';

abstract class ProductAdminState {}

class InitState extends ProductAdminState {}

class LoadingState extends ProductAdminState {}

class ChangeState extends ProductAdminState {}

class LoadedState extends ProductAdminState {
  List<AdminProductsModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends ProductAdminState {
  String message;

  ErrorState({required this.message});
}
