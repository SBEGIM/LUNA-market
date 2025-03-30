import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_shop_products_state.dart';
import '../data/models/blogger_shop_products_model.dart';
import '../data/repository/blogger_shop_products_repo.dart';

class BloggerShopProductsCubit extends Cubit<BloggerShopProductsState> {
  final BloggerShopProductsRepository bloggerShopProductsRepository;

  BloggerShopProductsCubit({required this.bloggerShopProductsRepository})
      : super(InitState());

  int page = 1;

  List<BloggerShopProductModel> array = [];

  Future<void> products(String? name, int shopId) async {
    try {
      emit(LoadingState());
      page = 1;

      final List<BloggerShopProductModel> data =
          await bloggerShopProductsRepository.products(name, shopId, page);
      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> productsPagination(String? name, int? shopId) async {
    try {
      // emit(LoadingState());
      final data =
          await bloggerShopProductsRepository.products(name, shopId, page);

      // for (int i = 0; i < data.length; i++) {
      //   array.add(data[i]);
      // }
      if (data.isNotEmpty) {
        page++;
      }

      array += data;
      emit(LoadedState(array));
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
