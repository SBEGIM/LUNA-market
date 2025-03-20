import '../../../my_products_admin/data/models/blogger_shop_products_model.dart';

abstract class BloggerVideoProductsState {}

class InitState extends BloggerVideoProductsState {}

class LoadingState extends BloggerVideoProductsState {}

class ChangeState extends BloggerVideoProductsState {}

class LoadedState extends BloggerVideoProductsState {
  List<BloggerShopProductModel> productModel;
  LoadedState(this.productModel);
}

class ErrorState extends BloggerVideoProductsState {
  String message;

  ErrorState({required this.message});
}
