import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/bloger/my_products_admin/data/models/blogger_product_statistics_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BloggerProductsStatisticsRepository {
  final StatisticsToApi _statisticsToApi = StatisticsToApi();

  Future<BloggerProductStatisticsModel> statistics() =>
      _statisticsToApi.statistics();
}

class StatisticsToApi {
  final _box = GetStorage();

  Future<BloggerProductStatisticsModel> statistics() async {
    final response =
        await http.get(Uri.parse('$baseUrl/blogger/product/statistics'));
    final data = jsonDecode(response.body);

    return BloggerProductStatisticsModel.fromJson(data);
  }
}
