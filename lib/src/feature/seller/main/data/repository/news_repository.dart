import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/main/data/model/news_seeler_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class NewsSellerRepository {
  final NewsApi _newsApi = NewsApi();

  Future<List<NewsSeelerModel>> news() => _newsApi.news();
  like(int id) => _newsApi.like(id);
  view(int id) => _newsApi.view(id);
}

class NewsApi {
  final _box = GetStorage();

  Future<List<NewsSeelerModel>> news() async {
    String token = _box.read('seller_token');
    final response = await http.get(
      Uri.parse('$baseUrl/list/news'),
      headers: {"Authorization": "Bearer $token"},
    );
    final data = jsonDecode(response.body);

    return (data as List).map((e) => NewsSeelerModel.fromJson(e)).toList();
  }

  like(int id) async {
    final String? token = _box.read('seller_token');

    final response = await http.post(Uri.parse('$baseUrl/seller/news/like'),
        body: {'news_id': id.toString()},
        headers: {"Authorization": "Bearer $token"});

    return response.statusCode;
  }

  view(int id) async {
    final String? token = _box.read('seller_token');

    final response = await http.post(Uri.parse('$baseUrl/seller/news/view'),
        body: {'news_id': id.toString()},
        headers: {"Authorization": "Bearer $token"});

    return response.statusCode;
  }
}
