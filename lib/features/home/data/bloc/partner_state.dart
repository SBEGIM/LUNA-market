import '../model/PartnerModel.dart';

abstract class PartnerState {}

class InitState extends PartnerState {}

class LoadingState extends PartnerState {}

class LoadedState extends PartnerState {
  List<PartnerModel> partner;
  LoadedState(this.partner);
}

class ErrorState extends PartnerState {
  String message;
  ErrorState({required this.message});
}
