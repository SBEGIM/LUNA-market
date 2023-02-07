import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../my_products_admin/data/models/blogger_shop_products_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class BloggerVideoProductsRepository {
  ProductToApi _productToApi = ProductToApi();

  Future<List<BloggerShopProductModel>> products(String? name, shop_id) =>
      _productToApi.products(name, shop_id);
}

class ProductToApi {
  final _box = GetStorage();

  Future<List<BloggerShopProductModel>> products(
      String? name, int shop_id) async {
    try {
      final String? token = _box.read('token');
      final response = await http.get(
          Uri.parse('$baseUrl/blogger/products?shop_id=$shop_id&name=$name'),
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
