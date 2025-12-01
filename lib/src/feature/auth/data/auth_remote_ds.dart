import 'dart:io';

import 'package:dio/dio.dart';
import 'package:haji_market/src/core/rest_client/rest_client.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import 'package:haji_market/src/feature/auth/data/DTO/register.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

abstract interface class IAuthRemoteDS {
  Future<UserDTO> login({
    required String phone,
    required String password,
    required String deviceToken,
  });

  Future<UserDTO> registerSmsCheck({required String phone, required String code});

  Future<UserDTO> register({required RegisterDTO registerDto, required String deviceToken});

  Future<UserDTO> lateAuth();

  Future<UserDTO> editProfile({
    required String firstName,
    required String lastName,
    required String surName,
    required String phone,
    String? avatarPath,
    required String gender,
    required String birthday,
    required String country,
    required String city,
    required String street,
    required String home,
    required String porch,
    required String floor,
    required String room,
    required String email,
  });

  Future<void> editPush({required int pushStatus});

  Future<void> updateCityCode({required String code});

  Future<void> deleteAccount();

  // Forgot password
  Future<int> forgotPasswordSmsSend({required String phone});

  Future<String> forgotPasswordSmsCheck({required String phone, required String code});

  Future<void> sendRegisterCode({required String phone});

  Future<void> passwordResetByPhone({required String phone, required String password});
}

class AuthRemoteDSImpl implements IAuthRemoteDS {
  const AuthRemoteDSImpl({required this.restClient});
  final IRestClient restClient;

  String _formatPhone(String phone, int substringIndex) {
    if (phone.length <= substringIndex) return phone;
    return phone.substring(substringIndex).replaceAll(RegExp('[^0-9]'), '');
  }

  Map<String, dynamic> _sanitizeUserMap(Map<String, dynamic> map) {
    final newMap = Map<String, dynamic>.from(map);
    
    if (newMap['city'] is String) {
      newMap['city'] = {'id': -1, 'name': newMap['city']};
    }
    
    if (newMap['class'] is String) {
       newMap['class'] = {'id': -1, 'name': newMap['class']};
    }
    
    return newMap;
  }

