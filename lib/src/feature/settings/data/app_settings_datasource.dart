import 'dart:ui';
import 'package:haji_market/src/core/theme/resources.dart';
import 'package:haji_market/src/core/utils/persisted_entry.dart';
import 'package:haji_market/src/feature/settings/model/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template app_settings_datasource}
/// [AppSettingsDatasource] sets and gets app settings.
/// {@endtemplate}
abstract interface class AppSettingsDatasource {
  /// Set app settings
  Future<void> setAppSettings(AppSettings appSettings);

  /// Load [AppSettings] from the source of truth.
  Future<AppSettings> getAppSettings();
}

/// {@macro app_settings_datasource}
final class AppSettingsDatasourceImpl implements AppSettingsDatasource {
  /// {@macro app_settings_datasource}
  AppSettingsDatasourceImpl({required this.sharedPreferences});

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferencesAsync sharedPreferences;

  late final _appSettings = AppSettingsPersistedEntry(
    sharedPreferences: sharedPreferences,
    key: 'settings',
  );

  @override
  Future<AppSettings> getAppSettings() => _appSettings.read();

  @override
  Future<void> setAppSettings(AppSettings appSettings) =>
      _appSettings.set(appSettings);
}

/// Persisted entry for [AppSettings]
class AppSettingsPersistedEntry extends SharedPreferencesEntry<AppSettings> {
  /// Create [AppSettingsPersistedEntry]
  AppSettingsPersistedEntry(
      {required super.sharedPreferences, required super.key});

  late final _themeMode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.themeMode',
  );

  late final _themeSeedColor = IntPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.seedColor',
  );

  late final _localeLanguageCode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.locale.languageCode',
  );

  late final _localeCountryCode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.locale.countryCode',
  );

  late final _textScale = DoublePreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.textScale',
  );

  @override
  Future<AppSettings> read() async {
    final textScale = await _textScale.read();
    final themeMode = await _themeMode.read();
    final themeSeedColor = await _themeSeedColor.read();
    final languageCode = await _localeLanguageCode.read();
    final countryCode = await _localeCountryCode.read();

    AppTheme? appTheme;

    if (themeMode != null && themeSeedColor != null) {
      // appTheme = AppTheme(
      //   themeMode: const ThemeModeCodec().decode(themeMode),
      //   seed: colorCodec.decode(themeSeedColor),
      // );
    }

    Locale? appLocale;

    if (languageCode != null) {
      appLocale = Locale(
        languageCode,
        countryCode,
      );
    }

    if (appLocale == null) {
      // set default language
      await _localeLanguageCode.set('kk');
      appLocale = const Locale('kk');
    }

    return AppSettings(
      appTheme: appTheme,
      locale: appLocale,
      textScale: textScale,
    );
  }

  @override
  Future<void> remove() async {
    await (
      _themeMode.remove(),
      _themeSeedColor.remove(),
      _localeLanguageCode.remove(),
      _localeCountryCode.remove(),
      _textScale.remove()
    ).wait;
  }

  @override
  Future<void> set(AppSettings value) async {
    if (value.appTheme != null) {
      // await (
      //   _themeMode
      //       .set(const ThemeModeCodec().encode(value.appTheme!.themeMode)),
      //   _themeSeedColor.set(colorCodec.encode(value.appTheme!.seed)),
      // ).wait;
    }

    await _localeLanguageCode.set(value.locale.languageCode);

    if (value.locale.countryCode != null) {
      await _localeCountryCode.set(value.locale.countryCode!);
    }

    if (value.textScale != null) {
      await _textScale.set(value.textScale!);
    }
  }
}
