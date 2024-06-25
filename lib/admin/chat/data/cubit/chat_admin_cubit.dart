import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../model/chat_model.dart';
import '../repository/chat_admin_repo.dart';
import 'chat_admin_state.dart';

class ChatAdminCubit extends Cubit<ChatAdminState> {
  List<ChatAdminModel> _chats = [];
  int _page = 1;

  final ChatAdminRepository chatRepository;

  ChatAdminCubit({required this.chatRepository}) : super(InitState());

  Future<void> chat() async {
    try {
      _page = 1;
      emit(LoadingState());
      final List<ChatAdminModel> data = await chatRepository.chatList(_page);
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
      final List<ChatAdminModel> data = await chatRepository.chatList(_page);

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

    List<ChatAdminModel> temp = [];
    for (int i = 0; i < _chats.length; i++) {
      if (_chats[i].name != null &&
          _chats[i].name!.toLowerCase().contains(name.toLowerCase())) {
        temp.add(_chats[i]);
      }
    }
    emit(LoadedState(temp));
  }
}
