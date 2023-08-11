import 'package:haji_market/features/home/data/model/Cats.dart';

abstract class CharacteristicsState {}

class InitState extends CharacteristicsState {}

class LoadingState extends CharacteristicsState {}

class LoadedState extends CharacteristicsState {
  List<Cats> cats;
  LoadedState(this.cats);
}

class ErrorState extends CharacteristicsState {
  String message;
  ErrorState({required this.message});
}
