import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/admin/profile_admin/data/bloc/profile_edit_admin_state.dart';
import 'package:haji_market/admin/profile_admin/data/model/profile_statics_admin_model.dart';

import '../repository/profile_edit_admin_repo.dart';

class ProfileEditAdminCubit extends Cubit<ProfileEditAdminState> {
  final ProfileEditAdminRepository profileEditAdminRepository;

  ProfileEditAdminCubit({required this.profileEditAdminRepository}) : super(InitState());

  Future<void> edit(
    String? name,
    String? phone,
    String? logo,
    String? password_new,
    String? password_old,
    String? country,
    String? city,
    String? home,
    String? street,
    String? shopName,
    String? iin,
    String? check,
    String? email,
    String? card,
  ) async {
    try {
      //  emit(LoadingState());
      await profileEditAdminRepository.edit(name, phone, logo, password_new, password_old, country, city, home, street,
          shopName, iin, check, email, card);

      // if (data != null) {
      //  emit(LoadedState(loadedProfile: data));
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

  Future<void> cityCode(
    int? code,
  ) async {
    try {
      //  emit(LoadingState());
      await profileEditAdminRepository.code(code);

      // if (data != null) {
      //  emit(LoadedState(loadedProfile: data));
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
