import 'dart:convert';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class ProfitRepository {
  final ProfitApi _profitApi = ProfitApi();

  Future<String> profitApi() => _profitApi.profit();
}

class ProfitApi {
  Future<String> profit() async {
    final response = await http.get(Uri.parse('$baseUrl/list/profitable'));

    final data = jsonDecode(response.body);

    return data['path'];
  }
}
