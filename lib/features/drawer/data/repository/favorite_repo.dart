import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class FavoriteRepository {
  final FavoriteApi _favoriteApi = FavoriteApi();

  Future<List<ProductModel>> favorites() => _favoriteApi.favorites();
  Future<int> favorite(id) => _favoriteApi.favorite(id);
  Future<int> favoriteTape(id) => _favoriteApi.favoriteTape(id);
}

class FavoriteApi {
  final _box = GetStorage();

  Future<List<ProductModel>> favorites() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/user/favorites'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<int> favorite(id) async {
    final String? token = _box.read('token');

    final response = await http.post(
        Uri.parse('$baseUrl/shop/favorite/product/store'),
        headers: {"Authorization": "Bearer $token"},
        body: {'id': id});

    final data = response.statusCode;

    return data;
  }

  Future<int> favoriteTape(id) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/shop/favorite/store'),
        headers: {"Authorization": "Bearer $token"}, body: {'id': id});

    final data = response.statusCode;

    return data;
  }
}
