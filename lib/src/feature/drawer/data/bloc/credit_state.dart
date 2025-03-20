import 'package:haji_market/src/feature/drawer/data/models/credit_model.dart';

abstract class CreditState {}

class InitState extends CreditState {}

class LoadingState extends CreditState {}

class LoadedState extends CreditState {
  List<CreditModel> creditModel;
  LoadedState(this.creditModel);
}

class ErrorState extends CreditState {
  String message;
  ErrorState({required this.message});
}
