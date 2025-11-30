import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/chat/data/repository/message_repo.dart';

import '../DTO/messageDto.dart';
import 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  List<MessageDto> _message = [];

  int _page = 1;

  final MessageRepository messageRepository;

  MessageCubit({required this.messageRepository}) : super(InitState());

  Future<void> getMessage(int chatId, int userId) async {
    try {
      _page = 1;
      emit(LoadingState());
      final List<MessageDto> data = await messageRepository.messageList(_page, chatId, userId);
      _message = data;
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> paginationMessage(int chatId, userId) async {
    try {
      _page++;
      //  print(_page++);
      // emit(LoadingState());

      final List<MessageDto> data = await messageRepository.messageList(_page, chatId, userId);
      if (data.isNotEmpty) {
        _page--;
      }
      for (int i = 0; i < data.length; i++) {
        _message.add(data[i]);
      }
      emit(LoadedState(_message));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> newMessage(MessageDto message) async {
    try {
      //_page++;
      //  print(_page++);
      // emit(LoadingState());
      // if (message != null) {
      _message.insert(0, message);
      //   print('oklkkkweqweqwewq');
      // }

      emit(LoadedState(_message));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<String?> imageStore(String avatar) async {
    try {
      //_page++;
      //  print(_page++);
      // emit(LoadingState());
      // if (message != null) {
      //   print('oklkkkweqweqwewq');
      // }

      final String data = await messageRepository.imageStore(avatar);
      return data;
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
