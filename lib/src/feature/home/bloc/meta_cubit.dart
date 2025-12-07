import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/home/bloc/meta_state.dart';
import 'package:haji_market/src/feature/home/data/model/meta_model.dart';
import 'package:haji_market/src/feature/home/data/repository/meta_repository..dart';

class MetaCubit extends Cubit<MetaState> {
  final MetaRepository metaRepository;

  MetaCubit({required this.metaRepository}) : super(MetaStateInitial());

  Future<void> partners() async {
    try {
      emit(MetaStateLoading());
      final MetaModel data = await metaRepository.metas();

      emit(MetaStateLoaded(data));
    } catch (e) {
      emit(MetaStateError(message: 'Ошибка сервера'));
    }
  }
}
