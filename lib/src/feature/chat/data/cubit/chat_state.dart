import 'package:haji_market/src/feature/chat/data/model/chat_model.dart';

abstract class ChatState {}

class InitState extends ChatState {}

class LoadingState extends ChatState {}

class LoadedState extends ChatState {
  List<ChatModel> chat;
  LoadedState(this.chat);
}

class ErrorState extends ChatState {
  String message;
  ErrorState({required this.message});
}
