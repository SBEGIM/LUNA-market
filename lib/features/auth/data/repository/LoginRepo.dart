import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://80.87.202.73:8001/api';

class LoginRepository {
  LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String phone, String password) =>
      _loginToApi.login(phone, password);
  Future<dynamic> lateAuth() => _loginToApi.lateAuth();
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String phone, String password) async {
    String s = phone;

    // final device_token = _box.read('device_token');
    final device_token = '123';

//Removes everything after first '.'
    String result = s.substring(2);
    final response = await http.post(Uri.parse('$baseUrl/user/login'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'password': password,
      'device_type': 'android',
      'device_token': device_token,
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('token', data['access_token'].toString());
      _box.write('user_id', data['id'].toString());
      _box.write('name', data['name'].toString());
      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }

  Future<dynamic> lateAuth() async {
    // final device_token = _box.read('device_token');

//Removes everything after first '.'
    final response =
        await http.post(Uri.parse('$baseUrl/user/late/auth'), body: {});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data.toString());
      _box.write('token', data['access_token'].toString());
      _box.write('user_id', data['id'].toString());
      _box.write('name', 'Не авторизированный');
      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }
}
