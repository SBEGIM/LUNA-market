import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/product/cubit/recently_watched_product_state.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/data/repository/recently%20watched_repo.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';

class RecentlyWatchedProductCubit extends Cubit<RecentlyWatchedProductState> {
  final RecentlyWatchedRepository productRepository;

  RecentlyWatchedProductCubit({required this.productRepository}) : super(InitState());

  Future<void> products(FilterProvider filter) async {
    try {
      emit(LoadingState());
      final List<ProductModel> data = await productRepository.product(filter);

      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log('${e}ProductAdCubit products');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
