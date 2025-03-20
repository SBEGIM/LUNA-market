import 'dart:convert';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
// import 'package:haji_market/src/features/app/service/notification_service.dart';
import 'package:haji_market/src/feature/auth/data/auth_remote_ds.dart';
import 'package:haji_market/src/feature/auth/database/auth_dao.dart';
import 'package:haji_market/src/feature/auth/data/models/app_version_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/common_lists_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/request/user_payload.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

abstract interface class IAuthRepository {
  bool get isAuthenticated;

  UserDTO? get user;

  Future<AppVersionDTO> getForceUpdateVersion();

  Future<List<String>?> sendDeviceToken();

  Future<void> clearUser();

  // Forgot password API's
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

  /// Auth
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

  Future<String> generateCentrifugoToken();
}

class AuthRepositoryImpl implements IAuthRepository {
  const AuthRepositoryImpl({
    required IAuthRemoteDS remoteDS,
    required IAuthDao authDao,
  })  : _remoteDS = remoteDS,
        _authDao = authDao;
  final IAuthRemoteDS _remoteDS;
  final IAuthDao _authDao;

  @override
  bool get isAuthenticated => _authDao.user.value != null;

  @override
  UserDTO? get user {
    try {
      final userStr = _authDao.user.value;
      if (userStr != null) {
        return UserDTO.fromJson(
          jsonDecode(userStr) as Map<String, dynamic>,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _authDao.user.remove();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppVersionDTO> getForceUpdateVersion() async {
    try {
      return await _remoteDS.getForceUpdateVersion();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> sendDeviceToken() async {
    try {
      final deviceToken = _authDao.deviceToken.value;
      // await NotificationService.instance.getDeviceToken(
      //   authDao: _authDao,
      // );

      final remoteTopics = await _remoteDS.sendDeviceToken(
        deviceToken: deviceToken ?? 'DEVICE_TOKEN_ERROR',
      );

      if (remoteTopics == null) return null;

      final Set<String> remoteSet = remoteTopics.toSet();
      final Set<String> localSet = (_authDao.pushTopics.value ?? []).toSet();

      // Определяем темы для отписки и подписки
      final List<String> topicsToUnsubscribe =
          localSet.difference(remoteSet).toList();
      final List<String> topicsToSubscribe =
          remoteSet.difference(localSet).toList();
      TalkerLoggerUtil.talker.info('topicsToUnsubscribe $topicsToUnsubscribe');
      TalkerLoggerUtil.talker.info('topicsToSubscribe $topicsToSubscribe');

      // Отписка от старых тем
      // for (final topic in topicsToUnsubscribe) {
      // await NotificationService.instance.unsubscribeFromTopic(topic: topic);
      // }

      // Сохраняем актуальные топики в локальный кэш
      await _authDao.pushTopics.setValue(remoteTopics);

      // Подписка на новые топики
      // for (final topic in topicsToSubscribe) {
      // await NotificationService.instance.subscribeToTopic(topic: topic);
      // }

      return remoteTopics;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> login({
    required String phone,
    required String password,
  }) async {
    try {
      final user = await _remoteDS.login(
        phone: phone,
        password: password,
      );

      await _authDao.user.setValue(jsonEncode(user.toJson()));

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> forgotPasswordSmsSend({
    required String phone,
  }) async {
    try {
      return await _remoteDS.forgotPasswordSmsSend(phone: phone);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> forgotPasswordSmsCheck({
    required String phone,
    required String code,
  }) async {
    try {
      return await _remoteDS.forgotPasswordSmsCheck(
        phone: phone,
        code: code,
      );
    } catch (e) {
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
      return await _remoteDS.forgotPasswordChangePassword(
        passwordToken: passwordToken,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommonListsDTO> getRegisterFormOptions() async {
    try {
      return await _remoteDS.getRegisterFormOptions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> registerSmsSend({
    required UserPayload payload,
  }) async {
    try {
      return await _remoteDS.registerSmsSend(payload: payload);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> registerSmsCheck({
    required String phone,
    required String code,
  }) async {
    try {
      final user = await _remoteDS.registerSmsCheck(
        phone: phone,
        code: code,
      );

      await _authDao.user.setValue(jsonEncode(user.toJson()));

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> generateCentrifugoToken() async {
    try {
      final token = await _remoteDS.generateCentrifugoToken();

      return token;
    } catch (e) {
      rethrow;
    }
  }
}
