import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/basket_admin_order_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class UploadVideoBloggerCubitRepository {
  UploadVideo _video = UploadVideo();

  Future<int> upload(video, int product_id) => _video.upload(video, product_id);
}

class UploadVideo {
  final _box = GetStorage();

  Future<int> upload(video, product_id) async {
    final String? token = _box.read('blogger_token');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/blogger/upload/video'),
    );

    if (video != '') {
      request.files.add(
        await http.MultipartFile.fromPath('video', video),
      );
    }
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });
    request.fields.addAll({'product_id': product_id});

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    final jsonResponse = jsonDecode(respStr);
    // print(jsonResponse.toString());

    return response.statusCode;
  }
}
