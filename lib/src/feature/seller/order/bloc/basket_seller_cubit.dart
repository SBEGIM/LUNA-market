import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../data/models/basket_order_seller_model.dart';
import '../data/repository/basket_seller_repository.dart';
import 'basket_seller_state.dart';

class BasketSellerCubit extends Cubit<BasketAdminState> {
  final BasketSellerRepository basketRepository;

  BasketSellerCubit({required this.basketRepository}) : super(InitState());

  List<BasketOrderSellerModel> activeOrders = [];
  List<BasketOrderSellerModel> activeOrdersRealFBS = [];
  List<BasketOrderSellerModel> endOrders = [];

  Future<void> basketOrderShow(status) async {
    try {
      emit(LoadingState());
      final List<BasketOrderSellerModel> data = await basketRepository.basketOrderShow(status);
      activeOrders.clear();
      activeOrders.addAll(data);
      emit(LoadedState(activeOrders, activeOrdersRealFBS, endOrders));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketOrderRealFBSshow(fulfillment) async {
    try {
      emit(LoadingState());

      final List<BasketOrderSellerModel> data = await basketRepository.basketOrderRealFbsShow(
        'realFBS',
      );
      activeOrdersRealFBS.clear();
      activeOrdersRealFBS.addAll(data);

      print("data lenth ${activeOrdersRealFBS.length}");
      emit(LoadedState(activeOrders, activeOrdersRealFBS, endOrders));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketOrderEndShow() async {
    try {
      emit(LoadingState());
      final List<BasketOrderSellerModel> data = await basketRepository.basketOrderEndShow();

      endOrders.clear();
      endOrders.addAll(data);

      emit(LoadedState(activeOrders, activeOrdersRealFBS, endOrders));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  // Future<void> basketSwitchState(int value) async {
  //   try {
  //     if (value == 0) {
  //       emit(LoadingState());
  //       emit(LoadedOrderState(activeOrders));
  //     } else if (value == 1) {
  //       emit(LoadingState());
  //       print(activeOrdersRealFBS.length);
  //       emit(LoadedOrderRealFbsState(activeOrdersRealFBS));
  //     } else {
  //       emit(LoadedOrderEndState(endOrders));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     emit(ErrorState(message: 'Ошибка state'));
  //   }
  // }

  Future<void> basketStatus(String status, String id, productId, fulfillment) async {
    try {
      await basketRepository.basketStatus(status, id, productId, fulfillment);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
