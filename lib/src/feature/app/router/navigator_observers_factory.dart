import 'package:flutter/material.dart';
import 'package:haji_market/src/feature/app/router/router_observer.dart';

class NavigatorObserversFactory {
  const NavigatorObserversFactory();

  List<NavigatorObserver> call() => [
    // SentryNavigatorObserver(),
    RouterObserver(),
  ];
}
