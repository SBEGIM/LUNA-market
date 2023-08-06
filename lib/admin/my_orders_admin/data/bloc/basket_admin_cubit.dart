import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../models/basket_admin_order_model.dart';
import '../repository/basket_admin_repo.dart';
import 'basket_admin_state.dart';

class BasketAdminCubit extends Cubit<BasketAdminState> {
  final BasketAdminRepository basketRepository;

  BasketAdminCubit({required this.basketRepository}) : super(InitState());

  List<BasketAdminOrderModel> activeOrders = [];
  List<BasketAdminOrderModel> activeOrdersRealFBS = [];
  List<BasketAdminOrderModel> endOrders = [];

  Future<void> basketOrderShow(fulfillment) async {
    try {
      emit(LoadingState());
      final List<BasketAdminOrderModel> data =
          await basketRepository.basketOrderShow('fbs');
      activeOrders.clear();
      activeOrders.addAll(data);
      emit(LoadedOrderState(activeOrders));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketOrderRealFBSshow(fulfillment) async {
    try {
      emit(LoadingState());

      final List<BasketAdminOrderModel> data =
          await basketRepository.basketOrderRealFbsShow('realFBS');
      activeOrdersRealFBS.clear();
      activeOrdersRealFBS.addAll(data);

      print("data lenth ${activeOrdersRealFBS.length}");
      emit(LoadedOrderRealFbsState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketOrderEndShow() async {
    try {
      emit(LoadingState());
      final List<BasketAdminOrderModel> data =
          await basketRepository.basketOrderEndShow();

      endOrders.clear();
      endOrders.addAll(data);

      emit(LoadedOrderEndState(endOrders));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketSwitchState(int value) async {
    try {
      if (value == 0) {
        emit(LoadingState());
        emit(LoadedOrderState(activeOrders));
      } else if (value == 1) {
        emit(LoadingState());
        print(activeOrdersRealFBS.length);
        emit(LoadedOrderRealFbsState(activeOrdersRealFBS));
      } else {
        emit(LoadedOrderEndState(endOrders));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка state'));
    }
  }

  Future<void> basketStatus(String status, String id, productId) async {
    try {
      await basketRepository.basketStatus(status, id, productId);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
