import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../data/DTO/message_seller_dto.dart';
import '../data/repository/message_seller_repository.dart';
import 'message_seller_state.dart';

class MessageSellerCubit extends Cubit<MessageSellerState> {
  List<MessageSellerDTO> _message = [];

  int _page = 1;

  final MessageSellerRepository messageRepository;

  MessageSellerCubit({required this.messageRepository}) : super(InitState());

  Future<void> getMessage(int chatId, int userId) async {
    try {
      _page = 1;
      emit(LoadingState());
      final List<MessageSellerDTO> data =
          await messageRepository.messageList(_page, chatId, userId);
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

      final List<MessageSellerDTO> data =
          await messageRepository.messageList(_page, chatId, userId);
      if (data.isEmpty) {
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

  Future<void> newMessage(MessageSellerDTO message) async {
    try {
      //_page++;
      //  print(_page++);
      // emit(LoadingState());

      _message.insert(0, message);

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
