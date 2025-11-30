import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/rest_client/src/exception/rest_client_exception.dart';
import 'package:haji_market/src/feature/auth/bloc/sms_state.dart';
import '../data/auth_repository.dart';

class SmsCubit extends Cubit<SmsState> {
  SmsCubit({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const SmsStateInitial());

  final IAuthRepository _authRepository;

  Future<void> smsSend(String phone) async => _handleRequest(
    action: SmsAction.registerSend,
    request: () => _authRepository.sendRegisterCode(phone: phone),
    successMessage: 'Код отправлен на ваш номер!',
  );

  Future<void> smsResend(String phone) async => _handleRequest(
    action: SmsAction.registerResend,
    request: () => _authRepository.sendRegisterCode(phone: phone),
    successMessage: 'Код повторно отправлен на ваш номер',
  );

  Future<void> smsCheck(String phone, String code) async => _handleRequest(
    action: SmsAction.registerVerify,
    request: () => _authRepository.registerSmsCheck(phone: phone, code: code),
    successMessage: 'Код подтверждён',
  );

  Future<void> resetSend(String phone) async => _handleRequest(
    action: SmsAction.passwordSend,
    request: () => _authRepository.forgotPasswordSmsSend(phone: phone),
    successMessage: 'Код отправлен на ваш номер',
  );

  Future<void> resetCheck(String phone, String code) async => _handleRequest(
    action: SmsAction.passwordVerify,
    request: () => _authRepository.forgotPasswordSmsCheck(phone: phone, code: code),
    successMessage: 'Код подтверждён',
  );

  Future<void> passwordReset(String phone, String password) async => _handleRequest(
    action: SmsAction.passwordReset,
    request: () => _authRepository.passwordResetByPhone(phone: phone, password: password),
    successMessage: 'Пароль успешно обновлён',
  );

  Future<void> _handleRequest({
    required SmsAction action,
    required Future<dynamic> Function() request,
    required String successMessage,
  }) async {
    try {
      emit(SmsStateLoading(action: action));
      await request();

      if (isClosed) return;
      emit(SmsStateSuccess(action: action, message: successMessage));
    } on RestClientException catch (e) {
      if (isClosed) return;
      emit(SmsStateError(action: action, message: e.message));
    } catch (e) {
      if (isClosed) return;
      emit(SmsStateError(action: action, message: e.toString()));
    }
  }
}
