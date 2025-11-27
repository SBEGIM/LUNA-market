import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/drawer/data/models/credit_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class CreditRepository {
  final CredittApi _creditApi = CredittApi();

  Future<List<CreditModel>> credits(int id) => _creditApi.credits(id);
}

class CredittApi {
  final _box = GetStorage();

  Future<List<CreditModel>> credits(int id) async {
    final String? token = _box.read('token');

    final response = await http.get(
      Uri.parse("$baseUrl/list/credits?respublic_id=$id"),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CreditModel.fromJson(e)).toList();
  }
}
