import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/bloger/my_products_admin/data/bloc/blogger_shop_products_state.dart';
import '../models/blogger_shop_products_model.dart';
import '../repository/blogger_shop_products_repo.dart';

class BloggerShopProductsCubit extends Cubit<BloggerShopProductsState> {
  final BloggerShopProductsRepository bloggerShopProductsRepository;

  BloggerShopProductsCubit({required this.bloggerShopProductsRepository})
      : super(InitState());

  Future<void> products(String? name, int shop_id) async {
    try {
      emit(LoadingState());
      final List<BloggerShopProductModel> data =
          await bloggerShopProductsRepository.products(name, shop_id);

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
