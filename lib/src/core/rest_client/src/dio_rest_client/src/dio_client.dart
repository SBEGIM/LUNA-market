import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';
import 'package:haji_market/src/feature/auth/database/auth_dao.dart';
import 'package:haji_market/src/feature/settings/data/app_settings_datasource.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:uuid/uuid.dart';

class DioClient {
  factory DioClient({
    required String baseUrl,
    required Interceptor interceptor,
    required IAuthDao authDao,
    required PackageInfo packageInfo,
    // required ISettingsDao settings,
    required AppSettingsDatasource appSettingsDS,
    Dio? initialDio,
    bool useInterceptorWrapper = true,
  }) => DioClient._internal(
    baseUrl: baseUrl,
    initialDio: initialDio,
    interceptor: interceptor,
    authDao: authDao,
    packageInfo: packageInfo,
    // settings: settings,
    appSettingsDS: appSettingsDS,
    useInterceptorWrapper: useInterceptorWrapper,
  );

  DioClient._internal({
    required String baseUrl,
    required Interceptor interceptor,
    required IAuthDao authDao,
    required PackageInfo packageInfo,
    // required ISettingsDao settings,
    required AppSettingsDatasource appSettingsDS,
    required Dio? initialDio,
    required bool useInterceptorWrapper,
  }) : dio = initialDio ?? Dio(BaseOptions(baseUrl: baseUrl)) {
    _initInterceptors(
      dioInterceptor: interceptor,
      authDao: authDao,
      packageInfo: packageInfo,
      // settings: settings,
      appSettingsDS: appSettingsDS,
      useInterceptorWrapper: useInterceptorWrapper,
      uuid: const Uuid(),
    );
  }

  final Dio dio;

  void _initInterceptors({
    required Interceptor dioInterceptor,
    required IAuthDao authDao,
    required PackageInfo packageInfo,
    // required ISettingsDao settings,
    required AppSettingsDatasource appSettingsDS,
    required bool useInterceptorWrapper,
    required Uuid uuid,
  }) {
    if (useInterceptorWrapper) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final appSettings = await appSettingsDS.getAppSettings();

            options.headers['Accept'] = 'application/json';
            options.headers['version'] = packageInfo.version;
            options.headers['Accept-Language'] = appSettings.locale.languageCode;
            options.headers['X-Request-Id'] = uuid.v1();

            final userStr = authDao.user.value;
            if (userStr != null) {
              final user = UserDTO.fromJson(jsonDecode(userStr) as Map<String, dynamic>);
              if (user.accessToken != null) {
                options.headers['Authorization'] = 'Bearer ${user.accessToken}';
              }
            }

            return handler.next(options);
          },
          onError: (e, handler) => handler.next(e),
        ),
      );
    }

    /// Adds `TalkerDioLogger` to intercept Dio requests and responses and
    /// log them using Talker service.
    dio.interceptors.add(
      TalkerDioLogger(
        talker: TalkerLoggerUtil.talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseData: true,
        ),
      ),
    );

    dio.interceptors.add(dioInterceptor);
  }
}
