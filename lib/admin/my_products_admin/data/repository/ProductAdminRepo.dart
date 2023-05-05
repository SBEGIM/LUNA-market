import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/admin_products_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class ProductAdminRepository {
  final ProductToApi _productToApi = ProductToApi();

  Future<dynamic> store(
    String price,
    String count,
    String compound,
    String catId,
    String brandId,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String articul,
    String currency,
  ) =>
      _productToApi.store(price, count, compound, catId, brandId, description,
          name, height, width, massa, articul, currency);

  Future<dynamic> update(
    String price,
    String count,
    String compound,
    String catId,
    String brandId,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String productId,
    String articul,
    String currency,
  ) =>
      _productToApi.update(price, count, compound, catId, brandId, description,
          name, height, width, massa, productId, articul, currency);

  Future<List<AdminProductsModel>> products(String? name) =>
      _productToApi.products(name);
}

class ProductToApi {
  final _box = GetStorage();

  Future<dynamic> store(
    String price,
    String count,
    String compound,
    String catId,
    String brandId,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String articul,
    String currency,
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
      'currency': currency,
    });

    return response.statusCode;
  }

  Future<dynamic> update(
    String price,
    String count,
    String compound,
    String catId,
    String brandId,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String productId,
    String articul,
    String currency,
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
      'product_id': productId,
      'articul': articul,
      'currency': currency,
    });

    return response.statusCode;
  }

  Future<List<AdminProductsModel>> products(String? name) async {
    try {
      final sellerId = _box.read('seller_id');
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse('$baseUrl/seller/products?shop_id=$sellerId&name=$name'),
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
