import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/chat/data/model/chat_model.dart';

import '../repository/chat_repo.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  List<ChatModel> _chats = [];
  int _page = 1;

  final ChatRepository chatRepository;

  ChatCubit({required this.chatRepository}) : super(InitState());

  Future<void> chat() async {
    try {
      _page = 1;
      emit(LoadingState());
      final List<ChatModel> data = await chatRepository.chatList(_page);
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
      final List<ChatModel> data = await chatRepository.chatList(_page);

      for (int i = 0; i < data.length; i++) {
        _chats.add(data[i]);
      }

      emit(LoadedState(_chats));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  // Future<void> searchCity(String city) async {
  //   if(city.isEmpty) return;
  //   if(_cities.isEmpty) {
  //     await cities();
  //     // final List<City> data = await listRepository.cities();
  //     // _cities = data;
  //   }
  //   List<City> temp = [];
  //   Set<String> citiesSet = {};
  //   for(int i = 0 ; i < _cities.length; i++) {
  //     if(_cities[i].name != null && _cities[i].name!.contains(city)) {
  //       temp.add(_cities[i]);
  //       citiesSet.add(_cities[i].name.toString());
  //     }
  //   }
  //   emit(LoadedState(temp, citiesSet, ''));
  // }
}
