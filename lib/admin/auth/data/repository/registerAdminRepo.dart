import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../DTO/register_admin_dto.dart';

const baseUrl = 'http://185.116.193.73/api';

class RegisterAdminRepository {
  final RegisterToApi _registerToApi = RegisterToApi();

  Future<dynamic> register(RegisterAdminDTO register) => _registerToApi.register(register);
  Future<dynamic> smsSend(String phone) => _registerToApi.smsSend(phone);
  Future<dynamic> smsCheck(String phone, String code) => _registerToApi.smsCheck(phone, code);
  Future<dynamic> resetSend(String phone) => _registerToApi.resetSend(phone);
  Future<dynamic> resetCheck(String phone, String code) => _registerToApi.resetCheck(phone, code);
  Future<dynamic> passwordReset(String phone, String password) => _registerToApi.passwordReset(phone, password);
}

class RegisterToApi {
  final _box = GetStorage();

  Future<dynamic> register(RegisterAdminDTO register) async {
    final deviceToken = _box.read('device_token');

    String s = register.phone;
    String result = s.substring(2);

    final String? token = _box.read('seller_token');
    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }

    final headers = {
      'Authorization': 'Bearer $token',
    };
    final body = {
      'name': register.name,
      'user_name': register.userName,
      'iin': register.iin,
      'email': register.email,
      'password': register.password,
      'check': register.check,
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'device_token': deviceToken.toString(),
      'device_type': deviceType,
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/seller/register'),
    );

    // if(register.avatar != ''){
    //   request.files.add(await http.MultipartFile.fromPath('avatar', register.avatar),);
    // }
    request.headers.addAll(headers);
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    await response.stream.bytesToString();

    // if (response.statusCode == 200) {
    // final data = jsonDecode(respStr);
    // _box.write('token', data['access_token'].toString());
    // _box.write('seller_id', data['user']['id'].toString());
    // _box.write('seller_card', data['user']['card'].toString());
    // }
    return response.statusCode;
  }

  Future<dynamic> smsSend(String phone) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(Uri.parse('$baseUrl/seller/register/send-code'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
    });

    return response.statusCode;
  }

  Future<dynamic> smsCheck(String phone, String code) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(Uri.parse('$baseUrl/seller/register/check'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'code': code,
    });

    return response.statusCode;
  }

  Future<dynamic> resetSend(String phone) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(Uri.parse('$baseUrl/seller/password/reset/send-code'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
    });

    return response.statusCode;
  }

  Future<dynamic> resetCheck(String phone, String code) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(Uri.parse('$baseUrl/seller/password/reset/check-code'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'code': code,
    });

    return response.statusCode;
  }

  Future<dynamic> passwordReset(String phone, String password) async {
    String s = phone;
    String result = s.substring(2);

    final response = await http.post(Uri.parse('$baseUrl/seller/password/reset'), body: {
      'phone': result.replaceAll(RegExp('[^0-9]'), ''),
      'password': password,
    });

    return response.statusCode;
  }
}
