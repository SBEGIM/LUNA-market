import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/drawer/data/models/address_model.dart';
import '../data/repository/address_repo.dart';
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

  Future<int> store(
    BuildContext context,
    country,
    city,
    street,
    entrance,
    floor,
    apartament,
    intercom,
    comment,
    phone,
  ) async {
    try {
      final data = await addressRepository.store(
        country,
        city,
        street,
        entrance,
        floor,
        apartament,
        intercom,
        comment,
        phone,
      );

      print(data);
      if (data == 200) {
        AppSnackBar.show(context, 'Адрес успешно добавлен', type: AppSnackType.success);
      } else {}

      return data;
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
      return 500;
    }
  }

  Future<void> update(
    id,
    country,
    city,
    street,
    entrance,
    floor,
    apartament,
    intercom,
    comment,
    phone,
  ) async {
    try {
      await addressRepository.update(
        id,
        country,
        city,
        street,
        entrance,
        floor,
        apartament,
        intercom,
        comment,
        phone,
      );
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> delete(BuildContext context, id) async {
    try {
      final data = await addressRepository.delete(id);

      if (data == 200) {
        address();
        AppSnackBar.show(context, 'Адрес удален', type: AppSnackType.success);
      } else {}
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
