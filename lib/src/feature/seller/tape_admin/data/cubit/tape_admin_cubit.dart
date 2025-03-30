import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/tape_admin/data/cubit/tape_admin_state.dart';
import 'package:haji_market/src/feature/seller/tape_admin/data/repository/tape_admin_repo.dart';
import '../model/TapeAdminModel.dart';

class TapeAdminCubit extends Cubit<TapeAdminState> {
  final TapeAdminRepository tapeRepository;
  List<TapeAdminModel> array = [];

  TapeAdminCubit({required this.tapeRepository}) : super(InitState());
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

  update(TapeAdminModel tape, int index, bool? inSub, bool? inBas, bool? inFav,
      bool? inReport) {
    // data!.removeAt(index);

    try {
      final TapeAdminModel tapeModel = TapeAdminModel(
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
