import 'dart:io';

import 'package:haji_market/src/core/rest_client/rest_client.dart';
import 'package:haji_market/src/core/utils/extensions/map_indexed.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import 'package:haji_market/src/feature/auth/data/models/app_version_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/common_lists_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/request/user_payload.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

abstract interface class IAuthRemoteDS {
  Future<UserDTO> login({
    required String phone,
    required String password,
  });

  Future<CommonListsDTO> getRegisterFormOptions();

  Future<int> registerSmsSend({
    required UserPayload payload,
  });

  Future<UserDTO> registerSmsCheck({
    required String phone,
    required String code,
  });

  // Forgot password
  Future<int> forgotPasswordSmsSend({
    required String phone,
  });

  Future<String> forgotPasswordSmsCheck({
    required String phone,
    required String code,
  });

  Future forgotPasswordChangePassword({
    required String passwordToken,
    required String password,
    required String passwordConfirmation,
  });

  //
  Future<List<String>?> sendDeviceToken({
    required String deviceToken,
  });

  Future<String> generateCentrifugoToken();

  Future<AppVersionDTO> getForceUpdateVersion();
}

class AuthRemoteDSImpl implements IAuthRemoteDS {
  const AuthRemoteDSImpl({
    required this.restClient,
  });
  final IRestClient restClient;

  @override
  Future<UserDTO> login({
    required String phone,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/v1/auth/login',
        body: {
          'phone': phone,
          'password': password,
          'device_type': Platform.isIOS ? 'ios' : 'android',
        },
      );

      if (response['user'] == null || response['token'] == null) {
        return throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }

      if (response
          case {
            'token': final Map<String, Object?> tokenObject,
            'user': final Map<String, Object?> userObject,
          }) {
        final accessToken = tokenObject['access_token'] as String?;

        if (accessToken == null) {
          return throw WrongResponseTypeException(
            message:
                '''Unexpected response body type: ${response.runtimeType}\n$response''',
          );
        }

        final user = UserDTO.fromJson(userObject).copyWith(
          accessToken: accessToken,
        );
        return user;
      } else {
        throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#login - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<CommonListsDTO> getRegisterFormOptions() async {
    try {
      final Map<String, dynamic> response =
          await restClient.get('/v1/auth/register');

      return CommonListsDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getRegisterFormOptions - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<List<String>?> sendDeviceToken({
    required String deviceToken,
  }) async {
    try {
      final response = await restClient.put(
        '/v1/user/extra',
        body: {
          'device_token': deviceToken,
        },
      );

      if (response['push_notification_topics'] != null &&
          response['push_notification_topics'] is List) {
        return (response['push_notification_topics']! as List)
            .mapToList((e) => e as String);
      } else {
        return throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#sendDeviceToken - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<int> forgotPasswordSmsSend({
    required String phone,
  }) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/v1/auth/forgot-password/sms/send',
        body: {
          'phone': phone,
        },
      );

      final int? smsDelay = response['sms_delay'] as int?;

      if (smsDelay != null) {
        return smsDelay;
      } else {
        throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#forgotPasswordSmsSend - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<String> forgotPasswordSmsCheck({
    required String phone,
    required String code,
  }) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/v1/auth/forgot-password/sms/check',
        body: {
          'phone': phone,
          'code': code,
        },
      );

      final String? forgotPasswordToken =
          response['forgot_password_token'] as String?;

      if (forgotPasswordToken != null) {
        return forgotPasswordToken;
      } else {
        throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#forgotPasswordSmsSend - $e', e, st);
      rethrow;
    }
  }

  @override
  Future forgotPasswordChangePassword({
    required String passwordToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await restClient.post(
        '/v1/auth/forgot-password/change-password',
        body: {
          'token': passwordToken,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
    } catch (e, st) {
      TalkerLoggerUtil.talker
          .error('#forgotPasswordChangePassword - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<int> registerSmsSend({
    required UserPayload payload,
  }) async {
    try {
      final body = payload.toJson();
      body['device_type'] = Platform.isIOS ? 'ios' : 'android';

      final Map<String, dynamic> response = await restClient.post(
        '/v1/auth/register/sms/send',
        body: body,
      );

      final int? smsDelay = response['sms_delay'] as int?;

      if (smsDelay != null) {
        return smsDelay;
      } else {
        throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#registerSmsSend - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> registerSmsCheck({
    required String phone,
    required String code,
  }) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/v1/auth/register/sms/check',
        body: {
          'phone': phone,
          'code': code,
        },
      );

      if (response['user'] == null || response['token'] == null) {
        return throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }

      if (response case {'token': final Map<String, Object?> tokenObject}) {
        final accessToken = tokenObject['access_token'] as String?;

        if (accessToken == null) {
          return throw WrongResponseTypeException(
            message:
                '''Unexpected response body type: ${response.runtimeType}\n$response''',
          );
        }

        final user = UserDTO.fromJson(response['user']! as Map<String, dynamic>)
            .copyWith(
          accessToken: accessToken,
        );

        return user;
      } else {
        throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#login - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<String> generateCentrifugoToken() async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/v1/centrifugo/auth',
        body: {},
      );

      final String? token = response['token'] as String?;

      if (token != null) {
        return token;
      } else {
        throw WrongResponseTypeException(
          message:
              '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#generateCentrifugoToken - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<AppVersionDTO> getForceUpdateVersion() async {
    try {
      final Map<String, dynamic> response = await restClient.get('/v1/config');

      return AppVersionDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getForceUpdateVersion - $e', e, st);
      rethrow;
    }
  }
}
