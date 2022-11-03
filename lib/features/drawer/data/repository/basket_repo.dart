import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:http/http.dart' as http;




const   baseUrl = 'http://80.87.202.73:8001/api';

class BasketRepository{

  Basket  _basket = Basket();

  Future<int> basketAdd(product_id , count) => _basket.basketAdd(product_id , count);
  Future<int> basketMinus(product_id , count) => _basket.basketMinus(product_id , count);
  Future<List<BasketShowModel>> basketShow() => _basket.basketShow();
  Future<List<BasketOrderModel>> basketOrderShow() => _basket.basketOrderShow();
  Future<int> basketOrder(List id) => _basket.basketOrder(id);

}


class Basket{

final _box = GetStorage();


  Future<int> basketAdd(product_id , count) async {


    final String? token =  _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/basket/add') , headers:{
          "Authorization": "Bearer $token"
    },body: {
      'product_id': product_id,
      'count': count,
    }

    );


    final data = response.statusCode;

    return  data;
  }

  Future<int> basketMinus(product_id , count) async {


    final String? token =  _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/basket/minus') , headers:{
          "Authorization": "Bearer $token"
    },body: {
      'product_id': product_id,
      'count': count,
    }

    );


    final data = response.statusCode;

    return  data;
  }

  Future<List<BasketShowModel>> basketShow() async {

    final String? token =  _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/basket/show') , headers:{
          "Authorization": "Bearer $token"
    });

    final data = jsonDecode(response.body);

    return  (data['data'] as List).map((e) => BasketShowModel.fromJson(e)).toList();
  }


  Future<List<BasketOrderModel>> basketOrderShow() async {

    final String? token =  _box.read('token');

    final response = await http.get(Uri.parse("$baseUrl/basket/order/status?status=active&page=1") , headers:{
          "Authorization": "Bearer $token"
    }

    );

    final data = jsonDecode(response.body);
    print('wwww1');

    return  (data['data'] as List).map((e) => BasketOrderModel.fromJson(e)).toList();
  }


Future<int> basketOrder(List id) async {

  final String? token =  _box.read('token');

  Map<String,String>?basketData = Map();
  for(int i=0;i<id.length;i++){
    basketData.addAll({"id[$i]":"${id[i]}"});
  }


  final response = await http.post(Uri.parse('$baseUrl/basket/order') , headers:{
    "Authorization": "Bearer $token"
  },body: basketData
  //
  // basketData ,
  );


  final data = response.statusCode;

  return  data;
}

}