import '../DTO/DTO/messageAdminDto.dart';
import '../model/chat_model.dart';

abstract class ChatAdminState {}

class InitState extends ChatAdminState {}

class LoadingState extends ChatAdminState {}

class LoadedState extends ChatAdminState {
  List<ChatAdminModel> chat;
  LoadedState(this.chat);
}

class ErrorState extends ChatAdminState {
  String message;
  ErrorState({required this.message});
}
