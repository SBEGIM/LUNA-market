import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/home/bloc/partner_state.dart';
import 'package:haji_market/src/feature/home/data/model/partner_model.dart';
import '../data/repository/partner_repository..dart';

class PartnerCubit extends Cubit<PartnerState> {
  final PartnerRepository partnerRepository;

  PartnerCubit({required this.partnerRepository}) : super(InitState());

  Future<void> partners() async {
    try {
      emit(LoadingState());
      final List<PartnerModel> data = await partnerRepository.partner();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString() + 'asdasdasdas !@#');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
