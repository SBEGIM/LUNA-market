
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/home/data/model/PopularShops.dart';
import 'package:http/http.dart' as http;

import '../models/shops_drawer_model.dart';



const   baseUrl = 'http://80.87.202.73:8001/api';

class ProductRepository{

  ProductApi  _productApi = ProductApi();

  Future<List<ProductModel>> product() => _productApi.product();

}


class ProductApi{

final _box = GetStorage();
RangeValues price = const RangeValues(0, 0);
int brandId = 0;
int shopId = 0;
int subCatId = 0;
bool rating = false;


  Future<List<ProductModel>> product() async {
    _box.listen(() {
      if(_box.read('priceFilter') != null){
          price = GetStorage().read('priceFilter');
      }
      if(_box.read('brandFilterId') != null){
          brandId = GetStorage().read('brandFilterId');
      }
      if(_box.read('subCatId') != null){
          subCatId = GetStorage().read('subCatId');
      }
      if(_box.read('shopFilterId') != null){
            shopId = GetStorage().read('shopFilterId');
      }
      if(_box.read('ratingFilter') != null){
        rating = GetStorage().read('ratingFilter');
      }


    });

    final String? token =  _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/shop/search?brand_id=$brandId?shop_id=$shopId?rating=$rating?cat_id=$subCatId') , headers:{
          "Authorization": "Bearer $token"
    });


    final data = jsonDecode(response.body);

    return  (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }

}