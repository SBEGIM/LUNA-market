import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/basket/data/repository/basket_repo.dart';
import '../data/repository/basket_seller_repository.dart';

part 'order_status_seller_state.dart';

class OrderStatusSellerCubit extends Cubit<OrderStatusSellerState> {
  final BasketSellerRepository basketAdminRepository;
  final BasketRepository basketRepository;

  OrderStatusSellerCubit(this.basketRepository, {required this.basketAdminRepository})
    : super(InitState());

  void toInitState() {
    emit(InitState());
  }

  Future<void> basketStatus(String status, String id, productId, String fulfillment) async {
    emit(LoadingState());
    try {
      await basketAdminRepository.basketStatus(status, id, productId, fulfillment);

      emit(LoadedState());
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> cancelOrder(String id, String status, String? text) async {
    try {
      final data = await basketRepository.status(id, status, text);

      emit(CancelState());
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
