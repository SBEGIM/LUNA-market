// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuth,
    required TResult Function() exiting,
    required TResult Function() logining,
    required TResult Function(AppState state) chageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuth,
    TResult? Function()? exiting,
    TResult? Function()? logining,
    TResult? Function(AppState state)? chageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuth,
    TResult Function()? exiting,
    TResult Function()? logining,
    TResult Function(AppState state)? chageState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuth value) checkAuth,
    required TResult Function(_Exiting value) exiting,
    required TResult Function(_Logining value) logining,
    required TResult Function(_ChangeState value) chageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuth value)? checkAuth,
    TResult? Function(_Exiting value)? exiting,
    TResult? Function(_Logining value)? logining,
    TResult? Function(_ChangeState value)? chageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuth value)? checkAuth,
    TResult Function(_Exiting value)? exiting,
    TResult Function(_Logining value)? logining,
    TResult Function(_ChangeState value)? chageState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEventCopyWith<$Res> {
  factory $AppEventCopyWith(AppEvent value, $Res Function(AppEvent) then) =
      _$AppEventCopyWithImpl<$Res, AppEvent>;
}

/// @nodoc
class _$AppEventCopyWithImpl<$Res, $Val extends AppEvent>
    implements $AppEventCopyWith<$Res> {
  _$AppEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_CheckAuthCopyWith<$Res> {
  factory _$$_CheckAuthCopyWith(
          _$_CheckAuth value, $Res Function(_$_CheckAuth) then) =
      __$$_CheckAuthCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_CheckAuthCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$_CheckAuth>
    implements _$$_CheckAuthCopyWith<$Res> {
  __$$_CheckAuthCopyWithImpl(
      _$_CheckAuth _value, $Res Function(_$_CheckAuth) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_CheckAuth implements _CheckAuth {
  const _$_CheckAuth();

  @override
  String toString() {
    return 'AppEvent.checkAuth()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_CheckAuth);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuth,
    required TResult Function() exiting,
    required TResult Function() logining,
    required TResult Function(AppState state) chageState,
  }) {
    return checkAuth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuth,
    TResult? Function()? exiting,
    TResult? Function()? logining,
    TResult? Function(AppState state)? chageState,
  }) {
    return checkAuth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuth,
    TResult Function()? exiting,
    TResult Function()? logining,
    TResult Function(AppState state)? chageState,
    required TResult orElse(),
  }) {
    if (checkAuth != null) {
      return checkAuth();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuth value) checkAuth,
    required TResult Function(_Exiting value) exiting,
    required TResult Function(_Logining value) logining,
    required TResult Function(_ChangeState value) chageState,
  }) {
    return checkAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuth value)? checkAuth,
    TResult? Function(_Exiting value)? exiting,
    TResult? Function(_Logining value)? logining,
    TResult? Function(_ChangeState value)? chageState,
  }) {
    return checkAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuth value)? checkAuth,
    TResult Function(_Exiting value)? exiting,
    TResult Function(_Logining value)? logining,
    TResult Function(_ChangeState value)? chageState,
    required TResult orElse(),
  }) {
    if (checkAuth != null) {
      return checkAuth(this);
    }
    return orElse();
  }
}

abstract class _CheckAuth implements AppEvent {
  const factory _CheckAuth() = _$_CheckAuth;
}

/// @nodoc
abstract class _$$_ExitingCopyWith<$Res> {
  factory _$$_ExitingCopyWith(
          _$_Exiting value, $Res Function(_$_Exiting) then) =
      __$$_ExitingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ExitingCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$_Exiting>
    implements _$$_ExitingCopyWith<$Res> {
  __$$_ExitingCopyWithImpl(_$_Exiting _value, $Res Function(_$_Exiting) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Exiting implements _Exiting {
  const _$_Exiting();

  @override
  String toString() {
    return 'AppEvent.exiting()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Exiting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuth,
    required TResult Function() exiting,
    required TResult Function() logining,
    required TResult Function(AppState state) chageState,
  }) {
    return exiting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuth,
    TResult? Function()? exiting,
    TResult? Function()? logining,
    TResult? Function(AppState state)? chageState,
  }) {
    return exiting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuth,
    TResult Function()? exiting,
    TResult Function()? logining,
    TResult Function(AppState state)? chageState,
    required TResult orElse(),
  }) {
    if (exiting != null) {
      return exiting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuth value) checkAuth,
    required TResult Function(_Exiting value) exiting,
    required TResult Function(_Logining value) logining,
    required TResult Function(_ChangeState value) chageState,
  }) {
    return exiting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuth value)? checkAuth,
    TResult? Function(_Exiting value)? exiting,
    TResult? Function(_Logining value)? logining,
    TResult? Function(_ChangeState value)? chageState,
  }) {
    return exiting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuth value)? checkAuth,
    TResult Function(_Exiting value)? exiting,
    TResult Function(_Logining value)? logining,
    TResult Function(_ChangeState value)? chageState,
    required TResult orElse(),
  }) {
    if (exiting != null) {
      return exiting(this);
    }
    return orElse();
  }
}

