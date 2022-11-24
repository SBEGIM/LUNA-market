import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/admin_products_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class ProductAdminRepository {
  ProductToApi _productToApi = ProductToApi();

  Future<dynamic> store(
          String price,
          String count,
          String compound,
          String cat_id,
          String brand_id,
          String description,
          String name,
          String height,
          String width,
          String massa,
          String articul) =>
      _productToApi.store(price, count, compound, cat_id, brand_id, description,
          name, height, width, massa, articul);

  Future<dynamic> update(
    String price,
    String count,
    String compound,
    String cat_id,
    String brand_id,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String product_id,
    String articul,
  ) =>
      _productToApi.update(price, count, compound, cat_id, brand_id,
          description, name, height, width, massa, product_id, articul);

  Future<List<AdminProductsModel>> products(String? name) =>
      _productToApi.products(name);
}

class ProductToApi {
  final _box = GetStorage();

  Future<dynamic> store(
    String price,
    String count,
    String compound,
    String cat_id,
    String brand_id,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String articul,
  ) async {
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
      'height': height,
      'width': width,
      'massa': massa,
      'articul': articul,
    });

    return response.statusCode;
  }

  Future<dynamic> update(
    String price,
    String count,
    String compound,
    String cat_id,
    String brand_id,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String product_id,
    String articul,
  ) async {
    final response =
        await http.post(Uri.parse('$baseUrl/seller/product/update'), body: {
      'shop_id': _box.read('seller_id'),
      'token': _box.read('seller_token'),
      'name': name,
      'price': price,
      'count': count,
      'compound': compound,
      'cat_id': '1',
      'brand_id': '1',
      'description': description,
      'height': height,
      'width': width,
      'massa': massa,
      'product_id': product_id,
      'articul': articul,
    });

    return response.statusCode;
  }

  Future<List<AdminProductsModel>> products(String? name) async {
    try {
      final seller_id = _box.read('seller_id');
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse('$baseUrl/seller/products?shop_id=$seller_id&name=$name'),
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
