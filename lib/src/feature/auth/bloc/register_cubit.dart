import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/rest_client/src/exception/rest_client_exception.dart';
import 'package:haji_market/src/feature/auth/bloc/register_state.dart';
import '../data/DTO/register.dart';
import '../data/auth_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const RegisterStateInitial());

  final IAuthRepository _authRepository;

  Future<void> register(RegisterDTO register) async {
    try {
      emit(const RegisterStateLoading());
      await _authRepository.register(registerDto: register);

      if (isClosed) return;
      emit(const RegisterStateSuccess());
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(RegisterStateError(message: e.message));
    } catch (e) {
      if (isClosed) return;
      emit(RegisterStateError(message: e.toString()));
    }
  }
}