abstract class _Exiting implements AppEvent {
  const factory _Exiting() = _$_Exiting;
}

/// @nodoc
abstract class _$$_LoginingCopyWith<$Res> {
  factory _$$_LoginingCopyWith(
          _$_Logining value, $Res Function(_$_Logining) then) =
      __$$_LoginingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoginingCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$_Logining>
    implements _$$_LoginingCopyWith<$Res> {
  __$$_LoginingCopyWithImpl(
      _$_Logining _value, $Res Function(_$_Logining) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Logining implements _Logining {
  const _$_Logining();

  @override
  String toString() {
    return 'AppEvent.logining()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Logining);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuth,
    required TResult Function() exiting,
    required TResult Function() logining,
    required TResult Function(AppState state) chageState,
  }) {
    return logining();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuth,
    TResult? Function()? exiting,
    TResult? Function()? logining,
    TResult? Function(AppState state)? chageState,
  }) {
    return logining?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuth,
    TResult Function()? exiting,
    TResult Function()? logining,
    TResult Function(AppState state)? chageState,
    required TResult orElse(),
  }) {
    if (logining != null) {
      return logining();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuth value) checkAuth,
    required TResult Function(_Exiting value) exiting,
    required TResult Function(_Logining value) logining,
    required TResult Function(_ChangeState value) chageState,
  }) {
    return logining(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuth value)? checkAuth,
    TResult? Function(_Exiting value)? exiting,
    TResult? Function(_Logining value)? logining,
    TResult? Function(_ChangeState value)? chageState,
  }) {
    return logining?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuth value)? checkAuth,
    TResult Function(_Exiting value)? exiting,
    TResult Function(_Logining value)? logining,
    TResult Function(_ChangeState value)? chageState,
    required TResult orElse(),
  }) {
    if (logining != null) {
      return logining(this);
    }
    return orElse();
  }
}

abstract class _Logining implements AppEvent {
  const factory _Logining() = _$_Logining;
}

/// @nodoc
abstract class _$$_ChangeStateCopyWith<$Res> {
  factory _$$_ChangeStateCopyWith(
          _$_ChangeState value, $Res Function(_$_ChangeState) then) =
      __$$_ChangeStateCopyWithImpl<$Res>;
  @useResult
  $Res call({AppState state});

  $AppStateCopyWith<$Res> get state;
}

/// @nodoc
class __$$_ChangeStateCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$_ChangeState>
    implements _$$_ChangeStateCopyWith<$Res> {
  __$$_ChangeStateCopyWithImpl(
      _$_ChangeState _value, $Res Function(_$_ChangeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$_ChangeState(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as AppState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AppStateCopyWith<$Res> get state {
    return $AppStateCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value));
    });
  }
}

/// @nodoc

class _$_ChangeState implements _ChangeState {
  const _$_ChangeState({required this.state});

  @override
  final AppState state;

