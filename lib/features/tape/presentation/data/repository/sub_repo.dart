import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/home/data/model/PopularShops.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://80.87.202.73:8001/api';

class SubsRepository {
  SubApi _subApi = SubApi();

  subs(shop_id) => _subApi.sub(shop_id);
}

class SubApi {
  final _box = GetStorage();

  sub(shop_id) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/user/subs'),
        headers: {"Authorization": "Bearer $token"},
        body: {"shop_id": shop_id});

    return response.statusCode;
  }
}
