import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../repository/basket_admin_repo.dart';

part 'order_status_admin_state.dart';

class OrderStatusAdminCubit extends Cubit<OrderStatusAdminState> {
  final BasketAdminRepository basketRepository;

  OrderStatusAdminCubit({required this.basketRepository}) : super(InitState());

  Future<void> basketStatus(String status, String id, productId) async {
    emit(LoadingState());
    try {
      await basketRepository.basketStatus(status, id, productId);

      emit(LoadedState());
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
