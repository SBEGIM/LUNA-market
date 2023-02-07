import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../DTO/register_blogger_dto.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class LoginBloggerRepository {
  LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String phone, String password) =>
      _loginToApi.login(phone, password);

  Future<dynamic> register(RegisterBloggerDTO register) =>
      _loginToApi.register(register);
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String phone, String password) async {
    String s = phone;

    String result = s.substring(2);

    final response =
        await http.post(Uri.parse('$baseUrl/blogger/login'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'password': password,
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_name', data['name'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }

  Future<dynamic> register(RegisterBloggerDTO register) async {
    String s = register.phone;

    String result = s.substring(2);

    final response =
        await http.post(Uri.parse('$baseUrl/blogger/register'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'password': register.password,
      'nick_name': register.nick_name,
      'email': register.email,
      'social_network': register.social_network,
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_name', data['name'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }
}
