import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/main/cubit/news_seller_state.dart';
import 'package:haji_market/src/feature/seller/main/data/model/news_seeler_model.dart';
import 'package:haji_market/src/feature/seller/main/data/repository/news_repository.dart';

class NewsSellerCubit extends Cubit<NewsSellerState> {
  final NewsSellerRepository newsSellerRepository;

  NewsSellerCubit({required this.newsSellerRepository}) : super(InitState());

  Future<void> news() async {
    try {
      emit(LoadingState());
      final List<NewsSeelerModel> data = await newsSellerRepository.news();
      emit(LoadedState(newsSeelerModel: data));
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  like(int id) async {
    try {
      await newsSellerRepository.like(id);

      news();
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  view(int id) async {
    try {
      await newsSellerRepository.view(id);
      news();
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
