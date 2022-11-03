
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/home/data/model/PopularShops.dart';
import 'package:http/http.dart' as http;

import '../models/shops_drawer_model.dart';



const   baseUrl = 'http://80.87.202.73:8001/api';

class FavoriteRepository{

  FavoriteApi  _favoriteApi = FavoriteApi();

  Future<List<ProductModel>> favorites() => _favoriteApi.favorites();
  Future<int> favorite(id) => _favoriteApi.favorite(id);

}


class FavoriteApi{

final _box = GetStorage();

  Future<List<ProductModel>> favorites() async {


    final String? token =  _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/user/favorites') , headers:{
          "Authorization": "Bearer $token"});


    final data = jsonDecode(response.body);

    return  (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }




  Future<int> favorite(id) async {


    final String? token =  _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/shop/favorite/store') , headers:{
          "Authorization": "Bearer $token"
    },body: {
      'id': id
    }

    );


    final data = response.statusCode;

    return  data;
  }

}