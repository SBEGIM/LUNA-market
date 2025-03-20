import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/drawer/data/repository/basket_repo.dart';

class OrderCubit extends Cubit<OrderState> {
  final BasketRepository basketRepository;

  OrderCubit({required this.basketRepository}) : super(InitState());

  Future<void> payment(
      {String? address, String? bonus, String? fulfillment}) async {
    try {
      emit(LoadingState());
      final data = await basketRepository.payment(
          address: address, bonus: bonus, fulfillment: fulfillment);
      emit(LoadedState(url: data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}

abstract class OrderState {}

class InitState extends OrderState {}

class LoadingState extends OrderState {}

class LoadedState extends OrderState {
  String url;
  LoadedState({
    required this.url,
  });
}

class ErrorState extends OrderState {
  String message;
  ErrorState({required this.message});
}
