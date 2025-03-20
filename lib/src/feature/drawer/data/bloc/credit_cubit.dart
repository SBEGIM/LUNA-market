import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/credit_state.dart';
import 'package:haji_market/src/feature/drawer/data/models/credit_model.dart';
import 'package:haji_market/src/feature/drawer/data/repository/credit_repo.dart';

class CreditCubit extends Cubit<CreditState> {
  final CreditRepository creditRepository;

  CreditCubit({required this.creditRepository}) : super(InitState());

  Future<void> credits(int id) async {
    try {
      emit(LoadingState());
      final List<CreditModel> data = await creditRepository.credits(id);
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString() + 'CreditCubit');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
