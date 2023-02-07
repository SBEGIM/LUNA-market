import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../DTO/register_blogger_dto.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class EditBloggerRepository {
  EditToApi _editToApi = EditToApi();

  Future<dynamic> edit(String name, String phone, String password, avatar) =>
      _editToApi.edit(name, phone, password, avatar);
}

class EditToApi {
  final _box = GetStorage();

  Future<dynamic> edit(
      String name, String phone, String password, avatar) async {
    String result = '';
    if (phone.isNotEmpty) {
      result = phone.substring(2);

      phone = result.replaceAll(RegExp('[^0-9]'), '');
    }

    final body = {
      'phone': phone,
      'password': password,
      'name': name,
      'access_token': _box.read('blogger_token').toString(),
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/blogger/edit'),
    );

    if (avatar != '') {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatar),
      );
    }
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    final jsonResponse = jsonDecode(respStr);

    if (jsonResponse.statusCode == 200) {
      final data = jsonDecode(jsonResponse.body);
      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_name', data['name'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());

      // _box.write('card', data['user']['card'].toString());
    }
    return jsonResponse.statusCode;
  }
}
