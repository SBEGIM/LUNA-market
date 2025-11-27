import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class ProductRepository {
  final ProductApi _productApi = ProductApi();

  Future<List<ProductModel>> product(FilterProvider filters, int page) =>
      _productApi.product(filters, page);
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

  Future<List<ProductModel>> product(FilterProvider filters, int page) async {
    final queryParams = filters.toQueryParams(page: page);

    final String? token = _box.read('token');

    final uri = Uri.parse('$baseUrl/shop/search').replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer $token"});

    // if (response.statusCode < 200 || response.statusCode >= 300) {
    //   return;
    // }

    final data = jsonDecode(response.body);

    final products = (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();

    return products;
  }
}
