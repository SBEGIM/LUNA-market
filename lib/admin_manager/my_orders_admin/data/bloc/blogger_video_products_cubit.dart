import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/bloger/my_orders_admin/data/bloc/blogger_video_products_state.dart';

import '../../../../bloger/my_orders_admin/data/repository/blogger_video_products_repo.dart';
import '../../../../bloger/my_products_admin/data/models/blogger_shop_products_model.dart';

class BloggerVideoProductsCubit extends Cubit<BloggerVideoProductsState> {
  final BloggerVideoProductsRepository bloggerShopProductsRepository;

  BloggerVideoProductsCubit({required this.bloggerShopProductsRepository}) : super(InitState());

  Future<void> products(String? name, int shopId) async {
    try {
      emit(LoadingState());
      final List<BloggerShopProductModel> data = await bloggerShopProductsRepository.products(name, shopId);

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
