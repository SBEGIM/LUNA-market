import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_edit_admin_state.dart';
import '../repository/profile_edit_admin_repo.dart';

class ProfileEditAdminCubit extends Cubit<ProfileEditAdminState> {
  final ProfileEditAdminRepository profileEditAdminRepository;

  ProfileEditAdminCubit({required this.profileEditAdminRepository})
      : super(InitState());

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
    bool? typeOrganization,
    String? address,
    String? kpp,
    String? ogrn,
    String? okved,
    String? tax_authority,
    String? date_register,
    String? legal_address,
    String? founder,
    String? date_of_birth,
    String? citizenship,
    String? CEO,
    String? organization_fr,
    String? bank,
    String? company_name,
  ) async {
    try {
      //  emit(LoadingState());
      String repPhone = '';

      if (phone != '') {
        if (phone != null) {
          String subPhone = phone.substring(2);
          repPhone = subPhone.replaceAll(RegExp('[^0-9]'), '');
        }
      }

      await profileEditAdminRepository.edit(
          name,
          repPhone,
          logo,
          password_new,
          password_old,
          country,
          city,
          home,
          street,
          shopName,
          iin,
          check,
          email,
          card,
          typeOrganization,
          address,
          kpp,
          ogrn,
          okved,
          tax_authority,
          date_register,
          legal_address,
          founder,
          date_of_birth,
          citizenship,
          CEO,
          organization_fr,
          bank,
          company_name);

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
