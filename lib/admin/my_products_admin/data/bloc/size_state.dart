import 'package:haji_market/features/home/data/model/Cats.dart';

abstract class SizeState {}

class InitState extends SizeState {}

class LoadingState extends SizeState {}

class LoadedState extends SizeState {
  List<Cats> cats;
  LoadedState(this.cats);
}

class ErrorState extends SizeState {
  String message;
  ErrorState({required this.message});
}
