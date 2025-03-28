import 'package:haji_market/src/feature/drawer/data/models/bonus_model.dart';

abstract class BonusState {}

class InitState extends BonusState {}

class LoadingState extends BonusState {}

class NoDataState extends BonusState {}

class LoadedState extends BonusState {
  List<BonusModel> bonusModel;
  LoadedState(this.bonusModel);
}

class ErrorState extends BonusState {
  String message;
  ErrorState({required this.message});
}
