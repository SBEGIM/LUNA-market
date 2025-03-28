import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_state.dart';
import 'package:haji_market/src/feature/tape/data/models/tape_model.dart';

import '../data/repository/tape_repository.dart';

class TapeCubit extends Cubit<TapeState> {
  final TapeRepository tapeRepository;
  List<TapeModel> array = [];
  List<TapeModel> arrayForBlogger = [];
  int page = 1;

  TapeCubit({required this.tapeRepository}) : super(InitState());
  Future<void> tapes(
      bool? inSub, bool? inFav, String? search, int? blogger_id) async {
    try {
      emit(LoadingState());
      page = 1;
      final data =
          await tapeRepository.tapes(inSub, inFav, search, blogger_id, page);
      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        if (blogger_id == 0) {
          array = data;
          emit(LoadedState(array));
        } else {
          arrayForBlogger = data;
          emit(BloggerLoadedState(arrayForBlogger));
        }
        page++;
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> tapePagination(
      bool? inSub, bool? inFav, String? search, int? blogger_id) async {
    try {
      // emit(LoadingState());
      final data =
          await tapeRepository.tapes(inSub, inFav, search, blogger_id, page);

      // for (int i = 0; i < data.length; i++) {
      //   array.add(data[i]);
      // }
      if (data.isNotEmpty) {
        page++;
      }

      if (blogger_id == 0) {
        array += data;
        emit(LoadedState(array));
      } else {
        arrayForBlogger += data;
        emit(BloggerLoadedState(arrayForBlogger));
      }
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  update(TapeModel tape, int index, bool? inSub, bool? inBas, bool? inFav,
      bool? inReport,
      {bool isBlogger = false}) {
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
          blogger: tape.blogger,
          inBasket: inBas ?? tape.inBasket,
          inReport: inReport ?? tape.inReport,
          inFavorite: inFav ?? tape.inFavorite,
          inSubscribe: inSub ?? tape.inSubscribe,
          shop: tape.shop);

      // data!.removeAt(index);
      //data!.u(index);

      if (isBlogger == true) {
        arrayForBlogger[index] = arrayForBlogger[index].copyWith(
            id: tapeModel.id,
            name: tapeModel.name,
            catName: tapeModel.name,
            price: tapeModel.price,
            description: tapeModel.description,
            compound: tapeModel.compound,
            video: tapeModel.video,
            image: tapeModel.image,
            blogger: tapeModel.blogger,
            inBasket: inBas ?? tape.inBasket,
            inReport: inReport ?? tape.inReport,
            inFavorite: inFav ?? tape.inFavorite,
            inSubscribe: inSub ?? tape.inSubscribe,
            shop: tape.shop);

        emit(BloggerLoadedState(arrayForBlogger));
      } else {
        array[index] = array[index].copyWith(
            id: tapeModel.id,
            name: tapeModel.name,
            catName: tapeModel.name,
            price: tapeModel.price,
            description: tapeModel.description,
            compound: tapeModel.compound,
            video: tapeModel.video,
            image: tapeModel.image,
            blogger: tapeModel.blogger,
            inBasket: inBas ?? tape.inBasket,
            inReport: inReport ?? tape.inReport,
            inFavorite: inFav ?? tape.inFavorite,
            inSubscribe: inSub ?? tape.inSubscribe,
            shop: tape.shop);

        emit(LoadedState(array));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void toBloggerLoadedState() {
    emit(BloggerLoadedState(arrayForBlogger));
  }

  void toLoadedState() {
    emit(LoadedState(array));
  }

  view(int id) async {
    // data!.removeAt(index);

    try {
      await tapeRepository.view(id);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void updateTapeByIndex({
    required int index,
    required TapeModel updatedTape,
  }) {
    log(updatedTape.tapeId.toString());
    array[index] = updatedTape;
    emit(LoadedState(array));
  }
}