  @override
  Future<UserDTO> login({
    required String phone,
    required String password,
    required String deviceToken,
  }) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/user/login',
        body: {
          'phone': _formatPhone(phone, 1),
          'password': password,
          'device_type': Platform.isIOS ? 'ios' : 'android',
          'device_token': deviceToken,
        },
      );

      if (response['user'] == null && response['access_token'] == null) {
         // Fallback if structure is different
         if (response['token'] != null) {
            // Maybe it's the old structure?
         }
      }

      // Handling potential flat structure or nested structure
      final accessToken = (response['access_token'] ?? response['token']) as String?;
      
      Map<String, dynamic> userMap;
      if (response.containsKey('user') && response['user'] is Map) {
        userMap = response['user'] as Map<String, dynamic>;
      } else {
        userMap = response;
      }

      if (accessToken == null) {
        return throw WrongResponseTypeException(
          message: '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }

      final user = UserDTO.fromJson(_sanitizeUserMap(userMap)).copyWith(accessToken: accessToken);
      return user;

    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#login - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> register({required RegisterDTO registerDto, required String deviceToken}) async {
    try {
      final body = {
        'first_name': registerDto.firstName,
        'last_name': registerDto.lastName,
        'sur_name': registerDto.surName,
        'password': registerDto.password,
        'phone': _formatPhone(registerDto.phone, 2),
        'device_token': deviceToken,
        'device_type': Platform.isIOS ? 'ios' : 'android',
      };

      final Map<String, dynamic> response = await restClient.post(
        '/user/register',
        body: body,
        returnFullData: true,
      );

      final accessToken = response['access_token'] as String?;
      final userMap = response['user'] as Map<String, dynamic>?;

      if (accessToken != null && userMap != null) {
        return UserDTO.fromJson(_sanitizeUserMap(userMap)).copyWith(accessToken: accessToken);
      } else {
        throw WrongResponseTypeException(
          message: '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#register - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> lateAuth() async {
    try {
      final Map<String, dynamic> response = await restClient.post('/user/late/auth', body: {});

      final accessToken = response['access_token'] as String?;
      final userMap = response['user'] as Map<String, dynamic>?;

      if (accessToken != null && userMap != null) {
        return UserDTO.fromJson(_sanitizeUserMap(userMap)).copyWith(accessToken: accessToken);
      } else {
        throw WrongResponseTypeException(
          message: '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#lateAuth - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> editProfile({
    required String firstName,
    required String lastName,
    required String surName,
    required String phone,
    String? avatarPath,
    required String gender,
    required String birthday,
    required String country,
    required String city,
    required String street,
    required String home,
    required String porch,
    required String floor,
    required String room,
    required String email,
  }) async {
    try {
      final map = {
        'first_name': firstName,
        'last_name': lastName,
        'sur_name': surName,
        'phone': _formatPhone(phone, 2),
        'gender': gender,
        'birthday': birthday,
        'country': country,
        'city': city,
        'street': street,
        'home': home,
        'porch': porch,
        'floor': floor,
        'room': room,
        'email': email,
      };

      final formData = FormData.fromMap(map);

      if (avatarPath != null && avatarPath.isNotEmpty) {
        formData.files.add(MapEntry('avatar', await MultipartFile.fromFile(avatarPath)));
      }

      final Map<String, dynamic> response = await restClient.post('/user/edit', body: formData);

      final accessToken = response['access_token'] as String?;

      if (accessToken != null) {
        return UserDTO.fromJson(_sanitizeUserMap(response)).copyWith(accessToken: accessToken);
      } else {
        throw WrongResponseTypeException(
          message: '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#editProfile - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<void> editPush({required int pushStatus}) async {
    try {
      await restClient.post('/user/edit', body: {'push': pushStatus});
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#editPush - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<void> updateCityCode({required String code}) async {
    try {
      await restClient.post('/user/edit', body: {'code': code});
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#updateCityCode - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await restClient.post('/user/delete', body: {});
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#deleteAccount - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<int> forgotPasswordSmsSend({required String phone}) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/user/password/reset/send-code',
        body: {'phone': _formatPhone(phone, 1)},
      );

      final int? smsDelay = response['sms_delay'] as int?;
      return smsDelay ?? 0;
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#forgotPasswordSmsSend - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<String> forgotPasswordSmsCheck({required String phone, required String code}) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/user/password/reset/check-code',
        body: {'phone': _formatPhone(phone, 2), 'code': code},
      );

      final String? forgotPasswordToken = response['forgot_password_token'] as String?;
      return forgotPasswordToken ?? '';
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#forgotPasswordSmsCheck - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> registerSmsCheck({required String phone, required String code}) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/user/register/check',
        body: {'phone': _formatPhone(phone, 2), 'code': code},
      );

      if (response['user'] != null && response['access_token'] != null) {
         final accessToken = response['access_token'] as String?;
         final user = UserDTO.fromJson(_sanitizeUserMap(response['user'] as Map<String, dynamic>)).copyWith(accessToken: accessToken);
         return user;
      }
      
      throw WrongResponseTypeException(message: 'Response did not contain user data');

    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#registerSmsCheck - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<void> sendRegisterCode({required String phone}) async {
    try {
      await restClient.post(
        '/user/register/send-code',
        body: {'phone': _formatPhone(phone, 2)},
      );
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#sendRegisterCode - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<void> passwordResetByPhone({required String phone, required String password}) async {
    try {
      await restClient.post(
        '/user/password/reset',
        body: {'phone': _formatPhone(phone, 2), 'password': password},
      );
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#passwordResetByPhone - $e', e, st);
      rethrow;
    }
  }
}
