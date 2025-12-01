import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import 'package:haji_market/src/feature/drawer/data/repository/city_repo.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';

class CityCubit extends Cubit<CityState> {
  final CityRepository cityRepository;

  CityCubit({required this.cityRepository}) : super(CityStateInitial());
  List<CityModel> _cities = [];

  Future<void> cities() async {
    try {
      emit(CityStateLoading());
      final List<CityModel> data = await cityRepository.cityApi();
      _cities = data;

      if (_cities.isEmpty) {
        emit(CityStateNoData());
      } else {
        emit(CityStateLoaded(data));
      }
    } catch (e) {
      TalkerLoggerUtil.talker.error('CityCubit.cities', e);
      emit(CityStateError(message: 'Ошибка сервера'));
    }
  }

  Future<List<CityModel>> citiesList(String? country) async {
    if (_cities.isEmpty) {
      await citiesCdek(country ?? 'RU');
    }
    return _cities;
  }

  Future<List<CityModel>> citiesCdek(String? countryCode) async {
    try {
      emit(CityStateLoading());
      final List<CityModel> data = await cityRepository.cityCdekApi(countryCode);
      _cities = data;

      if (_cities.isEmpty) {
        emit(CityStateNoData());
      } else {
        emit(CityStateLoaded(data));
      }
      return _cities;
    } catch (e) {
      TalkerLoggerUtil.talker.error('CityCubit.citiesCdek', e);
      emit(CityStateError(message: 'Ошибка сервера'));
      return _cities;
    }
  }

  Future<void> searchCdekCity(String cats) async {
    if (cats.isEmpty) return;

    List<CityModel> temp = [];
    for (int i = 0; i < _cities.length; i++) {
      if (_cities[i].city != null && _cities[i].city!.toLowerCase().contains(cats.toLowerCase())) {
        temp.add(_cities[i]);
      }
    }
    emit(CityStateLoaded(temp));
  }

  Future<CityModel?> cityById(String id) async {
    if (id.isEmpty) return null;

    if (_cities.isEmpty) {
      await cities();
    }
    CityModel city = CityModel(id: 0, name: '');
    for (int i = 0; i < _cities.length; i++) {
      if (_cities[i].id.toString() == id) {
        city = _cities[i];
      }
    }

    return city;
  }
}

/// <--- State --->
sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityStateInitial extends CityState {}

class CityStateLoading extends CityState {}

class CityStateNoData extends CityState {}

class CityStateLoaded extends CityState {
  final List<CityModel> city;
  const CityStateLoaded(this.city);

  @override
  List<Object?> get props => [city];
}

class CityStateError extends CityState {
  final String message;
  const CityStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
