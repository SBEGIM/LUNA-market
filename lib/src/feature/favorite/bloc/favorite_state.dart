import 'package:haji_market/src/feature/product/data/model/product_model.dart';

abstract class FavoriteState {}

class InitState extends FavoriteState {}

class LoadingState extends FavoriteState {}

class NoDataState extends FavoriteState {}

class LoadedState extends FavoriteState {
  List<ProductModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends FavoriteState {
  String message;
  ErrorState({required this.message});
}
