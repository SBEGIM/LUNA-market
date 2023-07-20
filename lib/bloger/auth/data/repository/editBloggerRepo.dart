import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class EditBloggerRepository {
  final EditToApi _editToApi = EditToApi();

  Future<dynamic> edit(
          String? name, String? nick, String phone, String? password, avatar) =>
      _editToApi.edit(name, nick, phone, password, avatar);
}

class EditToApi {
  final _box = GetStorage();

  Future<dynamic> edit(String? name, String? nick, String phone,
      String? password, avatar) async {
    String result = '';
    if (phone.isNotEmpty) {
      print('qweqweqw');
      result = phone.substring(2);

      phone = result.replaceAll(RegExp('[^0-9]'), '');
    }

    final body = {
      'phone': phone.toString(),
      'password': password ?? '',
      'name': name ?? '',
      'nick_name': 'assda',
      'access_token': _box.read('blogger_token').toString(),
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/blogger/edit'),
    );

    if (avatar != '' && avatar != null) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatar),
      );
    }
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(respStr);
      // final data = jsonDecode(jsonResponse.body);

      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_name', data['name'].toString());
      _box.write('blogger_nick_name', data['nick_name'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }
}
