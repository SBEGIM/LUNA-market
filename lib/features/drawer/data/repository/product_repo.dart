import 'dart:convert';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/home/data/model/PopularShops.dart';
import 'package:http/http.dart' as http;

import '../models/shops_drawer_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class ProductRepository {
  ProductApi _productApi = ProductApi();

  Future<List<ProductModel>> product() => _productApi.product();
}

class ProductApi {
  final _box = GetStorage();
  RangeValues price = const RangeValues(0, 0);

  double? price_start;
  double? price_end;
  String brandId = '';
  String search = '';
  String shopId = '';
  int CatId = 0;
  String subCatId = '';
  bool rating = false;
  List<dynamic> shopIds = [];
  List<dynamic> brandIds = [];
  List<dynamic> subCatIds = [];

  Future<List<ProductModel>> product() async {
    if (_box.read('shopFilterId') != null) {
      shopId = GetStorage().read('shopFilterId');
    }
    _box.listen(() {
      if (_box.read('priceFilter') != null) {
        price = GetStorage().read('priceFilter');
        price_start = price.start;
        price_end = price.end;
      } else {
        price = const RangeValues(0, 0);
      }
      if (_box.read('search') != null) {
        search = GetStorage().read('search');
      } else {
        search = '';
      }
      if (_box.read('brandFilterId') != null) {
        brandId = GetStorage().read('brandFilterId');
        brandIds.clear();
        var ab = json.decode(brandId).cast<int>().toList();
        brandIds.addAll(ab);
      } else {
        brandId = '';
      }
      if (_box.read('subCatFilterId') != null) {
        subCatId = GetStorage().read('subCatFilterId');
        subCatIds.clear();
        var ab = json.decode(subCatId).cast<int>().toList();
        subCatIds.addAll(ab);
      } else {
        subCatId = '';
      }
      if (_box.read('CatId') != null) {
        CatId = GetStorage().read('CatId');
      } else {
        CatId = 0;
      }
      if (_box.read('shopFilterId') != null) {
        shopId = GetStorage().read('shopFilterId');
        shopIds.clear();
        var ab = json.decode(shopId).cast<int>().toList();
        shopIds.addAll(ab);
      } else {
        shopId = '';
      }
      if (_box.read('ratingFilter') != null) {
        rating = GetStorage().read('ratingFilter');
      } else {
        rating = false;
      }
    });

    Map<String, dynamic> queryParams = {};

    // shopIds.forEach((element) {
    //   return queryParams
    //       .addAll({"shop_id[${(element - 1).toString()}]": element.toString()});
    // });

    for (var i = 0; i < shopIds.length; i++) {
      queryParams['shop_id[$i]'] = shopIds[i].toString();
    }

    for (var i = 0; i < brandIds.length; i++) {
      queryParams['brand_id[$i]'] = brandIds[i].toString();
    }

    for (var i = 0; i < subCatIds.length; i++) {
      queryParams['sub_cat_id[$i]'] = subCatIds[i].toString();
    }

    Map<String, dynamic> body = {
      "rating": "${rating}",
      "cat_id": "${CatId}",
      "search": "${search}",
      "min_price": "${price_start}",
      "max_price": "${price_end}",
    };

    queryParams.addAll(body);

    final String? token = _box.read('token');
    final response = await http.get(
      Uri.parse(
        '$baseUrl/shop/search',
      ).replace(queryParameters: queryParams),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
