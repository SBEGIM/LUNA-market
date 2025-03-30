import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_statics_admin_state.dart';
import 'package:haji_market/src/feature/seller/profile/data/model/profile_statics_admin_model.dart';

import '../repository/profile_statics_admin_repo.dart';

class ProfileStaticsAdminCubit extends Cubit<ProfileStaticsAdminState> {
  final ProfileStaticsAdminRepository profileStaticsBloggerRepository;

  ProfileStaticsAdminCubit({required this.profileStaticsBloggerRepository})
      : super(InitState());

  Future<void> statics() async {
    try {
      emit(LoadingState());
      final ProfileStaticsAdminModel data =
          await profileStaticsBloggerRepository.statics();

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
