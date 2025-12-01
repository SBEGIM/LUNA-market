import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/login_seller_state.dart';
import '../data/repository/login_seller_repository.dart';

class LoginSellerCubit extends Cubit<LoginSellerState> {
  final LoginSellerRepository loginAdminRepository;

  LoginSellerCubit({required this.loginAdminRepository}) : super(InitState());

  Future<void> login(BuildContext context, String phone, String password) async {
    try {
      emit(LoadingState());
      final data = await loginAdminRepository.login(phone, password);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());

        AppSnackBar.show(context, 'Неверный телефон или пароль', type: AppSnackType.error);
      }
      if (data == 500) {
        emit(InitState());

        AppSnackBar.show(context, 'Ошибка сервера', type: AppSnackType.error);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
