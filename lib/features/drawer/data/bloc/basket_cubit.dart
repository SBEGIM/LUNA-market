import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/drawer/data/bloc/basket_state.dart';
import '../../../basket/data/models/basket_show_model.dart';
import '../repository/basket_repo.dart';

class BasketCubit extends Cubit<BasketState> {
  final BasketRepository basketRepository;

  BasketCubit({required this.basketRepository}) : super(InitState());

  Future<void> basketAdd(productId, count, price, String? size, String? color,
      {bool? isOptom, String? blogger_id, String? fulfillment}) async {
    try {
      final data = await basketRepository.basketAdd(productId, count, price, size, color,
          isOptom: isOptom, blogger_id: blogger_id);
      if (data != 200) {
        Get.snackbar('Ошибка', 'Товар не добавлен', backgroundColor: Colors.redAccent);
      }
      if (data == 200) {
        await basketShowWithoutLoading(fulfillment ?? 'fbs');
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
        await basketShowWithoutLoading(fulfillment ?? 'fbs');
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
        await basketShowWithoutLoading(fulfillment ?? 'fbs');
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketShow(String? fulfillment) async {
    try {
      emit(LoadingState());
      final List<BasketShowModel> data = await basketRepository.basketShow(fulfillment);
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

  Future<void> basketShowWithoutLoading(String? fulfillment) async {
    try {
      final List<BasketShowModel> data = await basketRepository.basketShow(fulfillment);
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
      final List<BasketShowModel> data = await basketRepository.basketShow(fulfillment);
      return data;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<void> basketOrder(List<int> id) async {
    try {
      final data = await basketRepository.basketOrder(id);
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

  Future<void> basketOrderShow() async {
    try {
      emit(LoadingState());
      final List<BasketOrderModel> data = await basketRepository.basketOrderShow();

      emit(LoadedOrderState(data));
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
    String? address,
  }) async {
    try {
      final data = await basketRepository.payment(
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
}
