import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/bonus_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BonusRepository {
  final BonusApi _bonusApi = BonusApi();

  Future<List<BonusModel>> bonuses() => _bonusApi.bonuses();
}

class BonusApi {
  final _box = GetStorage();

  Future<List<BonusModel>> bonuses() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/user/bonus'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => BonusModel.fromJson(e)).toList();
  }
}
