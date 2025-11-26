import 'package:haji_market/src/feature/auth/data/auth_remote_ds.dart';
import 'package:haji_market/src/feature/auth/data/auth_repository.dart';
import 'package:haji_market/src/feature/auth/database/auth_dao.dart';
import 'package:haji_market/src/feature/home/data/repository/banner_repository.dart';
import 'package:haji_market/src/feature/home/data/repository/banners_remote_ds.dart';
import 'package:haji_market/src/feature/home/data/repository/cats_remote_ds.dart';
import 'package:haji_market/src/feature/home/data/repository/cats_repository.dart';
import 'package:haji_market/src/feature/profile/data/profile_remote_ds.dart';
import 'package:haji_market/src/feature/profile/data/profile_repository.dart';
import 'package:haji_market/src/feature/settings/data/app_settings_datasource.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haji_market/src/core/rest_client/rest_client.dart';
import 'package:haji_market/src/core/rest_client/src/dio_rest_client/src/dio_client.dart';
import 'package:haji_market/src/core/rest_client/src/dio_rest_client/src/interceptor/dio_interceptor.dart';
import 'package:haji_market/src/core/rest_client/src/dio_rest_client/src/rest_client_dio.dart';
// import 'package:haji_market/src/feature/auth/data/auth_remote_ds.dart';

abstract class IRepositoryStorage {
  // dao's
  IAuthDao get authDao;

  /// Network
  IRestClient get restClient;

  // Repositories
  IAuthRepository get authRepository;
  IProfileRepository get profileRepository;
  ICatsRepository get catsRepository;
  IBannersRepository get bannersRepository;

  // Data sources
  IAuthRemoteDS get authRemoteDS;
  IProfileRemoteDS get profileRemoteDS;
  ICatsRemoteDS get catsRemoteDS;
  IBannersRemoteDS get bannersRemoteDS;

  void close();
}

class RepositoryStorage implements IRepositoryStorage {
  RepositoryStorage({
    required SharedPreferencesWithCache sharedPreferences,
    required PackageInfo packageInfo,
    required AppSettingsDatasource appSettingsDatasource,
  }) : _sharedPreferences = sharedPreferences,
       _packageInfo = packageInfo,
       _appSettingsDatasource = appSettingsDatasource;
  final SharedPreferencesWithCache _sharedPreferences;
  final PackageInfo _packageInfo;
  final AppSettingsDatasource _appSettingsDatasource;
  IRestClient? _restClient;

  @override
  Future<void> close() async {
    _restClient = null;
    // _portalRestClient = null;
    // _marketplaceRestClient = null;
    // _gamificationRestClient = null;
  }

  ///
  /// Network
  ///
  @override
  IRestClient get restClient => _restClient ??= RestClientDio(
    baseUrl: 'https://lunamarket.ru/api', // TODO: Env.apiUrl,
    dioClient: DioClient(
      baseUrl: 'https://lunamartket.ru/api',
      interceptor: const DioInterceptor(),
      authDao: authDao,
      packageInfo: _packageInfo,
      appSettingsDS: _appSettingsDatasource,
      // settings: SettingsDao(sharedPreferences: sharedPreferences),
    ),
  );

  ///
  /// Repositories
  ///
  @override
  IAuthRepository get authRepository =>
      AuthRepositoryImpl(remoteDS: authRemoteDS, authDao: authDao);

  @override
  IProfileRepository get profileRepository =>
      ProfileRepositoryImpl(remoteDS: profileRemoteDS, authDao: authDao);

  @override
  ICatsRepository get catsRepository => CatsRepositoryImpl(remoteDS: catsRemoteDS);

  @override
  IBannersRepository get bannersRepository => BannersRepositoryImpl(remoteDS: bannersRemoteDS);

  ///
  /// Remote datasources
  ///
  @override
  IProfileRemoteDS get profileRemoteDS => ProfileRemoteDSImpl(restClient: restClient);

  @override
  IAuthRemoteDS get authRemoteDS => AuthRemoteDSImpl(restClient: restClient);

  @override
  ICatsRemoteDS get catsRemoteDS => CatsRemoteDSImpl(restClient: restClient);

  @override
  IBannersRemoteDS get bannersRemoteDS => BannersRemoteDSImpl(restClient: restClient);

  ///
  /// Data Access Object
  ///
  @override
  IAuthDao get authDao => AuthDao(sharedPreferences: _sharedPreferences);
}
