import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
part 'last_articul_seller_state.dart';

class LastArticulSellerCubit extends Cubit<LastArticulSellerState> {
  final ProductSellerRepository repository;

  LastArticulSellerCubit({required this.repository}) : super(InitState());

  Future<int> getLastArticul() async {
    try {
      emit(LoadingState());
      final int data = await repository.getLastArticul();
      emit(LoadedState(data));
      return data;
    } catch (e) {
      // ...
      emit(ErrorState(message: 'Ошибка сервера'));
      return 0;
    }
  }
}
