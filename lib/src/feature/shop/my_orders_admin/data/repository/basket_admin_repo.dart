import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/basket_admin_order_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class BasketAdminRepository {
  final Basket _basket = Basket();

  Future<List<BasketAdminOrderModel>> basketOrderShow(fulfillment) =>
      _basket.basketOrderShow(fulfillment);

  Future<List<BasketAdminOrderModel>> basketOrderRealFbsShow(fulfillment) =>
      _basket.basketOrderRealFbsShow(fulfillment);

  Future<List<BasketAdminOrderModel>> basketOrderEndShow() =>
      _basket.basketOrderEndShow();

  Future<void> basketStatus(String status, id, productId, fulfillment) =>
      _basket.basketStatus(status, id, productId, fulfillment);
}

class Basket {
  final _box = GetStorage();

  Future<List<BasketAdminOrderModel>> basketOrderShow(
      String? fulfillment) async {
    final String? token = _box.read('seller_token');

    final response = await http.get(
        Uri.parse(
            "$baseUrl/basket/order/seller/status?status=active&page=1&fulfillment=$fulfillment"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => BasketAdminOrderModel.fromJson(e))
        .toList();
  }

  Future<List<BasketAdminOrderModel>> basketOrderRealFbsShow(
      String? fulfillment) async {
    final String? token = _box.read('seller_token');

    final response = await http.get(
        Uri.parse(
            "$baseUrl/basket/order/seller/status?status=active&page=1&fulfillment=realFBS"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => BasketAdminOrderModel.fromJson(e))
        .toList();
  }

  Future<List<BasketAdminOrderModel>> basketOrderEndShow() async {
    final String? token = _box.read('seller_token');

    final response = await http.get(
        Uri.parse("$baseUrl/basket/order/seller/status?status=end&page=1"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => BasketAdminOrderModel.fromJson(e))
        .toList();
  }

  Future<void> basketStatus(String status, id, productId, fulfillment) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse("$baseUrl/basket/status"),
        headers: {
          "Authorization": "Bearer $token"
        },
        body: {
          'status': status,
          'id': id,
          'product_id': productId,
          'fulfillment': fulfillment
        });

    return;
  }
}
