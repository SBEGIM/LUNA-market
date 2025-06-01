import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_notification_state.dart';
import 'package:haji_market/src/feature/bloger/shop/data/models/blogger_notification_model.dart';
import 'package:haji_market/src/feature/bloger/shop/data/repository/blogger_notification_repo.dart';

class BloggerNotificationCubit extends Cubit<BloggerNotificationState> {
  final BloggerNotificationRepository bloggerNotificationRepository;

  BloggerNotificationCubit({required this.bloggerNotificationRepository})
      : super(InitState());

  Future<void> notifications() async {
    try {
      emit(LoadingState());
      final List<BloggerNotificationModel> data =
          await bloggerNotificationRepository.notifications();
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
