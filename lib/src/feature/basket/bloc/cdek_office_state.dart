import 'package:haji_market/src/feature/basket/data/models/cdek_office_old_model.dart';

abstract class CdekOfficeState {}

class InitState extends CdekOfficeState {}

class LoadingState extends CdekOfficeState {}

class LoadedState extends CdekOfficeState {
  List<CdekOfficeOldModel> cdekOffice;
  LoadedState(this.cdekOffice);
}

class ErrorState extends CdekOfficeState {
  String message;
  ErrorState({required this.message});
}
