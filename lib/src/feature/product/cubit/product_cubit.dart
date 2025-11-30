import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/product/cubit/product_state.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';

import '../data/model/product_model.dart';
import '../data/repository/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository}) : super(InitState());
  int page = 1;
  List<ProductModel> _products = [];

  Future<void> products(FilterProvider filter) async {
    try {
      page = 1;
      emit(LoadingState());
      final List<ProductModel> data = await productRepository.product(filter, page);
      _products.clear();
      _products.addAll(data);

      emit(LoadedState(data));
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> productsPagination(FilterProvider filter) async {
    try {
      // emit(LoadingState());
      page++;
      final List<ProductModel> data = await productRepository.product(filter, page);

      for (int i = 0; i < data.length; i++) {
        _products.add(data[i]);
      }

      emit(LoadedState(_products));
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> productsMbInteresting(FilterProvider filter) async {
    try {
      emit(LoadingState());
      final List<ProductModel> data = await productRepository.product(filter, page);
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void updateProductByIndex({required int index, required ProductModel updatedProduct}) {
    if (index < _products.length) {
      _products[index] = updatedProduct;
      emit(LoadedState(_products));
    }
  }
}
