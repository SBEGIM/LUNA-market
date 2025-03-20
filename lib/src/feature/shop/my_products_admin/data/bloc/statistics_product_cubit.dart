import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/data/bloc/statistics_product_state.dart';
import '../models/admin_statistics_product.dart';
import '../repository/StatisticsProductAdminRepo.dart';

class StatisticsProductCubit extends Cubit<StatisticsProductState> {
  final StatisticsProductAdminRepository statisticsProductAdminRepo;

  StatisticsProductCubit({required this.statisticsProductAdminRepo})
      : super(InitState());

  Future statistics(product_id, year, month) async {
    try {
      emit(LoadingState());
      final StatisticsProductAdmin data =
          await statisticsProductAdminRepo.get(product_id, year, month);
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
