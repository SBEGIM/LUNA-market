import '../../../../features/home/data/model/Characteristics.dart';

abstract class CharacteristicsState {}

class InitState extends CharacteristicsState {}

class LoadingState extends CharacteristicsState {}

class LoadedState extends CharacteristicsState {
  List<Characteristics> characteristics;
  LoadedState(this.characteristics);
}

class ErrorState extends CharacteristicsState {
  String message;
  ErrorState({required this.message});
}
