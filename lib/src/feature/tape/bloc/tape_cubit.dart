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
  bool isLoading = false;

  TapeCubit({required this.tapeRepository}) : super(InitState());

  Future<void> tapes(bool? inSub, bool? inFav, String? search, int? bloggerId) async {
    try {
      emit(LoadingState());
      page = 1;
      final data = await tapeRepository.tapes(inSub, inFav, search, bloggerId, page);

      if (data.isEmpty) {
        print('NoDataState');
        emit(NoDataState());
      } else {
        if ((bloggerId ?? 0) == 0) {
          array = List.from(data); // reset
          emit(LoadedState(List.from(array)));
        } else {
          print('blogger success');
          arrayForBlogger = List.from(data); // reset
          emit(BloggerLoadedState(List.from(arrayForBlogger)));
        }
        page++;
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> tapePagination(bool? inSub, bool? inFav, String? search, int? bloggerId) async {
    if (isLoading) return;
    isLoading = true;

    try {
      final data = await tapeRepository.tapes(inSub, inFav, search, bloggerId, page);

      if ((bloggerId ?? 0) == 0) {
        array += data;
        emit(LoadedState(List.from(array)));
      } else {
        arrayForBlogger += data;
        emit(BloggerLoadedState(List.from(arrayForBlogger)));
      }

      if (data.isNotEmpty) page++;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    } finally {
      isLoading = false;
    }
  }

  void update(
    TapeModel tape,
    int index,
    bool? inSub,
    bool? inBas,
    bool? inFav,
    bool? inReport,
    bool? isLiked,
    int? like,
    int? favorite,
    int? send, {
    bool isBlogger = false,
  }) {
    try {
      final updatedTape = tape.copyWith(
        inBasket: inBas ?? tape.inBasket,
        inReport: inReport ?? tape.inReport,
        inFavorite: inFav ?? tape.inFavorite,
        inSubscribe: inSub ?? tape.inSubscribe,
        isLiked: isLiked ?? tape.isLiked,
        statistics: Statistics(
          send: send ?? (tape.statistics?.like ?? 0),
          like: like ?? (tape.statistics?.like ?? 0),
          favorite: favorite ?? (tape.statistics?.favorite ?? 0),
        ),
      );

      if (isBlogger) {
        if (index >= 0 && index < arrayForBlogger.length) {
          arrayForBlogger[index] = updatedTape;
          emit(BloggerLoadedState(List.from(arrayForBlogger)));
        } else {}
      } else {
        if (index >= 0 && index < array.length) {
          array[index] = updatedTape;
          emit(LoadedState(List.from(array)));
        } else {}
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void updateTapeByIndex({
    required int index,
    required TapeModel updatedTape,
    bool isBlogger = false,
  }) {
    try {
      if (isBlogger) {
        if (index >= 0 && index < arrayForBlogger.length) {
          arrayForBlogger[index] = updatedTape;
          emit(BloggerLoadedState(List.from(arrayForBlogger)));
        }
      } else {
        if (index >= 0 && index < array.length) {
          array[index] = updatedTape;
          emit(LoadedState(List.from(array)));
        }
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка обновления ленты'));
    }
  }

  void toBloggerLoadedState() {
    emit(BloggerLoadedState(List.from(arrayForBlogger)));
  }

  void toLoadedState() {
    emit(LoadedState(List.from(array)));
  }

  Future<void> report({required int tapeId, required String report}) async {
    try {
      await tapeRepository.report(tapeId, report);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка при увеличении просмотров'));
    }
  }

  Future<void> view(int id) async {
    try {
      await tapeRepository.view(id);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка при увеличении просмотров'));
    }
  }

  Future<void> like(int id) async {
    try {
      await tapeRepository.like(id);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка при увеличении просмотров'));
    }
  }

  Future<void> share(int id) async {
    try {
      await tapeRepository.share(id);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка при увеличении просмотров'));
    }
  }
}
