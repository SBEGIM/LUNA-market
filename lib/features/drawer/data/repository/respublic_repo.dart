import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/drawer/data/models/credit_model.dart';
import 'package:haji_market/features/drawer/data/models/respublic_model.dart';
import 'package:http/http.dart' as http;

import '../models/review_product_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class RespublicRepository {
  final RespublicApi _respublicApi = RespublicApi();

  Future<List<RespublicModel>> respublics() => _respublicApi.respublics();
}

class RespublicApi {
  final _box = GetStorage();

  Future<List<RespublicModel>> respublics() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse("$baseUrl/list/respublics"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => RespublicModel.fromJson(e)).toList();
  }
}
