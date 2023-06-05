import 'package:haji_market/features/drawer/data/models/product_model.dart';

abstract class ProductState {}

class InitState extends ProductState {}

class LoadingState extends ProductState {}

class LoadedState extends ProductState {
  List<ProductModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends ProductState {
  String message;
  ErrorState({required this.message});
}
