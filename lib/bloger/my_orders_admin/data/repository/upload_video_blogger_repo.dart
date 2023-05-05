import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class UploadVideoBloggerCubitRepository {
  final UploadVideo _video = UploadVideo();

  Future<int> upload(video, int productId) => _video.upload(video, productId);
}

class UploadVideo {
  final _box = GetStorage();

  Future<int> upload(video, productId) async {
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
    // request.headers.addAll({
    //   'Authorization': 'Bearer $token',
    // });
    request.fields
        .addAll({'product_id': productId.toString(), 'access_token': token!});

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    final jsonResponse = jsonDecode(respStr);
    // print(jsonResponse.toString());

    return response.statusCode;
  }
}
