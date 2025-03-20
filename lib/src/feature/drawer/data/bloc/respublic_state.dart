import 'package:haji_market/src/feature/drawer/data/models/respublic_model.dart';

abstract class RespublicState {}

class InitState extends RespublicState {}

class LoadingState extends RespublicState {}

class LoadedState extends RespublicState {
  List<RespublicModel> respublicModel;
  LoadedState(this.respublicModel);
}

class ErrorState extends RespublicState {
  String message;
  ErrorState({required this.message});
}
