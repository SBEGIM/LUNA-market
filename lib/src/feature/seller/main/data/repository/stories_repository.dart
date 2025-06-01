import 'dart:convert';
import 'package:haji_market/src/feature/seller/main/data/model/stories_seller_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class StoriesSellerRepository {
  final NewsApi _storiesApi = NewsApi();

  Future<List<SellerStoriesModel>> news() => _storiesApi.news();
}

class NewsApi {
  Future<List<SellerStoriesModel>> news() async {
    final response = await http.get(Uri.parse('$baseUrl/list/stories'));
    final data = jsonDecode(response.body);

    return (data as List).map((e) => SellerStoriesModel.fromJson(e)).toList();
  }
}
