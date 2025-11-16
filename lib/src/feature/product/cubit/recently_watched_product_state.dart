import 'package:haji_market/src/feature/product/data/model/product_model.dart';

abstract class RecentlyWatchedProductState {}

class InitState extends RecentlyWatchedProductState {}

class LoadingState extends RecentlyWatchedProductState {}

class NoDataState extends RecentlyWatchedProductState {}

class LoadedState extends RecentlyWatchedProductState {
  List<ProductModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends RecentlyWatchedProductState {
  String message;
  ErrorState({required this.message});
}
