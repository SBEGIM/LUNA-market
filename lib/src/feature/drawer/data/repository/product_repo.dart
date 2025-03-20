import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/drawer/data/models/product_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class ProductRepository {
  final ProductApi _productApi = ProductApi();

  Future<List<ProductModel>> product(int page) => _productApi.product(page);
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
  int priceAsc = 0;
  int priceDesc = 0;
  int orderByNew = 0;
  int orderByPopular = 0;

  List<dynamic> shopIds = [];
  List<dynamic> brandIds = [];
  List<dynamic> subCatIds = [];

  Future<List<ProductModel>> product(int page) async {
    _box.listen(() {
      if (_box.hasData('priceFilter')) {
        price = GetStorage().read('priceFilter');
        price_start = price.start;
        price_end = price.end;
      } else {
        price = const RangeValues(0, 0);
      }
      if (_box.hasData('search')) {
        search = GetStorage().read('search');
      } else {
        search = '';
      }
      if (_box.hasData('brandFilterId')) {
        brandId = GetStorage().read('brandFilterId');
        brandIds.clear();
        var ab = json.decode(brandId).cast<int>().toList();

        brandIds.addAll(ab);
      } else {
        brandId = '';
        brandIds.clear();
      }
      if (_box.hasData('subCatFilterId')) {
        subCatId = GetStorage().read('subCatFilterId');
        subCatIds.clear();
        var ab = json.decode(subCatId).cast<int>().toList();
        subCatIds.addAll(ab);
      } else {
        subCatId = '';
        subCatIds.clear();
      }
      if (_box.hasData('CatId')) {
        CatId = GetStorage().read('CatId');
      } else {
        CatId = 0;
      }
      if (_box.hasData('shopFilterId')) {
        shopId = GetStorage().read('shopFilterId');
        shopIds.clear();
        var ab = json.decode(shopId).cast<int>().toList();
        shopIds.addAll(ab);
      } else {
        shopId = '';
        shopIds.clear();
      }
      if (_box.hasData('ratingFilter')) {
        rating = GetStorage().read('ratingFilter');
      } else {
        rating = false;
      }
      if (_box.hasData('sortFilter')) {
        final String sort = GetStorage().read('sortFilter');

        if (sort == 'priceAsc') {
          priceAsc = 1;
        }

        switch (sort) {
          case 'priceAsc':
            priceAsc = 1;
            priceDesc = 0;
            orderByNew = 0;
            orderByPopular = 0;

            break;
          case 'priceDesc':
            priceAsc = 0;
            priceDesc = 1;
            orderByNew = 0;
            orderByPopular = 0;
            break;
          case 'orderByNew':
            priceAsc = 0;
            priceDesc = 0;
            orderByNew = 1;
            orderByPopular = 0;
            break;
          case 'orderByPopular':
            priceAsc = 0;
            priceDesc = 0;
            orderByNew = 0;
            orderByPopular = 1;
            break;
          case 'rating':
            priceAsc = 0;
            priceDesc = 0;
            orderByNew = 0;
            orderByPopular = 0;
            rating = true;
            break;
          default:
        }
      }
    });

    Map<String, dynamic> queryParams = {};

    for (var i = 0; i < shopIds.length; i++) {
      queryParams['shop_id[$i]'] = shopIds[i].toString();
    }

    for (var i = 0; i < brandIds.length; i++) {
      print('sssss ${brandIds[i]}');
      queryParams['brand_id[$i]'] = brandIds[i].toString();
    }

    for (var i = 0; i < subCatIds.length; i++) {
      if (subCatIds[i] != 1) {
        queryParams['sub_cat_id[$i]'] = subCatIds[i].toString();
      }
    }

    Map<String, dynamic> body = {
      "rating": "$rating",
      "cat_id": "$CatId",
      "search": search,
      "min_price": "$price_start",
      "max_price": "$price_end",
      "price_asc": "$priceAsc",
      "price_desc": "$priceDesc",
      "order_by_new": "$orderByNew",
      "order_by_popular": "$orderByPopular",
      "page": "$page"
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
