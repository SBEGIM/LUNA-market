import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../features/home/data/model/Cats.dart';

const baseUrl = 'http://185.116.193.73/api';

class SizeAdminRepository {
  final SizeToApi _sizeToApi = SizeToApi();

  Future<List<Cats>> get() => _sizeToApi.get();
}

class SizeToApi {
  Future<List<Cats>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/sizes'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Cats.fromJson(e)).toList();
  }
}
