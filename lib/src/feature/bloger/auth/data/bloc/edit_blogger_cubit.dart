import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/edit_blogger_repo.dart';
import 'edit_blogger_statet.dart';

class EditBloggerCubit extends Cubit<EditBloggerState> {
  final EditBloggerRepository editBloggerRepository;

  EditBloggerCubit({required this.editBloggerRepository}) : super(InitState());

  Future<void> edit(
      String? name,
      String? nick,
      String phone,
      String? password,
      String? check,
      String? iin,
      avatar,
      String? card,
      String? email,
      String? socialNetwork) async {
    try {
      emit(LoadingState());
      final data = await editBloggerRepository.edit(name, nick, phone, password,
          iin, check, avatar, card, email, socialNetwork);

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
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
