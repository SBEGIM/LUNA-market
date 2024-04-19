import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/home/data/bloc/meta_state.dart';
import 'package:haji_market/features/home/data/model/MetaModel.dart';
import 'package:haji_market/features/home/data/repository/meta_repo.dart';

class MetaCubit extends Cubit<MetaState> {
  final MetaRepository metaRepository;

  MetaCubit({required this.metaRepository}) : super(InitState());

  Future<void> partners() async {
    try {
      emit(LoadingState());
      final MetaModel data = await metaRepository.metas();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString() + 'asdasdasdas !@#');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
