import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/subs_state.dart';

import '../repository/sub_repo.dart';
import '../repository/tape_repo.dart';

class SubsCubit extends Cubit<SubsState> {
  final SubsRepository subsRepository;

  SubsCubit({required this.subsRepository}) : super(InitState());

  sub(shop_id) async {
    try {
      subsRepository.subs(shop_id);
      return true;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
