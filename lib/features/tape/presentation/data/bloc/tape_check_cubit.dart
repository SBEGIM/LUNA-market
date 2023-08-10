import 'package:bloc/bloc.dart';
import 'package:haji_market/features/tape/presentation/data/models/tape_check_model.dart';
import 'package:haji_market/features/tape/presentation/data/repository/tape_repo.dart';


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
