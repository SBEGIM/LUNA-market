import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// {@template app_database}
/// The drift-managed database configuration
/// {@endtemplate}
@DriftDatabase()
class AppDatabase extends _$AppDatabase {
  /// {@macro app_database}
  AppDatabase(super.e);

  /// {@macro app_database}
  AppDatabase.defaults()
      : super(
          driftDatabase(
            name: 'app',
            native: const DriftNativeOptions(
              shareAcrossIsolates: true,
            ),
          ),
        );

  @override
  int get schemaVersion => 1;
}
