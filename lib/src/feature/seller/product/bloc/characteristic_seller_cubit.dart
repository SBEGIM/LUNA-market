import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/product/bloc/characteristics_seller_state.dart';
import '../../../home/data/model/characteristic_model.dart';
import '../data/repository/characteristic_seller_repository.dart';

class CharacteristicSellerCubit extends Cubit<CharacteristicSellerState> {
  final CharacteristicSellerRepository characteristicRepository;

  CharacteristicSellerCubit({required this.characteristicRepository}) : super(InitState());

  List<CharacteristicsModel> _characteristics = [];

  Future<List<CharacteristicsModel>?> characteristic() async {
    try {
      emit(LoadingState());
      final List<CharacteristicsModel> data = await characteristicRepository.get();
      _characteristics = data;
      emit(LoadedState(data));
      return _characteristics;
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<List<CharacteristicsModel>?> subCharacteristic({id}) async {
    try {
      emit(LoadingState());
      final List<CharacteristicsModel> data = await characteristicRepository.subGet(id);
      _characteristics = data;
      emit(LoadedState(data));
      return _characteristics;
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<List<CharacteristicsModel>?> subListCharacteristic() async {
    try {
      emit(LoadingState());
      final List<CharacteristicsModel> data = await characteristicRepository.subGet(null);
      _characteristics = data;
      return _characteristics;
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  listSubCharacteristicsIndex(int index) async {
    if (_characteristics.isEmpty) {
      await characteristic();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    List<CharacteristicsModel> _listSubCharacteristics = [];

    for (int i = 0; i < _characteristics.length; i++) {
      if (_characteristics[i].id == index) {
        _listSubCharacteristics.add(_characteristics[i]);
      }
    }

    return _listSubCharacteristics;
  }

  ColorById(String name) async {
    if (name.isEmpty) return;
    if (_characteristics.isEmpty) {
      await characteristic();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    CharacteristicsModel color = CharacteristicsModel(id: 0, key: 'Выберите характеристику');
    for (int i = 0; i < _characteristics.length; i++) {
      if (_characteristics[i].key == name) {
        color = _characteristics[i];
      }
    }

    return color;
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
