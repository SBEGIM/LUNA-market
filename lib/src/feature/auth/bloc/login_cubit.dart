import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/rest_client/src/exception/rest_client_exception.dart';
import 'package:haji_market/src/feature/auth/bloc/login_state.dart';
import '../data/auth_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginStateInitial());

  final IAuthRepository _authRepository;

  Future<void> login(String phone, String password) async {
    try {
      emit(const LoginStateLoading(action: LoginAction.login));
      await _authRepository.login(phone: phone, password: password);

      if (isClosed) return;
      emit(const LoginStateSuccess(action: LoginAction.login));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.message, action: LoginAction.login));
    } catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.toString(), action: LoginAction.login));
    }
  }

  Future<void> lateAuth() async {
    try {
      emit(const LoginStateLoading(action: LoginAction.lateAuth));
      await _authRepository.lateAuth();

      if (isClosed) return;
      emit(const LoginStateSuccess(action: LoginAction.lateAuth));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.message, action: LoginAction.lateAuth));
    } catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.toString(), action: LoginAction.lateAuth));
    }
  }

  Future<void> edit(
    String firstname,
    String lastName,
    String surName,
    String phone,
    String avatar,
    String gender,
    String birthday,
    String country,
    String city,
    String street,
    String home,
    String porch,
    String floor,
    String room,
    String email,
  ) async {
    try {
      emit(const LoginStateLoading(action: LoginAction.editProfile));
      await _authRepository.editProfile(
        firstName: firstname,
        lastName: lastName,
        surName: surName,
        phone: phone,
        avatarPath: avatar,
        gender: gender,
        birthday: birthday,
        country: country,
        city: city,
        street: street,
        home: home,
        porch: porch,
        floor: floor,
        room: room,
        email: email,
      );

      if (isClosed) return;
      emit(const LoginStateSuccess(action: LoginAction.editProfile));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.message, action: LoginAction.editProfile));
    } catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.toString(), action: LoginAction.editProfile));
    }
  }

  Future<void> editPush(int pushStatus) async {
    try {
      emit(const LoginStateLoading(action: LoginAction.editPushSettings));
      await _authRepository.editPush(pushStatus: pushStatus);

      if (isClosed) return;
      emit(const LoginStateSuccess(action: LoginAction.editPushSettings));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.message, action: LoginAction.editPushSettings));
    } catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.toString(), action: LoginAction.editPushSettings));
    }
  }

  Future<void> cityCode(dynamic code) async {
    try {
      emit(const LoginStateLoading(action: LoginAction.updateCityCode));
      await _authRepository.updateCityCode(code: code.toString());

      if (isClosed) return;
      emit(const LoginStateSuccess(action: LoginAction.updateCityCode));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.message, action: LoginAction.updateCityCode));
    } catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.toString(), action: LoginAction.updateCityCode));
    }
  }

  Future<void> delete() async {
    try {
      emit(const LoginStateLoading(action: LoginAction.deleteAccount));
      await _authRepository.deleteAccount();

      if (isClosed) return;
      emit(const LoginStateSuccess(action: LoginAction.deleteAccount));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.message, action: LoginAction.deleteAccount));
    } catch (e) {
      if (isClosed) return;
      emit(LoginStateError(message: e.toString(), action: LoginAction.deleteAccount));
    }
  }
}
