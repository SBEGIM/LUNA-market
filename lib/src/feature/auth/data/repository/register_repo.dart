import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../DTO/register.dart';

const baseUrl = 'https://lunamarket.ru/api';

class RegisterRepository {
  final RegisterToApi _registerToApi = RegisterToApi();

  Future<dynamic> register(RegisterDTO register) =>
      _registerToApi.register(register);
  Future<dynamic> smsSend(String phone) => _registerToApi.smsSend(phone);
  Future<dynamic> smsCheck(String phone, String code) =>
      _registerToApi.smsCheck(phone, code);
  Future<dynamic> resetSend(String phone) => _registerToApi.resetSend(phone);
  Future<dynamic> resetCheck(String phone, String code) =>
      _registerToApi.resetCheck(phone, code);
  Future<dynamic> passwordReset(String phone, String password) =>
      _registerToApi.passwordReset(phone, password);
}

class RegisterToApi {
  final _box = GetStorage();

  Future<dynamic> register(RegisterDTO register) async {
    final deviceToken = await _box.read('device_token');
    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }

    String s = register.phone;
    String result = s.substring(2);

    final String? token = _box.read('token');

    final headers = {
      'Authorization': 'Bearer $token',
    };
    final body = {
      'name': register.name,
      'password': register.password,
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'device_token': deviceToken.toString(),
      'device_type': deviceType,
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/user/register'),
    );

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
      _box.write('name', data['user']['name'].toString());
      _box.write('phone', data['user']['phone'].toString());
      _box.write('gender', data['user']['gender'].toString());
      _box.write('avatar', data['user']['avatar'].toString());
      _box.write('birthday', data['user']['birthday'].toString());
      _box.write('country', data['user']['country'].toString());
      _box.write('city', data['user']['city'].toString());
      _box.write('street', data['user']['street'].toString());
      _box.write('home', data['user']['home'].toString());
      _box.write('porch', data['user']['porch'].toString());
      _box.write('floor', data['user']['floor'].toString());
      _box.write('room', data['user']['room'].toString());
      _box.write('email', data['user']['email'].toString());
    }
    return response.statusCode;
  }

  Future<dynamic> smsSend(String phone) async {
    String s = phone;
    String result = s.substring(2);

    final response =
        await http.post(Uri.parse('$baseUrl/user/register/send-code'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
    });

    return response.statusCode;
  }

  Future<dynamic> smsCheck(String phone, String code) async {
    String s = phone;
    String result = s.substring(2);

    final response =
        await http.post(Uri.parse('$baseUrl/user/register/check'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'code': code,
    });

    return response.statusCode;
  }

  Future<dynamic> resetSend(String phone) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http
        .post(Uri.parse('$baseUrl/user/password/reset/send-code'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
    });

    return response.statusCode;
  }

  Future<dynamic> resetCheck(String phone, String code) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http
        .post(Uri.parse('$baseUrl/user/password/reset/check-code'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'code': code,
    });

    return response.statusCode;
  }

  Future<dynamic> passwordReset(String phone, String password) async {
    print("111 $phone");
    String s = phone;
    String result = s.substring(2);

    final response =
        await http.post(Uri.parse('$baseUrl/user/password/reset'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'password': password,
    });

    return response.statusCode;
  }
}
