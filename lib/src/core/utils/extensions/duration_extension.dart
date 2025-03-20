import 'dart:async';

/// Extension on [Duration] providing utility methods for asynchronous operations.
extension DurationExtension on Duration {
  /// Delays execution for the specified [Duration].
  Future<T> delayed<T>([FutureOr<T> Function()? computation]) => Future<T>.delayed(this, computation);

  /// Delays execution for the specified [Duration] without returning a result.
  Future<void> get sleep => delayed<void>();
}
