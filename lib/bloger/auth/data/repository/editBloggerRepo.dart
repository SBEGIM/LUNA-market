import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class EditBloggerRepository {
  final EditToApi _editToApi = EditToApi();

  Future<dynamic> edit(String? name, String? nick, String phone, String? password, String? iin, String? check, avatar,
          String? card, String? email, String? socialNetwork) =>
      _editToApi.edit(name, nick, phone, password, iin, check, avatar, card, email, socialNetwork);
}

class EditToApi {
  final _box = GetStorage();

  Future<dynamic> edit(String? name, String? nick, String phone, String? password, String? iin, String? check, avatar,
      String? card, String? email, String? socialNetwork) async {
    String result = '';
    if (phone.isNotEmpty) {
      result = phone.substring(2);
      phone = result.replaceAll(RegExp('[^0-9]'), '');
    }

    final body = {
      'phone': phone.toString(),
      'password': password ?? '',
      'iin': iin ?? '',
      'name': name ?? '',
      'nick_name': nick ?? '',
      'invoice': check ?? '',
      'card': card ?? '',
      'email': email ?? '',
      'social_network': socialNetwork ?? ''
    };

    final header = {"Authorization": "Bearer ${_box.read('blogger_token').toString()}"};

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
    request.headers.addAll(header);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(respStr);
      // final data = jsonDecode(jsonResponse.body);

      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_name', data['name'].toString());
      _box.write('blogger_phone', data['phone'].toString());
      _box.write('blogger_iin', data['iin'].toString());
      _box.write('blogger_nick_name', data['nick_name'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());
      _box.write('blogger_invoice', data['invoice'].toString());
      _box.write('blogger_card', data['card'].toString());
      _box.write('blogger_social_network', data['social_network'].toString());
      _box.write('blogger_email', data['email'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return response.statusCode;
  }
}
