import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/basket_admin_order_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class BasketAdminRepository {
  Basket _basket = Basket();

  Future<List<BasketAdminOrderModel>> basketOrderShow() =>
      _basket.basketOrderShow();

  Future<void> basketStatus(String status, id, product_id) =>
      _basket.basketStatus(status, id, product_id);
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

  Future<void> basketStatus(String status, id, product_id) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse("$baseUrl/basket/status"),
        headers: {"Authorization": "Bearer $token"},
        body: {'status': status, 'id': id, 'product_id': product_id});

    return;
  }
}
