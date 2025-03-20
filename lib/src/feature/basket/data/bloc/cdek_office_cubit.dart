import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/basket/data/DTO/cdek_office_old_model.dart';
import 'package:haji_market/src/feature/basket/data/bloc/cdek_office_state.dart';
import '../repository/cdek_office_repo.dart';

class CdekOfficeCubit extends Cubit<CdekOfficeState> {
  final CdekOfficeRepository cdekRepository;

  CdekOfficeCubit({required this.cdekRepository}) : super(InitState());

  Future<void> cdek(int cc) async {
    try {
      emit(LoadingState());
      final List<CdekOfficeOldModel> data = await cdekRepository.cdekOffice(cc);

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
