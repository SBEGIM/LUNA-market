import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/utils/extensions/duration_extension.dart';

/// A mixin for managing short-lived, notification-like state transitions.
///
/// This mixin is intended for use with classes that extend [BlocBase<State>].
/// It provides a method to temporarily emit a "notification" state and then
/// restore the previous or specified state after a delay.
mixin StateNotifierMixin<State extends Object> on BlocBase<State> {
  /// Emits short, notification-like state.
  ///
  /// - `notifyDelay`: By default, one event-loop tick `Duration.zero` is used.
  /// - `then`: State to emit after notification.
  /// If not provided, the previous `state` will be used.
  Future<void> notify(
    State stateToNotify, {
    Duration notifyDelay = Duration.zero,
    State? then,
  }) async {
    final stateToRestore = then ?? state;
    emit(stateToNotify);
    await notifyDelay.sleep;
    emit(stateToRestore);
  }
}
