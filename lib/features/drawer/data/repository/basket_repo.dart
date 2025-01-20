import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BasketRepository {
  final Basket _basket = Basket();

  Future<int> basketAdd(productId, count, price, size, color,
          {bool? isOptom, String? blogger_id}) =>
      _basket.basketAdd(productId, count, price, size, color,
          isOptom: isOptom, blogger_id: blogger_id);
  Future<int> basketMinus(productId, count, price) =>
      _basket.basketMinus(productId, count, price);
  Future<int> basketDelete(productId) => _basket.basketDelete(productId);
  Future<List<BasketShowModel>> basketShow(String? fulfillment) =>
      _basket.basketShow(fulfillment);
  Future<List<BasketOrderModel>> basketOrderShow() => _basket.basketOrderShow();
  Future<int> basketOrder(List id) => _basket.basketOrder(id);
  Future<String> payment(
          {String? address, String? bonus, String? fulfillment}) =>
      _basket.payment(
        address: address,
        bonus: bonus,
        fulfillment: fulfillment,
      );
  Future<int> status(String id, String status, String? text) =>
      _basket.status(id, status, text);
}

class Basket {
  final _box = GetStorage();

  Future<int> basketAdd(productId, count, price, size, color,
      {bool? isOptom, String? blogger_id}) async {
    final String? token = _box.read('token');

    final response =
        await http.post(Uri.parse('$baseUrl/basket/add'), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'product_id': productId.toString(),
      'count': count.toString(),
      'price': price.toString(),
      'size': size.toString(),
      'color': color.toString(),
      if (isOptom == true) 'optom': '1',
      if (blogger_id != '0' && blogger_id != null) 'blogger_id': blogger_id
    });

    final data = response.statusCode;

    return data;
  }

  Future<int> basketMinus(productId, count, int? price) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/basket/minus'),
        headers: {
          "Authorization": "Bearer $token"
        },
        body: {
          'product_id': productId,
          'count': count.toString(),
          'price': price.toString()
        });

    final data = response.statusCode;

    return data;
  }

  Future<int> basketDelete(
    productId,
  ) async {
    final String? token = _box.read('token');

    final response =
        await http.post(Uri.parse('$baseUrl/basket/delete'), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'product_id': productId,
    });

    final data = response.statusCode;

    return data;
  }

  Future<List<BasketShowModel>> basketShow(String? fulfillment) async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse('$baseUrl/basket/show?fulfillment=$fulfillment'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => BasketShowModel.fromJson(e))
        .toList();
  }

  Future<List<BasketOrderModel>> basketOrderShow() async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse("$baseUrl/basket/order/status?status=active&page=1"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => BasketOrderModel.fromJson(e))
        .toList();
  }

  Future<int> basketOrder(List id) async {
    final String? token = _box.read('token');

    Map<String, String>? basketData = {};
    for (int i = 0; i < id.length; i++) {
      basketData.addAll({"id[$i]": "${id[i]}"});
    }

    final response = await http.post(Uri.parse('$baseUrl/basket/order'),
        headers: {"Authorization": "Bearer $token"}, body: basketData
        //
        // basketData ,
        );

    final data = response.statusCode;

    return data;
  }

  Future<String> payment(
      {String? address, String? bonus, String? fulfillment}) async {
    final String? token = _box.read('token');

    final response = await http.post(
        Uri.parse('$baseUrl/payment/tinkoff/payment'),
        headers: {"Authorization": "Bearer $token"},
        body: {'address': address, 'bonus': bonus, 'fulfillment': fulfillment});

    final data = jsonDecode(response.body);


    return data['data_tinkoff']['PaymentURL'];
  }

  Future<int> status(id, status, text) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/basket/status'),
      headers: {"Authorization": "Bearer $token"},
      body: {
        "id": id,
        "status": status,
        "text": text,
      },
      //
      // basketData ,
    );

    return response.statusCode;
  }
}
