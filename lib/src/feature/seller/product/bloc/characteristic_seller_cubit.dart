import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/home/data/model/characteristic_model.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/characteristic_seller_repository.dart';

class CharacteristicSellerCubit extends Cubit<CharacteristicSellerState> {
  final CharacteristicSellerRepository characteristicRepository;

  CharacteristicSellerCubit({required this.characteristicRepository}) : super(InitState());

  List<CharacteristicsModel> _characteristics = [];

  Future<List<CharacteristicsModel>?> characteristic() async {
    try {
      emit(CharacteristicSellerStateLoading());
      final List<CharacteristicsModel> data = await characteristicRepository.get();
      _characteristics = data;
      emit(CharacteristicSellerStateLoaded(data));
      return _characteristics;
    } catch (e) {
      emit(CharacteristicSellerStateError(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<List<CharacteristicsModel>?> subCharacteristic({id}) async {
    try {
      emit(CharacteristicSellerStateLoading());
      final List<CharacteristicsModel> data = await characteristicRepository.subGet(id);
      _characteristics = data;
      emit(CharacteristicSellerStateLoaded(data));
      return _characteristics;
    } catch (e) {
      emit(CharacteristicSellerStateError(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<List<CharacteristicsModel>?> subListCharacteristic() async {
    try {
      emit(CharacteristicSellerStateLoading());
      final List<CharacteristicsModel> data = await characteristicRepository.subGet(null);
      _characteristics = data;
      return _characteristics;
    } catch (e) {
      emit(CharacteristicSellerStateError(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<List<CharacteristicsModel>> listSubCharacteristicsIndex(int index) async {
    if (_characteristics.isEmpty) {
      await characteristic();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    List<CharacteristicsModel> listSubCharacteristics = [];

    for (int i = 0; i < _characteristics.length; i++) {
      if (_characteristics[i].id == index) {
        listSubCharacteristics.add(_characteristics[i]);
      }
    }

    return listSubCharacteristics;
  }
}

sealed class CharacteristicSellerState {
  const CharacteristicSellerState();
}

class InitState extends CharacteristicSellerState {}

class CharacteristicSellerStateLoading extends CharacteristicSellerState {}

class CharacteristicSellerStateLoaded extends CharacteristicSellerState {
  final List<CharacteristicsModel> characteristics;

  const CharacteristicSellerStateLoaded(this.characteristics);
}

class CharacteristicSellerStateError extends CharacteristicSellerState {
  final String message;

  const CharacteristicSellerStateError({required this.message});
}
