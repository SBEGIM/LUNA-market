import '../data/models/statistic_product_seller_model.dart';

abstract class StatisticProductSellerState {}

class InitState extends StatisticProductSellerState {}

class LoadingState extends StatisticProductSellerState {}

class LoadedState extends StatisticProductSellerState {
  StatisticProductSellerModel stats;
  LoadedState(this.stats);
}

class ErrorState extends StatisticProductSellerState {
  String message;
  ErrorState({required this.message});
}
