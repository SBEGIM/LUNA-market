import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/bloger/profile_admin/presentation/data/bloc/profile_month_statics_blogger_state.dart';

import '../model/profile_month_blogger_statics.dart';
import '../repository/profile_month_statics_blogger_repo.dart';

class ProfileMonthStaticsBloggerCubit
    extends Cubit<ProfileMonthStaticsBloggerState> {
  final ProfileMonthStaticsBloggerRepository
      profileMonthStaticsBloggerRepository;

  ProfileMonthStaticsBloggerCubit(
      {required this.profileMonthStaticsBloggerRepository})
      : super(InitState());

  Future<void> statics() async {
    try {
      emit(LoadingState());
      final List<ProfileMonthStatics> data =
          await profileMonthStaticsBloggerRepository.statics();

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
