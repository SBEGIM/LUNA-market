import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_state.dart';
import 'package:haji_market/src/feature/seller/main/data/model/stories_seller_model.dart';
import 'package:haji_market/src/feature/seller/main/data/repository/stories_repository.dart';

class StoriesSellerCubit extends Cubit<StoriesSellerState> {
  final StoriesSellerRepository storesSellerRepository;

  StoriesSellerCubit({required this.storesSellerRepository})
      : super(InitState());

  Future<void> news() async {
    try {
      emit(LoadingState());
      final List<SellerStoriesModel> data = await storesSellerRepository.news();
      emit(LoadedState(storiesSeelerModel: data));
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
