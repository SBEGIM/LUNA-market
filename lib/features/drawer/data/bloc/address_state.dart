import 'package:haji_market/features/drawer/data/models/address_model.dart';

abstract class AddressState {}

class InitState extends AddressState {}

class LoadingState extends AddressState {}

class LoadedState extends AddressState {
  List<AddressModel> addressModel;
  LoadedState(this.addressModel);
}

class ErrorState extends AddressState {
  String message;
  ErrorState({required this.message});
}
