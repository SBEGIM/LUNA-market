import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_product_statistics_state.dart';
import 'package:haji_market/src/feature/bloger/shop/data/models/blogger_product_statistics_model.dart';
import '../data/repository/blogger_products_statistics_repo.dart';

class BloggerProductStatisticsCubit
    extends Cubit<BloggerProductStatisticsState> {
  final BloggerProductsStatisticsRepository bloggerProductStatisticsRepository;

  BloggerProductStatisticsCubit(
      {required this.bloggerProductStatisticsRepository})
      : super(InitState());

  Future<void> statistics() async {
    try {
      emit(LoadingState());
      final BloggerProductStatisticsModel data =
          await bloggerProductStatisticsRepository.statistics();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
