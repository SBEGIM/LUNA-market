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
abstract class _$$CheckAuthImplCopyWith<$Res> {
  factory _$$CheckAuthImplCopyWith(
          _$CheckAuthImpl value, $Res Function(_$CheckAuthImpl) then) =
      __$$CheckAuthImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAuthImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$CheckAuthImpl>
    implements _$$CheckAuthImplCopyWith<$Res> {
  __$$CheckAuthImplCopyWithImpl(
      _$CheckAuthImpl _value, $Res Function(_$CheckAuthImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CheckAuthImpl implements _CheckAuth {
  const _$CheckAuthImpl();

  @override
  String toString() {
    return 'AppEvent.checkAuth()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckAuthImpl);
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
  const factory _CheckAuth() = _$CheckAuthImpl;
}

/// @nodoc
abstract class _$$ExitingImplCopyWith<$Res> {
  factory _$$ExitingImplCopyWith(
          _$ExitingImpl value, $Res Function(_$ExitingImpl) then) =
      __$$ExitingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExitingImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$ExitingImpl>
    implements _$$ExitingImplCopyWith<$Res> {
  __$$ExitingImplCopyWithImpl(
      _$ExitingImpl _value, $Res Function(_$ExitingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExitingImpl implements _Exiting {
  const _$ExitingImpl();

  @override
  String toString() {
    return 'AppEvent.exiting()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExitingImpl);
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
  const factory _Exiting() = _$ExitingImpl;
}

/// @nodoc
abstract class _$$LoginingImplCopyWith<$Res> {
  factory _$$LoginingImplCopyWith(
          _$LoginingImpl value, $Res Function(_$LoginingImpl) then) =
      __$$LoginingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginingImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$LoginingImpl>
    implements _$$LoginingImplCopyWith<$Res> {
  __$$LoginingImplCopyWithImpl(
      _$LoginingImpl _value, $Res Function(_$LoginingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginingImpl implements _Logining {
  const _$LoginingImpl();

  @override
  String toString() {
    return 'AppEvent.logining()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginingImpl);
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
  const factory _Logining() = _$LoginingImpl;
}

/// @nodoc
abstract class _$$ChangeStateImplCopyWith<$Res> {
  factory _$$ChangeStateImplCopyWith(
          _$ChangeStateImpl value, $Res Function(_$ChangeStateImpl) then) =
      __$$ChangeStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppState state});

  $AppStateCopyWith<$Res> get state;
}

/// @nodoc
class __$$ChangeStateImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$ChangeStateImpl>
    implements _$$ChangeStateImplCopyWith<$Res> {
  __$$ChangeStateImplCopyWithImpl(
      _$ChangeStateImpl _value, $Res Function(_$ChangeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$ChangeStateImpl(
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

class _$ChangeStateImpl implements _ChangeState {
  const _$ChangeStateImpl({required this.state});

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
            other is _$ChangeStateImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeStateImplCopyWith<_$ChangeStateImpl> get copyWith =>
      __$$ChangeStateImplCopyWithImpl<_$ChangeStateImpl>(this, _$identity);

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
  const factory _ChangeState({required final AppState state}) =
      _$ChangeStateImpl;

  AppState get state;
  @JsonKey(ignore: true)
  _$$ChangeStateImplCopyWith<_$ChangeStateImpl> get copyWith =>
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
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
abstract class _$$LoadingStateImplCopyWith<$Res> {
  factory _$$LoadingStateImplCopyWith(
          _$LoadingStateImpl value, $Res Function(_$LoadingStateImpl) then) =
      __$$LoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$LoadingStateImpl>
    implements _$$LoadingStateImplCopyWith<$Res> {
  __$$LoadingStateImplCopyWithImpl(
      _$LoadingStateImpl _value, $Res Function(_$LoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateImpl implements _LoadingState {
  const _$LoadingStateImpl();

  @override
  String toString() {
    return 'AppState.loadingState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingStateImpl);
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
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
  const factory _LoadingState() = _$LoadingStateImpl;
}

/// @nodoc
abstract class _$$NotAuthorizedStateImplCopyWith<$Res> {
  factory _$$NotAuthorizedStateImplCopyWith(_$NotAuthorizedStateImpl value,
          $Res Function(_$NotAuthorizedStateImpl) then) =
      __$$NotAuthorizedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotAuthorizedStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$NotAuthorizedStateImpl>
    implements _$$NotAuthorizedStateImplCopyWith<$Res> {
  __$$NotAuthorizedStateImplCopyWithImpl(_$NotAuthorizedStateImpl _value,
      $Res Function(_$NotAuthorizedStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NotAuthorizedStateImpl implements _NotAuthorizedState {
  const _$NotAuthorizedStateImpl();

  @override
  String toString() {
    return 'AppState.notAuthorizedState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotAuthorizedStateImpl);
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
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
  const factory _NotAuthorizedState() = _$NotAuthorizedStateImpl;
}

/// @nodoc
abstract class _$$InAppUserStateImplCopyWith<$Res> {
  factory _$$InAppUserStateImplCopyWith(_$InAppUserStateImpl value,
          $Res Function(_$InAppUserStateImpl) then) =
      __$$InAppUserStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$InAppUserStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$InAppUserStateImpl>
    implements _$$InAppUserStateImplCopyWith<$Res> {
  __$$InAppUserStateImplCopyWithImpl(
      _$InAppUserStateImpl _value, $Res Function(_$InAppUserStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$InAppUserStateImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$InAppUserStateImpl implements _InAppUserState {
  const _$InAppUserStateImpl({this.index});

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
            other is _$InAppUserStateImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InAppUserStateImplCopyWith<_$InAppUserStateImpl> get copyWith =>
      __$$InAppUserStateImplCopyWithImpl<_$InAppUserStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
  const factory _InAppUserState({final int? index}) = _$InAppUserStateImpl;

  int? get index;
  @JsonKey(ignore: true)
  _$$InAppUserStateImplCopyWith<_$InAppUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InAppBlogerStateImplCopyWith<$Res> {
  factory _$$InAppBlogerStateImplCopyWith(_$InAppBlogerStateImpl value,
          $Res Function(_$InAppBlogerStateImpl) then) =
      __$$InAppBlogerStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$InAppBlogerStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$InAppBlogerStateImpl>
    implements _$$InAppBlogerStateImplCopyWith<$Res> {
  __$$InAppBlogerStateImplCopyWithImpl(_$InAppBlogerStateImpl _value,
      $Res Function(_$InAppBlogerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$InAppBlogerStateImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$InAppBlogerStateImpl implements _InAppBlogerState {
  const _$InAppBlogerStateImpl({this.index});

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
            other is _$InAppBlogerStateImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InAppBlogerStateImplCopyWith<_$InAppBlogerStateImpl> get copyWith =>
      __$$InAppBlogerStateImplCopyWithImpl<_$InAppBlogerStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
  const factory _InAppBlogerState({final int? index}) = _$InAppBlogerStateImpl;

  int? get index;
  @JsonKey(ignore: true)
  _$$InAppBlogerStateImplCopyWith<_$InAppBlogerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InAppAdminStateImplCopyWith<$Res> {
  factory _$$InAppAdminStateImplCopyWith(_$InAppAdminStateImpl value,
          $Res Function(_$InAppAdminStateImpl) then) =
      __$$InAppAdminStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$InAppAdminStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$InAppAdminStateImpl>
    implements _$$InAppAdminStateImplCopyWith<$Res> {
  __$$InAppAdminStateImplCopyWithImpl(
      _$InAppAdminStateImpl _value, $Res Function(_$InAppAdminStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$InAppAdminStateImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$InAppAdminStateImpl implements _InAppAdminState {
  const _$InAppAdminStateImpl({this.index});

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
            other is _$InAppAdminStateImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InAppAdminStateImplCopyWith<_$InAppAdminStateImpl> get copyWith =>
      __$$InAppAdminStateImplCopyWithImpl<_$InAppAdminStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
  const factory _InAppAdminState({final int? index}) = _$InAppAdminStateImpl;

  int? get index;
  @JsonKey(ignore: true)
  _$$InAppAdminStateImplCopyWith<_$InAppAdminStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InAppManagerStateImplCopyWith<$Res> {
  factory _$$InAppManagerStateImplCopyWith(_$InAppManagerStateImpl value,
          $Res Function(_$InAppManagerStateImpl) then) =
      __$$InAppManagerStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$InAppManagerStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$InAppManagerStateImpl>
    implements _$$InAppManagerStateImplCopyWith<$Res> {
  __$$InAppManagerStateImplCopyWithImpl(_$InAppManagerStateImpl _value,
      $Res Function(_$InAppManagerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$InAppManagerStateImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$InAppManagerStateImpl implements _InAppManagerState {
  const _$InAppManagerStateImpl({this.index});

  @override
  final int? index;

  @override
  String toString() {
    return 'AppState.inAppManagerState(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InAppManagerStateImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InAppManagerStateImplCopyWith<_$InAppManagerStateImpl> get copyWith =>
      __$$InAppManagerStateImplCopyWithImpl<_$InAppManagerStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(int? index) inAppManagerState,
    required TResult Function(String message) errorState,
  }) {
    return inAppManagerState(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingState,
    TResult? Function()? notAuthorizedState,
    TResult? Function(int? index)? inAppUserState,
    TResult? Function(int? index)? inAppBlogerState,
    TResult? Function(int? index)? inAppAdminState,
    TResult? Function(int? index)? inAppManagerState,
    TResult? Function(String message)? errorState,
  }) {
    return inAppManagerState?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingState,
    TResult Function()? notAuthorizedState,
    TResult Function(int? index)? inAppUserState,
    TResult Function(int? index)? inAppBlogerState,
    TResult Function(int? index)? inAppAdminState,
    TResult Function(int? index)? inAppManagerState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (inAppManagerState != null) {
      return inAppManagerState(index);
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return inAppManagerState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult? Function(_InAppUserState value)? inAppUserState,
    TResult? Function(_InAppBlogerState value)? inAppBlogerState,
    TResult? Function(_InAppAdminState value)? inAppAdminState,
    TResult? Function(_InAppManagerState value)? inAppManagerState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return inAppManagerState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_NotAuthorizedState value)? notAuthorizedState,
    TResult Function(_InAppUserState value)? inAppUserState,
    TResult Function(_InAppBlogerState value)? inAppBlogerState,
    TResult Function(_InAppAdminState value)? inAppAdminState,
    TResult Function(_InAppManagerState value)? inAppManagerState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (inAppManagerState != null) {
      return inAppManagerState(this);
    }
    return orElse();
  }
}

abstract class _InAppManagerState implements AppState {
  const factory _InAppManagerState({final int? index}) =
      _$InAppManagerStateImpl;

  int? get index;
  @JsonKey(ignore: true)
  _$$InAppManagerStateImplCopyWith<_$InAppManagerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorStateImplCopyWith<$Res> {
  factory _$$ErrorStateImplCopyWith(
          _$ErrorStateImpl value, $Res Function(_$ErrorStateImpl) then) =
      __$$ErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$ErrorStateImpl>
    implements _$$ErrorStateImplCopyWith<$Res> {
  __$$ErrorStateImplCopyWithImpl(
      _$ErrorStateImpl _value, $Res Function(_$ErrorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorStateImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorStateImpl implements _ErrorState {
  const _$ErrorStateImpl({required this.message});

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
            other is _$ErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorStateImplCopyWith<_$ErrorStateImpl> get copyWith =>
      __$$ErrorStateImplCopyWithImpl<_$ErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingState,
    required TResult Function() notAuthorizedState,
    required TResult Function(int? index) inAppUserState,
    required TResult Function(int? index) inAppBlogerState,
    required TResult Function(int? index) inAppAdminState,
    required TResult Function(int? index) inAppManagerState,
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
    TResult? Function(int? index)? inAppManagerState,
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
    TResult Function(int? index)? inAppManagerState,
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
    required TResult Function(_InAppManagerState value) inAppManagerState,
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
    TResult? Function(_InAppManagerState value)? inAppManagerState,
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
    TResult Function(_InAppManagerState value)? inAppManagerState,
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
  const factory _ErrorState({required final String message}) = _$ErrorStateImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorStateImplCopyWith<_$ErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
