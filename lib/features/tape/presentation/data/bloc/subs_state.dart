import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';

abstract class SubsState {}

class InitState extends SubsState {}

class LoadingState extends SubsState {}

class LoadedState extends SubsState {}

class ErrorState extends SubsState {
  String message;
  ErrorState({required this.message}) : assert(message != null);
}