  @override
  String toString() {
    return 'AppEvent.chageState(state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeState &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeStateCopyWith<_$_ChangeState> get copyWith =>
      __$$_ChangeStateCopyWithImpl<_$_ChangeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuth,
    required TResult Function() exiting,
    required TResult Function() logining,
    required TResult Function(AppState state) chageState,
  }) {
    return chageState(state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuth,
    TResult? Function()? exiting,
    TResult? Function()? logining,
    TResult? Function(AppState state)? chageState,
  }) {
    return chageState?.call(state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuth,
    TResult Function()? exiting,
    TResult Function()? logining,
    TResult Function(AppState state)? chageState,
    required TResult orElse(),
  }) {
    if (chageState != null) {
      return chageState(state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuth value) checkAuth,
    required TResult Function(_Exiting value) exiting,
    required TResult Function(_Logining value) logining,
    required TResult Function(_ChangeState value) chageState,
  }) {
    return chageState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuth value)? checkAuth,
    TResult? Function(_Exiting value)? exiting,
    TResult? Function(_Logining value)? logining,
    TResult? Function(_ChangeState value)? chageState,
  }) {
    return chageState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuth value)? checkAuth,
    TResult Function(_Exiting value)? exiting,
    TResult Function(_Logining value)? logining,
    TResult Function(_ChangeState value)? chageState,
    required TResult orElse(),
  }) {
    if (chageState != null) {
      return chageState(this);
    }
    return orElse();
  }
}

abstract class _ChangeState implements AppEvent {
  const factory _ChangeState({required final AppState state}) = _$_ChangeState;

