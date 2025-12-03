import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_state.dart';
import '../data/models/basket_show_model.dart';
import '../data/repository/basket_repo.dart';

class BasketCubit extends Cubit<BasketState> {
  final BasketRepository basketRepository;

  BasketCubit({required this.basketRepository}) : super(InitState());

  int basketOrderShowPage = 1;

  List<BasketOrderModel> _orders = [];

  List<BasketShowModel> basketProducts = [];
  List<BasketShowModel> buyProducts = [];

  Future<void> basketAdd(
    productId,
    count,
    price,
    String? size,
    String? color, {
    bool? isOptom,
    String? blogger_id,
    String? fulfillment,
  }) async {
    try {
      final data = await basketRepository.basketAdd(
        productId,
        count,
        price,
        size,
        color,
        isOptom: isOptom,
        blogger_id: blogger_id,
      );
      if (data != 200) {
        Get.snackbar('Ошибка', 'Товар не добавлен', backgroundColor: Colors.redAccent);
      }
      if (data == 200) {
        await basketShowWithoutLoading();
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketMinus(productId, count, price, String? fulfillment) async {
    try {
      final data = await basketRepository.basketMinus(productId, count, price);
      if (data != 200) {
        Get.snackbar('Ошибка', 'Товар не убрань', backgroundColor: Colors.redAccent);
      }
      if (data == 200) {
        await basketShowWithoutLoading();
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketDelete(productId, fulfillment) async {
    try {
      final data = await basketRepository.basketDelete(productId);
      if (data != 200) {
        Get.snackbar('Ошибка', 'Товар не удален', backgroundColor: Colors.redAccent);
      }
      if (data == 200) {
        await basketShowWithoutLoading();
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketDeleteProducts(List<int> productIds) async {
    try {
      print('basket');
      print(productIds.toString());
      final data = await basketRepository.basketDeleteProducts(productIds);
      if (data != 200) {
        Get.snackbar('Ошибка', 'Товар не удален', backgroundColor: Colors.redAccent);
      }
      if (data == 200) {
        await basketShowWithoutLoading();
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketSelectProducts(List<int> productIds) async {
    buyProducts = basketProducts.where((e) => productIds.contains(e.basketId)).toList();

    emit(LoadedState(buyProducts));
  }

  Future<void> basketBackSelectProducts() async {
    emit(LoadedState(basketProducts));
  }

  Future<void> basketShow() async {
    try {
      emit(LoadingState());
      final List<BasketShowModel> data = await basketRepository.basketShow();
      basketProducts.clear();
      basketProducts.addAll(data);
      if (data.length == 0) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketShowWithoutLoading() async {
    try {
      final List<BasketShowModel> data = await basketRepository.basketShow();
      basketProducts.clear();
      basketProducts.addAll(data);
      if (data.length == 0) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<List<BasketShowModel>?> basketData(String fulfillment) async {
    try {
      emit(LoadingState());
      final List<BasketShowModel> data = await basketRepository.basketShow();
      basketProducts.clear();
      basketProducts.addAll(data);
      return data;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<void> basketOrder(List<int> productIds) async {
    try {
      final data = await basketRepository.basketOrder(productIds);
      if (data == 200) {
        Get.snackbar('Успешно', 'Заказ оформлен', backgroundColor: Colors.blueAccent);
      } else {
        Get.snackbar('Ошибка', 'Заказ не оформлен', backgroundColor: Colors.redAccent);
      }
      emit(OrderState());
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketOrderShow({required String status}) async {
    try {
      basketOrderShowPage = 1;

      emit(LoadingState());
      final List<BasketOrderModel> data = await basketRepository.basketOrderShow(
        status: status,
        page: basketOrderShowPage,
      );

      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        _orders.clear();
        _orders.addAll(data);

        emit(LoadedOrderState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketOrderShowPaginate({required String status}) async {
    try {
      basketOrderShowPage++;

      final List<BasketOrderModel> data = await basketRepository.basketOrderShow(
        status: status,
        page: basketOrderShowPage,
      );

      for (int i = 0; i < data.length; i++) {
        _orders.add(data[i]);
      }

      emit(LoadedOrderState(_orders));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<int> basketCount(int count) async {
    return count;
  }

  Future<int> basketPrice(int price) async {
    return price;
  }

  Future<String?> payment({
    required BuildContext context,
    required List<int> basketIds,
    String? address,
  }) async {
    try {
      final data = await basketRepository.payment(
        context: context,
        basketIds: basketIds,
        address: address,
      );
      // if (data == 200) {
      //   Get.snackbar('Успешно', 'Заказ оформлен',
      //       backgroundColor: Colors.blueAccent);
      // } else {
      //   Get.snackbar('Ошибка', 'Заказ не оформлен',
      //       backgroundColor: Colors.redAccent);
      // }
      // emit(OrderState());
      return data;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<int?> basketStatusUpdate(String id, String status, String? text) async {
    try {
      final data = await basketRepository.status(id, status, text);

      return 1;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void updateProductByIndex({required int index, required BasketOrderModel updatedOrder}) {
    if (index < _orders.length) {
      _orders[index] = updatedOrder;
      emit(LoadedOrderState(_orders));
    }
  }
}
