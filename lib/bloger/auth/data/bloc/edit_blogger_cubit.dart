import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/editBloggerRepo.dart';
import 'edit_blogger_statet.dart';

class EditBloggerCubit extends Cubit<EditBloggerState> {
  final EditBloggerRepository editBloggerRepository;

  EditBloggerCubit({required this.editBloggerRepository}) : super(InitState());

  Future<void> edit(String? name, String? nick, String phone, String? password,
      String? iin, avatar) async {
    try {
      emit(LoadingState());
      final data = await editBloggerRepository.edit(
          name, nick, phone, password, iin, avatar);

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
}
