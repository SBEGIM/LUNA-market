import '../../../home/data/model/characteristic_model.dart';

abstract class CharacteristicSellerState {}

class InitState extends CharacteristicSellerState {}

class LoadingState extends CharacteristicSellerState {}

class LoadedState extends CharacteristicSellerState {
  List<CharacteristicsModel> characteristics;
  LoadedState(this.characteristics);
}

class ErrorState extends CharacteristicSellerState {
  String message;
  ErrorState({required this.message});
}
