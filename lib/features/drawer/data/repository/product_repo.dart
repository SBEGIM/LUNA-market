import 'dart:convert';
import 'dart:developer';
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
  int brandId = 0;
  String search = '';
  int shopId = 0;
  int subCatId = 0;
  bool rating = false;

  Future<List<ProductModel>> product() async {
    if (_box.read('shopFilterId') != null) {
      shopId = GetStorage().read('shopFilterId');
    }
    _box.listen(() {
      if (_box.read('priceFilter') != null) {
        price = GetStorage().read('priceFilter');
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
      } else {
        brandId = 0;
      }
      if (_box.read('subCatId') != null) {
        subCatId = GetStorage().read('subCatId');
      } else {
        subCatId = 0;
      }
      if (_box.read('shopFilterId') != null) {
        shopId = GetStorage().read('shopFilterId');
      } else {
        shopId = 0;
      }
      if (_box.read('ratingFilter') != null) {
        rating = GetStorage().read('ratingFilter');
      } else {
        rating = false;
      }
    });

    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse(
            '$baseUrl/shop/search?brand_id=$brandId&shop_id=$shopId&rating=$rating&cat_id=$subCatId&sub_cat_id=$subCatId&search=$search'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
