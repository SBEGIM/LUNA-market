import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/admin_products_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class ProductAdminRepository {
  ProductToApi _productToApi = ProductToApi();

  Future<dynamic> product(String price, String count, String compound,
          String cat_id, String brand_id, String description, String name) =>
      _productToApi.product(
          price, count, compound, cat_id, brand_id, description, name);

  Future<List<AdminProductsModel>> products() => _productToApi.products();
}

class ProductToApi {
  final _box = GetStorage();

  Future<dynamic> product(String price, String count, String compound,
      String cat_id, String brand_id, String description, String name) async {
    final response =
        await http.post(Uri.parse('$baseUrl/seller/product/store'), body: {
      'shop_id': _box.read('seller_id'),
      'token': _box.read('seller_token'),
      'name': name,
      'price': price,
      'count': count,
      'compound': compound,
      'cat_id': '1',
      'brand_id': '1',
      'description': description,
    });

    return response.statusCode;
  }

  Future<List<AdminProductsModel>> products() async {
    try {
      final seller_id = _box.read('seller_id');
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse('$baseUrl/seller/products?shop_id=$seller_id'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return (data['data'] as List)
          .map((e) => AdminProductsModel.fromJson(e as Map<String, Object?>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
