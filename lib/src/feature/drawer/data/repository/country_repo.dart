import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../home/data/model/country_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class CountryRepository {
  final CountryApi _countryApi = CountryApi();

  Future<List<CountryModel>> countryApi() => _countryApi.countries();
}

class CountryApi {
  Future<List<CountryModel>> countries() async {
    final response = await http.get(Uri.parse('$baseUrl/list/country'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CountryModel.fromJson(e)).toList();
  }
}
