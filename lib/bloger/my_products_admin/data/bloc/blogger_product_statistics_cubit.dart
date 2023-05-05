import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/bloger/my_products_admin/data/bloc/blogger_product_statistics_state.dart';
import 'package:haji_market/bloger/my_products_admin/data/models/blogger_product_statistics_model.dart';
import '../repository/blogger_products_statistics_repo.dart';

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

      print('success');
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
