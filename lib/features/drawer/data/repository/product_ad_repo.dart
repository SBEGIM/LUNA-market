import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class ProductAdRepository {
  final ProductApi _productApi = ProductApi();

  Future<List<ProductModel>> product(int? catId) => _productApi.product(catId);
}

class ProductApi {
  final _box = GetStorage();

  Future<List<ProductModel>> product(int? catId) async {
    Map<String, dynamic> queryParams = {};

    Map<String, dynamic> body = {
      "cat_id": catId.toString(),
    };

    queryParams.addAll(body);

    final String? token = _box.read('token');
    final response = await http.get(
      Uri.parse(
        '$baseUrl/shop/ads',
      ).replace(queryParameters: queryParams),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
