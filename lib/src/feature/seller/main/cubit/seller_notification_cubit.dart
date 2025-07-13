import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/main/cubit/seller_notification_state.dart';
import 'package:haji_market/src/feature/seller/main/data/model/notification_seller_model.dart';
import 'package:haji_market/src/feature/seller/main/data/repository/seller_notification_repo.dart';

class SellerNotificationCubit extends Cubit<SellerNotificationState> {
  final SellerrNotificationRepository sellerrNotificationRepository;

  SellerNotificationCubit({required this.sellerrNotificationRepository})
      : super(InitState());

  List<NotificationSellerModel> list = [];

  Future<void> notifications() async {
    try {
      list.clear();
      emit(LoadingState());
      final List<NotificationSellerModel> data =
          await sellerrNotificationRepository.notifications();

      list.addAll(data);
      emit(LoadedState(list));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> read(int id) async {
    try {
      sellerrNotificationRepository.read(id);

      final updatedNotifications = list.map((n) {
        if (n.id == id) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      list = updatedNotifications;
      emit(LoadedState(list));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<int> count() async {
    try {
      final int count = await sellerrNotificationRepository.count();
      return count;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
