import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/login_blogger_state.dart';
import '../data/DTO/blogger_dto.dart';
import '../data/repository/login_blogger_repo.dart';

class LoginBloggerCubit extends Cubit<LoginBloggerState> {
  final LoginBloggerRepository loginBloggerRepository;

  LoginBloggerCubit({required this.loginBloggerRepository})
      : super(InitState());

  Future<void> login(
      BuildContext context, String phone, String password) async {
    try {
      emit(LoadingState());
      final data = await loginBloggerRepository.login(phone, password);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        AppSnackBar.show(
          context,
          'Неверный номер телефона или пароль',
          type: AppSnackType.error,
        );
      }
      if (data == 500) {
        emit(InitState());

        AppSnackBar.show(
          context,
          'Ошибка сервера',
          type: AppSnackType.error,
        );

        // Get.snackbar('500', 'Ошибка сервера',
        //     backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<int?> register(BuildContext context, BloggerDTO register) async {
    try {
      emit(LoadingState());
      final data = await loginBloggerRepository.register(register);

      if (data == 200) {
        // emit(LoadedState());
        emit(InitState());
        return 200;
      }
      if (data == 400) {
        emit(InitState());
        AppSnackBar.show(
          context,
          'Телефон или Никнейм занято',
          type: AppSnackType.error,
        );
        return 400;
      }
      if (data == 500) {
        emit(InitState());
        AppSnackBar.show(
          context,
          'Ошибка сервера',
          type: AppSnackType.error,
        );
        return 500;
      }

      return data;
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
