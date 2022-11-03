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

  Future<void> basketAdd(product_id , count) async {
    try {
      final data = await basketRepository.basketAdd(product_id , count);
      if(data != 200){
        Get.snackbar('Ошибка', 'Товар не добавлен' , backgroundColor: Colors.redAccent);
      }


    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }


  Future<void> basketMinus(product_id , count) async {
    try {
      final data = await basketRepository.basketMinus(product_id , count);
      if(data != 200){
        Get.snackbar('Ошибка', 'Товар не убрань' , backgroundColor: Colors.redAccent);
      }


    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketShow() async {
    try {

      emit(LoadingState());
      final List<BasketShowModel> data = await basketRepository.basketShow();

      emit(LoadedState(data));

    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }



  Future<List<BasketShowModel>?> basketData() async {
    try {

      emit(LoadingState());
      final List<BasketShowModel> data = await basketRepository.basketShow();
      return data ;

    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }


  Future <void> basketOrder(List<int> id) async {
    try {

      final data = await basketRepository.basketOrder(id);
      if(data == 200){
        Get.snackbar('Успешно', 'Заказ оформлен' , backgroundColor: Colors.blueAccent);
      }else{
        Get.snackbar('Ошибка', 'Заказ не оформлен' , backgroundColor: Colors.redAccent);
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



}
