import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/drawer/data/models/respublic_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class RespublicRepository {
  final RespublicApi _respublicApi = RespublicApi();

  Future<List<RespublicModel>> respublics() => _respublicApi.respublics();
}

class RespublicApi {
  final _box = GetStorage();

  Future<List<RespublicModel>> respublics() async {
    final String? token = _box.read('token');

    final response = await http.get(
      Uri.parse("$baseUrl/list/respublics"),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data as List).map((e) => RespublicModel.fromJson(e)).toList();
  }
}
