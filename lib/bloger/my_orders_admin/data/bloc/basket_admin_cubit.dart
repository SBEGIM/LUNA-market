import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../models/basket_admin_order_model.dart';
import '../repository/basket_admin_repo.dart';
import 'basket_admin_state.dart';

class BasketAdminCubit extends Cubit<BasketAdminState> {
  final BasketAdminRepository basketRepository;

  BasketAdminCubit({required this.basketRepository}) : super(InitState());

  Future<void> basketOrderShow() async {
    try {
      emit(LoadingState());
      final List<BasketAdminOrderModel> data =
          await basketRepository.basketOrderShow();

      emit(LoadedOrderState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> basketStatus(String status, String id, product_id) async {
    try {
      await basketRepository.basketStatus(status, id, product_id);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
