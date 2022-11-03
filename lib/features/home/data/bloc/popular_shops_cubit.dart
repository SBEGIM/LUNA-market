import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/home/data/bloc/popular_shops_state.dart';
import 'package:haji_market/features/home/data/model/PopularShops.dart';
import 'package:haji_market/features/home/data/repository/Popular_shops_repo.dart';


class PopularShopsCubit extends Cubit<PopularShopsState> {
  final PopularShopsRepository popularShopsRepository;

  PopularShopsCubit({required this.popularShopsRepository}) : super(InitState());

  Future<void> popShops() async {
    try {
      emit(LoadingState());
      final List<PopularShops> data = await popularShopsRepository.popularShops();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
