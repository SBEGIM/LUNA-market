import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../home/data/model/characteristic_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class CharacteristicSellerRepository {
  final CharacteristicToApi _characteristicToApi = CharacteristicToApi();

  Future<List<CharacteristicsModel>> get() => _characteristicToApi.get();
  Future<List<CharacteristicsModel>> subGet(id) =>
      _characteristicToApi.subGet(id);
}

class CharacteristicToApi {
  Future<List<CharacteristicsModel>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/characteristics'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CharacteristicsModel.fromJson(e)).toList();
  }

  Future<List<CharacteristicsModel>> subGet(id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/list/sub/characteristics?id=$id'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CharacteristicsModel.fromJson(e)).toList();
  }
}
