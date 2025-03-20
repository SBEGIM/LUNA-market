import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../home/data/model/cats.dart';

const baseUrl = 'https://lunamarket.ru/api';

class SizeAdminRepository {
  final SizeToApi _sizeToApi = SizeToApi();

  Future<List<CatsModel>> get() => _sizeToApi.get();
}

class SizeToApi {
  Future<List<CatsModel>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/sizes'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }
}
