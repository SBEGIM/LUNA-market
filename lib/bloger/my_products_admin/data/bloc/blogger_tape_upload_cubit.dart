import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/bloger/my_products_admin/data/bloc/blogger_product_statistics_state.dart';
import 'package:haji_market/bloger/my_products_admin/data/models/blogger_product_statistics_model.dart';
import '../repository/blogger_products_statistics_repo.dart';
import '../repository/blogger_tape_upload_repo.dart';

class BloggerTapeUploadCubit extends Cubit<BloggerProductStatisticsState> {
  final BloggerTapeUploadRepository bloggerTapeUploadRepository;

  BloggerTapeUploadCubit({required this.bloggerTapeUploadRepository})
      : super(InitState());

  Future<void> uploadVideo(String product_id, video) async {
    try {
      emit(LoadingState());
      final data =
          await bloggerTapeUploadRepository.uploadVideo(product_id, video);

      print('success');
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
