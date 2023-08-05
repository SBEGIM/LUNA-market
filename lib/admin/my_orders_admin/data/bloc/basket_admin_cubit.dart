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
          await basketRepository.basketOrderShow(fulfillment);
      if (fulfillment == 'fbs') {
        activeOrders.clear();
        activeOrders.addAll(data);
      } else if (fulfillment == 'realFBS') {
        print('realFBS');
        activeOrdersRealFBS.clear();
        activeOrdersRealFBS.addAll(data);
      }

      emit(LoadedOrderState(activeOrders));
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
        print('qwewqeqweq');
        emit(LoadingState());
        print(activeOrdersRealFBS.length);
        if (activeOrdersRealFBS.length == 0) {
          print('weweq');
          await basketOrderShow('realFBS');
        }
        emit(LoadedOrderState(activeOrdersRealFBS));
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
