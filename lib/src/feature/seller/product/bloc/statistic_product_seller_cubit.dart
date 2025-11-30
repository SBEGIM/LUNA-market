import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/product/bloc/statistic_product_seller_state.dart';
import 'package:haji_market/src/feature/seller/product/data/models/statistic_product_seller_model.dart';
import '../data/repository/statistic_product_seller_repository.dart';

class StatisticsProductSellerCubit extends Cubit<StatisticProductSellerState> {
  final StatisticsProductAdminRepository statisticsProductAdminRepo;

  StatisticsProductSellerCubit({required this.statisticsProductAdminRepo}) : super(InitState());

  Future statistics(product_id, year, month) async {
    try {
      emit(LoadingState());
      final StatisticProductSellerModel data = await statisticsProductAdminRepo.get(
        product_id,
        year,
        month,
      );
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
