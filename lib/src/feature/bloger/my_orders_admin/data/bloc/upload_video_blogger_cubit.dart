import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/bloger/my_orders_admin/data/bloc/upload_video_blogger_state.dart';

import '../repository/upload_video_blogger_repo.dart';

class UploadVideoBLoggerCubit extends Cubit<UploadVideoBloggerCubitState> {
  final UploadVideoBloggerCubitRepository uploadVideoBloggerCubitRepository;

  UploadVideoBLoggerCubit({required this.uploadVideoBloggerCubitRepository})
      : super(InitState());

  Future<void> upload(video, productId) async {
    try {
      emit(LoadingState());
      final data =
          await uploadVideoBloggerCubitRepository.upload(video, productId);
      if (data == 200) {
        emit(LoadedOrderState());
      } else {
        emit(ErrorState(message: 'Ошибка загрузки'));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> delete({
    required int tapeId,
  }) async {
    try {
      emit(LoadingState());
      final data = await uploadVideoBloggerCubitRepository.deleteVideo(
        tapeId: tapeId,
      );
      if (data == 200) {
        emit(LoadedOrderState());
      } else {
        emit(ErrorState(message: 'Ошибка загрузки'));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
