import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_month_statics_blogger_state.dart';

import '../data/model/profile_month_blogger_statics.dart';
import '../data/repository/profile_month_statics_blogger_repo.dart';

class ProfileMonthStaticsBloggerCubit extends Cubit<ProfileMonthStaticsBloggerState> {
  final ProfileMonthStaticsBloggerRepository profileMonthStaticsBloggerRepository;

  ProfileMonthStaticsBloggerCubit({required this.profileMonthStaticsBloggerRepository})
    : super(InitState());

  Future<void> statics(int month, int year) async {
    try {
      emit(LoadingState());
      final List<ProfileMonthStatics> data = await profileMonthStaticsBloggerRepository.statics(
        month,
        year,
      );

      // if (data != null) {
      emit(LoadedState(loadedProfile: data));
      // }
      // if (data == 400) {
      //   emit(InitState());
      //   Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
      //       backgroundColor: Colors.redAccent);
      // }
      // if (data == 500) {
      //   emit(InitState());
      //   Get.snackbar('500', 'Ошибка сервера',
      //       backgroundColor: Colors.redAccent);
      // }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
