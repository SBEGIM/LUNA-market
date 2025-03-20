import '../models/admin_statistics_product.dart';

abstract class StatisticsProductState {}

class InitState extends StatisticsProductState {}

class LoadingState extends StatisticsProductState {}

class LoadedState extends StatisticsProductState {
  StatisticsProductAdmin stats;
  LoadedState(this.stats);
}

class ErrorState extends StatisticsProductState {
  String message;
  ErrorState({required this.message});
}
