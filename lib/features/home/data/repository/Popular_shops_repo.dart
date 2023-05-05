import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/home/data/model/PopularShops.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class PopularShopsRepository {
  final PopularShopsApi _shopsApi = PopularShopsApi();

  Future<List<PopularShops>> popularShops() => _shopsApi.popularShops();
}

class PopularShopsApi {
  final _box = GetStorage();

  Future<List<PopularShops>> popularShops() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/shop/popular/shops'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => PopularShops.fromJson(e)).toList();
  }
}
