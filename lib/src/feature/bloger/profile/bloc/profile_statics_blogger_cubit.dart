import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_statics_blogger_state.dart';

import '../data/model/profile_statics_blogger_model.dart';
import '../data/repository/profile_statics_blogger_repo.dart';

class ProfileStaticsBloggerCubit extends Cubit<ProfileStaticsBloggerState> {
  final ProfileStaticsBloggerRepository profileStaticsBloggerRepository;

  ProfileStaticsBloggerCubit({required this.profileStaticsBloggerRepository})
      : super(InitState());

  Future<void> statics(int? bloggerId) async {
    try {
      emit(LoadingState());
      final ProfileStaticsBloggerModel data =
          await profileStaticsBloggerRepository.statics(bloggerId);

      // if (data != null) {
      emit(LoadedState(loadedProfile: data));
      // }
      // if (data == 400) {
      //   emit(InitState());
      //   Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
      //       backgroundColor: Colors.redAccent);
      // }
      // if (data == 500) {
      //   emit(InitState());
      //   Get.snackbar('500', 'Ошибка сервера',
      //       backgroundColor: Colors.redAccent);
      // }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
