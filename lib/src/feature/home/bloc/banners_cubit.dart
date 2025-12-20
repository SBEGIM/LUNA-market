import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/home/data/model/banner_model.dart';
import 'package:haji_market/src/feature/home/data/repository/banner_repository.dart';
import 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  final IBannersRepository bannersRepository;

  BannersCubit({required this.bannersRepository}) : super(BannerStateInitial());

  Future<void> banners() async {
    try {
      emit(BannersStateLoading());
      final List<BannerModel> data = await bannersRepository.getBanners();

      emit(BannersStateLoaded(data));
    } catch (e) {
      log(e.toString());
      emit(BannersStateError(message: 'Ошибка сервера'));
    }
  }
}
