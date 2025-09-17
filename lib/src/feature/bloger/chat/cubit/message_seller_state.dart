import '../data/DTO/message_seller_dto.dart';

abstract class MessageSellerState {}

class InitState extends MessageSellerState {}

class LoadingState extends MessageSellerState {}

class LoadedState extends MessageSellerState {
  List<MessageSellerDTO> chat;
  LoadedState(this.chat);
}

class ErrorState extends MessageSellerState {
  String message;
  ErrorState({required this.message});
}
