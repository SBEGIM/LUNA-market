import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class LoginAdminRepository {
  final LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String name, String password) => _loginToApi.login(name, password);
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String name, String password) async {
    final deviceToken = await _box.read('device_token');
    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }

    final response = await http.post(Uri.parse('$baseUrl/seller/login'),
        body: {'name': name, 'password': password, 'device_token': deviceToken.toString(), 'device_type': deviceType});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('seller_token', data['token'].toString());
      _box.write('seller_id', data['id'].toString());
      _box.write('seller_name', data['name'].toString());
      _box.write('seller_image', data['image'].toString());
      _box.write('seller_phone', data['phone'].toString());
      _box.write('seller_email', data['email'].toString());
      _box.write('seller_country', data['country'].toString());
      _box.write('seller_city', data['city'].toString());
      _box.write('seller_home', data['home'].toString());
      _box.write('seller_street', data['street'].toString());
      _box.write('seller_iin', data['iin'].toString());
      _box.write('seller_check', data['check'].toString());
      _box.write('seller_partner', data['partner'].toString());
      _box.write('seller_userName', data['user_name'].toString());
      _box.write('seller_type_organization', data['type_organization'].toString());
    }
    return response.statusCode;
  }
}
