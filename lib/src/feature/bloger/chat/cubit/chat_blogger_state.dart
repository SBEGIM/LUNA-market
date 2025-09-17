import '../data/model/chat_seller_model.dart';

abstract class ChatBloggerState {}

class InitState extends ChatBloggerState {}

class LoadingState extends ChatBloggerState {}

class LoadedState extends ChatBloggerState {
  List<ChatSellerModel> chat;
  LoadedState(this.chat);
}

class ErrorState extends ChatBloggerState {
  String message;
  ErrorState({required this.message});
}
