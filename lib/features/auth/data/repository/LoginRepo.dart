import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class LoginRepository {
  final LoginToApi _loginToApi = LoginToApi();

  Future<dynamic> login(String phone, String password) =>
      _loginToApi.login(phone, password);
  Future<dynamic> delete() => _loginToApi.delete();
  Future<dynamic> lateAuth() => _loginToApi.lateAuth();
  Future<dynamic> edit(
          String name,
          String phone,
          String Avatar,
          String gender,
          String birthday,
          String country,
          String city,
          String street,
          String home,
          String porch,
          String floor,
          String room,
          String email) =>
      _loginToApi.edit(name, phone, Avatar, gender, birthday, country, city,
          street, home, porch, floor, room, email);
}

class LoginToApi {
  final _box = GetStorage();

  Future<dynamic> login(String phone, String password) async {
    String s = phone;

    // final device_token = _box.read('device_token');
    final deviceToken = _box.read('device_token');
    String? deviceType;
    if (Platform.isIOS == true) {
      deviceType = 'ios';
    } else {
      deviceType = 'android';
    }

//Removes everything after first '.'
    String result = s.substring(2);
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      body: {
        'phone': result.replaceAll(RegExp('[^0-9]'), ''),
        'password': password,
        'device_type': deviceType,
        'device_token': deviceToken.toString(),
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _box.write('token', data['access_token'].toString());
      _box.write('user_id', data['id'].toString());
      _box.write('name', data['name'].toString());
      _box.write('phone', data['phone'].toString());
      _box.write('gender', data['gender'].toString());
      _box.write('avatar', data['avatar'].toString());
      _box.write('birthday', data['birthday'].toString());
      _box.write('country', data['country'].toString());
      _box.write('city', data['city'].toString());
      _box.write('street', data['street'].toString());
      _box.write('home', data['home'].toString());
      _box.write('porch', data['porch'].toString());
      _box.write('floor', data['floor'].toString());
      _box.write('room', data['room'].toString());
      _box.write('email', data['email'].toString());

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

  Future<dynamic> edit(
    String name,
    String phone,
    String avatar,
    String gender,
    String birthday,
    String country,
    String city,
    String street,
    String home,
    String porch,
    String floor,
    String room,
    String email,
  ) async {
    final String? token = _box.read('token');

    final cityId = _box.read('user_city_id');

    var replace = '';
    if (phone != '') {
      String s = phone;
      String result = s.substring(2);
      replace = result.replaceAll(RegExp('[^0-9]'), '');
    } else {
      replace = '';
    }

    final headers = {
      'Authorization': 'Bearer $token',
    };
    final body = {
      'name': name,
      'phone': replace,
      'gender': gender,
      'birthday': birthday,
      'country': country,
      'city': city,
      'street': street,
      'home': home,
      'porch': porch,
      'floor': floor,
      'room': room,
      'email': email,
      'city_id': cityId.toString(),
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/user/edit'),
    );

    if (avatar != '') {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatar),
      );
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    final jsonResponse = jsonDecode(respStr);
    // print(jsonResponse.toString());
    if (response.statusCode == 200) {
      _box.write('token', jsonResponse['access_token'].toString());
      _box.write('user_id', jsonResponse['id'].toString());
      _box.write('name', jsonResponse['name'].toString());
      _box.write('gender', jsonResponse['gender'].toString());
      _box.write('avatar', jsonResponse['avatar'].toString());
      _box.write('birthday', jsonResponse['birthday'].toString());
      _box.write('country', jsonResponse['country'].toString());
      _box.write('city', jsonResponse['city'].toString());
      _box.write('street', jsonResponse['street'].toString());
      _box.write('home', jsonResponse['home'].toString());
      _box.write('porch', jsonResponse['porch'].toString());
      _box.write('floor', jsonResponse['floor'].toString());
      _box.write('room', jsonResponse['room'].toString());
      _box.write('email', jsonResponse['email'].toString());

      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> delete() async {
    final String? token = _box.read('token');

    final response =
        await http.post(Uri.parse('$baseUrl/user/delete'), headers: {
      'Authorization': 'Bearer $token',
    });

    return response.statusCode;
  }
}