  AppState get state;
  @JsonKey(ignore: true)
  _$$_ChangeStateCopyWith<_$_ChangeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoadingStateCopyWith<$Res> {
  factory _$$_LoadingStateCopyWith(
          _$_LoadingState value, $Res Function(_$_LoadingState) then) =
      __$$_LoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_LoadingState>
    implements _$$_LoadingStateCopyWith<$Res> {
  __$$_LoadingStateCopyWithImpl(
      _$_LoadingState _value, $Res Function(_$_LoadingState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_LoadingState implements _LoadingState {
  const _$_LoadingState();

  @override
  String toString() {
    return 'AppState.loadingState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_LoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) {
    return loadingState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) {
    return loadingState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return loadingState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return loadingState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState(this);
    }
    return orElse();
  }
}

abstract class _LoadingState implements AppState {
  const factory _LoadingState() = _$_LoadingState;
}

/// @nodoc
abstract class _$$_NotAuthorizedStateCopyWith<$Res> {
  factory _$$_NotAuthorizedStateCopyWith(_$_NotAuthorizedState value,
          $Res Function(_$_NotAuthorizedState) then) =
      __$$_NotAuthorizedStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NotAuthorizedStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_NotAuthorizedState>
    implements _$$_NotAuthorizedStateCopyWith<$Res> {
  __$$_NotAuthorizedStateCopyWithImpl(
      _$_NotAuthorizedState _value, $Res Function(_$_NotAuthorizedState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_NotAuthorizedState implements _NotAuthorizedState {
  const _$_NotAuthorizedState();

  @override
  String toString() {
    return 'AppState.notAuthorizedState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NotAuthorizedState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) {
    return notAuthorizedState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) {
    return notAuthorizedState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (notAuthorizedState != null) {
      return notAuthorizedState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return notAuthorizedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return notAuthorizedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (notAuthorizedState != null) {
      return notAuthorizedState(this);
    }
    return orElse();
  }
}

abstract class _NotAuthorizedState implements AppState {
  const factory _NotAuthorizedState() = _$_NotAuthorizedState;
}

/// @nodoc
abstract class _$$_InAppUserStateCopyWith<$Res> {
  factory _$$_InAppUserStateCopyWith(
          _$_InAppUserState value, $Res Function(_$_InAppUserState) then) =
      __$$_InAppUserStateCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$_InAppUserStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_InAppUserState>
    implements _$$_InAppUserStateCopyWith<$Res> {
  __$$_InAppUserStateCopyWithImpl(
      _$_InAppUserState _value, $Res Function(_$_InAppUserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$_InAppUserState(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_InAppUserState implements _InAppUserState {
  const _$_InAppUserState({this.index});

  @override
  final int? index;

  @override
  String toString() {
    return 'AppState.inAppUserState(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InAppUserState &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InAppUserStateCopyWith<_$_InAppUserState> get copyWith =>
      __$$_InAppUserStateCopyWithImpl<_$_InAppUserState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) {
    return inAppUserState(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) {
    return inAppUserState?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (inAppUserState != null) {
      return inAppUserState(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return inAppUserState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return inAppUserState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (inAppUserState != null) {
      return inAppUserState(this);
    }
    return orElse();
  }
}

abstract class _InAppUserState implements AppState {
  const factory _InAppUserState({final int? index}) = _$_InAppUserState;

  int? get index;
  @JsonKey(ignore: true)
  _$$_InAppUserStateCopyWith<_$_InAppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_InAppBlogerStateCopyWith<$Res> {
  factory _$$_InAppBlogerStateCopyWith(
          _$_InAppBlogerState value, $Res Function(_$_InAppBlogerState) then) =
      __$$_InAppBlogerStateCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$_InAppBlogerStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_InAppBlogerState>
    implements _$$_InAppBlogerStateCopyWith<$Res> {
  __$$_InAppBlogerStateCopyWithImpl(
      _$_InAppBlogerState _value, $Res Function(_$_InAppBlogerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$_InAppBlogerState(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_InAppBlogerState implements _InAppBlogerState {
  const _$_InAppBlogerState({this.index});

  @override
  final int? index;

  @override
  String toString() {
    return 'AppState.inAppBlogerState(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InAppBlogerState &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InAppBlogerStateCopyWith<_$_InAppBlogerState> get copyWith =>
      __$$_InAppBlogerStateCopyWithImpl<_$_InAppBlogerState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) {
    return inAppBlogerState(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) {
    return inAppBlogerState?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (inAppBlogerState != null) {
      return inAppBlogerState(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return inAppBlogerState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return inAppBlogerState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (inAppBlogerState != null) {
      return inAppBlogerState(this);
    }
    return orElse();
  }
}

abstract class _InAppBlogerState implements AppState {
  const factory _InAppBlogerState({final int? index}) = _$_InAppBlogerState;

  int? get index;
  @JsonKey(ignore: true)
  _$$_InAppBlogerStateCopyWith<_$_InAppBlogerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_InAppAdminStateCopyWith<$Res> {
  factory _$$_InAppAdminStateCopyWith(
          _$_InAppAdminState value, $Res Function(_$_InAppAdminState) then) =
      __$$_InAppAdminStateCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$_InAppAdminStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_InAppAdminState>
    implements _$$_InAppAdminStateCopyWith<$Res> {
  __$$_InAppAdminStateCopyWithImpl(
      _$_InAppAdminState _value, $Res Function(_$_InAppAdminState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$_InAppAdminState(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_InAppAdminState implements _InAppAdminState {
  const _$_InAppAdminState({this.index});

  @override
  final int? index;

  @override
  String toString() {
    return 'AppState.inAppAdminState(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InAppAdminState &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InAppAdminStateCopyWith<_$_InAppAdminState> get copyWith =>
      __$$_InAppAdminStateCopyWithImpl<_$_InAppAdminState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) {
    return inAppAdminState(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) {
    return inAppAdminState?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (inAppAdminState != null) {
      return inAppAdminState(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return inAppAdminState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return inAppAdminState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (inAppAdminState != null) {
      return inAppAdminState(this);
    }
    return orElse();
  }
}

abstract class _InAppAdminState implements AppState {
  const factory _InAppAdminState({final int? index}) = _$_InAppAdminState;

  int? get index;
  @JsonKey(ignore: true)
  _$$_InAppAdminStateCopyWith<_$_InAppAdminState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorStateCopyWith<$Res> {
  factory _$$_ErrorStateCopyWith(
          _$_ErrorState value, $Res Function(_$_ErrorState) then) =
      __$$_ErrorStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_ErrorState>
    implements _$$_ErrorStateCopyWith<$Res> {
  __$$_ErrorStateCopyWithImpl(
      _$_ErrorState _value, $Res Function(_$_ErrorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_ErrorState(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorState implements _ErrorState {
  const _$_ErrorState({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppState.errorState(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorState &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorStateCopyWith<_$_ErrorState> get copyWith =>
      __$$_ErrorStateCopyWithImpl<_$_ErrorState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(String message) errorState,
  }) {
    return errorState(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(String message)? errorState,
  }) {
    return errorState?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_NotAuthorizedState value) notAuthorizedState,
    required TResult Function(_InAppUserState value) inAppUserState,
    required TResult Function(_InAppBlogerState value) inAppBlogerState,
    required TResult Function(_InAppAdminState value) inAppAdminState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return errorState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return errorState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(this);
    }
    return orElse();
  }
}

abstract class _ErrorState implements AppState {
  const factory _ErrorState({required final String message}) = _$_ErrorState;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorStateCopyWith<_$_ErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}
