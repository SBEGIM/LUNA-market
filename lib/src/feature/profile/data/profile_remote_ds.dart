import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:haji_market/src/core/rest_client/rest_client.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import 'package:haji_market/src/feature/auth/data/models/common_lists_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/profile_data_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/request/user_payload.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

abstract interface class IProfileRemoteDS {
  Future<ProfileDataDTO> getProfile();

  Future logout();

  Future deleteAccount();

  Future updateLanguage({required String languageCode});

  Future<UserDTO> updateAvatar({required Uint8List? imageByteUint8List});

  Future<void> addChild({required int id});

  Future<void> deleteChild({required int id});
  Future<CommonListsDTO> getProfileUpdateFormOptions();

  Future<UserDTO> updateProfile({required UserPayload payload});

  Future<List<UserDTO>> getChildren();
  Future<int> updatePhoneSmsSend({required String phone});

  Future<UserDTO> updatePhoneSmsCheck({required String phone, required String code});

  Future<UserDTO> changePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  });

  Future makeAchievementShown({required int achievementId});
}

class ProfileRemoteDSImpl implements IProfileRemoteDS {
  const ProfileRemoteDSImpl({required this.restClient});
  final IRestClient restClient;

  @override
  Future<void> addChild({required int id}) async {
    try {
      final response = await restClient.post('/v1/user/parent/child/$id', body: null);
      TalkerLoggerUtil.talker.info('#addChild - Success: $response');
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#addChild - Error: $e', e, st);
      rethrow; // Propagate the exception for higher-level handling
    }
  }

  @override
  Future<void> deleteChild({required int id}) async {
    try {
      final response = await restClient.delete('/v1/user/parent/child/$id');
      TalkerLoggerUtil.talker.info('#deleteChild - Success: $response');
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#deleteChild - Error: $e', e, st);
      rethrow; // Propagate the exception for higher-level handling
    }
  }

  @override
  Future<ProfileDataDTO> getProfile() async {
    try {
      final Map<String, dynamic> response = await restClient.get('/v1/user');

      return ProfileDataDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getProfile - $e', e, st);
      rethrow;
    }
  }

  @override
  Future deleteAccount() async {
    try {
      await restClient.delete('/v1/user');
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#deleteAccount - $e', e, st);
      rethrow;
    }
  }

  @override
  Future logout() async {
    try {
      await restClient.post('/v1/user/logout', body: null);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#logout - $e', e, st);
      rethrow;
    }
  }

  @override
  Future updateLanguage({required String languageCode}) async {
    try {
      await restClient.put('/v1/user/lang', body: {'lang': languageCode});
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#updateLanguage - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> updateAvatar({required Uint8List? imageByteUint8List}) async {
    try {
      FormData? formData;
      if (imageByteUint8List != null) {
        formData = FormData.fromMap({
          'avatar': MultipartFile.fromBytes(imageByteUint8List, filename: 'test.png'),
          '_method': 'PUT',
        });
      } else {
        formData = FormData.fromMap({'_method': 'PUT'});
      }

      final Map<String, dynamic> response = await restClient.post(
        '/v1/user/avatar',
        body: formData,
        headers: {'connection': 'keep-alive'},
      );

      return UserDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#updateAvatar - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<CommonListsDTO> getProfileUpdateFormOptions() async {
    try {
      final Map<String, dynamic> response = await restClient.get('/v1/user/form');

      return await compute<Map<String, dynamic>, CommonListsDTO>(CommonListsDTO.fromJson, response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getProfileUpdateFormOptions - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> updateProfile({required UserPayload payload}) async {
    try {
      final Map<String, dynamic> response = await restClient.put(
        '/v1/user/profile',
        body: payload.toJson(),
      );

      return UserDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#updateProfile - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<int> updatePhoneSmsSend({required String phone}) async {
    try {
      final Map<String, dynamic> response = await restClient.post(
        '/v1/user/phone/sms/send',
        body: {'phone': phone},
      );

      final int? smsDelay = response['sms_delay'] as int?;

      if (smsDelay != null) {
        return smsDelay;
      } else {
        throw WrongResponseTypeException(
          message: '''Unexpected response body type: ${response.runtimeType}\n$response''',
        );
      }
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#updatePhoneSmsSend - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> updatePhoneSmsCheck({required String phone, required String code}) async {
    try {
      final Map<String, dynamic> response = await restClient.put(
        '/v1/user/phone/sms/check',
        body: {'phone': phone, 'code': code},
      );

      return UserDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#updatePhoneSmsCheck - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<UserDTO> changePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final Map<String, dynamic> response = await restClient.put(
        '/v1/user/password',
        body: {
          'old_password': oldPassword,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      return UserDTO.fromJson(response);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#changePassword - $e', e, st);
      rethrow;
    }
  }

  @override
  Future makeAchievementShown({required int achievementId}) async {
    try {
      await restClient.post('/v1/user/achievement/$achievementId/shown', body: null);
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#makeAchievementShown - $e', e, st);
      rethrow;
    }
  }

  @override
  Future<List<UserDTO>> getChildren() {
    // TODO: implement getChildren
    throw UnimplementedError();
  }
}
