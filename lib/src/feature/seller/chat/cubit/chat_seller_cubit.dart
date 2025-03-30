import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../data/model/chat_seller_model.dart';
import '../data/repository/chat_seller_repository.dart';
import 'chat_seller_state.dart';

class ChatSellerCubit extends Cubit<ChatSellerState> {
  List<ChatSellerModel> _chats = [];
  int _page = 1;

  final ChatSellerRepository chatRepository;

  ChatSellerCubit({required this.chatRepository}) : super(InitState());

  Future<void> chat() async {
    try {
      _page = 1;
      emit(LoadingState());
      final List<ChatSellerModel> data = await chatRepository.chatList(_page);
      _chats = data;

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> pagination() async {
    try {
      _page++;
      print(_page.toString());
      // emit(LoadingState());
      final List<ChatSellerModel> data = await chatRepository.chatList(_page);

      for (int i = 0; i < data.length; i++) {
        _chats.add(data[i]);
      }

      emit(LoadedState(_chats));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> searchChats(String name) async {
    if (name.isEmpty) {
      chat();
      return;
    }

    List<ChatSellerModel> temp = [];
    for (int i = 0; i < _chats.length; i++) {
      if (_chats[i].name != null &&
          _chats[i].name!.toLowerCase().contains(name.toLowerCase())) {
        temp.add(_chats[i]);
      }
    }
    emit(LoadedState(temp));
  }
}
