import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/product_ad_state.dart';
import 'package:haji_market/features/drawer/data/repository/product_ad_repo.dart';

import '../models/product_model.dart';
import '../repository/product_repo.dart';

class ProductAdCubit extends Cubit<ProductAdState> {
  final ProductAdRepository productAdRepository;

  ProductAdCubit({required this.productAdRepository}) : super(InitState());

  Future<void> adProducts(int? catId) async {
    try {
      emit(LoadingState());
      final List<ProductModel> data = await productAdRepository.product(catId);

      if (data.isNotEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString() + 'ProductAdCubit products');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
