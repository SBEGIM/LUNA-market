

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/product_state.dart';

import '../models/product_model.dart';
import '../repository/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository}) : super(InitState());

  Future<void> products() async {
    try {
      emit(LoadingState());
      final List<ProductModel> data = await productRepository.product();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
