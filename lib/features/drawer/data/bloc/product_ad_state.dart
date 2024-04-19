import 'package:haji_market/features/drawer/data/models/product_model.dart';

abstract class ProductAdState {}

class InitState extends ProductAdState {}

class LoadingState extends ProductAdState {}

class NoDataState extends ProductAdState {}

class LoadedState extends ProductAdState {
  List<ProductModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends ProductAdState {
  String message;
  ErrorState({required this.message});
}
