import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/review_product_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ReviewProductRepository {
  final ReviewProductApi _reviewProductApi = ReviewProductApi();

  Future<List<ReviewProductModel>> productReviews(String product_id) =>
      _reviewProductApi.productReviews(product_id);

  Future<int> storeReview(String review, String rating, String product_id) =>
      _reviewProductApi.storeReview(review, rating, product_id);
}

class ReviewProductApi {
  final _box = GetStorage();

  Future<List<ReviewProductModel>> productReviews(String product_id) async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse("$baseUrl/shop/review/product?id=$product_id&page=1"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => ReviewProductModel.fromJson(e))
        .toList();
  }

  Future<int> storeReview(
      String review, String rating, String product_id) async {
    final String? token = _box.read('token');

    final response =
        await http.post(Uri.parse("$baseUrl/shop/review/store"), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'review': review,
      'rating': rating,
      'product_id': product_id,
    });

    // final data = jsonDecode(response.body);

    return response.statusCode;
  }
}
