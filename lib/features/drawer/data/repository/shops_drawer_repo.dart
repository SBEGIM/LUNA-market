import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/shops_drawer_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ShopsDrawerRepository {
  final ShopsDrawerApi _shopsApi = ShopsDrawerApi();

  Future<List<ShopsDrawerModel>> shopsDrawer(int? cat_id) =>
      _shopsApi.shopsDrawer(cat_id);
}

class ShopsDrawerApi {
  final _box = GetStorage();

  Future<List<ShopsDrawerModel>> shopsDrawer(int? cat_id) async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse('$baseUrl/list/shops?cat_id=$cat_id'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => ShopsDrawerModel.fromJson(e)).toList();
  }
}
