import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../features/home/data/model/Cats.dart';
import '../models/blogger_shop_products_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class ColorAdminRepository {
  ColorToApi _colorToApi = ColorToApi();

  Future<List<Cats>> get() => _colorToApi.get();
}

class ColorToApi {
  final _box = GetStorage();

  Future<List<Cats>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/colors'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Cats.fromJson(e)).toList();
  }
}
