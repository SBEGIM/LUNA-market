import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/product/cubit/product_ad_state.dart';
import 'package:haji_market/src/feature/product/data/repository/product_ad_repo.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import '../data/model/product_model.dart';

class ProductAdCubit extends Cubit<ProductAdState> {
  final ProductAdRepository productAdRepository;

  ProductAdCubit({required this.productAdRepository}) : super(InitState());

  Future<void> adProducts(FilterProvider filters) async {
    try {
      emit(LoadingState());
      final List<ProductModel> data =
          await productAdRepository.product(filters);

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
