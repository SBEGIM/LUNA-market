import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_state.dart';
import '../data/model/tape_blogger_model.dart';
import '../data/repository/tape_blogger_repo.dart';

class TapeBloggerCubit extends Cubit<TapeBloggerState> {
  final TapeBloggerRepository tapeRepository;
  List<TapeBloggerModel> array = [];

  TapeBloggerCubit({required this.tapeRepository}) : super(InitState());
  Future<void> tapes(bool? inSub, bool? inFav, String? search) async {
    try {
      emit(LoadingState());
      final data = await tapeRepository.tapes(inSub, inFav, search);
      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
        data.forEach((element) {
          array.add(element);
        });
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  update(TapeBloggerModel tape, int index, bool? inSub, bool? inBas,
      bool? inFav, bool? inReport) {
    // data!.removeAt(index);

    try {
      final TapeBloggerModel tapeModel = TapeBloggerModel(
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
