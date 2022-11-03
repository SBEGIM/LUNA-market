
import 'dart:convert';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:http/http.dart' as http;

import '../model/Banners.dart';


const   baseUrl = 'http://80.87.202.73:8001/api';

class ListRepository{
  ListApi  _listApi = ListApi();

  Future<List<Cats>> cats() => _listApi.cats();
  Future<List<Banners>> banners() => _listApi.banners();
  Future<List<Cats>> shperes() => _listApi.shperes();
}


class ListApi {

  Future<List<Cats>> cats() async {
    final response = await http.get(Uri.parse('$baseUrl/list/cats'));

    final data = jsonDecode(response.body);

    return  (data as List).map((e) => Cats.fromJson(e)).toList();
  }

  Future<List<Banners>> banners() async {
    final response = await http.get(Uri.parse('$baseUrl/list/banners'));

    final data = jsonDecode(response.body);

    return  (data as List).map((e) => Banners.fromJson(e)).toList();
  }

  Future<List<Cats>> shperes() async {
    final response = await http.get(Uri.parse('$baseUrl/targets'));
    final data = jsonDecode(response.body);
    return  (data as List).map((e) => Cats.fromJson(e)).toList();
  }

}