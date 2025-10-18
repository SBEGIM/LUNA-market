import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../DTO/blogger_dto.dart';

const baseUrl = 'https://lunamarket.ru/api';

class LoginBloggerRepository {
  final LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String phone, String password) =>
      _loginToApi.login(phone, password);

  Future<dynamic> register(BloggerDTO register) =>
      _loginToApi.register(register);
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String phone, String password) async {
    final deviceToken = await _box.read('device_token');
    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }
    String s = phone;

    String result = s.substring(1);

    final response =
        await http.post(Uri.parse('$baseUrl/blogger/login'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'password': password,
      'device_token': deviceToken.toString(),
      'device_type': deviceType
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_name', data['name'].toString());
      _box.write('blogger_phone', data['phone'].toString());
      _box.write('blogger_nick_name', data['nick_name'].toString());
      _box.write('blogger_iin', data['iin'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());
      _box.write('blogger_invoice', data['invoice'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }

  Future<dynamic> register(BloggerDTO register) async {
    String s = register.phone ?? '';
    final deviceToken = await _box.read('device_token');

    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }

    String result = s.substring(2);

    final response =
        await http.post(Uri.parse('$baseUrl/blogger/register'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'first_name': register.firstName,
      'last_name': register.lastName,
      'sur_name': register.surName,
      'password': register.password,
      'iin': register.iin,
      'nick_name': register.nick,
      'email': register.email,
      'invoice': register.check,
      'social_network': register.socialNetwork,
      'legal_status': register.legalStatus.toString(),
      'device_token': deviceToken.toString(),
      'device_type': deviceType
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_first_name', data['first_name'].toString());
      _box.write('blogger_last_name', data['last_name'].toString());
      _box.write('blogger_sur_name', data['sur_name'].toString());
      _box.write('blogger_nick_name', data['nick_name'].toString());
      _box.write('blogger_phone', data['phone'].toString());
      _box.write('blogger_iin', data['iin'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());
      _box.write('blogger_invoice', data['invoice'].toString());
      _box.write('blogger_legal_status', data['invoice'].toString());
    }
    return response.statusCode;
  }
}
