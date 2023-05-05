import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class LoginAdminRepository {
  final LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String name, String password) =>
      _loginToApi.login(name, password);
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String name, String password) async {
    String deviceToken = _box.read('device_token');
    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }

    final response = await http.post(Uri.parse('$baseUrl/seller/login'), body: {
      'name': name,
      'password': password,
      'device_token': deviceToken.toString(),
      'device_type': deviceType
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('seller_token', data['token'].toString());
      _box.write('seller_id', data['id'].toString());
      _box.write('seller_name', data['name'].toString());
      _box.write('seller_image', data['image'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }
}
