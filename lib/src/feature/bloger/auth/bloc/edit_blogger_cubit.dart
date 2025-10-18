import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/auth/data/DTO/blogger_dto.dart';
import '../data/repository/edit_blogger_repo.dart';
import 'edit_blogger_statet.dart';

class EditBloggerCubit extends Cubit<EditBloggerState> {
  final EditBloggerRepository editBloggerRepository;

  EditBloggerCubit({required this.editBloggerRepository}) : super(InitState());

  Future<void> edit(BuildContext context, BloggerDTO dto) async {
    try {
      emit(LoadingState());
      final data = await editBloggerRepository.edit(dto);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());

        AppSnackBar.show(
          context,
          'Телефон или никнейм занято',
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
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
