import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../features/home/data/model/Cats.dart';

const baseUrl = 'http://185.116.193.73/api';

class CharacteristicAdminRepo {
  final CharacteristicToApi _characteristicToApi = CharacteristicToApi();

  Future<List<Cats>> get() => _characteristicToApi.get();
}

class CharacteristicToApi {
  Future<List<Cats>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/characteristics'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Cats.fromJson(e)).toList();
  }
}
