import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/profit_state.dart';
import 'package:haji_market/features/drawer/data/repository/profit_repo.dart';

class ProfitCubit extends Cubit<ProfitState> {
  final ProfitRepository profitRepository;

  ProfitCubit({required this.profitRepository}) : super(InitState());

  Future<void> profit() async {
    try {
      emit(LoadingState());
      final data = await profitRepository.profitApi();
      emit(LoadedState(path: data));

      print('success');
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
