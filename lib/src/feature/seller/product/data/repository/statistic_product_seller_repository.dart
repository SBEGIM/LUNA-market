import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/statistic_product_seller_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class StatisticsProductAdminRepository {
  final StatisticsProductToApi _statisticsProductToApi = StatisticsProductToApi();

  Future<StatisticProductSellerModel> get(product_id, year, month) =>
      _statisticsProductToApi.get(product_id, year, month);
}

class StatisticsProductToApi {
  Future<StatisticProductSellerModel> get(product_id, year, month) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/seller/product/statistics?product_id=$product_id&year=$year&month=$month',
      ),
    );

    final data = jsonDecode(response.body);

    return StatisticProductSellerModel.fromJson(data);
  }
}
