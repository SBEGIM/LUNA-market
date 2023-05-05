import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/shops_drawer_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class ShopsDrawerRepository {
  final ShopsDrawerApi _shopsApi = ShopsDrawerApi();

  Future<List<ShopsDrawerModel>> shopsDrawer() => _shopsApi.shopsDrawer();
}

class ShopsDrawerApi {
  final _box = GetStorage();

  Future<List<ShopsDrawerModel>> shopsDrawer() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/list/shops'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => ShopsDrawerModel.fromJson(e)).toList();
  }
}
