import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/basket_admin_order_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class BasketAdminRepository {
  final Basket _basket = Basket();

  Future<List<BasketAdminOrderModel>> basketOrderShow() =>
      _basket.basketOrderShow();

  Future<void> basketStatus(String status, id, productId) =>
      _basket.basketStatus(status, id, productId);
}

class Basket {
  final _box = GetStorage();

  Future<List<BasketAdminOrderModel>> basketOrderShow() async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse("$baseUrl/basket/order/status?status=active&page=1"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => BasketAdminOrderModel.fromJson(e))
        .toList();
  }

  Future<void> basketStatus(String status, id, productId) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse("$baseUrl/basket/status"),
        headers: {"Authorization": "Bearer $token"},
        body: {'status': status, 'id': id, 'product_id': productId});

    return;
  }
}
