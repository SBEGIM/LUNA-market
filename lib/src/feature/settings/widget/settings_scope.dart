import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:haji_market/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:haji_market/src/feature/settings/model/app_settings.dart';

/// SettingsScope widget.
class SettingsScope extends StatefulWidget {
  const SettingsScope({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Get the [AppSettingsBloc] instance.
  static AppSettingsBloc of(
    BuildContext context, {
    bool listen = true,
  }) {
    final settingsScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
        : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return settingsScope!.state._appSettingsBloc;
  }

  /// Get the [AppSettings] instance.
  static AppSettings settingsOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final settingsScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
        : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return settingsScope!.settings ?? const AppSettings(locale: Locale('kk'));
  }

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

/// State for widget SettingsScope.
class _SettingsScopeState extends State<SettingsScope> {
  late final AppSettingsBloc _appSettingsBloc;

  @override
  void initState() {
    _appSettingsBloc = DependenciesScope.of(context).appSettingsBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppSettingsBloc, AppSettingsState>(
        bloc: _appSettingsBloc,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            // BlocProvider(
            //   create: (context) => AppBloc(context.repository.authRepository),
            // ),
            // BlocProvider(
            //   create: (context) => ProfileBLoC(
            //     authRepository: context.repository.authRepository,
            //     profileRepository: context.repository.profileRepository,
            //   ),
            // ),
            // BlocProvider(
            //   create: (context) => AppRoleBloc(),
            // ),
          ],
          child: _InheritedSettings(
            settings: state.appSettings,
            state: this,
            child: widget.child,
          ),
        ),
      );
}

/// _InheritedSettings widget.
class _InheritedSettings extends InheritedWidget {
  const _InheritedSettings({
    required super.child,
    required this.state,
    required this.settings,
  });

  /// _SettingsScopeState instance.
  final _SettingsScopeState state;
  final AppSettings? settings;

  @override
  bool updateShouldNotify(covariant _InheritedSettings oldWidget) =>
      settings != oldWidget.settings;
}
