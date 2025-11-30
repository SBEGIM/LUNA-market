import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_show_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BasketRepository {
  final Basket _basket = Basket();

  Future<int> basketAdd(
    productId,
    count,
    price,
    size,
    color, {
    bool? isOptom,
    String? blogger_id,
  }) => _basket.basketAdd(
    productId,
    count,
    price,
    size,
    color,
    isOptom: isOptom,
    blogger_id: blogger_id,
  );
  Future<int> basketMinus(productId, count, price) => _basket.basketMinus(productId, count, price);
  Future<int> basketDelete(productId) => _basket.basketDelete(productId);

  Future<int> basketDeleteProducts(productIds) => _basket.basketDeleteProducts(productIds);

  Future<List<BasketShowModel>> basketShow() => _basket.basketShow();
  Future<List<BasketOrderModel>> basketOrderShow({required String status, required int page}) =>
      _basket.basketOrderShow(status: status, page: page);
  Future<int> basketOrder(List id) => _basket.basketOrder(id);
  Future<String> payment({
    required BuildContext context,
    required List<int> basketIds,
    String? address,
    String? bonus,
    String? fulfillment,
  }) => _basket.payment(
    context: context,
    basketIds: basketIds,
    address: address,
    bonus: bonus,
    fulfillment: fulfillment,
  );
  Future<int> status(String id, String status, String? text) => _basket.status(id, status, text);
}

class Basket {
  final _box = GetStorage();

  Future<int> basketAdd(
    productId,
    count,
    price,
    size,
    color, {
    bool? isOptom,
    String? blogger_id,
  }) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/basket/add'),
      headers: {"Authorization": "Bearer $token"},
      body: {
        'product_id': productId.toString(),
        'count': count.toString(),
        'price': price.toString(),
        'size': size.toString(),
        'color': color.toString(),
        if (isOptom == true) 'optom': '1',
        if (blogger_id != '0' && blogger_id != null) 'blogger_id': blogger_id,
      },
    );

    final data = response.statusCode;

    return data;
  }

  Future<int> basketMinus(productId, count, int? price) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/basket/minus'),
      headers: {"Authorization": "Bearer $token"},
      body: {'product_id': productId, 'count': count.toString(), 'price': price.toString()},
    );

    final data = response.statusCode;

    return data;
  }

  Future<int> basketDelete(productId) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/basket/delete'),
      headers: {"Authorization": "Bearer $token"},
      body: {'product_id': productId},
    );

    final data = response.statusCode;

    return data;
  }

  Future<int> basketDeleteProducts(List<int> productIds) async {
    final String? token = _box.read('token');

    final uri = Uri.parse('$baseUrl/basket/delete/products');
    final headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final payload = <String, dynamic>{'product_ids': productIds};

    final response = await http.delete(uri, headers: headers, body: jsonEncode(payload));

    return response.statusCode;
  }

  Future<List<BasketShowModel>> basketShow() async {
    final String? token = _box.read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/basket/show'),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => BasketShowModel.fromJson(e)).toList();
  }

  Future<List<BasketOrderModel>> basketOrderShow({
    required String status,
    required int page,
  }) async {
    final String? token = _box.read('token');

    final response = await http.get(
      Uri.parse("$baseUrl/basket/order/status?status=$status&page=$page"),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => BasketOrderModel.fromJson(e)).toList();
  }

  Future<int> basketOrder(List id) async {
    final String? token = _box.read('token');

    Map<String, String>? basketData = {};
    for (int i = 0; i < id.length; i++) {
      basketData.addAll({"id[$i]": "${id[i]}"});
    }

    final response = await http.post(
      Uri.parse('$baseUrl/basket/order'),
      headers: {"Authorization": "Bearer $token"},
      body: basketData,
      //
      // basketData ,
    );

    final data = response.statusCode;

    return data;
  }

  Future<String> payment({
    required BuildContext context,
    required List<int> basketIds,
    String? address,
    String? bonus,
    String? fulfillment,
  }) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/payment/tinkoff/payment/v1'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({
        'address': address,
        'bonus': bonus,
        'fulfillment': fulfillment,
        'basket_ids': basketIds,
      }),
    );
    final data = jsonDecode(response.body);

    if (data['data_tinkoff']?['Success'] != true) {
      AppSnackBar.show(
        context,
        '${data['data_tinkoff']?['Details'] ?? 'Ошибка оплаты'}',
        type: AppSnackType.error,
      );
    }

    return data['data_tinkoff']['PaymentURL'];
  }

  Future<int> status(id, status, text) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/basket/status'),
      headers: {"Authorization": "Bearer $token"},
      body: {"id": id, "status": status, "text": text},
      //
      // basketData ,
    );

    return response.statusCode;
  }
}
