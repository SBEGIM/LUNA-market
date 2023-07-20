import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_state.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';

import '../repository/tape_repo.dart';

class TapeCubit extends Cubit<TapeState> {
  final TapeRepository tapeRepository;
  List<TapeModel> array = [];

  TapeCubit({required this.tapeRepository}) : super(InitState());
  Future<void> tapes(
      bool? inSub, bool? inFav, String? search, int? blogger_id) async {
    try {
      emit(LoadingState());
      final data = await tapeRepository.tapes(inSub, inFav, search, blogger_id);
      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        if (blogger_id == 0) {
          emit(LoadedState(data));
        } else {
          emit(BloggerLoadedState(data));
        }
        array.clear();
        data.forEach((element) {
          array.add(element);
        });
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  update(TapeModel tape, int index, bool? inSub, bool? inBas, bool? inFav,
      bool? inReport) {
    // data!.removeAt(index);

    try {
      final TapeModel tapeModel = TapeModel(
          id: tape.id,
          name: tape.name,
          catName: tape.catName,
          price: tape.price,
          description: tape.description,
          compound: tape.compound,
          video: tape.video,
          image: tape.image,
          inBasket: inBas ?? tape.inBasket,
          inReport: inReport ?? tape.inReport,
          inFavorite: inFav ?? tape.inFavorite,
          inSubscribe: inSub ?? tape.inSubscribe,
          shop: tape.shop);

      // data!.removeAt(index);
      //data!.u(index);

      array[index] = tapeModel;

      // emit(LoadedState(data!));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
