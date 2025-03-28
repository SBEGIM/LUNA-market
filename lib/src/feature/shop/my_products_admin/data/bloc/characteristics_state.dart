import '../../../../home/data/model/characteristic_model.dart';

abstract class CharacteristicsState {}

class InitState extends CharacteristicsState {}

class LoadingState extends CharacteristicsState {}

class LoadedState extends CharacteristicsState {
  List<CharacteristicsModel> characteristics;
  LoadedState(this.characteristics);
}

class ErrorState extends CharacteristicsState {
  String message;
  ErrorState({required this.message});
}
