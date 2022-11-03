import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../home/data/model/Cats.dart';
import '../repository/BrandRepo.dart';
import 'brand_state.dart';



class BrandCubit extends Cubit<BrandState> {
  final BrandsRepository brandRepository;

  BrandCubit({required this.brandRepository}) : super(InitState());

  Future<void> brands() async {
    try {
      emit(LoadingState());
      final List<Cats> data = await brandRepository.brandApi();

      emit(LoadedState(data));
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
