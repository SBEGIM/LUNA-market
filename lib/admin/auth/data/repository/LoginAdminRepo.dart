import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://80.87.202.73:8001/api';

class LoginAdminRepository {
  LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String name, String password) =>
      _loginToApi.login(name, password);
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String name, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/seller/login'), body: {
      'name': name,
      'password': password,
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('seller_token', data['token'].toString());
      _box.write('seller_id', data['id'].toString());
      _box.write('seller_name', data['name'].toString());
      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }
}
