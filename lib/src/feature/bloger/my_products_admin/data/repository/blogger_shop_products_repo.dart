import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/blogger_shop_products_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class BloggerShopProductsRepository {
  final ProductToApi _productToApi = ProductToApi();

  Future<List<BloggerShopProductModel>> products(String? name, shopId, page) =>
      _productToApi.products(name, shopId, page);
}

class ProductToApi {
  final _box = GetStorage();

  Future<List<BloggerShopProductModel>> products(
      String? name, int shopId, int page) async {
    try {
      final String? token = _box.read('token');
      final response = await http.get(
          Uri.parse(
              '$baseUrl/seller/products?shop_id=$shopId&name=$name&page=$page'),
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
