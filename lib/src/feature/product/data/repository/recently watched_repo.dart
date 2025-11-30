import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class RecentlyWatchedRepository {
  final ProductApi _productApi = ProductApi();

  Future<List<ProductModel>> product(FilterProvider filters) => _productApi.product(filters);
}

class ProductApi {
  final _box = GetStorage();

  RangeValues price = const RangeValues(0, 0);
  double? price_start;
  double? price_end;
  String brandId = '';
  String search = '';
  String shopId = '';
  int CatId = 0;
  String subCatId = '';
  bool rating = false;
  int priceAsc = 0;
  int priceDesc = 0;
  int orderByNew = 0;
  int orderByPopular = 0;

  List<dynamic> shopIds = [];
  List<dynamic> brandIds = [];
  List<dynamic> subCatIds = [];

  Future<List<ProductModel>> product(FilterProvider filters) async {
    final queryParams = filters.toQueryParams(page: 1);

    final String? token = _box.read('token');

    final uri = Uri.parse('$baseUrl/shop/recently/watched').replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    final products = (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();

    return products;
  }
}
