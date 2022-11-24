import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_state.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';

import '../repository/tape_repo.dart';

class TapeCubit extends Cubit<TapeState> {
  final TapeRepository tapeRepository;
  List<TapeModel>? data;

  TapeCubit({required this.tapeRepository}) : super(InitState());
  Future<void> tapes(bool? inSub, bool? inFav, String? search) async {
    try {
      emit(LoadingState());
      data = await tapeRepository.tapes(inSub, inFav, search);

      emit(LoadedState(data!));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  update(TapeModel tape, int index, bool? inSub, bool? inBas, bool? inFav) {
    // data!.removeAt(index);

    try {
      final TapeModel tape_model = TapeModel(
          id: tape.id,
          name: tape.name,
          catName: tape.catName,
          price: tape.price,
          description: tape.description,
          compound: tape.compound,
          video: tape.video,
          image: tape.image,
          inBasket: inBas ?? tape.inBasket,
          inFavorite: inFav ?? tape.inFavorite,
          inSubscribe: inSub ?? tape.inSubscribe,
          shop: tape.shop);

      // data!.removeAt(index);
      //data!.u(index);
      data![index] = tape_model;
      emit(LoadedState(data!));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
