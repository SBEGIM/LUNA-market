import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../data/repository/blogger_tape_upload_repo.dart';
import 'blogger_tape_upload_state.dart';

class BloggerTapeUploadCubit extends Cubit<BloggerTapeUploadState> {
  final BloggerTapeUploadRepository bloggerTapeUploadRepository;

  BloggerTapeUploadCubit({required this.bloggerTapeUploadRepository})
      : super(InitState());

  Future<void> uploadVideo(String product_id, video) async {
    try {
      emit(LoadingState());
      final data =
          await bloggerTapeUploadRepository.uploadVideo(product_id, video);
      emit(LoadedState());
      emit(InitState());
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
