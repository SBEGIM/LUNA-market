import 'package:equatable/equatable.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterStateInitial extends RegisterState {
  const RegisterStateInitial();
}

final class RegisterStateLoading extends RegisterState {
  const RegisterStateLoading();
}

final class RegisterStateSuccess extends RegisterState {
  const RegisterStateSuccess();
}

final class RegisterStateError extends RegisterState {
  const RegisterStateError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
