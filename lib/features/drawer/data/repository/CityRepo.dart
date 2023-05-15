import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/home/data/model/City.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class CityRepository {
  final CityApi _cityApi = CityApi();

  Future<List<City>> cityApi() => _cityApi.cities();
}

class CityApi {
  Future<List<City>> cities() async {
    final cityId = GetStorage().read('user_country_id');
    final response =
        await http.get(Uri.parse('$baseUrl/list/city?country_id=$cityId'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => City.fromJson(e)).toList();
  }
}
