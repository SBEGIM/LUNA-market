import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/tape/data/models/tape_check_model.dart';
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';

part 'tape_check_state.dart';

class TapeCheckCubit extends Cubit<TapeCheckState> {
  final TapeRepository tapeRepository;

  TapeCheckCubit({required this.tapeRepository}) : super(InitState());

  Future<void> tapeCheck({
    required int tapeId,
  }) async {
    emit(LoadingState());
    try {
      final data = await tapeRepository.tapeCheck(tapeId: tapeId);
      emit(LoadedState(data));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
