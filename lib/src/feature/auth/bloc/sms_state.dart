import 'package:equatable/equatable.dart';

enum SmsAction {
  registerSend,
  registerResend,
  registerVerify,
  passwordSend,
  passwordVerify,
  passwordReset,
}

sealed class SmsState extends Equatable {
  const SmsState();

  @override
  List<Object?> get props => [];
}

final class SmsStateInitial extends SmsState {
  const SmsStateInitial();
}

final class SmsStateLoading extends SmsState {
  const SmsStateLoading({required this.action});

  final SmsAction action;

  @override
  List<Object?> get props => [action];
}

final class SmsStateSuccess extends SmsState {
  const SmsStateSuccess({required this.action, this.message});

  final SmsAction action;
  final String? message;

  @override
  List<Object?> get props => [action, message];
}

final class SmsStateError extends SmsState {
  const SmsStateError({required this.action, required this.message});

  final SmsAction action;
  final String message;

  @override
  List<Object?> get props => [action, message];
}
