import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/respublic_state.dart';
import 'package:haji_market/features/drawer/data/models/credit_model.dart';
import 'package:haji_market/features/drawer/data/models/respublic_model.dart';
import 'package:haji_market/features/drawer/data/repository/respublic_repo.dart';

class RespublicCubit extends Cubit<RespublicState> {
  final RespublicRepository respublicRepository;

  RespublicCubit({required this.respublicRepository}) : super(InitState());

  Future<void> respublics() async {
    try {
      emit(LoadingState());
      final List<RespublicModel> data = await respublicRepository.respublics();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString() + 'CreditCubit');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
