import '../DTO/DTO/messageDto.dart';

abstract class MessageState {}

class InitState extends MessageState {}

class LoadingState extends MessageState {}

class LoadedState extends MessageState {
  List<MessageDto> chat;
  LoadedState(this.chat);
}

class ErrorState extends MessageState {
  String message;
  ErrorState({required this.message});
}
