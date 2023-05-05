import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/basket/data/DTO/cdek_office_model.dart';
import 'package:haji_market/features/basket/data/bloc/cdek_office_state.dart';
import '../repository/CdekOfficeRepo.dart';

class CdekOfficeCubit extends Cubit<CdekOfficeState> {
  final CdekOfficeRepository cdekRepository;

  CdekOfficeCubit({required this.cdekRepository}) : super(InitState());

  Future<void> cdek() async {
    try {
      emit(LoadingState());
      final List<CdekOfficeModel> data = await cdekRepository.cdekOffice();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
