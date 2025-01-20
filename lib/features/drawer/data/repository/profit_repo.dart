import 'dart:convert';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class ProfitRepository {
  final ProfitApi _profitApi = ProfitApi();

  Future<String> profitApi(id) => _profitApi.profit(id);
}

class ProfitApi {
  Future<String> profit(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/list/profitable?id=$id'));

    final data = jsonDecode(response.body);

    return data['path'];
  }
}
