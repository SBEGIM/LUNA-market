import 'package:haji_market/features/chat/data/DTO/DTO/messageDto.dart';
import 'package:haji_market/features/chat/data/model/chat_model.dart';

import '../DTO/DTO/messageAdminDto.dart';

abstract class MessageAdminState {}

class InitState extends MessageAdminState {}

class LoadingState extends MessageAdminState {}

class LoadedState extends MessageAdminState {
  List<MessageAdminDto> chat;
  LoadedState(this.chat);
}

class ErrorState extends MessageAdminState {
  String message;
  ErrorState({required this.message});
}
