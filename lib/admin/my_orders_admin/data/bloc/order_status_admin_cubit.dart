import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/repository/basket_repo.dart';
import '../repository/basket_admin_repo.dart';

part 'order_status_admin_state.dart';

class OrderStatusAdminCubit extends Cubit<OrderStatusAdminState> {
  final BasketAdminRepository basketAdminRepository;
  final BasketRepository basketRepository;

  OrderStatusAdminCubit(this.basketRepository, {required this.basketAdminRepository}) : super(InitState());
  
  void toInitState(){
    
    emit(InitState());
  }

  Future<void> basketStatus(String status, String id, productId) async {
    emit(LoadingState());
    try {
      await basketAdminRepository.basketStatus(status, id, productId);

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
