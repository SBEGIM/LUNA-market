import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/optom_price_dto.dart';
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
          String subCatId,
          String brandId,
          String description,
          String name,
          String height,
          String width,
          String massa,
          String articul,
          String currency,
          String deep,
          List<dynamic>? image,
          List<optomPriceDto> optom,
          String? video) =>
      _productToApi.store(
          price,
          count,
          compound,
          catId,
          subCatId,
          brandId,
          description,
          name,
          height,
          width,
          massa,
          articul,
          currency,
          deep,
          image,
          optom,
          video);

  Future<dynamic> update(
          String price,
          String count,
          String compound,
          String catId,
          String subCatId,
          String brandId,
          String colorId,
          String description,
          String name,
          String height,
          String width,
          String massa,
          String productId,
          String articul,
          String currency,
          String deep,
          List<dynamic>? image) =>
      _productToApi.update(
          price,
          count,
          compound,
          catId,
          subCatId,
          brandId,
          colorId,
          description,
          name,
          height,
          width,
          massa,
          productId,
          articul,
          currency,
          deep,
          image);
  Future<dynamic> delete(String productId) => _productToApi.delete(productId);
  Future<String?> ad(int productId, int price) =>
      _productToApi.ad(productId, price);
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
      String subCatId,
      String brandId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String articul,
      String currency,
      String deep,
      List<dynamic>? image,
      List<optomPriceDto> optom,
      String? video) async {
    try {
      final sellerId = _box.read('seller_id');
      final token = _box.read('seller_token');

      Map<String, dynamic> bodys = {
        'shop_id': sellerId.toString(),
        'token': token.toString(),
        'name': name,
        'price': price,
        'count': count,
        'compound': compound,
        'cat_id': catId,
        'sub_cat_id': subCatId,
        'brand_id': brandId,
        'description': description,
        'height': height,
        'width': width,
        'massa': massa,
        'articul': articul,
        'deep': deep,
        'currency': currency,
      };

      Map<String, dynamic> queryParams = {};
      Map<String, dynamic> blocc = {};
      List<Map<String, dynamic>> blocMapList = [];

      for (var i = 0; i < optom.length; i++) {
        blocc['bloc[$i][count]'] = optom[i].count;
        blocc['bloc[$i][price]'] = optom[i].price;
      }

      queryParams.addAll(blocc);
      queryParams.addAll(bodys);

      final request = http.MultipartRequest(
          'POST',
          Uri.parse('$baseUrl/seller/product/store')
              .replace(queryParameters: queryParams));

      final headers = {
        'Authorization': 'Bearer $token',
      };

      request.headers.addAll(headers);

      if (video != null) {
        request.files.add(
          await http.MultipartFile.fromPath('video', video),
        );
      }

      image!.forEach((element) async {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', element!.path),
        );
      });

      final http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();

      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update(
      String price,
      String count,
      String compound,
      String catId,
      String subCatId,
      String brandId,
      String colorId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String productId,
      String articul,
      String currency,
      String deep,
      List<dynamic>? image) async {
    final sellerId = _box.read('seller_id');
    final token = _box.read('seller_token');

    final body = {
      'shop_id': sellerId.toString(),
      'token': token.toString(),
      'product_id': productId,
      'name': name,
      'price': price,
      'count': count,
      'compound': compound,
      'cat_id': catId,
      'sub_cat_id': subCatId,
      'brand_id': brandId,
      'color_id': colorId,
      'description': description,
      'height': height,
      'width': width,
      'massa': massa,
      'articul': articul,
      'deep': deep,
      'currency': currency,
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/seller/product/update'),
    );

    if (image != null) {
      image.forEach((element) async {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', element!.path),
        );
      });
    }
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    log(response.statusCode.toString() + 'we');
    return response.statusCode;
  }

  Future<dynamic> delete(String productId) async {
    final response =
        await http.post(Uri.parse('$baseUrl/seller/product/delete'), body: {
      'shop_id': _box.read('seller_id'),
      'token': _box.read('seller_token'),
      'product_id': productId,
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

  Future<String?> ad(int productId, int price) async {
    try {
      final sellerId = _box.read('seller_id');
      final String? token = _box.read('token');
      int view = 300;

      final response = await http.get(
          Uri.parse(
              '$baseUrl/seller/ad/payment/?product_id=$productId&price=$price&view=$view'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return data['data_tinkoff']['PaymentURL'];
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
