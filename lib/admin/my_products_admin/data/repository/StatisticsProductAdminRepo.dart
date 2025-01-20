import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/admin_statistics_product.dart';

const baseUrl = 'https://lunamarket.ru/api';

class StatisticsProductAdminRepository {
  final StatisticsProductToApi _statisticsProductToApi =
      StatisticsProductToApi();

  Future<StatisticsProductAdmin> get(product_id, year, month) =>
      _statisticsProductToApi.get(product_id, year, month);
}

class StatisticsProductToApi {
  Future<StatisticsProductAdmin> get(product_id, year, month) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/seller/product/statistics?product_id=$product_id&year=$year&month=$month'));

    final data = jsonDecode(response.body);

    return StatisticsProductAdmin.fromJson(data);
  }
}
