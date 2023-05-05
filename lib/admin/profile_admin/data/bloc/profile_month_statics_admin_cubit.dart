import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/admin/profile_admin/data/bloc/profile_month_statics_admin_state.dart';
import 'package:haji_market/admin/profile_admin/data/repository/profile_month_statics_admin_repo.dart';

import '../model/profile_month_admin_statics.dart';

class ProfileMonthStaticsAdminCubit
    extends Cubit<ProfileMonthStaticsAdminState> {
  final ProfileMonthStaticsAdminRepository profileMonthStaticsBloggerRepository;

  ProfileMonthStaticsAdminCubit(
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
