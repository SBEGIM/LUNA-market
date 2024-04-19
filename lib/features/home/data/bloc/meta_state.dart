import 'package:haji_market/features/home/data/model/MetaModel.dart';

abstract class MetaState {}

class InitState extends MetaState {}

class LoadingState extends MetaState {}

class LoadedState extends MetaState {
  MetaModel metas;
  LoadedState(this.metas);
}

class ErrorState extends MetaState {
  String message;
  ErrorState({required this.message});
}
