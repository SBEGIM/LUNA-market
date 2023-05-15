import 'dart:convert';
import 'package:haji_market/features/home/data/model/City.dart';
import 'package:http/http.dart' as http;
import '../../../home/data/model/Country.dart';

const baseUrl = 'http://185.116.193.73/api';

class CountryRepository {
  final CountryApi _countryApi = CountryApi();

  Future<List<Country>> countryApi() => _countryApi.countries();
}

class CountryApi {
  Future<List<Country>> countries() async {
    final response = await http.get(Uri.parse('$baseUrl/list/country'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Country.fromJson(e)).toList();
  }
}
