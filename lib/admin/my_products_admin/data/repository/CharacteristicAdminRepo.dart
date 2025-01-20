import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../features/home/data/model/Characteristics.dart';

const baseUrl = 'https://lunamarket.ru/api';

class CharacteristicAdminRepo {
  final CharacteristicToApi _characteristicToApi = CharacteristicToApi();

  Future<List<Characteristics>> get() => _characteristicToApi.get();
  Future<List<Characteristics>> subGet(id) => _characteristicToApi.subGet(id);
}

class CharacteristicToApi {
  Future<List<Characteristics>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/characteristics'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Characteristics.fromJson(e)).toList();
  }

  Future<List<Characteristics>> subGet(id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/list/sub/characteristics?id=$id'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Characteristics.fromJson(e)).toList();
  }
}
