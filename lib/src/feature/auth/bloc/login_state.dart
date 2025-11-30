import 'package:equatable/equatable.dart';

enum LoginAction { login, lateAuth, editProfile, editPushSettings, updateCityCode, deleteAccount }

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

final class LoginStateLoading extends LoginState {
  const LoginStateLoading({required this.action});

  final LoginAction action;

  @override
  List<Object?> get props => [action];
}

final class LoginStateSuccess extends LoginState {
  const LoginStateSuccess({required this.action});

  final LoginAction action;

  @override
  List<Object?> get props => [action];
}

final class LoginStateError extends LoginState {
  const LoginStateError({required this.message, required this.action});

  final String message;
  final LoginAction action;

  @override
  List<Object?> get props => [message, action];
}
