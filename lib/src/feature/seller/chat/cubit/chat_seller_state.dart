import '../data/model/chat_seller_model.dart';

abstract class ChatSellerState {}

class InitState extends ChatSellerState {}

class LoadingState extends ChatSellerState {}

class LoadedState extends ChatSellerState {
  List<ChatSellerModel> chat;
  LoadedState(this.chat);
}

class ErrorState extends ChatSellerState {
  String message;
  ErrorState({required this.message});
}
