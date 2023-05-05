import 'package:haji_market/features/basket/data/DTO/cdek_office_model.dart';

abstract class CdekOfficeState {}

class InitState extends CdekOfficeState {}

class LoadingState extends CdekOfficeState {}

class LoadedState extends CdekOfficeState {
  List<CdekOfficeModel> cdekOffice;
  LoadedState(this.cdekOffice);
}

class ErrorState extends CdekOfficeState {
  String message;
  ErrorState({required this.message});
}
