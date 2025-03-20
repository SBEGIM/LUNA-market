import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/bloger/auth/data/bloc/login_blogger_state.dart';
import '../DTO/register_blogger_dto.dart';
import '../repository/login_blogger_repo.dart';

class LoginBloggerCubit extends Cubit<LoginBloggerState> {
  final LoginBloggerRepository loginBloggerRepository;

  LoginBloggerCubit({required this.loginBloggerRepository})
      : super(InitState());

  Future<void> login(String phone, String password) async {
    try {
      emit(LoadingState());
      final data = await loginBloggerRepository.login(phone, password);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
            backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(InitState());
        Get.snackbar('500', 'Ошибка сервера',
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<int?> register(RegisterBloggerDTO register) async {
    try {
      emit(LoadingState());
      final data = await loginBloggerRepository.register(register);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Телефон или никнейм занято',
            backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(InitState());
        Get.snackbar('500', 'Ошибка сервера',
            backgroundColor: Colors.redAccent);
      }

      return data;
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
