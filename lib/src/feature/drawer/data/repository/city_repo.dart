import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class CityRepository {
  final CityApi _cityApi = CityApi();

  Future<List<CityModel>> cityApi() => _cityApi.cities();
  Future<List<CityModel>> cityCdekApi(countryCode) =>
      _cityApi.citiesCdek(countryCode);
}

class CityApi {
  Future<List<CityModel>> cities() async {
    final cityId = GetStorage().read('user_country_id');
    final response =
        await http.get(Uri.parse('$baseUrl/list/city?country_id=$cityId'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CityModel.fromJson(e)).toList();
  }

  Future<List<CityModel>> citiesCdek(countryCode) async {
    final response = await http
        .get(Uri.parse('$baseUrl/list/city?country_code=$countryCode'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CityModel.fromJson(e)).toList();
  }
}
