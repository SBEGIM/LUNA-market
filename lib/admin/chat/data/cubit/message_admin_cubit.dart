import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../DTO/DTO/messageAdminDto.dart';
import '../repository/message_admin_repo.dart';
import 'message_admin_state.dart';

class MessageAdminCubit extends Cubit<MessageAdminState> {
  List<MessageAdminDto> _message = [];

  int _page = 1;

  final MessageAdminRepository messageRepository;

  MessageAdminCubit({required this.messageRepository}) : super(InitState());

  Future<void> getMessage(int chatId, int userId) async {
    try {
      _page = 1;
      emit(LoadingState());
      final List<MessageAdminDto> data = await messageRepository.messageList(_page, chatId, userId);
      _message = data;
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> paginationMessage(int chatId, int userId) async {
    try {
      _page++;
      //  print(_page++);
      // emit(LoadingState());

      final List<MessageAdminDto> data = await messageRepository.messageList(_page, chatId, userId);
      if (data.length == 0) {
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

  Future<void> newMessage(MessageAdminDto message) async {
    try {
      //_page++;
      //  print(_page++);
      // emit(LoadingState());

      _message.add(message);

      emit(LoadedState(_message));
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
