import 'package:rxdart/rxdart.dart';

enum NotAuthLogicStatus { reset, unauthorized }

/// Singleton is a class that manages the state of "unauthorized access"
class NotAuthLogic {
  factory NotAuthLogic() => _singleton;

  NotAuthLogic._internal();
  static final NotAuthLogic _singleton = NotAuthLogic._internal();

  /// The stream that transmits the status. BehaviorSubject stores the last value.
  ///
  /// - Use in the code `statusSubject.add(...)` to notify the listeners
  /// - Listeners can subscribe to `.listen(...)` and react to changes
  BehaviorSubject<NotAuthLogicStatus> statusSubject = BehaviorSubject<NotAuthLogicStatus>();

  void dispose() {
    statusSubject.close();
  }
}
