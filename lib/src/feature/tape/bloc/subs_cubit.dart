import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/tape/bloc/subs_state.dart';

import '../data/repository/sub_repository.dart';

class SubsCubit extends Cubit<SubsState> {
  final SubsRepository subsRepository;

  SubsCubit({required this.subsRepository}) : super(InitState());

  sub(bloggerId) async {
    try {
      subsRepository.subs(bloggerId);
      return true;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  subShop(shopId) async {
    try {
      subsRepository.subSeller(shopId);
      return true;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
