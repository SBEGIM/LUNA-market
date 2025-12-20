import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/presentation/location_page.dart';

part 'app_bloc.freezed.dart';

const _tag = 'AppBloc';

class AppBloc extends Bloc<AppEvent, AppState> {
  /// Статус аутентификации
  final bool token = GetStorage().hasData('token');

  AppBloc() : super(const AppState.loadingState()) {
    on<AppEvent>(
      (AppEvent event, Emitter<AppState> emit) async => event.map(
        exiting: (_Exiting event) async => _exit(event, emit),
        checkAuth: (_CheckAuth event) async => _checkAuth(event, emit),
        switchState: (_SwitchState event) async => _switchState(event, emit),
        chageState: (_ChangeState event) async => _changeState(event, emit),
        logining: (_Logining event) async => _login(event, emit),
        location: (_Location event) async => _location(event, emit),
      ),
    );
  }

  Future<void> _login(_Logining event, Emitter<AppState> emit) async {
    log('AppBloc _login', name: _tag);

    emit(const AppState.inAppUserState());
  }

  // CityModel? loadCity() {
  //   final data = GetStorage().read('city');
  //   if (data == null) return null;
  //   return CityModel.fromJson(Map<String, dynamic>.from(data));
  // }

  Future<void> _location(_Location event, Emitter<AppState> emit) async {
    bool exists = GetStorage().hasData('user_location_code');
    // CityModel? city = loadCity();
    bool guest = GetStorage().hasData('user_guest');

    if (!exists && !guest) {
      Get.to(LocationPage());
    }
    if (token) {
      emit(const AppState.inAppUserState());
    }
  }

  Future<void> _checkAuth(_CheckAuth event, Emitter<AppState> emit) async {
    if (token) {
      emit(const AppState.inAppUserState());
    } else {
      emit(const AppState.notAuthorizedState());
    }
  }

  Future<void> _switchState(_SwitchState event, Emitter<AppState> emit) async {
    if (event.key) {
      emit(const AppState.inAppUserState(index: 1));
    } else {
      emit(const AppState.notAuthorizedState());
    }
  }

  Future<void> _exit(_Exiting event, Emitter<AppState> emit) async {
    emit(const AppState.loadingState());
    // await _authRepository.clearUser();
    emit(const AppState.notAuthorizedState());
  }

  Future<void> _changeState(_ChangeState event, Emitter<AppState> emit) async => emit(event.state);
}

///
///
/// Event class
///
///
@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.switchState({required bool key}) = _SwitchState;
  const factory AppEvent.checkAuth() = _CheckAuth;
  const factory AppEvent.exiting() = _Exiting;
  const factory AppEvent.logining() = _Logining;
  const factory AppEvent.location() = _Location;
  const factory AppEvent.chageState({required AppState state}) = _ChangeState;
}

///
///
/// State class
///
///
@freezed
class AppState with _$AppState {
  const factory AppState.loadingState() = _LoadingState;

  const factory AppState.notAuthorizedState({bool? button}) = _NotAuthorizedState;

  const factory AppState.inAppUserState({int? index}) = _InAppUserState;
  const factory AppState.inAppBlogerState({int? index}) = _InAppBlogerState;
  const factory AppState.inAppAdminState({int? index}) = _InAppAdminState;

  const factory AppState.inAppManagerState({int? index}) = _InAppManagerState;

  const factory AppState.errorState({required String message}) = _ErrorState;
}
