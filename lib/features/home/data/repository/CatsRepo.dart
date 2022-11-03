
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/data/model/City.dart';

 const   baseUrl = 'http://rizapp.kz/api';

class ListRepository{
  ListApi  _listApi = ListApi();

  Future<List<City>> cities() => _listApi.cities();
  Future<List<City>> shperes() => _listApi.shperes();
}


class ListApi {

  Future<List<City>> cities() async {
    final response = await http.get(Uri.parse('$baseUrl/cities'));

    final data = jsonDecode(response.body);

    return  (data as List).map((e) => City.fromJson(e)).toList();
  }

  Future<List<City>> shperes() async {
    final response = await http.get(Uri.parse('$baseUrl/targets'));
    final data = jsonDecode(response.body);
    return  (data as List).map((e) => City.fromJson(e)).toList();
  }

}