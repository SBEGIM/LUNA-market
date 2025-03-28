import 'dart:convert';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:http/http.dart' as http;

import '../model/banner_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ListRepository {
  final ListApi _listApi = ListApi();

  Future<List<CatsModel>> cats() => _listApi.cats();
  Future<List<BannerModel>> banners() => _listApi.banners();
  Future<List<CatsModel>> shperes() => _listApi.shperes();
}

class ListApi {
  Future<List<CatsModel>> cats() async {
    final response = await http.get(Uri.parse('$baseUrl/list/cats'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }

  Future<List<BannerModel>> banners() async {
    final response = await http.get(Uri.parse('$baseUrl/list/banners'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => BannerModel.fromJson(e)).toList();
  }

  Future<List<CatsModel>> shperes() async {
    final response = await http.get(Uri.parse('$baseUrl/targets'));
    final data = jsonDecode(response.body);
    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }
}
