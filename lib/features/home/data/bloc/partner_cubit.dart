import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/home/data/bloc/partner_state.dart';
import 'package:haji_market/features/home/data/model/PartnerModel.dart';
import '../repository/partner_repo.dart';

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
