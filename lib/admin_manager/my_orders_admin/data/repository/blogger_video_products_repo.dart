import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../my_products_admin/data/models/blogger_shop_products_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class BloggerVideoProductsRepository {
  final ProductToApi _productToApi = ProductToApi();

  Future<List<BloggerShopProductModel>> products(String? name, shopId) =>
      _productToApi.products(name, shopId);
}

class ProductToApi {
  final _box = GetStorage();

  Future<List<BloggerShopProductModel>> products(
      String? name, int shopId) async {
    try {
      final String? token = _box.read('blogger_token');
      final response = await http.get(
          Uri.parse('$baseUrl/blogger/products?shop_id=$shopId&name=$name'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return (data['data'] as List)
          .map((e) =>
              BloggerShopProductModel.fromJson(e as Map<String, Object?>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
