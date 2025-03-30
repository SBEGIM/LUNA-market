import '../data/models/blogger_shop_products_model.dart';

abstract class BloggerShopProductsState {}

class InitState extends BloggerShopProductsState {}

class LoadingState extends BloggerShopProductsState {}

class ChangeState extends BloggerShopProductsState {}

class NoDataState extends BloggerShopProductsState {}

class LoadedState extends BloggerShopProductsState {
  List<BloggerShopProductModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends BloggerShopProductsState {
  String message;

  ErrorState({required this.message});
}
