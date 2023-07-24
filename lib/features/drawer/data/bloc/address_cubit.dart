import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/features/drawer/data/models/address_model.dart';

import '../repository/address_repo.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository addressRepository;

  AddressCubit({required this.addressRepository}) : super(InitState());

  Future<void> address() async {
    try {
      emit(LoadingState());
      final List<AddressModel> data = await addressRepository.address();
      if (data.isEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> store(country, city, street, home, floor, porch, room) async {
    try {
      await addressRepository.store(
          country, city, street, home, floor, porch, room);
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> update(
      id, country, city, street, home, floor, porch, room) async {
    try {
      await addressRepository.update(
          id, country, city, street, home, floor, porch, room);
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> delete(id) async {
    try {
      await addressRepository.delete(id);
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
