import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/auth/data/DTO/register.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class RegisterBloggerRepository {
  final RegisterToApi _registerToApi = RegisterToApi();

  Future<dynamic> register(RegisterDTO register) => _registerToApi.register(register);
  Future<dynamic> smsSend(String phone) => _registerToApi.smsSend(phone);
  Future<dynamic> smsCheck(String phone, String code) => _registerToApi.smsCheck(phone, code);
  Future<dynamic> resetSend(String phone) => _registerToApi.resetSend(phone);
  Future<dynamic> resetCheck(String phone, String code) => _registerToApi.resetCheck(phone, code);
  Future<dynamic> passwordReset(String phone, String password) =>
      _registerToApi.passwordReset(phone, password);
}

class RegisterToApi {
  final _box = GetStorage();

  Future<dynamic> register(RegisterDTO register) async {
    final deviceToken = await _box.read('device_token');

    String s = register.phone;
    String result = s.substring(1);

    final String? token = _box.read('token');

    final headers = {'Authorization': 'Bearer $token'};
    final body = {
      'first_name': register.firstName,
      'last_name': register.lastName,
      'sur_name': register.surName,
      'password': register.password,
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'device_token': deviceToken.toString(),
      'device_type': 'android',
    };

    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/blogger/register'));

    // if(register.avatar != ''){
    //   request.files.add(await http.MultipartFile.fromPath('avatar', register.avatar),);
    // }
    request.headers.addAll(headers);
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(respStr);
      _box.write('token', data['access_token'].toString());
      _box.write('user_id', data['user']['id'].toString());
      _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }

  Future<dynamic> smsSend(String phone) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(
      Uri.parse('$baseUrl/blogger/register/send-code'),
      body: {'phone': result.replaceAll(RegExp('[^0-9]'), '')},
    );

    return response.statusCode;
  }

  Future<dynamic> smsCheck(String phone, String code) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(
      Uri.parse('$baseUrl/blogger/register/check'),
      body: {'phone': result.replaceAll(RegExp('[^0-9]'), ''), 'code': code},
    );

    return response.statusCode;
  }

  Future<dynamic> resetSend(String phone) async {
    String s = phone;
    String result = s.substring(1);

    final response = await http.post(
      Uri.parse('$baseUrl/blogger/password/reset/send-code'),
      body: {'phone': result.replaceAll(RegExp('[^0-9]'), '')},
    );

    return response.statusCode;
  }

  Future<dynamic> resetCheck(String phone, String code) async {
    String s = phone;
    String result = s.substring(1);

    final response = await http.post(
      Uri.parse('$baseUrl/blogger/password/reset/check-code'),
      body: {'phone': result.replaceAll(RegExp('[^0-9]'), ''), 'code': code},
    );

    return response.statusCode;
  }

  Future<dynamic> passwordReset(String phone, String password) async {
    String s = phone;
    String result = s.substring(1);

    final response = await http.post(
      Uri.parse('$baseUrl/blogger/password/reset'),
      body: {'phone': result.replaceAll(RegExp('[^0-9]'), ''), 'password': password},
    );

    return response.statusCode;
  }
}
