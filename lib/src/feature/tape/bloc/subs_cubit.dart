import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/tape/bloc/subs_state.dart';

import '../data/repository/sub_repository.dart';

class SubsCubit extends Cubit<SubsState> {
  final SubsRepository subsRepository;

  SubsCubit({required this.subsRepository}) : super(InitState());

  sub(shopId) async {
    try {
      subsRepository.subs(shopId);
      return true;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
