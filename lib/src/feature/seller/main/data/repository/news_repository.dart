import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/main/data/model/news_seeler_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class NewsSellerRepository {
  final NewsApi _newsApi = NewsApi();

  Future<List<NewsSeelerModel>> news() => _newsApi.news();
}

class NewsApi {
  Future<List<NewsSeelerModel>> news() async {
    final response = await http.get(Uri.parse('$baseUrl/list/news'));
    final data = jsonDecode(response.body);

    return (data as List).map((e) => NewsSeelerModel.fromJson(e)).toList();
  }
}
