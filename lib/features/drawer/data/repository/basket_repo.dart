import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class BasketRepository {
  final Basket _basket = Basket();

  Future<int> basketAdd(productId, count, price, size, color) =>
      _basket.basketAdd(productId, count, price, size, color);
  Future<int> basketMinus(productId, count, price) =>
      _basket.basketMinus(productId, count, price);
  Future<List<BasketShowModel>> basketShow() => _basket.basketShow();
  Future<List<BasketOrderModel>> basketOrderShow() => _basket.basketOrderShow();
  Future<int> basketOrder(List id) => _basket.basketOrder(id);
  Future<String> payment({
    String? address,
  }) =>
      _basket.payment(
        address: address,
      );
  Future<int> status(String id, String status, String? text) =>
      _basket.status(id, status, text);
}

class Basket {
  final _box = GetStorage();

  Future<int> basketAdd(productId, count, price, size, color) async {
    final String? token = _box.read('token');

    final response =
        await http.post(Uri.parse('$baseUrl/basket/add'), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'product_id': productId,
      'count': count.toString(),
      'price': price.toString(),
      'size': size,
      'color': color
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

  Future<List<BasketShowModel>> basketShow() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/basket/show'),
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
    print('wwww1');

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

  Future<String> payment({
    String? address,
  }) async {
    final String? token = _box.read('token');

    final response = await http
        .post(Uri.parse('$baseUrl/payment/tinkoff/payment'), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'address': address,
    }
            //
            // basketData ,
            );

    final data = jsonDecode(response.body);

    print(data.toString());
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
