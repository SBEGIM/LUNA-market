import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/bonus_state.dart';
import 'package:haji_market/features/drawer/data/models/bonus_model.dart';

import '../models/product_model.dart';
import '../repository/bonus_repo.dart';

class BonusCubit extends Cubit<BonusState> {
  final BonusRepository bonusRepository;

  BonusCubit({required this.bonusRepository}) : super(InitState());

  Future<void> myBonus() async {
    try {
      emit(LoadingState());
      final List<BonusModel> data = await bonusRepository.bonuses();
      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
